Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E4159B242
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 08:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiHUGR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 02:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiHUGR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 02:17:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E9420F6A;
        Sat, 20 Aug 2022 23:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5GHQ8lsVBIhq+oelqV2y6+nyZwMa9j4Xf+XLM5s2Zb0=; b=F5FpUK1WANEgjo+iDNQ2Mh29GI
        FmHm6mXPXNLIsJFejBP0Asx3X787+4h3/8U8EcPWduLPve964t+OH/AiY3qNChCcVvIddsTGzMwfY
        2h0sWUiikHF2Fy1eH79ET3Gz8v8Na+DFwZ677VPQ4/9rhKnBJF7Zfxw8nur6utLKAimrJlmZ6etfU
        BC/JM4GuFCFazyE9zJp/R5/48wVKAT75ib0Dbo3e3fCIMhwbOx9UV9PJQlne5jn88r6mgEOunx0il
        sAik/mt2tAFTaiPKdpX0+PK8U4NFm2jIPsL1uYJCl65BYU+5pRyBUmS6DNjPudgNJwslKlOmtoD9d
        LWyBwysA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oPeHI-006gRs-I3; Sun, 21 Aug 2022 06:17:44 +0000
Date:   Sat, 20 Aug 2022 23:17:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>, iommu@lists.linux.dev,
        Mickey Rachamim <mickeyr@marvell.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix 2G limitation on AC5 SoC
Message-ID: <YwHOCHmKaf7yfgOD@infradead.org>
References: <20220808095237.GA15939@plvision.eu>
 <6c94411c-4847-526c-d929-c9523aa65c11@intel.com>
 <20220808122652.GA6599@plvision.eu>
 <3f96b382-aede-1f52-33cb-5f95715bdf59@intel.com>
 <3d16ebad-ea6c-555e-2481-ca5fb08a6c66@arm.com>
 <20220816205129.GA6438@plvision.eu>
 <94888b3b-8f54-367d-c6b4-5ebfeeafe4c4@arm.com>
 <20220817160730.GA17202@plvision.eu>
 <80d2538c-bac4-cc4f-85ae-352fcf86321d@arm.com>
 <20220818120740.GA21548@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818120740.GA21548@plvision.eu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 03:07:40PM +0300, Vadym Kochan wrote:
> It works with the following changes:
> 
>     #1 dma-ranges = <0x0 0x0 0x2 0x0 0x0 0x80000000>;
> 
>     #3 swiotlb="force"
> 
> Is it OK to force the memory allocation from the start for the swiotlb ?

It should be ok, but isn't really optimal.

I wonder if we should just allow DT to specify the swiotlb buffer
location.  Basically have yet another RESERVEDMEM_OF_DECLARE variant
for it, which shouldn't be all that much work except for figuring
out the interaction with the various kernel command line options.
