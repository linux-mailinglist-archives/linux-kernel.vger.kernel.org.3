Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6A24AD997
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357404AbiBHNVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359692AbiBHMwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:52:43 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2178CC03FECA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:52:43 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C4F41EC02B9;
        Tue,  8 Feb 2022 13:52:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644324757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wW5v18SsFr9UFGcEVFzDWXiJLXGqG2TS6A5yFHIl6Jc=;
        b=lauEYb3mkpYVOjoKl82iGb4BxW8WhTexv0OYMU0Bi1UGmkaqXeONSkaTS7vb3qNqIYHZgA
        1r8h0Aw0NO0LejTu36v1B2nacn2kHrlOm20OtnkjRPmbfGwFFDP2ISJIlEPWuHf9WS8fqX
        KuM9pm/0RJSI/s2NmzqvIgDwEiDfKLI=
Date:   Tue, 8 Feb 2022 13:52:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Hugh Dickins <hughd@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: x86: should clear_user() have alternatives?
Message-ID: <YgJnhB+bAxoNsiSB@zn.tnic>
References: <2f5ca5e4-e250-a41c-11fb-a7f4ebc7e1c9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f5ca5e4-e250-a41c-11fb-a7f4ebc7e1c9@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

On Mon, Feb 07, 2022 at 09:45:36PM -0800, Hugh Dickins wrote:
> I realize that dd'ing from /dev/zero to /dev/null, and sparse files on
> tmpfs, are not prime candidates for optimization; and I've no idea how
> much clear_user() normally gets used for long clears.

Right, we usually don't take such "optimizations" because the folks who
send them always come up with either microbenchmarks or only test on a
single machine.

> If I were capable of compiler asm, with alternatives, and knew at what
> length ERMS becomes advantageous when clearing, I would be sending you
> a proper patch.  As it is, I'm hoping to tempt someone else to do the
> work!  Or reject it as too niche to bother with.

Yap, looking at arch/x86/lib/clear_page_64.S - that's straight-forward
asm without special-cases noodles like __copy_user_nocache, for example,
so I wouldn't be opposed to someone

 - remodelling it so that you can have clear_user* variants there too,
 with the length supplied so that you can call a common function with
 arbitrary length and clear_page* can call it too. And then call them in
 a clear_user() version just like the clear_page() one which selects the
 proper target based on CPU feature flags.

 - testing this on bunch of modern machines with, say, a kernel build or
 some sensible benchmark so that we at least have some coverage

If the numbers are worth it - and judging by your quick testing above
they should be - then I don't mind taking that at all.

If only someone would have the time and diligence to do it properly...

:-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
