Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66894BA9C6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245174AbiBQT14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:27:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiBQT1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:27:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03C0710459A;
        Thu, 17 Feb 2022 11:27:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90D5F113E;
        Thu, 17 Feb 2022 11:27:38 -0800 (PST)
Received: from e122247.arm.com (E122209.Arm.com [10.50.65.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4B863F70D;
        Thu, 17 Feb 2022 11:27:36 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: ccree: don't attempt 0 len DMA mappings
Date:   Thu, 17 Feb 2022 21:27:26 +0200
Message-Id: <20220217192726.612328-1-gilad@benyossef.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refuse to try mapping zero bytes as this may cause a fault
on some configurations / platforms and it seems the prev.
attempt is not enough and we need to be more explicit.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Reported-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Fixes: ce0fc6db38de ("crypto: ccree - protect against empty or NULL
scatterlists")
---
 drivers/crypto/ccree/cc_buffer_mgr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/crypto/ccree/cc_buffer_mgr.c b/drivers/crypto/ccree/cc_buffer_mgr.c
index a5e041d9d2cf..11e0278c8631 100644
--- a/drivers/crypto/ccree/cc_buffer_mgr.c
+++ b/drivers/crypto/ccree/cc_buffer_mgr.c
@@ -258,6 +258,13 @@ static int cc_map_sg(struct device *dev, struct scatterlist *sg,
 {
 	int ret = 0;
 
+	if (!nbytes) {
+		*mapped_nents = 0;
+		*lbytes = 0;
+		*nents = 0;
+		return 0;
+	}
+
 	*nents = cc_get_sgl_nents(dev, sg, nbytes, lbytes);
 	if (*nents > max_sg_nents) {
 		*nents = 0;
-- 
2.25.1

