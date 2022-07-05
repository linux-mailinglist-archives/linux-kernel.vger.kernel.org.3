Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFB25660AE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 03:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbiGEBZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 21:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiGEBZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 21:25:33 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF636403
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 18:25:32 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220705012530epoutp027af5b7d6d6f95f63c1b408e50a29d6ad~_ynglEvHS2744527445epoutp02Z
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 01:25:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220705012530epoutp027af5b7d6d6f95f63c1b408e50a29d6ad~_ynglEvHS2744527445epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656984330;
        bh=AzNm0xLY0Fnv3a1td38IRyzqImN7mPuakVjbDTWje5E=;
        h=From:To:Cc:Subject:Date:References:From;
        b=QMfaLsHJZgxQWL3lRLi06P9JzMri47k5Au8p5IcAignDLdJbu/zMRU/6ZhVJClobu
         MkzawLj8pqffxlVuW4xwzqIxYwAoxgO1mlmf4pzn4C86kMw0+37qcuhrgrz2NwEwib
         P38HCwC69fQH662WsHXbtqdQ5NdR9rsj5mmp8950=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220705012529epcas1p3fcbe8cb4e5d08815553e9a87ebffaa0e~_yngG5itU0897108971epcas1p3N;
        Tue,  5 Jul 2022 01:25:29 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.224]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LcQ306kmcz4x9Q1; Tue,  5 Jul
        2022 01:25:16 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.B6.09678.CF293C26; Tue,  5 Jul 2022 10:25:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220705012516epcas1p2c15e9e9984735c32bcc754ff646ccbf3~_ynTrSTUs1325313253epcas1p2d;
        Tue,  5 Jul 2022 01:25:16 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220705012516epsmtrp14ab3b045ea3aa460de23dabcf781b1bd~_ynTqDh6I3155031550epsmtrp14;
        Tue,  5 Jul 2022 01:25:16 +0000 (GMT)
X-AuditID: b6c32a39-e51ff700000025ce-50-62c392fcfff1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.74.08802.CF293C26; Tue,  5 Jul 2022 10:25:16 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.71]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220705012516epsmtip24a17a858fe0d52d8c74432fea1f405ac~_ynTaIzao1416314163epsmtip2U;
        Tue,  5 Jul 2022 01:25:16 +0000 (GMT)
From:   Seunghui Lee <sh043.lee@samsung.com>
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, Avri.Altman@wdc.com,
        shawn.lin@rock-chips.com, adrian.hunter@intel.com
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, junwoo80.lee@samsung.com,
        jangsub.yi@samsung.com, cw9316.lee@samsung.com,
        sh8267.baek@samsung.com, wkon.kim@samsung.com,
        seunghwan.hyun@samsung.com, Seunghui Lee <sh043.lee@samsung.com>
