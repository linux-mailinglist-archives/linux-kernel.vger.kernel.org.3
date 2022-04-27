Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169C7511921
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238775AbiD0Ovt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238750AbiD0Ouj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:50:39 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357A03BA4B;
        Wed, 27 Apr 2022 07:47:27 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23R8jpdZ029645;
        Wed, 27 Apr 2022 07:47:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=IXW8izC+70e6HnGnlIiBj31HZtDnovvL6iYq2sB8/5A=;
 b=FBx4GZjhRGy/Dq5FDKGVUM/eS4zyXQGcfuHJuVwK8xjTUWFSsuBrfzbZysXQLDB2u3m6
 GMArQqb6hSBSptrFIY8qWRhl70vB/hWEFmaUCUfAtlWoCXcbQJm+xuY6LmCYnLTwt37H
 8qpNniETqBAvRLZSbOYIAbsF8l57HjSilLWg4Butold3AC+qArIALoH97yQdDpAX2550
 EMAKffIs4Fgfc9kmB7PJC1Gy8IUmr1xvDq6Sbr8qwAnQX3OFLYZz2Wb1EdknvyL85vSC
 tHgSeRB3vwI8CEA9QdO85Po0tA3wt3J87RkjgYSA5hyAWgtJUk558KQuoJ8BtLehHfvT DA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3fprsqu7c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 07:47:24 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Apr
 2022 07:47:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 07:47:23 -0700
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 2EB883F7063;
        Wed, 27 Apr 2022 07:47:23 -0700 (PDT)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <rric@kernel.org>,
        <cchavva@marvell.com>, <wsadowski@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH 4/5] gpio: thunderx: extend PIN_SEL_MASK to cover otx2 platform
Date:   Wed, 27 Apr 2022 07:46:19 -0700
Message-ID: <20220427144620.9105-5-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220427144620.9105-1-pmalgujar@marvell.com>
References: <20220427144620.9105-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wZSqUzC7mEqMcS_b2O2sMGq8zt872j0H
X-Proofpoint-GUID: wZSqUzC7mEqMcS_b2O2sMGq8zt872j0H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extending the PIN_SEL_MASK to support otx2 platform which was
earlier RAZ.

Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/gpio/gpio-thunderx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-thunderx.c b/drivers/gpio/gpio-thunderx.c
index 451c412512450fea717937376002d2ba35d1c508..87ab1ad7e652347a67b7747ea497b944498a8b41 100644
--- a/drivers/gpio/gpio-thunderx.c
+++ b/drivers/gpio/gpio-thunderx.c
@@ -32,7 +32,7 @@
 #define  GPIO_BIT_CFG_FIL_CNT_SHIFT	4
 #define  GPIO_BIT_CFG_FIL_SEL_SHIFT	8
 #define  GPIO_BIT_CFG_TX_OD		BIT(12)
-#define  GPIO_BIT_CFG_PIN_SEL_MASK	GENMASK(25, 16)
+#define  GPIO_BIT_CFG_PIN_SEL_MASK	GENMASK(26, 16)
 #define GPIO_INTR	0x800
 #define  GPIO_INTR_INTR			BIT(0)
 #define  GPIO_INTR_INTR_W1S		BIT(1)
-- 
2.17.1

