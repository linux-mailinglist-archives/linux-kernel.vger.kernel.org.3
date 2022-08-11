Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0945B58FFA9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbiHKPch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbiHKPb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:31:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAA59752E
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:30:55 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j7so21782710wrh.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=qZtGOXbRC+1H6SPLMpuq1SgPyHU7zMutv39GohgMBvo=;
        b=kHDbzD7P9eGWeR5QgJz8o1M4lnlOV+24zL4PIkoKaISN137ifaBEtwvYZGOrdPMJ1W
         6cHV0oSmCKFcNNk0vpWxMajyRH6PYZfHGLxbZa6xz0nQ0PXYtFjJjeq4xbJ9n4t/PUbL
         m5WN1x1jV/pmiObU1mVXl4tO198NP8iOeBji/RR6eJUItHUSMiYtAhPQHerKaSrbAzxn
         n7RuZbkyl7A9sc/63XXdJd5sjQkdpw5IakaHG8aepNjjhcwZFSbPg1/73XwhReevGlY8
         71gjrAj4jM4uDDj5iU3EAQ3hK34JOnyjeJLo0cTpTUI0OAWpe36RaEDXeM0oEZJKjmXJ
         UkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=qZtGOXbRC+1H6SPLMpuq1SgPyHU7zMutv39GohgMBvo=;
        b=4iLHuXc2rQIFFaS3KWrdUdQw4ELVU9eOsQs5QGZfF+PDop0bhd9auGYNEF9bWOJ1To
         6aANim+IVKtirk5zj/amQ+YxHov+Mif17Y437dl1fUlM+FEyjBOHSpARS96kghh6Soyy
         Rwnhto6xNIecn1F/7oCrtDM1r//XP5lnYyKrugx2rsrYA9sTnKny5nWeGFSbmxucNfHC
         qi9bRxT6s5dFoLyzNImUg8nwo9GbkiIRp/H1mEAlftbbbcCuHiDwgL4da/YbqAgbgQnv
         5j5KaSakHFGVfuVmlLJoi1IXq+E6WNkbK4pK39a4jMBdOGUT3LqGe83gcCK7XRxayWtd
         CdnA==
X-Gm-Message-State: ACgBeo2naSJFKqXu2wu+tIh3vWSMSA/0+BNGFPMF0aE82s2+xrxFjiuy
        wT18gRR+9Rp2MpIAm2uu7XI=
X-Google-Smtp-Source: AA6agR5a9kzgqtDr+SyVjmXoGK7TQ3C9s6/ZzMuJhHCJyK48sU4+XUw9zEtEFNtg3FIup6WEqH0qNg==
X-Received: by 2002:a5d:52cb:0:b0:21a:3cc5:f5f4 with SMTP id r11-20020a5d52cb000000b0021a3cc5f5f4mr20771696wrv.367.1660231853386;
        Thu, 11 Aug 2022 08:30:53 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id m7-20020a056000008700b00222ed7ea203sm9805502wrx.100.2022.08.11.08.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 08:30:52 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        John Harrison <John.C.Harrison@Intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 2/3] drm/i915/gt: Replace kmap() with kmap_local_page()
Date:   Thu, 11 Aug 2022 17:30:40 +0200
Message-Id: <20220811153041.12795-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811153041.12795-1-fmdefrancesco@gmail.com>
References: <20220811153041.12795-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and are still valid.

Since its use in i915/gt is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in i915/gt

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c |  4 ++--
 drivers/gpu/drm/i915/gt/shmem_utils.c        | 11 ++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c b/drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c
index 6ebda3d65086..21d8ce40b897 100644
--- a/drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c
+++ b/drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c
@@ -747,7 +747,7 @@ static void swizzle_page(struct page *page)
 	char *vaddr;
 	int i;
 
-	vaddr = kmap(page);
+	vaddr = kmap_local_page(page);
 
 	for (i = 0; i < PAGE_SIZE; i += 128) {
 		memcpy(temp, &vaddr[i], 64);
@@ -755,7 +755,7 @@ static void swizzle_page(struct page *page)
 		memcpy(&vaddr[i + 64], temp, 64);
 	}
 
-	kunmap(page);
+	kunmap_local(vaddr);
 }
 
 /**
diff --git a/drivers/gpu/drm/i915/gt/shmem_utils.c b/drivers/gpu/drm/i915/gt/shmem_utils.c
index 402f085f3a02..48edbb8a33e5 100644
--- a/drivers/gpu/drm/i915/gt/shmem_utils.c
+++ b/drivers/gpu/drm/i915/gt/shmem_utils.c
@@ -98,22 +98,19 @@ static int __shmem_rw(struct file *file, loff_t off,
 		unsigned int this =
 			min_t(size_t, PAGE_SIZE - offset_in_page(off), len);
 		struct page *page;
-		void *vaddr;
 
 		page = shmem_read_mapping_page_gfp(file->f_mapping, pfn,
 						   GFP_KERNEL);
 		if (IS_ERR(page))
 			return PTR_ERR(page);
 
-		vaddr = kmap(page);
 		if (write) {
-			memcpy(vaddr + offset_in_page(off), ptr, this);
+			memcpy_to_page(page, offset_in_page(off), ptr, this);
 			set_page_dirty(page);
 		} else {
-			memcpy(ptr, vaddr + offset_in_page(off), this);
+			memcpy_from_page(ptr, page, offset_in_page(off), this);
 		}
 		mark_page_accessed(page);
-		kunmap(page);
 		put_page(page);
 
 		len -= this;
@@ -140,11 +137,11 @@ int shmem_read_to_iosys_map(struct file *file, loff_t off,
 		if (IS_ERR(page))
 			return PTR_ERR(page);
 
-		vaddr = kmap(page);
+		vaddr = kmap_local_page(page);
 		iosys_map_memcpy_to(map, map_off, vaddr + offset_in_page(off),
 				    this);
 		mark_page_accessed(page);
-		kunmap(page);
+		kunmap_local(vaddr);
 		put_page(page);
 
 		len -= this;
-- 
2.37.1

