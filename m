Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C640C54AD34
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355085AbiFNJVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238892AbiFNJVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:21:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9DD43AF7;
        Tue, 14 Jun 2022 02:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=U6PoerE9UCYpP4xSLqMKP1SJdUCxaCfj3/XK0rIc3e4=; b=cUTdTvyAk6sfntwoLmCm7BNRnw
        UiPjTyCzLLzLWIcPXL+HFSEoGO7dRMDpxrdgrOgl3bWFtSfZtctEal3MT4b+aULh4sAI9rFWtw3lN
        skBAwH+2v4vbjKGieaUl9/RCzwHOv+1ncywbF2JUpHErtgWmwKKDHgfJNXKVeyY5JGe4zisvy5gMg
        FJ9YV2IzEcvZZ685Cuk/yKE5Wn6evqdWBQMrkAFT+aBH3k3p5O8Bss2RFHDvw31rMJ33rP8nMNXFP
        GPrq34WCn+/sHP/iys5BtM7ma6i2oZOWap8guOIS9sbp6NP6t1H8QjUHv7GkfVLrjFOt8j+mxdwe3
        xbNAHYYw==;
Received: from [2001:4bb8:180:36f6:1fed:6d48:cf16:d13c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o12jB-008fFa-RD; Tue, 14 Jun 2022 09:20:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: fully convert arm to use dma-direct v3
Date:   Tue, 14 Jun 2022 11:20:37 +0200
Message-Id: <20220614092047.572235-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

arm is the last platform not using the dma-direct code for directly
mapped DMA.  With the dmaboune removal from Arnd we can easily switch
arm to always use dma-direct now (it already does for LPAE configs
and nommu).  I'd love to merge this series through the dma-mapping tree
as it gives us the opportunity for additional core dma-mapping
improvements.

Changes since v2:
 - rebased to Linux 5.19-rc2

Changes since v1:
 - remove another unused function
 - improve a few commit logs
 - add three more patches from Robin

Diffstat:
 arch/arm/common/dmabounce.c                          |  582 -----------------
 arch/arm/include/asm/dma-mapping.h                   |  128 ---
 b/arch/arm/Kconfig                                   |    5 
 b/arch/arm/common/Kconfig                            |    6 
 b/arch/arm/common/Makefile                           |    1 
 b/arch/arm/common/sa1111.c                           |   64 -
 b/arch/arm/include/asm/device.h                      |    3 
 b/arch/arm/include/asm/dma-direct.h                  |   49 -
 b/arch/arm/include/asm/memory.h                      |    2 
 b/arch/arm/mach-footbridge/Kconfig                   |    1 
 b/arch/arm/mach-footbridge/common.c                  |   19 
 b/arch/arm/mach-footbridge/include/mach/dma-direct.h |    8 
 b/arch/arm/mach-footbridge/include/mach/memory.h     |    4 
 b/arch/arm/mach-highbank/highbank.c                  |    2 
 b/arch/arm/mach-mvebu/coherency.c                    |    2 
 b/arch/arm/mm/dma-mapping.c                          |  649 ++-----------------
 b/drivers/usb/core/hcd.c                             |   17 
 b/drivers/usb/host/ohci-sa1111.c                     |   25 
 18 files changed, 137 insertions(+), 1430 deletions(-)
