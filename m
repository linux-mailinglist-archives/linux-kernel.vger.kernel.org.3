Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4446F4F5C20
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbiDFLZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237092AbiDFLYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:24:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88060B6461;
        Wed,  6 Apr 2022 01:12:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4403F23A;
        Wed,  6 Apr 2022 01:12:03 -0700 (PDT)
Received: from e122247.kfn.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 068C43F718;
        Wed,  6 Apr 2022 01:12:00 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Dung Nguyen <dung.nguyen.zy@renesas.com>,
        Jing Dan <jing.dan.nx@renesas.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] crypto: ccree: rearrange init calls to avoid race
Date:   Wed,  6 Apr 2022 11:11:38 +0300
Message-Id: <20220406081139.1963615-2-gilad@benyossef.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220406081139.1963615-1-gilad@benyossef.com>
References: <20220406081139.1963615-1-gilad@benyossef.com>
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

Rearrange init calls to avoid the rare race condition of
the cipher algs being registered and used while we still
init the hash code which uses the HW without proper lock.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Reported-by: Dung Nguyen <dung.nguyen.zy@renesas.com>
Tested-by: Jing Dan <jing.dan.nx@renesas.com>
Tested-by: Dung Nguyen <dung.nguyen.zy@renesas.com>
Fixes: 63893811b0fc("crypto: ccree - add ahash support")
---
 drivers/crypto/ccree/cc_driver.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
index 790fa9058a36..7d1bee86d581 100644
--- a/drivers/crypto/ccree/cc_driver.c
+++ b/drivers/crypto/ccree/cc_driver.c
@@ -529,24 +529,26 @@ static int init_cc_resources(struct platform_device *plat_dev)
 		goto post_req_mgr_err;
 	}
 
-	/* Allocate crypto algs */
-	rc = cc_cipher_alloc(new_drvdata);
+	/* hash must be allocated first due to use of send_request_init()
+	 * and dependency of AEAD on it
+	 */
+	rc = cc_hash_alloc(new_drvdata);
 	if (rc) {
-		dev_err(dev, "cc_cipher_alloc failed\n");
+		dev_err(dev, "cc_hash_alloc failed\n");
 		goto post_buf_mgr_err;
 	}
 
-	/* hash must be allocated before aead since hash exports APIs */
-	rc = cc_hash_alloc(new_drvdata);
+	/* Allocate crypto algs */
+	rc = cc_cipher_alloc(new_drvdata);
 	if (rc) {
-		dev_err(dev, "cc_hash_alloc failed\n");
-		goto post_cipher_err;
+		dev_err(dev, "cc_cipher_alloc failed\n");
+		goto post_hash_err;
 	}
 
 	rc = cc_aead_alloc(new_drvdata);
 	if (rc) {
 		dev_err(dev, "cc_aead_alloc failed\n");
-		goto post_hash_err;
+		goto post_cipher_err;
 	}
 
 	/* If we got here and FIPS mode is enabled
@@ -558,10 +560,10 @@ static int init_cc_resources(struct platform_device *plat_dev)
 	pm_runtime_put(dev);
 	return 0;
 
-post_hash_err:
-	cc_hash_free(new_drvdata);
 post_cipher_err:
 	cc_cipher_free(new_drvdata);
+post_hash_err:
+	cc_hash_free(new_drvdata);
 post_buf_mgr_err:
 	 cc_buffer_mgr_fini(new_drvdata);
 post_req_mgr_err:
@@ -593,8 +595,8 @@ static void cleanup_cc_resources(struct platform_device *plat_dev)
 		(struct cc_drvdata *)platform_get_drvdata(plat_dev);
 
 	cc_aead_free(drvdata);
-	cc_hash_free(drvdata);
 	cc_cipher_free(drvdata);
+	cc_hash_free(drvdata);
 	cc_buffer_mgr_fini(drvdata);
 	cc_req_mgr_fini(drvdata);
 	cc_fips_fini(drvdata);
-- 
2.25.1

