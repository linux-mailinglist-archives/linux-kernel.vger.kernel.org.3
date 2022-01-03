Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396E14834CD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbiACQbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:31:36 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:47470 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbiACQbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=YXMmsjAKD4enFUv7730GlyCVjbxRWf+7/jx1bcj5cDE=; b=oCVRfQ+8xNKBnU505brU6HrEN1
        VjxB5lc7xSzbYpR+FbnDlND3yPytZSYTPkEscIBJEgUcpR6SA1aSHcptbzVvAaHd2Jd3Jc7EHwL4S
        2b2MEoPzMkN7EZTdpXUvUu2XbkXHMlkF2WGzKn6XQO+fimfUTan3XOzIZtH8wh5eMKmh+k6T4O8Yf
        AH/qnOu+eQZBVLwSYTe3/53cToAy/nXy3X4vzt/F0Le0ZZno6It4rm79b5vr5uOKzITM/TCI8O0GA
        2i4vKbiF1J/h7dVJCG/xK24ng3UoOtBwM6xvaDpi0WgfZZPxgUxGij9kQu8oEWzC4evqbaXgXumUY
        az8PWWBg==;
Received: from 200-153-146-242.dsl.telesp.net.br ([200.153.146.242] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1n4QEZ-000Akp-0d; Mon, 03 Jan 2022 17:30:55 +0100
Subject: Re: [PATCH] panic: Move panic_print before kmsg dumpers
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kernel@gpiccoli.net, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, feng.tang@intel.com,
        kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
References: <20211230161828.121858-1-gpiccoli@igalia.com>
 <YdMPJwkfcjRA48sM@alley>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <315d9a0b-2494-5d3d-e228-7c957f7c5e4a@igalia.com>
Date:   Mon, 3 Jan 2022 13:30:35 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YdMPJwkfcjRA48sM@alley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr, first of all, I'd like to thank you for the _very_ complete and
informative response, pretty useful!
Some comments inline below:


On 03/01/2022 11:58, Petr Mladek wrote:
> [...]
> I see the point. Unfortunately, there is some risk in this change
> so I have to ask:
> 
> Did you miss this behavior in practice?
> Or does it just look like something that might be useful?

Heh it's a valid question! And the answer is that indeed, we miss this
behavior in practice - the plan is to use pstore as panic "fast" log
collection (instead of kdump), and to print some extra info through
panic_print. Hence the surprise when that information wasn't properly
stored in the pstore saved logs...


> [...] 
> Note that panic_print_sys_info() might produce a lot of lines. There is
> non-trivial chance that a lot of information might get lost because
> of the limited log buffer size.
> 
> It might cause regression even when no dumpers are registered and
> crash kernel is not loaded. panic_print_sys_info() might overwrite
> the existing messages before we try hard to flush them via
> console_flush_on_panic().

Sure, we already account for this risk, and make use of "log_buf_len" to
increase dmesg size, something like 4M/8M.

Now, the second portion of your statement is a bit frightening! Maybe a
silly question, but the risk is to lose some messages in the *dmesg* or
only in the output console, like a serial/graphic console?

If the risk is to lose messages even in the dmesg (that is going to be
collected through pstore/any other kmsg dumper), do you think would make
sense to have a second (in fact, first!) "console_flush_on_panic(...)"
_before_ "panic_print_sys_info()"?
What would be the cons in this approach? I understand that we may need
to (at least) disable debug_locks earlier than it's currently done, for
example. If kexec is more risky having this earlier flush, we could
flush conditionally on not having a crash kernel loaded.


> [...] 
> IMHO, the best solution would be to allow dumping messages produced
> by panic_print_sys_info() using the registered dumpers directly.
> But it might require redesigning the kmsg_dump API.
> 
> 
> After all, the proposed patch might be good enough.
> panic_print_sys_info() does nothing by default.
> It might be enough to document that a large enough log buffer
> should be used when some output is enabled, especially when
> a dumper is used.
> 
> Also we should mention these pitfalls and risks in the commit
> message.

OK, makes total sense. I'll wait on your feedback to my points above,
and maybe others could also provide ideas/concerns, and then, I'll
rework the commit message/code accordingly.

Thanks again, and a happy new year to you and family =)
Cheers,


Guilherme
