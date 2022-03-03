Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BF24CC7FB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 22:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbiCCVZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 16:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbiCCVZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:25:37 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A18713DE03;
        Thu,  3 Mar 2022 13:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646342691; x=1677878691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cePptrGSsl2dfgN2SgrOoddSMEntTjj47nFxKZ1BSv8=;
  b=TmzAhPPwm2oHd4RPA8TMIT91CeANV4gC0T8QIewXeMczVCqEkueO4lRo
   khtxAIFHbOG/6ZB4iRiWAx2ZPNgWE4QdHqDaUT7k5UWEFoqg0FhJ0TcwE
   nfjyoMrdIdEyZ/ZPVIBR3U8womyBU6xE8mRT8I3nlfIAxUMGHJAjIoYUO
   nWCd7NA9HcKrQgQsnAywr/vYPi0T4V/ikoNkn4aQ/nRBBWGU9RqZAIhz8
   E0ZHPY8xljFGs/F1PH2CkWlEy3c1AXkiSMH8nHPcP6d5CKxtB2JbrtXkj
   08Xd73wRq6pp7rg0iCqB49psJCBa39ltNSA/d6xlAXSF8EDwHmPlYGRDy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="253747927"
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="253747927"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 13:24:51 -0800
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="536016037"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 13:24:48 -0800
Date:   Thu, 3 Mar 2022 21:24:42 +0000
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kyle Sanderson <kyle.leet@gmail.com>,
        Dave Chinner <david@fromorbit.com>, qat-linux@intel.com,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: Intel QAT on A2SDi-8C-HLN4F causes massive data corruption with
 dm-crypt + xfs
Message-ID: <YiEyGoHacN80FcOL@silpixa00400314>
References: <CAHk-=wi+xewHz=BH7LcZAxrj9JXi66s9rp+kBqRchVG3a-b2BA@mail.gmail.com>
 <Yh2c4Vwu61s51d6N@gondor.apana.org.au>
 <Yh9G7FyCLtsm2mFA@kroah.com>
 <Yh9ZvLHuztwQCu0d@silpixa00400314>
 <Yh+FpKuoyj3G16lK@kroah.com>
 <Yh/vY4t3xnuoCW3Q@gondor.apana.org.au>
 <Yh/yr6oB5yeOUErL@silpixa00400314>
 <Yh/znCnZzWaL49+o@gondor.apana.org.au>
 <YiDHT31ujlGdQEe/@silpixa00400314>
 <YiEVPc2cd38AnLZB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiEVPc2cd38AnLZB@gmail.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 07:21:33PM +0000, Eric Biggers wrote:
> If these algorithms have critical bugs, which it appears they do, then IMO it
> would be better to disable them (either stop registering them, or disable the
> whole driver) than to leave them available with low cra_priority.  Low
> cra_priority doesn't guarantee that they aren't used.
Thanks for your feedback Eric.

Here is a patch that disables the registration of the algorithms in the
QAT driver by setting, a config time, the number of HW queues (aka
instances) to zero.

---8<---
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH] crypto: qat - disable registration of algorithms
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland

The implementations of aead and skcipher in the QAT driver do not
support properly requests with the CRYPTO_TFM_REQ_MAY_BACKLOG flag set.
If the HW queue is full, the driver returns -EBUSY but does not enqueue
the request.
This can result in applications like dm-crypt waiting indefinitely for a
completion of a request that was never submitted to the hardware.

To avoid this problem, disable the registration of all skcipher and aead
implementations in the QAT driver by setting the number of crypto
instances to 0 at configuration time.

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
 drivers/crypto/qat/qat_common/qat_crypto.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/qat_crypto.c b/drivers/crypto/qat/qat_common/qat_crypto.c
index 3852d31ce0a4..611d214d5198 100644
--- a/drivers/crypto/qat/qat_common/qat_crypto.c
+++ b/drivers/crypto/qat/qat_common/qat_crypto.c
@@ -159,9 +159,7 @@ struct qat_crypto_instance *qat_crypto_get_instance_node(int node)
  */
 int qat_crypto_dev_config(struct adf_accel_dev *accel_dev)
 {
-	int cpus = num_online_cpus();
-	int banks = GET_MAX_BANKS(accel_dev);
-	int instances = min(cpus, banks);
+	int instances = 0;
 	char key[ADF_CFG_MAX_KEY_LEN_IN_BYTES];
 	int i;
 	unsigned long val;

base-commit: 866ae42cf4788c8b18de6bda0a522362702861d7
-- 
2.35.1
