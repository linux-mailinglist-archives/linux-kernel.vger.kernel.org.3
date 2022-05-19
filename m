Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282BD52CF8C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbiESJjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiESJjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:39:09 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F006A79389
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 02:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oalRBxkTX86uDEQJHCY1MH0YBsw4GZosq8rcs4Idt+U=; b=yBiUZH+mvXwf0I6bOxbWX9EoTq
        D3qbvdxP/bvb43mE15tMf/UQmGh6xcZ60r33ZJxQjb2B/m+BliWBFAcrUdJ0lEqMh1/oQ43aQBqN2
        1irqy48J9FsESRBc7lAse/5oOeFhLRv3S5nW493ZffREIkPvSxyNGT04mCMYG/oDXVwoeIdCKcoXV
        ZbveE4+P1KTTNpyPjz2ctc27sWjHlzhocELBCZv04ng8rH/AT51KyomK/1hnH9OssNnw6fjLsZjI/
        JMHasHe5u6qCrikQA5nF21Y6Ub1gL8McZh0/S8O2/f6bHW4bGtfXaFpx1h13PQaZnrmrpgbpKmstP
        K9NgNBSA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60770)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nrccJ-0003Wr-Dy; Thu, 19 May 2022 10:38:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nrcc8-0006Ru-Uu; Thu, 19 May 2022 10:38:36 +0100
Date:   Thu, 19 May 2022 10:38:36 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     David Spickett <david.spickett@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 4/4] ARM: pass -march= only to compiler
Message-ID: <YoYQHE8SBzi2HS+H@shell.armlinux.org.uk>
References: <20220516210954.1660716-5-ndesaulniers@google.com>
 <202205180917.RNpZaxIl-lkp@intel.com>
 <CAKwvOdmkd2PxvMUZA=A-72eATGDZkqDj--Bv1W+Xt_K_LWdROA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmkd2PxvMUZA=A-72eATGDZkqDj--Bv1W+Xt_K_LWdROA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 03:38:18PM -0700, Nick Desaulniers wrote:
> (so it seems that the preprocessor definition of `__thumb2__` is
> dependent on `-march=`, not `-Wa,-march=`).

Yes, it will be. -Wa,... are only ever passed to the assembler and do
not affect the preprocessor nor the compiler with GCC.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
