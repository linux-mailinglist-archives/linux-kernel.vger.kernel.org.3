Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CDD4FF8C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbiDMOTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiDMOTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:19:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AFCF61A3F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649859429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFQ4n1ZiT6nh1FIp/j+v44jFK47JkInxV4Qw8iHhfA8=;
        b=XVMTvjWOuD7HrWS+o2KY2GAQwnz8oMUGy0k9Prq4QX5nSzcYUHZsiDVKI5XqXK/yB8HuWC
        LBMc7ZfkTS8hrXxl/f89/WOkZeboRy4vb4PBMOzZ6FBkVbmlqk87TiFuoVnbtQ+uHt7g5h
        Y08h7XxCztorNXYp+aDGTpPY6vZRNTM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-7_UcDZFDO6mf85hfRU0-Mg-1; Wed, 13 Apr 2022 10:17:06 -0400
X-MC-Unique: 7_UcDZFDO6mf85hfRU0-Mg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CDF6729DD986;
        Wed, 13 Apr 2022 14:17:05 +0000 (UTC)
Received: from rules.brq.redhat.com (unknown [10.40.208.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FB979D42;
        Wed, 13 Apr 2022 14:17:03 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     vdronov@redhat.com, Sunil Goutham <sgoutham@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Joseph Longever <jlongever@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwrng: cn10k - Make check_rng_health() return an error code
Date:   Wed, 13 Apr 2022 16:16:06 +0200
Message-Id: <20220413141606.8261-3-vdronov@redhat.com>
In-Reply-To: <20220413141606.8261-1-vdronov@redhat.com>
References: <20220413141606.8261-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently check_rng_health() returns zero unconditionally.
Make it to output an error code and return it.

Fixes: 38e9791a0209 ("hwrng: cn10k - Add random number generator support")
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 drivers/char/hw_random/cn10k-rng.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/char/hw_random/cn10k-rng.c b/drivers/char/hw_random/cn10k-rng.c
index dd226630b67d..a01e9307737c 100644
--- a/drivers/char/hw_random/cn10k-rng.c
+++ b/drivers/char/hw_random/cn10k-rng.c
@@ -31,26 +31,23 @@ struct cn10k_rng {
 
 #define PLAT_OCTEONTX_RESET_RNG_EBG_HEALTH_STATE     0xc2000b0f
 
-static int reset_rng_health_state(struct cn10k_rng *rng)
+static unsigned long reset_rng_health_state(struct cn10k_rng *rng)
 {
 	struct arm_smccc_res res;
 
 	/* Send SMC service call to reset EBG health state */
 	arm_smccc_smc(PLAT_OCTEONTX_RESET_RNG_EBG_HEALTH_STATE, 0, 0, 0, 0, 0, 0, 0, &res);
-	if (res.a0 != 0UL)
-		return -EIO;
-
-	return 0;
+	return res.a0;
 }
 
 static int check_rng_health(struct cn10k_rng *rng)
 {
 	u64 status;
-	int err;
+	unsigned long err;
 
 	/* Skip checking health */
 	if (!rng->reg_base)
-		return 0;
+		return -ENODEV;
 
 	status = readq(rng->reg_base + RNM_PF_EBG_HEALTH);
 	if (status & BIT_ULL(20)) {
@@ -58,7 +55,9 @@ static int check_rng_health(struct cn10k_rng *rng)
 		if (err) {
 			dev_err(&rng->pdev->dev, "HWRNG: Health test failed (status=%llx)\n",
 					status);
-			dev_err(&rng->pdev->dev, "HWRNG: error during reset\n");
+			dev_err(&rng->pdev->dev, "HWRNG: error during reset (error=%lx)\n",
+					err);
+			return -EIO;
 		}
 	}
 	return 0;
-- 
2.35.1

