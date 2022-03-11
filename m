Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0374D613B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 13:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbiCKMIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 07:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiCKMIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:08:09 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8461B124E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 04:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=P9CckRWFX9nuVoHNgZ4r3Zf8OiO94SzMZDbZRwU+9Fg=; b=lpu61ZeCEFFnDww2NqtykEn/Qt
        Wlqcrw3bu18X0kcFiCk8xEahxdq7msRrxaUDBmO2iGLsf9eBDnwmv4JHKEFU0EDPUuCWO20DsWJD2
        /j548vMfOJCqKCq00ErBazDfx1ay8SnWnNoyICEgSsAncMki7RJFlwkgl2Cegfm5loRI9uz8hkzug
        DRPzeyacMzWsMjHYdA2DHUupFbPp+gbd4KVZqtWTp/SE6YLvoHmk9gZ6AUdwgZ8UT/3YT+fkBsfvm
        vmmQv21M6icZRGzARyVcJTYPS3tOaZYPuHPLPc8QQ06gTOAVh18haU0nRglmVIr9LaAj/df0WqrXI
        7ZONLQ2g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57792)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nSe2x-0002XR-Vu; Fri, 11 Mar 2022 12:07:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nSe2x-0001a9-Mf; Fri, 11 Mar 2022 12:07:03 +0000
Date:   Fri, 11 Mar 2022 12:07:03 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     patches@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: decompressor: do not copy source files while
 building
Message-ID: <Yis7Z90qvPz+EcTk@shell.armlinux.org.uk>
References: <20211030175258.1716178-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211030175258.1716178-1-masahiroy@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2021 at 02:52:58AM +0900, Masahiro Yamada wrote:
> As commit 7ae4a78daacf ("ARM: 8969/1: decompressor: simplify libfdt
> builds") stated, copying source files during the build time may not
> end up with as clean code as expected.
> 
> Do similar for the other library files for further cleanups of the
> Makefile and .gitignore.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Hi,

I am now seeing the following every time I run a build:

  GEN     Makefile
  CALL    .../linux-rmk/scripts/atomic/check-atomics.sh
  CALL    .../linux-rmk/scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  Kernel: arch/arm/boot/Image is ready
  AS      arch/arm/boot/compressed/lib1funcs.o
  AS      arch/arm/boot/compressed/ashldi3.o
  AS      arch/arm/boot/compressed/bswapsdi2.o
  LD      arch/arm/boot/compressed/vmlinux
  OBJCOPY arch/arm/boot/zImage
  Kernel: arch/arm/boot/zImage is ready

In other words, those three objects are always rebuilt even though
they haven't changed.

I've tried removing the arch/arm/boot/compressed directory in the
build tree, but that doesn't make any difference.

Running with V=2 shows:

  AS      arch/arm/boot/compressed/lib1funcs.o - due to lib1funcs.o not in $(tar
gets)
  AS      arch/arm/boot/compressed/ashldi3.o - due to ashldi3.o not in $(targets)
  AS      arch/arm/boot/compressed/bswapsdi2.o - due to bswapsdi2.o not in $(targets)

It looks to me like:
OBJS    += lib1funcs.o ashldi3.o bswapsdi2.o

in your patch should have been added before:

targets       := vmlinux vmlinux.lds piggy_data piggy.o \
                 head.o $(OBJS)

Please confirm.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
