Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DFB54D0C2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358402AbiFOSOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357105AbiFOSOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:14:46 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0539232EDB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9rWayHKkl8gt9Yx/cvOcgsexoc9VTUlgxrdokQp62EQ=; b=FZB3f9MGAl+CLESm59l8QKJWoN
        xe9oHJFBv204+qGVvwUEezzVbNnVSdGi8N14sB0PUbgCod9gU5ls+zWps4lIve3r1TwksvehtEDgR
        uEabvJsTGao27iFyYgJxlG8bnE5XCZeCFgE2SnjSxtz0r6l08rFG9DEOmKTrz9jxOiO2+h5rkBM/Q
        6y94aph1X9xi0jVx9DUdC4bHOByG8eGt8TdMcOJnQx6pfiXc1mgelMGuYR5Eq4w76u9/l55VGgZ8T
        s1N0iOYBokRWfB9U6FJw1Vwvy/o86rI4OdtBJjn3Tb9P64h1nC6FALlmSvTkM1EXyvKerCFw3sZL1
        2umiVY1Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32884)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1o1XXM-0004r2-5O; Wed, 15 Jun 2022 19:14:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1o1XXJ-0000BN-JE; Wed, 15 Jun 2022 19:14:37 +0100
Date:   Wed, 15 Jun 2022 19:14:37 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        anand.gore@broadcom.com, kursad.oney@broadcom.com,
        samyon.furman@broadcom.com, tomer.yacoby@broadcom.com,
        philippe.reynes@softathome.com,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: bcmbca: add VFP and NEON fixup for bcm6846 SoC
Message-ID: <YqohjUuJ7ivSFeMN@shell.armlinux.org.uk>
References: <20220525003509.2812-1-william.zhang@broadcom.com>
 <700e7f0b-a535-545b-1c83-26ce2d4e8be1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <700e7f0b-a535-545b-1c83-26ce2d4e8be1@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 10:43:28AM -0700, Florian Fainelli wrote:
> On 5/24/22 17:35, William Zhang wrote:
> > BCM6846 SoC only has VFP and NEON support on core 0. So kernel VPF/NEON
> > support is disabled in this chip. Add this fixup to manually turn on
> > VFP/NEON in case userspace app need to access them on core 0.
> > 
> > Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> We have had this conversation internally already, but I do not think this is
> sufficient in order to have a workable solution, you indicated that there is
> all sorts of user-space involvement in your SDK to ensure that only VFP
> tasks are scheduled on core 0, but if we were to seek a proper solution we
> would have to modify the ARM Linux kernel to forcibly migrate VFP tasks onto
> a core that can support executing them, or accept emulating them with the
> implied slow down.
> 
> Russell, what are your thoughts on this?

The patch only enables access to the VFP, which adds the additional
instructions on that core. However, if the kernel has decided that
VFP isn't available, then we won't be advertising VFP via the HWCAPS
and therefore libraries won't be using it.

However, there may be some userspace that "probes" for VFP instruction
presence by trying to execute a VFP instruction, and catching the
SIGILL. The problem here is if we enable it on core 0 and such an app
is used, then it will think VFP is generally available when it isn't.

So, in terms of system stability, I don't think this is something we
want to generally do.

Also, without the VFP kernel support code, VFP registers won't be
saved and restored across context switches (which makes them a nice
path for covert communication) and neither will they be saved and
restored properly for signal handlers - so any use of VFP on that
core would need to be carefully thought through.

It doesn't sound like a particularly good idea for a generic kernel
to me, even one running on the specific hardware. For example, a
debian hardfp userspace may well run on core 0 but not properly.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
