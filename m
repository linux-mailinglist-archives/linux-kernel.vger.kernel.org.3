Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DFE4CBF22
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiCCNt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiCCNt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:49:58 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1CA48889;
        Thu,  3 Mar 2022 05:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646315352; x=1677851352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K3zaEHW1S0fJNBI4MmfbUZ44fQEWX4hjX1GkFZ8s7LY=;
  b=aH3on0SFW1hTOfcb59+iU6wasa2rr4tKp3kagcTeEILd+QtdpOnP+Ig7
   Y8sBgZKKQm4y9B2l04GLA5kvKeIBgmJRCNr8VmYYAxt21Dp4sj9LDdA6C
   Bae4xO9f2Nl4iBt6rRHrwA2t4b1z6ATtyQWKdylST/b3zwuw7wnVbKL9G
   EpkpUSi9TTk1B7CLhjBJGVk4moUIpxJCARGm2YH1L8T2zhvz/3+kgijc4
   DFono/QQ25QiA0w1SbVUx7ENYCpZEfCC64usLYqYjEsPSUdqHBt8R3LbP
   RRJNH6nQTzTQEW/PYMC+KAqNI2pYBEaATS7Dv4mO9zVWzsIsMkGvaYVo0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253410146"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="253410146"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 05:49:12 -0800
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="709928521"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 05:49:09 -0800
Date:   Thu, 3 Mar 2022 13:49:03 +0000
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kyle Sanderson <kyle.leet@gmail.com>,
        Dave Chinner <david@fromorbit.com>, qat-linux@intel.com,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: Intel QAT on A2SDi-8C-HLN4F causes massive data corruption with
 dm-crypt + xfs
Message-ID: <YiDHT31ujlGdQEe/@silpixa00400314>
References: <Yh0y75aegqS4jIP7@silpixa00400314>
 <Yh1aLfy/oBawCJIg@gondor.apana.org.au>
 <CAHk-=wi+xewHz=BH7LcZAxrj9JXi66s9rp+kBqRchVG3a-b2BA@mail.gmail.com>
 <Yh2c4Vwu61s51d6N@gondor.apana.org.au>
 <Yh9G7FyCLtsm2mFA@kroah.com>
 <Yh9ZvLHuztwQCu0d@silpixa00400314>
 <Yh+FpKuoyj3G16lK@kroah.com>
 <Yh/vY4t3xnuoCW3Q@gondor.apana.org.au>
 <Yh/yr6oB5yeOUErL@silpixa00400314>
 <Yh/znCnZzWaL49+o@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh/znCnZzWaL49+o@gondor.apana.org.au>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 10:45:48AM +1200, Herbert Xu wrote:
> On Wed, Mar 02, 2022 at 10:42:20PM +0000, Giovanni Cabiddu wrote:
> >
> > I was thinking, as an alternative, to lower the cra_priority in the QAT
> > driver for the algorithms used by dm-crypt so they are not used by
> > default.
> > Is that a viable option?
> 
> Yes I think that should work too.
The patch below implements that solution and applies to linux-5.4.y.
If it is ok, I can send it to stable for all kernels <= 5.4 following
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

---8<---
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Date: Thu, 3 Mar 2022 11:54:07 +0000
Subject: [PATCH] crypto: qat - drop priority of algorithms
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland

The implementations of aead and skcipher in the QAT driver are not
properly supporting requests with the CRYPTO_TFM_REQ_MAY_BACKLOG flag set.
If the HW queue is full, the driver returns -EBUSY but does not enqueue
the request.
This can result in applications like dm-crypt waiting indefinitely for a
completion of a request that was never submitted to the hardware.

To mitigate this problem, reduce the priority of all skcipher and aead
implementations in the QAT driver so they are not used by default.

This patch deviates from the original upstream solution, that prevents
dm-crypt to use drivers registered with the flag
CRYPTO_ALG_ALLOCATES_MEMORY, since a backport of that set to stable
kernels may have a too wide effect.

