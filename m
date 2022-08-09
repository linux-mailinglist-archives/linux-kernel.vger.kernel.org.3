Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C33458DD9A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 20:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344359AbiHISCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 14:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344367AbiHISBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:01:47 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8371A26AF3
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:01:03 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q6-20020a17090a1b0600b001f558bbb924so5102475pjq.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 11:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=JMRo2ixMHb3JOzogb+sGCIpZ2H1yxkZ6X1ZhcAfiIwI=;
        b=LT0t1bsNi8ymDwfrg5OhBBNiiN6VxO9/fwn7AvNHMR/6BvRV9oxpUACqkfuuJu5N07
         JwWFYys2GuTgOEr3E7lIRNpoQ6NyHZFOZxsupWY+Y1Yr0XRfNylilp/WjbfFgu6T30E4
         l2HD4L+hAzGNBKuezkfRGtO1GGi2Pjgk0Hg2kDN5c4U1otuRHvXorqAcsqsrW5CBXtI7
         3/Krs46z/tZ622sMN7iocrknfmHuHLF8ci5dTAVb4E6VpTzsrTR/ncbGmlo/BX8kQYRK
         n76LkKXT29nExez07OJW/SsqIMRyYJMpkzei6bpllpoKHHNqEj95xWjZLLTnXFdvHbDP
         bVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=JMRo2ixMHb3JOzogb+sGCIpZ2H1yxkZ6X1ZhcAfiIwI=;
        b=syyWiFa+uF6h03/CqiXIZ8Mq2DEflgQaTTDoX3ur0PXw/PZgSD77O3VlHXH1xsWacZ
         dpFUfaa9aE633zDheldOZ0vQjX2FfHvC8lnjp8hw2/R019Z30zY33apdetLWSGXyKZfh
         Mie//jrdc6WxA8A3X9tWVjBj0hgDgjPsYLc2QbZh+bMLctjFLrz9eoHQUVLK/aPu+loi
         y0kIQwUmwDbJxYg9dYf+nGHPQWzIJ/aVYIuNa2JEQ8Oi09JM5QJS0qSJCkdSNTQn996T
         aks/f+vGg1EIiR53ecrTL0HOmIxnySMuX6Zwn3CtldMTz7i/GvtdttOh51yO4/H5mjOX
         xxrw==
X-Gm-Message-State: ACgBeo2e+0GdtvK0u7tx84SFo9nglDy9lhA6XirjH/kXJ4ikxKNMJ/b4
        9B6UVe1HkBdhnIdIt8Eh8brRwYDidHiVYZf2Cs0=
X-Google-Smtp-Source: AA6agR7Cc5DUEBvfdyA5rq0jFSyZ+4r/tBcU9vcCcTtzlfHE3q1eOu8BjALWVEzjrnX+XR7J3lm6bhmIuXswNRqDLM4=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a17:902:cece:b0:16e:ea30:6287 with
 SMTP id d14-20020a170902cece00b0016eea306287mr24265895plg.104.1660068062910;
 Tue, 09 Aug 2022 11:01:02 -0700 (PDT)
Date:   Tue,  9 Aug 2022 18:00:49 +0000
In-Reply-To: <20220809180051.1063653-1-willmcvicker@google.com>
Message-Id: <20220809180051.1063653-2-willmcvicker@google.com>
Mime-Version: 1.0
References: <20220809180051.1063653-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v1 1/2] PCI: dwc: drop dependency on ZONE_DMA32
From:   Will McVicker <willmcvicker@google.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Will McVicker <willmcvicker@google.com>
Cc:     kernel-team@android.com, Vidya Sagar <vidyas@nvidia.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-work the msi_msg DMA allocation logic to use dma_alloc_coherent()
which uses the coherent DMA mask to try and return an allocation within
the DMA mask limits. This allows kernel configurations that disable
ZONE_DMA32 to continue supporting a 32-bit DMA mask. Without this patch,
the PCIe host device will fail to probe when ZONE_DMA32 is disabled.

Fixes: 35797e672ff0 ("PCI: dwc: Fix MSI msi_msg DMA mapping")
Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 7746f94a715f..0cfc3c098f13 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -272,9 +272,9 @@ static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
 		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 		struct device *dev = pci->dev;
 
-		dma_unmap_page(dev, pp->msi_data, PAGE_SIZE, DMA_FROM_DEVICE);
-		if (pp->msi_page)
-			__free_page(pp->msi_page);
+		dma_free_coherent(dev, PAGE_SIZE, pp->msi_page, pp->msi_data);
+		pp->msi_data = 0;
+		pp->msi_page = NULL;
 	}
 }
 
@@ -375,22 +375,22 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 						    dw_chained_msi_isr, pp);
 	}
 
-	ret = dma_set_mask(dev, DMA_BIT_MASK(32));
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret)
 		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
 
-	pp->msi_page = alloc_page(GFP_DMA32);
-	pp->msi_data = dma_map_page(dev, pp->msi_page, 0,
-				    PAGE_SIZE, DMA_FROM_DEVICE);
-	ret = dma_mapping_error(dev, pp->msi_data);
-	if (ret) {
-		dev_err(pci->dev, "Failed to map MSI data\n");
-		__free_page(pp->msi_page);
-		pp->msi_page = NULL;
+	pp->msi_page = dma_alloc_coherent(dev, PAGE_SIZE, &pp->msi_data,
+					  GFP_KERNEL);
+	if (!pp->msi_page || dma_mapping_error(dev, pp->msi_data)) {
+		dev_err(dev, "Failed to alloc and map MSI data\n");
+		if (pp->msi_page) {
+			dma_free_coherent(dev, PAGE_SIZE, pp->msi_page,
+					  pp->msi_data);
+			pp->msi_page = NULL;
+		}
 		pp->msi_data = 0;
 		dw_pcie_free_msi(pp);
-
-		return ret;
+		return -ENOMEM;
 	}
 
 	return 0;
-- 
2.37.1.559.g78731f0fdb-goog

