Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89ABC5162B2
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244639AbiEAI3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244592AbiEAI2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:28:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056B617E10;
        Sun,  1 May 2022 01:25:21 -0700 (PDT)
Date:   Sun, 01 May 2022 08:25:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651393520;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9twnfmTeQicWK61lPpH3y68atz1ooDKYw21C5/2KZno=;
        b=JDk1Gc7Y81h1GwFUvPMI2BbOmjVPrE49rNNS/RripR4rhkfBXVjeQZx0cNzKgi9FDpJegF
        9DgS6RcT03m63OQ3TQU64RrmMKPKHimyKYUM4AAIFrU/RPcphazW4ibdU2RVJc5mUbVoos
        QaLYuHZepSUs+JWJ5M4hNTpiCmujnJaQudBm8VWvSbibm7u0zcFXgpxYo5mNK20gnzqp/c
        1kZcCpGeumYajkZF4YDJ29gvDluCIQ8FSKKd6spFTMRfkmZqwl//AyO640O7x4kYAPtKm/
        31aXcO/7lBpqi5BDfcdhYmDQqt6U/jHGSelvS0BLYh6KrVgBwDVTzmtox0uR0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651393520;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9twnfmTeQicWK61lPpH3y68atz1ooDKYw21C5/2KZno=;
        b=WFdqINj3ETbfJvO2zo9K1OuUAWb8jVnqSmtxS2zpTrRmg2pxr6iZOXnEkzMbVMviEtcDD2
        2VxekzgpvQgm+iBw==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] mm: Fix PASID use-after-free issue
Cc:     Zhangfei Gao <zhangfei.gao@foxmail.com>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220428180041.806809-1-fenghua.yu@intel.com>
References: <20220428180041.806809-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <165139351922.4207.15523967417383711734.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     2667ed10d9f01e250ba806276740782c89d77fda
Gitweb:        https://git.kernel.org/tip/2667ed10d9f01e250ba806276740782c89d77fda
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Thu, 28 Apr 2022 11:00:41 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 01 May 2022 10:17:17 +02:00

mm: Fix PASID use-after-free issue

The PASID is being freed too early.  It needs to stay around until after
device drivers that might be using it have had a chance to clear it out
of the hardware.

The relevant refcounts are:

  mmget() /mmput()  refcount the mm's address space
  mmgrab()/mmdrop() refcount the mm itself

The PASID is currently tied to the life of the mm's address space and freed
in __mmput().  This makes logical sense because the PASID can't be used
once the address space is gone.

But, this misses an important point: even after the address space is gone,
the PASID will still be programmed into a device.  Device drivers might,
for instance, still need to flush operations that are outstanding and need
to use that PASID.  They do this at file->release() time.

Device drivers call the IOMMU driver to hold a reference on the mm itself
and drop it at file->release() time.  But, the IOMMU driver holds a
reference on the mm itself, not the address space.  The address space (and
the PASID) is long gone by the time the driver tries to clean up.  This is
effectively a use-after-free bug on the PASID.

To fix this, move the PASID free operation from __mmput() to __mmdrop().
This ensures that the IOMMU driver's existing mmgrab() keeps the PASID
allocated until it drops its mm reference.

Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID allocation and free it on mm exit")
Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Link: https://lore.kernel.org/r/20220428180041.806809-1-fenghua.yu@intel.com
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 9796897..35a3bef 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -792,6 +792,7 @@ void __mmdrop(struct mm_struct *mm)
 	mmu_notifier_subscriptions_destroy(mm);
 	check_mm(mm);
 	put_user_ns(mm->user_ns);
+	mm_pasid_drop(mm);
 	free_mm(mm);
 }
 EXPORT_SYMBOL_GPL(__mmdrop);
@@ -1190,7 +1191,6 @@ static inline void __mmput(struct mm_struct *mm)
 	}
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
-	mm_pasid_drop(mm);
 	mmdrop(mm);
 }
 
