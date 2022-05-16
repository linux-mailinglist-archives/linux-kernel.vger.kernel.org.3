Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EB75281A3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242338AbiEPKRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241408AbiEPKQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:16:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCD60DE9C;
        Mon, 16 May 2022 03:16:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A49D11FB;
        Mon, 16 May 2022 03:16:42 -0700 (PDT)
Received: from ampere-altra-2-1.usa.Arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 35B613F66F;
        Mon, 16 May 2022 03:16:42 -0700 (PDT)
From:   yoan.picchi@arm.com
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] crypto: qat: replace get_current_node() with numa_node_id()
Date:   Mon, 16 May 2022 10:16:34 +0000
Message-Id: <20220516101635.1082132-2-yoan.picchi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516101635.1082132-1-yoan.picchi@arm.com>
References: <20220516101635.1082132-1-yoan.picchi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Przywara <andre.przywara@arm.com>

Currently the QAT driver code uses a self-defined wrapper function
called get_current_node() when it wants to learn the current NUMA node.
This implementation references the topology_physical_package_id[] array,
which more or less coincidentally contains the NUMA node id, at least
on x86.

Because this is not universal, and Linux offers a direct function to
learn the NUMA node ID, replace that function with a call to
numa_node_id(), which would work everywhere.

This fixes the QAT driver operation on arm64 machines.

Reported-by: Yoan Picchi <Yoan.Picchi@arm.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Yoan Picchi <yoan.picchi@arm.com>
---
 drivers/crypto/qat/qat_common/adf_common_drv.h | 5 -----
 drivers/crypto/qat/qat_common/qat_algs.c       | 4 ++--
 drivers/crypto/qat/qat_common/qat_asym_algs.c  | 4 ++--
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index e8c9b77c0d66..b582107db67b 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -49,11 +49,6 @@ struct service_hndl {
 	struct list_head list;
 };
 
-static inline int get_current_node(void)
-{
-	return topology_physical_package_id(raw_smp_processor_id());
-}
-
 int adf_service_register(struct service_hndl *service);
 int adf_service_unregister(struct service_hndl *service);
 
diff --git a/drivers/crypto/qat/qat_common/qat_algs.c b/drivers/crypto/qat/qat_common/qat_algs.c
index f998ed58457c..c0ffaebcc8b8 100644
--- a/drivers/crypto/qat/qat_common/qat_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_algs.c
@@ -618,7 +618,7 @@ static int qat_alg_aead_newkey(struct crypto_aead *tfm, const u8 *key,
 {
 	struct qat_alg_aead_ctx *ctx = crypto_aead_ctx(tfm);
 	struct qat_crypto_instance *inst = NULL;
-	int node = get_current_node();
+	int node = numa_node_id();
 	struct device *dev;
 	int ret;
 
@@ -1042,7 +1042,7 @@ static int qat_alg_skcipher_newkey(struct qat_alg_skcipher_ctx *ctx,
 {
 	struct qat_crypto_instance *inst = NULL;
 	struct device *dev;
-	int node = get_current_node();
+	int node = numa_node_id();
 	int ret;
 
 	inst = qat_crypto_get_instance_node(node);
diff --git a/drivers/crypto/qat/qat_common/qat_asym_algs.c b/drivers/crypto/qat/qat_common/qat_asym_algs.c
index b0b78445418b..3701eac10bce 100644
--- a/drivers/crypto/qat/qat_common/qat_asym_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_asym_algs.c
@@ -480,7 +480,7 @@ static int qat_dh_init_tfm(struct crypto_kpp *tfm)
 {
 	struct qat_dh_ctx *ctx = kpp_tfm_ctx(tfm);
 	struct qat_crypto_instance *inst =
-			qat_crypto_get_instance_node(get_current_node());
+			qat_crypto_get_instance_node(numa_node_id());
 
 	if (!inst)
 		return -EINVAL;
@@ -1218,7 +1218,7 @@ static int qat_rsa_init_tfm(struct crypto_akcipher *tfm)
 {
 	struct qat_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
 	struct qat_crypto_instance *inst =
-			qat_crypto_get_instance_node(get_current_node());
+			qat_crypto_get_instance_node(numa_node_id());
 
 	if (!inst)
 		return -EINVAL;
-- 
2.25.1

