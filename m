Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C8D4D5FCE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348131AbiCKKib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348060AbiCKKiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:38:24 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6036C1C1AF2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fAl9Fpwe3hBpzZjYhYE3T3tApQIlsu2mrNCudRtI24A=; b=pbKdbcjp6Rv6g/ODfY6BaNs3sv
        6xJ8Jec6a5G/6IUuibQApJj8uJUk+tpJ7LaZ/lD55lGi/bOnv7f+a51Q2NcjDGNm4MheQfwTOyqPe
        MyCP2ksPra8jQA3znEiATfoIGOP50QMYv9ONS61XXP/EMGyVFhd6KkYHPvoOCLX0pMtOoseBGvY92
        7GJ6eRmd7HR2OfD+HrM6lMrlzEYFVZCZCKF74os6/GekIiRvM7YmMgQnDZnWcq7350Ig4GQ0YGdPZ
        Vw6mv+k9AjfMXmUdFPu1Ldk97IBIxcpREhi918ibPX9GWLiGk/IJ3efenia0uSlUENHuZLfhi8nIf
        hx+Rf3+g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57788)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nSce6-0002RB-51; Fri, 11 Mar 2022 10:37:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nSce4-0001Wp-LD; Fri, 11 Mar 2022 10:37:16 +0000
Date:   Fri, 11 Mar 2022 10:37:16 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        andreyknvl@gmail.com, anshuman.khandual@arm.com, ardb@kernel.org,
        dvyukov@google.com, geert+renesas@glider.be, glider@google.com,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        lukas.bulwahn@gmail.com, mark.rutland@arm.com,
        masahiroy@kernel.org, matthias.bgg@gmail.com,
        ryabinin.a.a@gmail.com, yj.chiang@mediatek.com
Subject: Re: [PATCH v3 0/2] arm: kasan: support CONFIG_KASAN_VMALLOC
Message-ID: <YismXDtUZ2cPtVnN@shell.armlinux.org.uk>
References: <20220227134726.27584-1-lecopzer.chen@mediatek.com>
 <CACRpkdasAGFDth-=eKgUFo+4c-638uo2RMbaUap6ent5mmBXbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdasAGFDth-=eKgUFo+4c-638uo2RMbaUap6ent5mmBXbw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 12:08:52AM +0100, Linus Walleij wrote:
> On Sun, Feb 27, 2022 at 2:48 PM Lecopzer Chen
> <lecopzer.chen@mediatek.com> wrote:
> 
> > Since the framework of KASAN_VMALLOC is well-developed,
> > It's easy to support for ARM that simply not to map shadow of VMALLOC
> > area on kasan_init.
> >
> > Since the virtual address of vmalloc for Arm is also between
> > MODULE_VADDR and 0x100000000 (ZONE_HIGHMEM), which means the shadow
> > address has already included between KASAN_SHADOW_START and
> > KASAN_SHADOW_END.
> > Thus we need to change nothing for memory map of Arm.
> >
> > This can fix ARM_MODULE_PLTS with KASan, support KASan for higmem
> > and provide the first step to support CONFIG_VMAP_STACK with Arm.
> >
> >
> > Test on
> > 1. Qemu with memory 2G and vmalloc=500M for 3G/1G mapping.
> > 2. Qemu with memory 2G and vmalloc=500M for 3G/1G mapping + LPAE.
> > 3. Qemu with memory 2G and vmalloc=500M for 2G/2G mapping.
> >
> > v3:
> >     rebase on 5.17-rc5.
> >     Add simple doc for "arm: kasan: support CONFIG_KASAN_VMALLOC"
> >     Tweak commit message.
> 
> Ater testing this with my kernel-in-vmalloc patches and some hacks, I got
> the kernel booting in the VMALLOC area with KASan enabled!
> See:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/log/?h=kernel-in-vmalloc-v5.17-rc1
> 
> That's a pretty serious stress test. So:
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> for the series.
> 
> I suppose you could put this into Russell's patch tracker, it's gonna be
> for kernel v5.19 by now but why stress. It seems I can fix up
> kernel-in-vmalloc on top and submit that for v5.19 as well.

Ard's series already adds vmap stack support (which we've been doing
some last minute panic-debugging on to get it ready for this merge
window), but the above description makes it sound like this series is
a pre-requisit for that.

Is it? Will Ard's work cause further regressions because this series
isn't merged.

Please clarify - and urgently, there is not much time left before the
merge window opens.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
