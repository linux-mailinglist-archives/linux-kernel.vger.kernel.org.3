Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A9855AD2F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 00:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiFYWzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 18:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiFYWzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 18:55:00 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FB113F42;
        Sat, 25 Jun 2022 15:55:00 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r66so5681404pgr.2;
        Sat, 25 Jun 2022 15:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b9AQXf/WNrNc7N52p1TXe/6XsOcmDEDaje1UkHX1E8o=;
        b=okxVvZPaPPWukgtMjoQ2zV2MOXVKhOwgEQOvy9s8dCC6F7E0d7C4RjjeWQUWzwZAkm
         HbgBHZeHh0rktafpVgdIjgiSpmmOqw6xg9YkCjTrPLgusIAG2HJs/PA8era9WpIh93Nt
         z+8xYrS0D9c7kB3yJ0kSruPdVZNGl/y00bgLEScL7cZxATvRwI2y+GxE69koJf33oyJo
         PlR4+li5IUTvUqMQVruUfcPoE25FkgSHT5zi9AICxEUBmH2KbCO2hbzvJRXUehRP8H2i
         SfIsa5IIuErdOtEu8xGLJBrd9pLz2FRkhenzvHZtjjN8UHlbhAKkBF4nxFdCTymjt0Qi
         B+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b9AQXf/WNrNc7N52p1TXe/6XsOcmDEDaje1UkHX1E8o=;
        b=q03a157Q7R9Arra7VxLCtmo+Gfq63E/7OQb6DJL9rvPZ1P2x8sCQ4M/AUepi0r4/gB
         EeQL/VIibrAomk2BCha/AD0IrxiDve0pmeCP8MiZBy4+3MMt4Ea4l+DLDTTevm3VdsTb
         ZG4hE9y1HVAketD7wNYn3E0chh2Tf5ns0D8Q5tdLwixXvOpdgqTMF7Ayt++ytCci6Tpw
         E+zjyUn5NVghWqJthCEN/nnGO5fLukpHcvjrDaGAJh1R/Jo8GXT/M8ki/Q4NdfBbnzB1
         okkvdjnuBkOGFtWRQ5CgFVWGhhsUwv6dImnxGxV8k0nBZ8krr0PLPVMk3SeBLyXdS1Ge
         4s0w==
X-Gm-Message-State: AJIora9qLc+sKu3luFAbTZB9ugD/UkJRy0SCEKnUECjiseMsoxpJUZSy
        eOdO6LBAikMhVfrWuJPeNII=
X-Google-Smtp-Source: AGRyM1uZ3CwKWuR6uDhS+F4l+oftGA9Xv00IBSUo91DHn+OXfWfzgkeYBrHk2SEcfJPI7kLktGC3UA==
X-Received: by 2002:a05:6a00:2312:b0:525:392a:73c3 with SMTP id h18-20020a056a00231200b00525392a73c3mr6465551pfh.67.1656197699690;
        Sat, 25 Jun 2022 15:54:59 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902680600b00163ffe73300sm4205641plk.137.2022.06.25.15.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 15:54:58 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 01/15] drm/msm: Switch to pfn mappings
Date:   Sat, 25 Jun 2022 15:54:36 -0700
Message-Id: <20220625225454.81039-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220625225454.81039-1-robdclark@gmail.com>
References: <20220625225454.81039-1-robdclark@gmail.com>
MIME-Version: 1.0
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

From: Rob Clark <robdclark@chromium.org>

I'm not entirely sure why we were using VM_MIXEDMAP.  These are never
CoW mappings.  Let's switch to be more consistent with what other
drivers and the GEM shmem helpers do.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index ad7da2ca35ab..8ddbd2e001d4 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -259,7 +259,8 @@ static vm_fault_t msm_gem_fault(struct vm_fault *vmf)
 	VERB("Inserting %p pfn %lx, pa %lx", (void *)vmf->address,
 			pfn, pfn << PAGE_SHIFT);
 
-	ret = vmf_insert_mixed(vma, vmf->address, __pfn_to_pfn_t(pfn, PFN_DEV));
+	ret = vmf_insert_pfn(vma, vmf->address, pfn);
+
 out_unlock:
 	msm_gem_unlock(obj);
 out:
@@ -1051,7 +1052,7 @@ static int msm_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struct
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
-	vma->vm_flags |= VM_IO | VM_MIXEDMAP | VM_DONTEXPAND | VM_DONTDUMP;
+	vma->vm_flags |= VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
 	vma->vm_page_prot = msm_gem_pgprot(msm_obj, vm_get_page_prot(vma->vm_flags));
 
 	return 0;
-- 
2.36.1

