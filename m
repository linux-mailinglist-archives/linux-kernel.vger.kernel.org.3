Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46974ECC9A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350205AbiC3Srf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348876AbiC3SrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:47:24 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D10630F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uU3vvHpm/VWpD6ZwYjcquWBCaaS4a6DtSrLVV4a15KQ=; b=JfcFYiNokfJixkPVp0WMCXHgVJ
        +liwnICyziJgvHmE1FrZSenf6cAa/KaSzKCso8Xiw3IXPX5n64dbFEy5/CfkMb4AcU4AEBY1mOJw8
        eqNdRMZ5KGKr9f0v4fK5H5BN+2o95IZWg4qYT9tnN0RRwh/3FBfVmzL8OmywKMAieW2ZMldACZErv
        sl9NFv8hyrSzF7ndOQMZr9BYgqEz/rfpoZxVbOsRvQRfq1cyvojZ2+WYZKvqHk21nM5+cLYz+pXYm
        pWluMM27Ar5fDOIB/aM0VFZNLetVT7n/XucbfMptssHaVdMr6vS8DAyr78pk7ywhJPU1b9vJVzGDx
        a2ypv0Pw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58028)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nZdJl-0003ae-Ma; Wed, 30 Mar 2022 19:45:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nZdJj-0006s1-PZ; Wed, 30 Mar 2022 19:45:15 +0100
Date:   Wed, 30 Mar 2022 19:45:15 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Christian Eggers <ceggers@arri.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: Re: CONFIG_THUMB2_KERNEL=y boot failure after Spectre BHB fixes
Message-ID: <YkSlO4BOyQv9uTyd@shell.armlinux.org.uk>
References: <YipOoAaBIHjeCKOq@dev-arch.thelio-3990X>
 <10062923.nUPlyArG6x@localhost.localdomain>
 <CAMj1kXGbNtJPEowha8=vFgjdv_m2viHJ2Q7AqtJeqOPLa8-1Sg@mail.gmail.com>
 <1896453.PYKUYFuaPT@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1896453.PYKUYFuaPT@localhost.localdomain>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 08:27:56PM +0200, Christian Eggers wrote:
> On Wednesday, 30 March 2022, 19:42:31 CEST, Ard Biesheuvel wrote:
> > Thanks for confirming. The first fix affects all Thumb2
> > configurations, my patch only affects Thumb2 configurations that
> > actually enable the loop8 mitigation for Spectre-BHB.
> > 
> > What type of CPU are you booting on?
> 
> NXP i.MX6ULL (ARM Cortex-A7).

As Cortex-A7 is not listed in Arm Ltd's table for speculative processor
vulnerabilities, the kernel doesn't implement any workarounds.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
