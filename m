Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AFE580F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiGZJMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiGZJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:12:30 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFCA2AC64
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nqCjJ8kaHKzTLbqQdlUfZDxdXr9VqNvKjOu3J0+NLh0=; b=h12PMr8iUOzEoNmQfmqzjSQ0fJ
        vBoM4A+cD5Mrlah5ydibxZadnAzIcbNduv1kzgmD82A3eVm95RqueKLoZHsIGukYZq7Z17OpNbKRd
        ZjvwP5xRlqOSGtr4jYUWTALlWRMu4wxLOlDKBKwWqR/QxnJu5fJpNKIak0anE5ivOCl6Wwo2mK/b3
        eLgE9Sz6anrcFvzWqh6LMD/NMhcofbgYpqhT8dkpHp0q4UjriTvnXEYSDX0/yWg7DT8ty0L/DRJv/
        KLYBnc/5BlQ3Cp7RyLuvtqdLXcPbcNzZG5SGFBuKIz5yu8H1exGZd5Y4XR0yDkQfqjZrn0bWGkAkd
        CekRWtKg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33564)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oGGc3-0003tK-OZ; Tue, 26 Jul 2022 10:12:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oGGc1-00016W-Df; Tue, 26 Jul 2022 10:12:21 +0100
Date:   Tue, 26 Jul 2022 10:12:21 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Yury Norov <yury.norov@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.19-rc8
Message-ID: <Yt+v9brPqxun0nhA@shell.armlinux.org.uk>
References: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
 <20220725161141.GA1306881@roeck-us.net>
 <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 10:55:18AM -0700, Linus Torvalds wrote:
> On Mon, Jul 25, 2022 at 9:11 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > BUG: KFENCE: out-of-bounds read in _find_next_bit_le+0x10/0x48
> 
> Ok, I was hoping somebody more ARMy would look at this, particularly
> since there is no call trace beyond the actual fault.

First I'm aware of it. Was it reported to linux-arm-kernel? I'm guessing
the report wasn't Cc'd to me - I can't find anything in my mailbox about
it.

> I think the fix might be something like this:
> 
>   diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
>   index b5e8b9ae4c7d..b36ca301892e 100644
>   --- a/arch/arm/lib/findbit.S
>   +++ b/arch/arm/lib/findbit.S
>   @@ -83,6 +83,8 @@ ENDPROC(_find_first_bit_le)
>    ENTRY(_find_next_bit_le)
>                 teq     r1, #0
>                 beq     3b
>   +             cmp     r2, r1
>   +             bhs     3b
>                 ands    ip, r2, #7
>                 beq     1b                      @ If new byte, goto old routine
>     ARM(                ldrb    r3, [r0, r2, lsr #3]    )
> 
> but my ARM asm is so broken that the above is just really random noise
> that may or may not build - much less work.
> 
> I'll leave it to Russell &co to have a tested and working patch.

I think it needs a bit more than that, but as you point out in later
emails, the compiler may do a better job for this.

One of the reasons for using byte loads was to avoid problems in the
early days of Linux where these took void pointers and thus could be
misaligned - and using word accesses would have resulted in much
pain. However, that was changed to unsigned long pointers back in
2017, so in theory that should no longer be a concern.

I don't remember why we used void pointers there originally - that's
something which dates back to the 1990s.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