Subject: [PATCH] mmc: use mmc_card_* macro and add it for sd_combo
Date:   Tue,  5 Jul 2022 10:57:29 +0900
Message-Id: <20220705015729.14455-1-sh043.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmru6fSYeTDF4sN7I4+WQNm8XLn1fZ
        LFbf7WezmHGqjdVi37WT7Ba//q5nt+jYOpnJYsfzM+wWu/42M1lc3jWHzeLI/35Gi3MnP7Fa
        NP3Zx2Jx7cwJVos7T9azWhxfG26x+dI3FgdBj8V7XjJ5XD5b6nHn2h42j7+z9rN49G1Zxejx
        eZOcR/uBbqYA9qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRef
        AF23zBygB5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BWYFesWJucWleel6eakl
        VoYGBkamQIUJ2Rm/70xnLrhmWPHv0k+WBsYHGl2MHBwSAiYSv7ucuhi5OIQEdjBK9DT9ZoJw
        PjFKbPxxkhXC+cwo8WXKN5YuRk6wjomfNkFV7WKU+LzhDELVuv4L7CBVbAJaEtM3bQGrEhHY
        wChxdf07NhCHWaCHSeL3pe+sIFXCAk4Ss1pmgXWwCKhKXO24zQ5yFa+AlcTah8oQ6+Ql/tzv
        YQaxeQUEJU7OfAJ2BjNQvHnrbGaQmRICKzkkHl09yAjR4CJxauMRKFtY4tXxLewQtpTEy/42
        KLtYou3fP2YIu0LiYN8XKNtY4tPnz4wgNzALaEqs36UPEVaU2Pl7LiPEXj6Jd197WCGBxyvR
        0SYEUaIs8fLRMiYIW1JiSfstqIkeEleerwL7VkggVmLpswvsExjlZyH5ZhaSb2YhLF7AyLyK
        USy1oDg3PbXYsMAUHqvJ+bmbGMGJWMtyB+P0tx/0DjEycTAeYpTgYFYS4V016WCSEG9KYmVV
        alF+fFFpTmrxIUZTYPBOZJYSTc4H5oK8knhDE0sDEzMjEwtjS2MzJXHeVdNOJwoJpCeWpGan
        phakFsH0MXFwSjUwKf3aGmZZzfN0lXKA8tonz6YY1exU2Bfxe9qxucF3qlXl23i7Wz6fuiLI
        8TMpYW2/j1/Px1kc3u88dOIXnSxnYxZcanJl5YRrjgesmXRmORieZ/uffGZvuskS40PPK67O
        6X+6uLGuOl/SbrKo0KSAV9UzGNamC93NMJrx1W/D2UJOd0PD2W1nVp/xN17NUfaYUdS/Jzxy
        0l6JMpabWgK3H65NOXrpW/8br1c3GXaoqMXUm9yU2SmyyorROuL/rNxVlz6tP3eWZe+i0P1i
        JwtPreAoC1dYmf37WwDnJ/urB7Qq797Yu+xeUJuOCFPtBAkvG/tXTznkPyz/+z5gscN+a43s
        f2oTz8zZribqY21mo8RSnJFoqMVcVJwIAA0seP1NBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSvO6fSYeTDCbNErQ4+WQNm8XLn1fZ
        LFbf7WezmHGqjdVi37WT7Ba//q5nt+jYOpnJYsfzM+wWu/42M1lc3jWHzeLI/35Gi3MnP7Fa
        NP3Zx2Jx7cwJVos7T9azWhxfG26x+dI3FgdBj8V7XjJ5XD5b6nHn2h42j7+z9rN49G1Zxejx
        eZOcR/uBbqYA9igum5TUnMyy1CJ9uwSujN93pjMXXDOs+HfpJ0sD4wONLkZODgkBE4mJnzYx
        dTFycQgJ7GCUWLPqCgtEQlJi8aOHbF2MHEC2sMThw8UQNR8ZJb6fnM4IUsMmoCUxfdMWJhBb
        BKT59lsdkCJmgRlMEo+WbwUrEhZwkpjVMosdxGYRUJW42nGbHWQor4CVxNqHyhC75CX+3O9h
        BrF5BQQlTs58AnYDM1C8eets5gmMfLOQpGYhSS1gZFrFKJlaUJybnltsWGCUl1quV5yYW1ya
        l66XnJ+7iREcGVpaOxj3rPqgd4iRiYPxEKMEB7OSCO+qSQeThHhTEiurUovy44tKc1KLDzFK
        c7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamBaJPF1R3HLOblGJZ3Dycv/H0i4y2d2LE8u
        YCPjBTbdGO+4RVf/ey7OthRdtizEO4Ltghtn3OfMJSoxX5L/ZpWnz1rcuFRx022+o+sXn0/g
        vJeQzPDZ8MOP1gTx7rU7OzVe7lWP5uy6tL6HxVbr6oXLXQFy+dzNZ2c1NLO8/cj/NnTNxS8K
        K96t0u++y7NuPn+kS8J/3Xl3Q34sWlwl9P1bvercXuXwy+dNnf5O5uLa+0Bv+jVrjZfz/tpf
        3V79bf8CMYvFFTYJz/vm1OzYryTQ+CXvysL6hs0s1aln5l07G/pA8w8vg/VZ34k2E6MFBH5X
        Gz+6ksVsyfb672v19fUFv98u/Wbx6uLmVXK8WjOslViKMxINtZiLihMBadfBNfsCAAA=
