Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFB14833D2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiACO6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:58:53 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41258 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiACO6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:58:52 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 43BB12110B;
        Mon,  3 Jan 2022 14:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641221931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S3iyNNYXHXoSzdbsSaUUeCjOo2owSZ0rgjDVrxxbXy4=;
        b=qCK8YBbxaJ/s0Vc58Ah+i9l0PDwGrMV7hNtU8Y3lnfeRGeu46QEUxoRFjlK05Pwg879L3T
        XqpmX6KbKbhtr6BPgb98WWaeiqBB0CErazH/QOJTDvc39FFCRdsHKfDHzAPHKJ0SrDwDzT
        6cu+AtfqErztQgng4C0bl4n+QhUm0/k=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D12C6A3B83;
        Mon,  3 Jan 2022 14:58:50 +0000 (UTC)
Date:   Mon, 3 Jan 2022 15:58:47 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kernel@gpiccoli.net, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, feng.tang@intel.com,
        kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Subject: Re: [PATCH] panic: Move panic_print before kmsg dumpers
Message-ID: <YdMPJwkfcjRA48sM@alley>
References: <20211230161828.121858-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230161828.121858-1-gpiccoli@igalia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-12-30 13:18:28, Guilherme G. Piccoli wrote:
> The panic_print setting allows users to collect more information in a
> panic event, like memory stats, tasks, CPUs backtraces, etc.
> This is a pretty interesting debug mechanism, but currently the print
> event happens *after* kmsg_dump(), meaning that Pstore, for example,
> cannot collect a dmesg with the panic_print information.

I see the point. Unfortunately, there is some risk in this change
so I have to ask:

Did you miss this behavior in practice?
Or does it just look like something that might be useful?


> This patch changes that by moving the panic_print_sys_info() function
> call up some lines, in order kmsg_dump() accounts this new information
> and exposes it through Pstore or other kmsg dumpers.

Note that panic_print_sys_info() might produce a lot of lines. There is
non-trivial chance that a lot of information might get lost because
of the limited log buffer size.

It might cause regression even when no dumpers are registered and
crash kernel is not loaded. panic_print_sys_info() might overwrite
the existing messages before we try hard to flush them via
console_flush_on_panic().


> Cc: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> Hey folks, thanks in advance for reviews/comments!
> One alternative I've considered was to move kmsg_dump() some
> lines down, I'm not sure which approach is better, can't see
> much difference. Opinions are very welcome =)

This does not look like a good idea either. The comment below
kmsg_dump(KMSG_DUMP_PANIC) says that it should be called
before crash_kexec() that might fail.


IMHO, the best solution would be to allow dumping messages produced
by panic_print_sys_info() using the registered dumpers directly.
But it might require redesigning the kmsg_dump API.


After all, the proposed patch might be good enough.
panic_print_sys_info() does nothing by default.
It might be enough to document that a large enough log buffer
should be used when some output is enabled, especially when
a dumper is used.

Also we should mention these pitfalls and risks in the commit
message.

Best Regards,
Petr
