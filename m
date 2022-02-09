Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9744AF474
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbiBIOxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbiBIOxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:53:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95079C05CB82
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 06:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644418384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=j/VJVwJcabH5SXTn4ZvXEnmPqcRm07U+dAsv8ELCv4A=;
        b=Rfm9aH1mrLhx3Xe27Ow9TdKyBQAmz59LbcKZvIAAWOaHLgAoic8j0exH4lPkbYHQ2bENNg
        gdpuUyHUdl9r6pbpza4rd5hwLBqEclqV3iHC8MEqAIMUhRhlrytkOfBUR4wTRms2CNCz2o
        psxlRYMGpXFieos4zQ5KT+vOJWCJVhs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-K2ZR4a2SOe2h3cx5A-jpyg-1; Wed, 09 Feb 2022 09:53:03 -0500
X-MC-Unique: K2ZR4a2SOe2h3cx5A-jpyg-1
Received: by mail-qt1-f199.google.com with SMTP id c15-20020ac87dcf000000b002d0a849c0beso1856460qte.16
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 06:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j/VJVwJcabH5SXTn4ZvXEnmPqcRm07U+dAsv8ELCv4A=;
        b=rWCGGG8FX9niiLzOM73Leazl5k9pKtn0aSRHNEJ0KeVR5ts8ixPsk7o9iWCGuchdkM
         28jGJ0pf/eHOEurrSmEVMPBrXu0sz5eYXqr3oyRTDqTjM6uii6u0q8md0kFbWhL5f1X8
         6Xarsn491lI6eyxdHh+5ATH9YwbdYCnjQUJsI++fLErolvp16sNR8DMhoOcbKU0eam4G
         K9EaxBcMtJ67vixOiAcrUef9n01k9kbEYlZmUyXPdssJ0R3+G7iDreRI4W1kH+IEQ4fu
         0pWcL2+jFeddieI6T8UND3PVrhYBWHklCf2/KFmJGnV2zoM53BTVj0/VmmRe31f/Mr+w
         eLzg==
X-Gm-Message-State: AOAM531TeEHLo0opkiqz2XIMvrqGRquNoypS1GVecKwUrVB1eWc3xA2J
        edJiiJKrUWLvfNCO6/0HM3ojHqoftqljnR8lW+dUj3FW+vstqn0iXFoJh/CFEoO6IVuTXvSfuqF
        TYotInKYbxUlDhLd7XQ8UEPK5
X-Received: by 2002:a05:622a:87:: with SMTP id o7mr1562250qtw.38.1644418382985;
        Wed, 09 Feb 2022 06:53:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5wcZMgzdbV24kPRKWlIzraNFqysXb9opnZC+c5gQEfuzVCDVwwO+VOEAL5ibZQMRfOE0JJw==
X-Received: by 2002:a05:622a:87:: with SMTP id o7mr1562236qtw.38.1644418382803;
        Wed, 09 Feb 2022 06:53:02 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id bk19sm8421478qkb.125.2022.02.09.06.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 06:53:02 -0800 (PST)
From:   trix@redhat.com
To:     Felix.Kuehling@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
        david.yatsin@amd.com, rajneesh.bhardwaj@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdkfd: fix freeing an unset pointer
Date:   Wed,  9 Feb 2022 06:52:54 -0800
Message-Id: <20220209145254.2291158-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem
kfd_chardev.c:2092:2: warning: 1st function call argument
  is an uninitialized value
        kvfree(bo_privs);
        ^~~~~~~~~~~~~~~~

When bo_buckets alloc fails, it jumps to an error handler
that frees the yet to be allocated bo_privs.  Because
bo_buckets is the first error, return directly.

Fixes: 5ccbb057c0a1 ("drm/amdkfd: CRIU Implement KFD checkpoint ioctl")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 64e3b4e3a7126..636391c61cafb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1982,10 +1982,8 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 	void *mem;
 
 	bo_buckets = kvzalloc(num_bos * sizeof(*bo_buckets), GFP_KERNEL);
-	if (!bo_buckets) {
-		ret = -ENOMEM;
-		goto exit;
-	}
+	if (!bo_buckets)
+		return -ENOMEM;
 
 	bo_privs = kvzalloc(num_bos * sizeof(*bo_privs), GFP_KERNEL);
 	if (!bo_privs) {
-- 
2.26.3