X-CMS-MailID: 20220705012516epcas1p2c15e9e9984735c32bcc754ff646ccbf3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220705012516epcas1p2c15e9e9984735c32bcc754ff646ccbf3
References: <CGME20220705012516epcas1p2c15e9e9984735c32bcc754ff646ccbf3@epcas1p2.samsung.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add mmc_card_sd_combo() macro for sd combo type card and
use mmc_card_* macro to simplify instead of comparing card->type

Signed-off-by: Seunghui Lee <sh043.lee@samsung.com>
---
 drivers/mmc/core/block.c  |  4 ++--
 drivers/mmc/core/bus.c    |  4 ++--
 drivers/mmc/core/sd.c     |  2 +-
 drivers/mmc/core/sdio.c   | 16 ++++++++--------
 drivers/mmc/host/mxcmmc.c |  2 +-
 include/linux/mmc/card.h  |  1 +
 6 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index bda6c67ce93f..4d7ae8fc2901 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2987,7 +2987,7 @@ static int mmc_blk_probe(struct mmc_card *card)
 	 * Don't enable runtime PM for SD-combo cards here. Leave that
 	 * decision to be taken during the SDIO init sequence instead.
 	 */
-	if (card->type != MMC_TYPE_SD_COMBO) {
+	if (!mmc_card_sd_combo(card)) {
 		pm_runtime_set_active(&card->dev);
 		pm_runtime_enable(&card->dev);
 	}
@@ -3014,7 +3014,7 @@ static void mmc_blk_remove(struct mmc_card *card)
 		mmc_blk_part_switch(card, md->part_type);
 		mmc_release_host(card->host);
 	}
-	if (card->type != MMC_TYPE_SD_COMBO)
+	if (!mmc_card_sd_combo(card))
 		pm_runtime_disable(&card->dev);
 	pm_runtime_put_noidle(&card->dev);
 	mmc_blk_remove_req(md);
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 58a60afa650b..d8762fa3d5cd 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -85,7 +85,7 @@ mmc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 			return retval;
 	}
 
