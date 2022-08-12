Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80EA591521
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbiHLR6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiHLR6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:58:03 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DD4B2859;
        Fri, 12 Aug 2022 10:58:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h13so1955855wrf.6;
        Fri, 12 Aug 2022 10:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=w8rPxxUwax5JSBYc+MunKfzJoBwcTejD8FTqXrjwB9Q=;
        b=ZwbNXCMdTWEOw1KTNDeKg360UJPG1HCsisp9+uIXW+AigUK7JmFTPhWn7FWmgINCpT
         rY7PLkCGfIgguc5MJ32GWWbMwoRGbrciy52PmMX1/5lfI+D30PYnOCwwVfBKBtPaUO/j
         jYYLJn+GgsmN4Sun3E86Ttf/CyJOHKdJX0obiuUQjFrYu9dJaoyFzwwcqIuPBGKsMxPe
         M72hExseMtt+PHjI93iQSBcrxtHFZL/mjeY81Pz5VAWFt9PzKIBklpHqsfs4HOpWlXKp
         1568kstFdwaTNQgqRboZuJDIWBp5MvvF5h0Q7MacN0YSXLEmyowtVOQpKpMF/mqMtWQ3
         dQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=w8rPxxUwax5JSBYc+MunKfzJoBwcTejD8FTqXrjwB9Q=;
        b=D14ZPtlzlq8c7e+6mQJOgk8oUVYy9cc9vIVSzKd4gEbgaO852DMrMsDOxA4o8NOIlO
         oNUq/1WKBfV3z6UgyYd8Vc2agud904zDIqPJUSWhD8kt6LeHOztAx/oZHjI2C0wxSp8z
         7tY/0Jnfi8+3YMy+tCdB2wYM0Bss+ocVDntlwZAQtzi/3+XWSCXKO+TzgK/HjIs5eRP5
         zJb14VBHMZdNpDkxN5r/rEeOnRiP1UE/hJHZ6nh3KmJgB8ZEk1DMSZroFshLx654Nkl1
         kXxebbO63ETqJ/rSzl5K7Ld5vzKAUEpVz7CCH8NCv5dI9JrEz5Ogl27KaEcQzc76hWdE
         EwAw==
X-Gm-Message-State: ACgBeo0vutrv3g2Q/YvFDBCMTk0gIuwhQiGaC1OZTLh3KZR88FKrUOcT
        GBD0O9DkOFd8lsuM9ylRK7X6WmtZLj0=
X-Google-Smtp-Source: AA6agR5BpjeASKsLrsRErii9wRhEEOlS5DHluRVxLpyj5mSQJt2UYcFvMbrTkLZMSIXhaY7aQVzWcA==
X-Received: by 2002:a5d:5848:0:b0:222:c8cd:288 with SMTP id i8-20020a5d5848000000b00222c8cd0288mr2788260wrf.34.1660327081009;
        Fri, 12 Aug 2022 10:58:01 -0700 (PDT)
Received: from localhost.localdomain (host-79-53-105-123.retail.telecomitalia.it. [79.53.105.123])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb03000000b002206236ab3dsm129831wrr.3.2022.08.12.10.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 10:57:59 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Jonathan Kim <jonathan.kim@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Zack Rusin <zackr@vmware.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] drm/amd/amdgpu: Replace kmap() with kmap_local_page()
Date:   Fri, 12 Aug 2022 19:57:53 +0200
Message-Id: <20220812175753.22926-1-fmdefrancesco@gmail.com>
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
kernel virtual addresses are restored and are still valid.

Since its use in amdgpu/amdgpu_ttm.c is safe, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in amdgpu/amdgpu_ttm.c.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 3b4c19412625..c11657b5915f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2301,9 +2301,9 @@ static ssize_t amdgpu_iomem_read(struct file *f, char __user *buf,
 		if (p->mapping != adev->mman.bdev.dev_mapping)
 			return -EPERM;
 
-		ptr = kmap(p);
+		ptr = kmap_local_page(p);
 		r = copy_to_user(buf, ptr + off, bytes);
-		kunmap(p);
+		kunmap_local(ptr);
 		if (r)
 			return -EFAULT;
 
@@ -2352,9 +2352,9 @@ static ssize_t amdgpu_iomem_write(struct file *f, const char __user *buf,
 		if (p->mapping != adev->mman.bdev.dev_mapping)
 			return -EPERM;
 
-		ptr = kmap(p);
+		ptr = kmap_local_page(p);
 		r = copy_from_user(ptr + off, buf, bytes);
-		kunmap(p);
+		kunmap_local(ptr);
 		if (r)
 			return -EFAULT;
 
-- 
2.37.1

