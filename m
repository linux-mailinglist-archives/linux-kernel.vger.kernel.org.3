Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AA24E9A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244335AbiC1PLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244265AbiC1PKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:10:50 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0DF25D678;
        Mon, 28 Mar 2022 08:09:08 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id A5BAF1D9D79;
        Thu, 24 Mar 2022 04:25:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru A5BAF1D9D79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648085134;
        bh=x89tsMKho6WoVTq6R1YvpMJGBDqdDnQvgiGVKdpmT88=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=lWhm1tbMirzpzxmTwcDIWSj/Ofvbjv8L+V09oTbOOx0D7ucDvxBDmnGHObLZw+08C
         LA77/bp+wewlv2lpTC7P/b13a6p+ZjTXM2BRcJKeyc+7/ye4QQaXmw0BLY+slzotof
         QwMKj8CDN3Dq15mtyPdEPuw+YjVdWSMMfMhBwVDg=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:25:34 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/12] PCI: dwc-plat: Simplify the probe method return value handling
Date:   Thu, 24 Mar 2022 04:25:21 +0300
Message-ID: <20220324012524.16784-11-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whole switch-case-logic implemented in the DWC PCIe RC/EP probe
procedure doesn't seem well thought through. First of all the ret variable
is unused in the EP-case and is only partly involved in the RC-case of the
switch-case statement, which unnecessary complicates the code. Secondly
the probe method will return zero if an unknown mode is detected. That is
improbable situation since the OF-device data is initialized only with
valid modes, but such code is still wrong at least from maintainability
point of view. So let's convert the switch-case part of the probe function
to being more coherent. We suggest to use the local ret variable to
preserve the status of the case-clauses and return its value from the
probe procedure after the work is done.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/pci/controller/dwc/pcie-designware-plat.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 0c5de87d3cc6..fea785096261 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -153,20 +153,21 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 			return -ENODEV;
 
 		ret = dw_plat_add_pcie_port(dw_plat_pcie, pdev);
-		if (ret < 0)
-			return ret;
 		break;
 	case DW_PCIE_EP_TYPE:
 		if (!IS_ENABLED(CONFIG_PCIE_DW_PLAT_EP))
 			return -ENODEV;
 
 		pci->ep.ops = &pcie_ep_ops;
-		return dw_pcie_ep_init(&pci->ep);
+		ret = dw_pcie_ep_init(&pci->ep);
+		break;
 	default:
 		dev_err(dev, "INVALID device type %d\n", dw_plat_pcie->mode);
+		ret = -EINVAL;
+		break;
 	}
 
-	return 0;
+	return ret;
 }
 
 static const struct dw_plat_pcie_of_data dw_plat_pcie_rc_of_data = {
-- 
2.35.1