-	if (card->type == MMC_TYPE_SDIO || card->type == MMC_TYPE_SD_COMBO) {
+	if (mmc_card_sdio(card) || mmc_card_sd_combo(card)) {
 		retval = add_uevent_var(env, "SDIO_ID=%04X:%04X",
 					card->cis.vendor, card->cis.device);
 		if (retval)
@@ -107,7 +107,7 @@ mmc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 	 * SDIO (non-combo) cards are not handled by mmc_block driver and do not
 	 * have accessible CID register which used by mmc_card_name() function.
 	 */
-	if (card->type == MMC_TYPE_SDIO)
+	if (mmc_card_sdio(card))
 		return 0;
 
 	retval = add_uevent_var(env, "MMC_NAME=%s", mmc_card_name(card));
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index c5f1df6ce4c0..f0186bdf2025 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -793,7 +793,7 @@ static umode_t sd_std_is_visible(struct kobject *kobj, struct attribute *attr,
 	     attr == &dev_attr_info2.attr ||
 	     attr == &dev_attr_info3.attr ||
 	     attr == &dev_attr_info4.attr
-	    ) && card->type != MMC_TYPE_SD_COMBO)
+	    ) &&!mmc_card_sd_combo(card))
 		return 0;
 
 	return attr->mode;
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 25799accf8a0..b589df1c35e0 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -335,7 +335,7 @@ static int sdio_disable_4bit_bus(struct mmc_card *card)
 {
 	int err;
 
-	if (card->type == MMC_TYPE_SDIO)
+	if (mmc_card_sdio(card))
 		goto out;
 
 	if (!(card->host->caps & MMC_CAP_4_BIT_DATA))
@@ -360,7 +360,7 @@ static int sdio_enable_4bit_bus(struct mmc_card *card)
 	err = sdio_enable_wide(card);
 	if (err <= 0)
 		return err;
-	if (card->type == MMC_TYPE_SDIO)
+	if (mmc_card_sdio(card))
 		goto out;
 
 	if (card->scr.bus_widths & SD_SCR_BUS_WIDTH_4) {
@@ -415,7 +415,7 @@ static int sdio_enable_hs(struct mmc_card *card)
 	int ret;
 
 	ret = mmc_sdio_switch_hs(card, true);
-	if (ret <= 0 || card->type == MMC_TYPE_SDIO)
+	if (ret <= 0 || mmc_card_sdio(card))
 		return ret;
 
 	ret = mmc_sd_switch_hs(card);
@@ -441,7 +441,7 @@ static unsigned mmc_sdio_get_max_clock(struct mmc_card *card)
 		max_dtr = card->cis.max_dtr;
 	}
 
-	if (card->type == MMC_TYPE_SD_COMBO)
+	if (mmc_card_sd_combo(card))
 		max_dtr = min(max_dtr, mmc_sd_get_max_clock(card));
 
 	return max_dtr;
@@ -689,7 +689,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	    mmc_sd_get_cid(host, ocr & rocr, card->raw_cid, NULL) == 0) {
 		card->type = MMC_TYPE_SD_COMBO;
 
-		if (oldcard && (oldcard->type != MMC_TYPE_SD_COMBO ||
+		if (oldcard && (!mmc_card_sd_combo(oldcard) ||
 		    memcmp(card->raw_cid, oldcard->raw_cid, sizeof(card->raw_cid)) != 0)) {
 			err = -ENOENT;
 			goto mismatch;
@@ -697,7 +697,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	} else {
 		card->type = MMC_TYPE_SDIO;
 
-		if (oldcard && oldcard->type != MMC_TYPE_SDIO) {
+		if (oldcard && !mmc_card_sdio(oldcard)) {
 			err = -ENOENT;
 			goto mismatch;
 		}
@@ -754,7 +754,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	/*
 	 * Read CSD, before selecting the card
 	 */
-	if (!oldcard && card->type == MMC_TYPE_SD_COMBO) {
+	if (!oldcard && mmc_card_sd_combo(card)) {
 		err = mmc_sd_get_csd(card);
 		if (err)
 			goto remove;
@@ -827,7 +827,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 
 	mmc_fixup_device(card, sdio_fixup_methods);
 
-	if (card->type == MMC_TYPE_SD_COMBO) {
+	if (mmc_card_sd_combo(card)) {
 		err = mmc_sd_setup_card(host, card, oldcard != NULL);
 		/* handle as SDIO-only card if memory init failed */
 		if (err) {
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 613f13306433..2cf0413407ea 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -923,7 +923,7 @@ static void mxcmci_init_card(struct mmc_host *host, struct mmc_card *card)
 	 * One way to prevent this is to only allow 1-bit transfers.
 	 */
 
-	if (is_imx31_mmc(mxcmci) && card->type == MMC_TYPE_SDIO)
+	if (is_imx31_mmc(mxcmci) && mmc_card_sdio(card))
 		host->caps &= ~MMC_CAP_4_BIT_DATA;
 	else
 		host->caps |= MMC_CAP_4_BIT_DATA;
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 37f975875102..156a7b673a28 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -348,5 +348,6 @@ bool mmc_card_is_blockaddr(struct mmc_card *card);
 #define mmc_card_mmc(c)		((c)->type == MMC_TYPE_MMC)
 #define mmc_card_sd(c)		((c)->type == MMC_TYPE_SD)
 #define mmc_card_sdio(c)	((c)->type == MMC_TYPE_SDIO)
+#define mmc_card_sd_combo(c)	((c)->type == MMC_TYPE_SD_COMBO)
 
 #endif /* LINUX_MMC_CARD_H */
-- 
2.29.0

