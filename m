Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865454EC9C3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348862AbiC3Qis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbiC3Qiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:38:46 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F7E197AC2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HWbPC5h/j58ceCxQlVSc5RvAYIlhggFe0pdxq+KiTPE=; b=ohc2cMwku7X0vVNhI8K19tG2iF
        uwO+P1yiW7VcQk8CMgq9EFPtfMFJaMmTkhiFga1tEaFJGGWZablr6Pe7JksjV3ecd4CLc6dEN/X4i
        M2H5zvv4h7OiKykxMtwjlXckE+aKI6WAc6TkiKj5QtneCteTW9PiQc+TN/zrCmP+e1cQuWnIES6SC
        +7za02u1fvjlc6uCSHGq3WtJd7s8uFdU9jtlG98tSXCtGlcodHnC9dfhl26JGVZmy4763GNFIfxZz
        TRGeS+ssw57B10Kuq9RcPztTFn96FjyOxjjdORnFDLQlKiCTuc55qFPDozZ+sGZfetTHTlN0Cl8/M
        xG+Xy6lA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58024)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nZbJY-0003T8-Pt; Wed, 30 Mar 2022 17:36:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nZbJX-0006mF-G3; Wed, 30 Mar 2022 17:36:55 +0100
Date:   Wed, 30 Mar 2022 17:36:55 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Christian Eggers <ceggers@arri.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: Re: CONFIG_THUMB2_KERNEL=y boot failure after Spectre BHB fixes
Message-ID: <YkSHJ65qGHO4bonJ@shell.armlinux.org.uk>
References: <YipOoAaBIHjeCKOq@dev-arch.thelio-3990X>
 <2109354.irdbgypaU6@localhost.localdomain>
 <YkSBJD0oA7zxHS+B@shell.armlinux.org.uk>
 <CAMj1kXGLehBkaG7-t5PZqN+32MS-5BDX-QGOe6ftZnPuNDKicg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGLehBkaG7-t5PZqN+32MS-5BDX-QGOe6ftZnPuNDKicg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 06:34:25PM +0200, Ard Biesheuvel wrote:
> On Wed, 30 Mar 2022 at 18:12, Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, Mar 22, 2022 at 06:49:17PM +0100, Christian Eggers wrote:
> > > Hi Nathan, hi Russel,
> > >
> > > I stumbled today over the same problem (no output on serial console
> > > with v5.15.28-rt36). During `git bisect`, I had also some commits
> > > where a few lines of output were visible.
> > >
> > > At commit 8d9d651ff227 ("ARM: use LOADADDR() to get load address of
> > > sections"), the system boots up to here:
> > >
> > > start_kernel()
> > > +--setup_arch()
> > >    +--paging_init()
> > >       +--devicemaps_init()
> > >          +--eary_trap_init(vectors_base = 0xC7FFE000)
> > >             +--copy_from_lma(vectors_base = 0xC7FFE000, __vectors_start=0x0, __vectors_end=0x20)
> > >                +--__memcpy()
> > >
> > >                copy_template.S:113
> > >                ldr8w   r1, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
> > >                r1 = 0
> > >
> > >
> > > With the final v5.15.28-rt36 I found out that the system boots fine
> > > after disabling CONFIG_HARDEN_BRANCH_HISTORY.
> > >
> > > Is there anything else I could analyze? My SoC system is a NXP i.MX6LL
> > > with a ARMv7 core. I have access to a JTAG debugger.
> >
> > I think this is already fixed in mainline. Commit:
> >
> > 6c7cb60bff7a ("ARM: fix Thumb2 regression")
> >
> 
> It's still broken - I sent a couple of patches on Monday, among which
> one to fix the boot issue with loop8 on Thumb2. The problem is 'b . +
> 4', which produces a narrow encoding, and so it skips the subsequent
> subs instruction and loops forever.

And what's the current status? Sorry, I've way too much email from the
last 2.5 weeks to find it myself.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
