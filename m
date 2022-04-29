Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43300514F18
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378294AbiD2PWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352753AbiD2PWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:22:48 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52277D4C97
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PPEhKtF0sbeyujzm9thZEDJXkLxwy3zvWFKn/rMauzg=; b=pyJ3fGMrzIjrPqmogJnmqGVwL9
        wgbSjJSFApC9+hZGKIuVIsHA2YByvO1vYQpx2Ik7LXVsoALcsE9G0Gmigyk3Ez1pyfd8g4CLXZqpj
        9h9MPMuHoN4KykqBBkfjbG7SnzXneSRJsGcHLy+hXv70MAxhQRLG4vwGFbXyi93vmfNuBNnRLVXSN
        nMz4lQpp4850iFRYrVsrVz2piZbGEnCddja+jgw8qpioI8TmHTkKdQWeLcm8Bs6BMwfn4pMS60Fh/
        FP6Vz7RvJkAKAVue13EySfL1anrmNqOOrEutnjpIwqWxFe6185QcTGoP8FduHitU3WRRO7Wg4Noi+
        8kBlSgxA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58442)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nkSOv-0004BC-Q4; Fri, 29 Apr 2022 16:19:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nkSOp-00022l-UK; Fri, 29 Apr 2022 16:19:15 +0100
Date:   Fri, 29 Apr 2022 16:19:15 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     xkernel.wang@foxmail.com
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mvebu: check the validation of memory allocation
Message-ID: <YmwB83u68uPKuU0a@shell.armlinux.org.uk>
References: <tencent_1D9E7394538085872BE9FD6780483137E70A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_1D9E7394538085872BE9FD6780483137E70A@qq.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 04:55:18PM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> kzalloc() and kstrdup() are memory allocation functions which can return
> NULL when some internal memory errors happen. So it is better to check
> the return value of them to prevent potential wrong memory access or
> memory leak.

Are these failures silent, or will they be reported in the kernel log to
make their failure obvious to those who debug the kernel?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
