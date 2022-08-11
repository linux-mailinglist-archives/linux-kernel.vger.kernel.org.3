Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CDF58FFA8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbiHKPcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235795AbiHKPb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:31:57 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5E385A8F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:30:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l22so21752629wrz.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=kbnOtrca+UKfTcKDYWH7RmzECZ4SW71xODW6/SpBFkQ=;
        b=ci+1jI/62tsyH/V1EY4ekoU++rhLYFviuU48qLgL8zl+T0l7ANtJqm2gXRiBqLa+ox
         qpWrBPuThrAOddUuiGN+Rl3hb4kmTH3XPRCVJlJ0+k5F4Mhaxe4swzOhfM8YFT0cNXq8
         LE/C074FR6731ZHOM7/u6OKvlMiGhMsulTGavvdqj9WQbjEbQo0jjI+mqsaAOvrNF0TJ
         GsFouHGa7OieG4d4u6E96D0rfM0b6lCbIjWtDAxgXdi4ApzaWNEOrR4wUzZ/7lMO1gPQ
         qmLZWsRWfqQjVeRd+vTxwIF36ZSbuE9cYssKv9B5kftZ3uLzpPIQehS1Zqnz3gijZuE8
         wnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=kbnOtrca+UKfTcKDYWH7RmzECZ4SW71xODW6/SpBFkQ=;
        b=QJGCMM1TpHp/SQ9hGzrM0Zqf62lz75VSKt4PVAYXY8cA99fIks32BCbpadMgYvAppf
         D9CZRFyQco3Fk8A3iRoPFSGFSQ3IkAZrLEITPj3Z7wrj2wwJ4+lS3MH5+RV88RdewlK0
         CBSF/KKz+YmXDvpqhF2/kn6x4YG3hTKwCW4frXuLvthBKKQdiPwBfXQ5+nB7/ygVsGOs
         tHKNxD3fHWPUWRQ2HZ7oS8Jl4oKXo9WthfFkxVp3SQq5eiQxAZpQRjQOJAkFroYquuDI
         rD1oY61B6zMZtL25Ccmyav+2TQTk0Fx5IJtAP4LoDR5i25jEBcFXfc5ACBs3TOvnWo+M
         nmnw==
X-Gm-Message-State: ACgBeo0SnwtHmu2F7ISVqBa6ul62qc2ffvY7ViMy9e7RHvmwZgaMg9V/
        zlAml9HqMxJ8GBZefj6UQC0=
X-Google-Smtp-Source: AA6agR4cNBxlswbb37h1EmIOwy/5UEzDGylekvDiyaLDKDyZyyioSmf9PY0tAVvRvBnO5/uiENTDcQ==
X-Received: by 2002:a5d:6687:0:b0:21e:d501:1b03 with SMTP id l7-20020a5d6687000000b0021ed5011b03mr20097422wru.387.1660231847121;
        Thu, 11 Aug 2022 08:30:47 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id m7-20020a056000008700b00222ed7ea203sm9805502wrx.100.2022.08.11.08.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 08:30:45 -0700 (PDT)
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
Subject: [PATCH 0/3] drm/i915: Replace kmap() with kmap_local_page()
Date:   Thu, 11 Aug 2022 17:30:38 +0200
Message-Id: <20220811153041.12795-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
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
kernel virtual addresses are restored and still valid.

Since its use in drm/i915 is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in drm/i915.

These changes should be tested in an 32 bits system, booting a kernel
with HIGHMEM enabled. Unfortunately I have no i915 based hardware,
therefore any help with testing would be greatly appreciated.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Fabio M. De Francesco (3):
  drm/i915: Replace kmap() with kmap_local_page()
  drm/i915/gt: Replace kmap() with kmap_local_page()
  drm/i915/gem: Replace kmap() with kmap_local_page()

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c          |  6 ++----
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |  8 ++++----
 drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c       |  4 ++--
 drivers/gpu/drm/i915/gt/shmem_utils.c              | 11 ++++-------
 drivers/gpu/drm/i915/i915_gem.c                    |  8 ++++----
 5 files changed, 16 insertions(+), 21 deletions(-)

-- 
2.37.1