commit 7bcb2c99f8ed032cfb3f5596b4dccac6b1f501df upstream
commit 2eb27c11937ee9984c04b75d213a737291c5f58c upstream
commit fbb6cda44190d72aa5199d728797aabc6d2ed816 upstream
commit b8aa7dc5c7535f9abfca4bceb0ade9ee10cf5f54 upstream
commit cd74693870fb748d812867ba49af733d689a3604 upstream

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/qat/qat_common/qat_algs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/qat_algs.c b/drivers/crypto/qat/qat_common/qat_algs.c
index 6b8ad3d67481..a5c28a08fd8c 100644
--- a/drivers/crypto/qat/qat_common/qat_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_algs.c
@@ -1274,7 +1274,7 @@ static struct aead_alg qat_aeads[] = { {
 	.base = {
 		.cra_name = "authenc(hmac(sha1),cbc(aes))",
 		.cra_driver_name = "qat_aes_cbc_hmac_sha1",
-		.cra_priority = 4001,
+		.cra_priority = 1,
 		.cra_flags = CRYPTO_ALG_ASYNC,
 		.cra_blocksize = AES_BLOCK_SIZE,
 		.cra_ctxsize = sizeof(struct qat_alg_aead_ctx),
@@ -1291,7 +1291,7 @@ static struct aead_alg qat_aeads[] = { {
 	.base = {
 		.cra_name = "authenc(hmac(sha256),cbc(aes))",
 		.cra_driver_name = "qat_aes_cbc_hmac_sha256",
-		.cra_priority = 4001,
+		.cra_priority = 1,
 		.cra_flags = CRYPTO_ALG_ASYNC,
 		.cra_blocksize = AES_BLOCK_SIZE,
 		.cra_ctxsize = sizeof(struct qat_alg_aead_ctx),
@@ -1308,7 +1308,7 @@ static struct aead_alg qat_aeads[] = { {
 	.base = {
 		.cra_name = "authenc(hmac(sha512),cbc(aes))",
 		.cra_driver_name = "qat_aes_cbc_hmac_sha512",
-		.cra_priority = 4001,
+		.cra_priority = 1,
 		.cra_flags = CRYPTO_ALG_ASYNC,
 		.cra_blocksize = AES_BLOCK_SIZE,
 		.cra_ctxsize = sizeof(struct qat_alg_aead_ctx),
@@ -1326,7 +1326,7 @@ static struct aead_alg qat_aeads[] = { {
 static struct crypto_alg qat_algs[] = { {
 	.cra_name = "cbc(aes)",
 	.cra_driver_name = "qat_aes_cbc",
-	.cra_priority = 4001,
+	.cra_priority = 1,
 	.cra_flags = CRYPTO_ALG_TYPE_ABLKCIPHER | CRYPTO_ALG_ASYNC,
 	.cra_blocksize = AES_BLOCK_SIZE,
 	.cra_ctxsize = sizeof(struct qat_alg_ablkcipher_ctx),
@@ -1348,7 +1348,7 @@ static struct crypto_alg qat_algs[] = { {
 }, {
 	.cra_name = "ctr(aes)",
 	.cra_driver_name = "qat_aes_ctr",
-	.cra_priority = 4001,
+	.cra_priority = 1,
 	.cra_flags = CRYPTO_ALG_TYPE_ABLKCIPHER | CRYPTO_ALG_ASYNC,
 	.cra_blocksize = 1,
 	.cra_ctxsize = sizeof(struct qat_alg_ablkcipher_ctx),
@@ -1370,7 +1370,7 @@ static struct crypto_alg qat_algs[] = { {
 }, {
 	.cra_name = "xts(aes)",
 	.cra_driver_name = "qat_aes_xts",
-	.cra_priority = 4001,
+	.cra_priority = 1,
 	.cra_flags = CRYPTO_ALG_TYPE_ABLKCIPHER | CRYPTO_ALG_ASYNC,
 	.cra_blocksize = AES_BLOCK_SIZE,
 	.cra_ctxsize = sizeof(struct qat_alg_ablkcipher_ctx),

base-commit: 866ae42cf4788c8b18de6bda0a522362702861d7
-- 
2.35.1

