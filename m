Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F7E509C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiDUJ2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiDUJ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:28:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B470E28
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:25:56 -0700 (PDT)
Received: from zn.tnic (p200300ea971b58ed329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:58ed:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D82E31EC0494;
        Thu, 21 Apr 2022 11:25:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650533150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PdMsW/f4pVpJ1A70NmnyABfT0PPmrPEhWaYHSLIwP28=;
        b=KhDa/m/qxorKIuqk+yN9KoNoeUwSKfInh/f7+NCwEp78225ANmnvFmBE2WBVHRZCsqAuTd
        d8XjJg6yZxZ29eYAjo+nPQ0tkYfgmUC4DWC7GWlUqbfErz71sB+D0eIz/DgsGzFqeRM56E
        dgdLRo1N9y5C+6Y0EAbmNTCcVa2eNFU=
Date:   Thu, 21 Apr 2022 11:25:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     bugzilla-daemon@kernel.org, kernel@dolney.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 215867] New: tboot suspend broken
Message-ID: <YmEjGl2RzYARUHK2@zn.tnic>
References: <bug-215867-6385@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bug-215867-6385@https.bugzilla.kernel.org/>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switching to mail because I can't CC the patch author on bugzilla.

Vincent, see below. It points to your commit:

453e41085183 ("cpu/hotplug: Add cpuhp_invoke_callback_range()")

@Derek, just to make sure: you're seeing this with the latest 5.17
kernel too, correct?

Thx.

On Thu, Apr 21, 2022 at 02:07:42AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=215867
> 
>             Bug ID: 215867
>            Summary: tboot suspend broken
>            Product: Platform Specific/Hardware
>            Version: 2.5
>     Kernel Version: 5.12.0
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: x86-64
>           Assignee: platform_x86_64@kernel-bugs.osdl.org
>           Reporter: kernel@dolney.com
>         Regression: Yes
> 
> I am using tboot (v1.10.5) to make use of intel-txt and all was working fine
> with the Linux kernel 5.10 series. However later in 5.12 release candidates, I
> have  proper booting however suspend is broken. I am using a Lenovo T460p.
> Usually when suspending on this machine the power button LED will blink 8 times
> and then it goes into a sleep state. With newer kernels I get power LED and
> caps lock LED blinking, cpu fan runs fast, and can't get out of that state
> without hard powerdown.
> 
> I did a git bisect on and found that commit
> 453e41085183980087f8a80dada523caf1131c3c is the one that breaks tboot+suspend
> to ram. It is part of a series of some cpu hotplug commits.
> 
> Just to be clear: if I build a kernel from the commit just before this one, I
> can suspend and resume, but if I build with this commit I can not suspend,
> laptop gets stuck on blinking power LED. Let me also mention that, given the
> above commit, if I do not use tboot, I can suspend and resume ok. It is only
> within the tboot boot context that I have suspend&resume problems.
> 
> -- 
> You may reply to this email to add a comment.
> 
> You are receiving this mail because:
> You are watching the assignee of the bug.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
