Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D984A4A3020
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 15:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351058AbiA2OyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 09:54:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345931AbiA2OyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 09:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643468042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ug7sd4MyyeKE9edVrNKTjnr3ZIjzipUabJp6vX5YHNg=;
        b=W0NX54tzdX3t+uMhfAMhbs6sn3y957vk2DHVAh+gaJh3Sp6YRAY6GUqpTTKYLvBMiem54T
        AL5SM7rIGBSQbVJe9VJIZ55AGOn+hBcAsvJrEvQ/tAbVkubwhawePfMdHFvn0mO4P5Y/fF
        qQ9OhjLMlDY5QgmAn+LHqkPvDQIBZYI=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-1a4M7ThlPSOZ-bVQcRPchA-1; Sat, 29 Jan 2022 09:54:01 -0500
X-MC-Unique: 1a4M7ThlPSOZ-bVQcRPchA-1
Received: by mail-io1-f70.google.com with SMTP id q7-20020a6bf207000000b006129589cb60so6563962ioh.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 06:54:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ug7sd4MyyeKE9edVrNKTjnr3ZIjzipUabJp6vX5YHNg=;
        b=r2GZYdOTEjLMSXMR9BjccU+uOY7Ih0EE9FeOap0qeL4UAt6lAoNZEIIa2mLEFlsEzI
         bN1jI++y3qOW6aRSRWmbAkgSk+PNK79jhh0OzM4Rv4Kmy7wSIDYnMpYXWTi3Hxm9hMTn
         jJ0+7byfJEwoq603l+AFOXq24B5GIeQipU6CetYjt6cxz4J5j5uzxQAlmqGnFzSrRhJU
         7EKs+t2GJtgssmlOEEa1fAXdeMMZCGaD5K/GmJ2VXfHcs4cbAhJFp+jCddXNqnffSxbT
         s0y8qTYGJaCL/xg9k4Lba4Gl2y5HGRMDL4wNnoV3MgBZj8PvsF4mqNACRCxWdcYQBmk4
         bVJQ==
X-Gm-Message-State: AOAM531/jLEUR0gz9BfqPA2z/Ai51pLBxBIWZgwT2AsAexUDW/KpsC8J
        hJBYkOsC9tfycPWCgQqcojQU4sbJFw9XFnj3CY1H5s7fjetfE7S0oDPw+2tIBxoDARaNiBhKN+1
        GkcgvdiGbxqK/axwgFOXtGrNw
X-Received: by 2002:a05:6638:33a1:: with SMTP id h33mr6293237jav.78.1643468040559;
        Sat, 29 Jan 2022 06:54:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwgXCva834kyAbS4ly/S/GHDc8v1pjp6kH32zHTbUhflIF5l0lCvtPA+s2R8yYYEuRITEFGA==
X-Received: by 2002:a05:6638:33a1:: with SMTP id h33mr6293223jav.78.1643468040391;
        Sat, 29 Jan 2022 06:54:00 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id p7sm14191616ilo.71.2022.01.29.06.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 06:53:59 -0800 (PST)
From:   trix@redhat.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        nathan@kernel.org, ndesaulniers@google.com, PengJu.Zhou@amd.com,
        candice.li@amd.com, Hawking.Zhang@amd.com, john.clements@amd.com,
        Jingwen.Chen2@amd.com, bokun.zhang@amd.com,
        victor.skvortsov@amd.com, bernard@vivo.com, lijo.lazar@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdgpu: initialize reg_access_ctrl
Date:   Sat, 29 Jan 2022 06:53:47 -0800
Message-Id: <20220129145347.1417849-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang build fails with
amdgpu_virt.c:878:51: error: variable 'reg_access_ctrl' is
  uninitialized when used here
  ... + 4 * reg_access_ctrl->scratch_reg0;
            ^~~~~~~~~~~~~~~

The reg_access_ctrl ptr is never initialized, so
initialize once we know it is supported.

Fixes: 5d447e296701 ("drm/amdgpu: add helper for rlcg indirect reg access")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 80c25176c9932..c137652189190 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -875,6 +875,7 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v
 		return 0;
 	}
 
+	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl;
 	scratch_reg0 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg0;
 	scratch_reg1 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg1;
 	scratch_reg2 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg2;
-- 
2.26.3

