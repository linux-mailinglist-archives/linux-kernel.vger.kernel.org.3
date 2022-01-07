Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8F7487E0E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiAGVOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:14:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54520 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229504AbiAGVOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641590040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CoxKyAZnnR3hc0Xq4/bujSICkBAnBdTmtPeVb0xDLIM=;
        b=QK9kFu7Y8iHNMOJC09Xf5JShFOikrkCIlWiSRHaVf+pn+AYlMhW1CwJRcfOQENjdo81oFS
        Nsh+861h/4Q2RBijzWe9D4PFAw8e/O/tXAqADm+YQLo6QicppbS3W+nxvL6Wrmi8wOyZ7u
        aIISijkfz82htXJrXoJg2+OIVI7bFo8=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-sxduQaQYOAKvvExcXfGzYA-1; Fri, 07 Jan 2022 16:13:59 -0500
X-MC-Unique: sxduQaQYOAKvvExcXfGzYA-1
Received: by mail-oo1-f69.google.com with SMTP id s14-20020a4aa54e000000b002db004adebdso4255296oom.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 13:13:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CoxKyAZnnR3hc0Xq4/bujSICkBAnBdTmtPeVb0xDLIM=;
        b=oOYDE0puy4mp6JYsMUxe7QjdqPUoGt5iLyCjYfHiK9GMs5s3JlmyL2d9e4WgNXTVRE
         ynQnNBfzZX/nm989KrXvDMXNwJ1vjN+8jgKsaDAXzyU/dblNAuAp74e9rySwQRW61dxZ
         L7Ss73wxcnAv03mcQiZQkpK3ANneXbTtUn6dkR/PRmKV9wBSV+YtpPAqinigOxaweWkg
         C2pfPRDJY/YyiUqxJR4h3oyZiX8vJDqkLNSek8oo6jGLQn/0m5thSvB9m06R6a4emh9E
         6SG4lGSQei6EE1PqjCwCdL41yrGWqXsei+cBUkwhANAPpaZ22E4pEwlt3MbbWOALXD4o
         muWw==
X-Gm-Message-State: AOAM5332jB/syHh9L5lU/2TQqhALqAM6kZUjQMIjC07AGjehDl6tD2jy
        J9s1J7XH1dlgc2KuTRFTQBvKXSgwGjUilaBeqU8bzgxon2b4MY/E+EieHWhauBRz4qG3X3KLVET
        FS6PjeihWnykfTR2GleglhnvY
X-Received: by 2002:a05:6830:34a3:: with SMTP id c35mr46669378otu.379.1641590038532;
        Fri, 07 Jan 2022 13:13:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygIGgpJ6DCegCd7Ncbdf1YNgwG/+5B2jrt7mHpcIrnWFgKCg/rH7tBIAGfsm+B/wdvFZl52Q==
X-Received: by 2002:a05:6830:34a3:: with SMTP id c35mr46669365otu.379.1641590038351;
        Fri, 07 Jan 2022 13:13:58 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id g61sm1111592otg.43.2022.01.07.13.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:13:57 -0800 (PST)
From:   trix@redhat.com
To:     mst@redhat.com, jasowang@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com, elic@nvidia.com, parav@nvidia.com,
        si-wei.liu@oracle.com, xieyongji@bytedance.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] vdpa/mlx5: fix error handling in mlx5_vdpa_dev_add()
Date:   Fri,  7 Jan 2022 13:13:52 -0800
Message-Id: <20220107211352.3940570-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang build fails with
mlx5_vnet.c:2574:6: error: variable 'mvdev' is used uninitialized whenever
  'if' condition is true
        if (!ndev->vqs || !ndev->event_cbs) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mlx5_vnet.c:2660:14: note: uninitialized use occurs here
        put_device(&mvdev->vdev.dev);
                    ^~~~~
This because mvdev is set after trying to allocate ndev->vqs,event_cbs.
So move the allocation to after mvdev is set but before the arrays
are used in init_mvqs()

Fixes: 7620d51af29a ("vdpa/mlx5: Support configuring max data virtqueue")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index b564c70475815..37220f6db7ad7 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2569,16 +2569,18 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	if (IS_ERR(ndev))
 		return PTR_ERR(ndev);
 
+	ndev->mvdev.mlx_features = mgtdev->mgtdev.supported_features;
+	ndev->mvdev.max_vqs = max_vqs;
+	mvdev = &ndev->mvdev;
+	mvdev->mdev = mdev;
+
 	ndev->vqs = kcalloc(max_vqs, sizeof(*ndev->vqs), GFP_KERNEL);
 	ndev->event_cbs = kcalloc(max_vqs + 1, sizeof(*ndev->event_cbs), GFP_KERNEL);
 	if (!ndev->vqs || !ndev->event_cbs) {
 		err = -ENOMEM;
 		goto err_alloc;
 	}
-	ndev->mvdev.mlx_features = mgtdev->mgtdev.supported_features;
-	ndev->mvdev.max_vqs = max_vqs;
-	mvdev = &ndev->mvdev;
-	mvdev->mdev = mdev;
+
 	init_mvqs(ndev);
 	mutex_init(&ndev->reslock);
 	config = &ndev->config;
-- 
2.26.3

