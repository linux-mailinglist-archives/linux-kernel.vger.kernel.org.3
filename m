Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AB7496CB7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 15:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiAVOgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 09:36:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26277 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231322AbiAVOgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 09:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642862161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iMoDmTVNmITbklh5q/t/44BNAz/LykE1HqAeIjzQA3M=;
        b=RoxdUggQLAXet7lvIgNfhr9haPK75KLMTX2oUXTlaW4z9ObSOL3nxosG9rpBq07dif53Jf
        Cxdp7mF5ZApcposFWLlzLB5G9TBdZI16W0GHwWz5AlX42oJpLNi9Py3lAnB2L/5oW9T+cZ
        BvAU+NVuVLVhydm7S+0LOME3P6o1GTo=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-m7XcvtTzOpKED_dl5jprxw-1; Sat, 22 Jan 2022 09:35:59 -0500
X-MC-Unique: m7XcvtTzOpKED_dl5jprxw-1
Received: by mail-ot1-f72.google.com with SMTP id n99-20020a9d206c000000b00590dde2cca8so7403108ota.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 06:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iMoDmTVNmITbklh5q/t/44BNAz/LykE1HqAeIjzQA3M=;
        b=EG55PBhauUn6edMMVRSphaGA0jdsFldSOZBejMdVYDxCuXR27tCJqe8DiECLRZg6ZY
         UWK69SPVRCCzWhnFHer2CFHrqk/0JDes5zqKabfstG9dneOYM4Kgwq6q1LMXVOrQ5rfc
         XuCu/lETtbLz2L/oC7RGeagmZKdyfAz9zqwnhnu/vCTAjeWlD4Fw5m3je7grEPOQryoG
         ME3mM0IGYyS1iuGZckXxIZQ52PneNOgj4140CGocMz7Ehj4NiCqoASfffwe5n+nkJIjA
         kKclerEwItv00RKLDrWqS2RLnurqNGvHHgIiiWjC4pZ41YcELVHA+NMpMgqHaiwvapQN
         tFVg==
X-Gm-Message-State: AOAM532eMpNxWQBeJsL9dqqKdp0imhR6BoGreEF3yTTb1ik5S+HqPl4u
        Awe7Kt1L3Z/8FR/4LrsDxPdo1yKXNN/6CpYlaANAmz27343TIVNLoeQHRe/qDHlvjH6+9iJL1mq
        0PLQatef74fXDSOS4UznglV1w
X-Received: by 2002:a05:6830:25d0:: with SMTP id d16mr6221809otu.362.1642862158899;
        Sat, 22 Jan 2022 06:35:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgc0T99YhICS47P7DM3QV6ViRHJuBhuoL3AAcXMdbyPUZZgVBeGsTVqm4QwhQs0NqYaB+Bjg==
X-Received: by 2002:a05:6830:25d0:: with SMTP id d16mr6221798otu.362.1642862158724;
        Sat, 22 Jan 2022 06:35:58 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id w13sm2943114oik.52.2022.01.22.06.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 06:35:58 -0800 (PST)
From:   trix@redhat.com
To:     Felix.Kuehling@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdkfd: simplify else if to else check of MIGRATION_COPY_DIR
Date:   Sat, 22 Jan 2022 06:35:49 -0800
Message-Id: <20220122143549.914925-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The enum MIGRATION_COPY_DIR type has 2 values.  So
the else-if can be converted to an else.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index d986f9ee0e1f4..c06c44f37b00e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -146,7 +146,8 @@ svm_migrate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
 			gart_s = svm_migrate_direct_mapping_addr(adev, *vram);
 			r = svm_migrate_gart_map(ring, size, sys, &gart_d, 0);
 
-		} else if (direction == FROM_RAM_TO_VRAM) {
+		} else {
+			/* direction == FROM_RAM_TO_VRAM */
 			r = svm_migrate_gart_map(ring, size, sys, &gart_s,
 						 KFD_IOCTL_SVM_FLAG_GPU_RO);
 			gart_d = svm_migrate_direct_mapping_addr(adev, *vram);
-- 
2.26.3

