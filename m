Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EDE4BBE8A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbiBRRjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:39:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiBRRjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:39:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA43D27B27
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645205960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xAam+qFCmo3Rl80e7z26slziDVWmWKJYDMPephJD4B8=;
        b=AprtKraEBaKMUz1ArMGI0c5rppZHUz1m4Fon13PWx4x83rjIhUuXYgQxevYgW6zHkaEJq+
        ZUsScaUCzk5GLRzgDzS/7pp5I13pE+S+DRXZ57XN71y2E1a807FxI+cZW+pNhKO/gHqt+J
        /t4EnTGQHB7r7hfGLEFQLHppmoj6ZjA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-TFqO6BGLMrebFI_l0DLvCg-1; Fri, 18 Feb 2022 12:39:19 -0500
X-MC-Unique: TFqO6BGLMrebFI_l0DLvCg-1
Received: by mail-qv1-f69.google.com with SMTP id du13-20020a05621409ad00b0042c2949e2c1so9551397qvb.19
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:39:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xAam+qFCmo3Rl80e7z26slziDVWmWKJYDMPephJD4B8=;
        b=X2WVtrnQPdCRVryhbKYesFCuJtP9kJw6nCjq8HAGOTlNCyh6GcKpbipapeiGRbc7Dk
         a7dstwScM2rmZP6UKKsvDhoLG+xyzjn2Hd0rgLSqalN3LFPPRK1gh0iYmfFe69C06qMj
         Uq+Ty5/nifsuMT/N4siJbcdzntp2fDIVa1/Ar41ZQn5LXfcfOah8n+9XtFt0CCL3DYF8
         5QAWZCFKkOOp1RcW3Sqjwx6PRV1l7R/fSW6n4i/sm+HMmcT14JOLoRSs2wXeEriAU6mN
         MWjgRXewrpyon+7YazhbZIW5HbgAH1tAG0ozm13VHP3QUlFS3qHwgV6bb16Aahx/zEqp
         WaVA==
X-Gm-Message-State: AOAM5321bM0t6XMF+BqlyCRxnmcwN2mzd2wWt4nFpQHTtAe2E3ctlFr2
        RQpievNFi1zwXzX2ihlkCGHbiSIFddSMMsIatYYquFviFZ0OwELWIk2pBQiALrSLEDBkvb7Wlj6
        YZ0xNgKX5bm+/tj7s/uyKAKZy
X-Received: by 2002:a05:6214:6ae:b0:42d:8c32:9697 with SMTP id s14-20020a05621406ae00b0042d8c329697mr6639084qvz.128.1645205959294;
        Fri, 18 Feb 2022 09:39:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHRTUjyiPCyav3YHqFIKehE5vskU34OYALKehiwfJAPYRDA2JG2akysROtDLt0A6lF7XH17w==
X-Received: by 2002:a05:6214:6ae:b0:42d:8c32:9697 with SMTP id s14-20020a05621406ae00b0042d8c329697mr6639057qvz.128.1645205959074;
        Fri, 18 Feb 2022 09:39:19 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id g22sm3425738qkp.63.2022.02.18.09.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 09:39:18 -0800 (PST)
From:   trix@redhat.com
To:     Felix.Kuehling@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
        david.yatsin@amd.com, rajneesh.bhardwaj@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdkfd: rework criu_restore_bos error handling
Date:   Fri, 18 Feb 2022 09:39:13 -0800
Message-Id: <20220218173913.3376948-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this problem
kfd_chardev.c:2327:2: warning: 1st function call argument
  is an uninitialized value
  kvfree(bo_privs);
  ^~~~~~~~~~~~~~~~

If the copy_from_users(bo_buckets, ...) fails, there is a jump to
the generic error handler at exit:.  The freeing of bo_privs and
unwinding of the dmabuf_fd loop do not need to be done.

Add some specific labels for the early failures.
Reorder the frees to be the reverse of their allocs.

Move the initialize of 'i' back to the loop.
The problem with the early frees predates the loop
unwinding problem.

Fixes: 73fa13b6a511 ("drm/amdkfd: CRIU Implement KFD restore ioctl")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 965af2a08bc0..1d5f41ac3832 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2102,7 +2102,7 @@ static int criu_restore_bos(struct kfd_process *p,
 	const bool criu_resume = true;
 	bool flush_tlbs = false;
 	int ret = 0, j = 0;
-	uint32_t i = 0;
+	uint32_t i;
 
 	if (*priv_offset + (args->num_bos * sizeof(*bo_privs)) > max_priv_data_size)
 		return -EINVAL;
@@ -2119,13 +2119,13 @@ static int criu_restore_bos(struct kfd_process *p,
 	if (ret) {
 		pr_err("Failed to copy BOs information from user\n");
 		ret = -EFAULT;
-		goto exit;
+		goto free_buckets;
 	}
 
 	bo_privs = kvmalloc_array(args->num_bos, sizeof(*bo_privs), GFP_KERNEL);
 	if (!bo_privs) {
 		ret = -ENOMEM;
-		goto exit;
+		goto free_buckets;
 	}
 
 	ret = copy_from_user(bo_privs, (void __user *)args->priv_data + *priv_offset,
@@ -2133,12 +2133,12 @@ static int criu_restore_bos(struct kfd_process *p,
 	if (ret) {
 		pr_err("Failed to copy BOs information from user\n");
 		ret = -EFAULT;
-		goto exit;
+		goto free_privs;
 	}
 	*priv_offset += args->num_bos * sizeof(*bo_privs);
 
 	/* Create and map new BOs */
-	for (; i < args->num_bos; i++) {
+	for (i = 0; i < args->num_bos; i++) {
 		struct kfd_criu_bo_bucket *bo_bucket;
 		struct kfd_criu_bo_priv_data *bo_priv;
 		struct kfd_dev *dev;
@@ -2323,8 +2323,11 @@ static int criu_restore_bos(struct kfd_process *p,
 		if (bo_buckets[i].alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
 			close_fd(bo_buckets[i].dmabuf_fd);
 	}
-	kvfree(bo_buckets);
+free_privs:
 	kvfree(bo_privs);
+free_buckets:
+	kvfree(bo_buckets);
+
 	return ret;
 }
 
-- 
2.26.3

