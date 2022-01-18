Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F4D4920B2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbiARH5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiARH5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:57:12 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C80DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 23:57:12 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id l17so21390279qtk.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 23:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oVASYcnUzo//aC4Lo3/46A3KtVN0oXM5tvWTeJ4jCZ8=;
        b=dFYGMojLFUBw1OMQjj6HwqnFRyARImliTcO5d7rybcEcORxWEfUGG7jjQtc9PHvOhb
         FTa0uKEgRc18PNWHHcixKTxZa+PX1QMKX20DuT5ma1QOhCgYVM22WgljjR4LB6SlXNYp
         jif/sq0cmvxhBSQ0kOaqsHsd3B+bEeDTxG7Chlz4Zd5FUfDSSeCgGJLCJ9l2AYOlGAPM
         6TzP+9gN33/WW2NlNFUROaL87ApVOyv1AgPoG5yMDqSOPrbMz3ES6zeZ12yOapBa7nk4
         I+IxRKwRqZYxPiW7qZNqrvhv1zLwawkF9wvs2u2JyItB1A8c2cCboH1TPGHCDcV8cShI
         a05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oVASYcnUzo//aC4Lo3/46A3KtVN0oXM5tvWTeJ4jCZ8=;
        b=s3qijnV5ydZtp3rtJEUmlbvmGwgj0/K53OSKw4xIXrWYFZEcguyFwGn9qGqzyOIq1G
         VQoiWKdQAeql5GPNOtpLaC+abXqHaZVwWlYJEm9PqcrU3ifHchS63P0soF6GKvB4doH3
         SLiu+sS81UOcdKGH8OYXnueCQd0dAb2vQ46yNmsYZzvDY+WneaxLfau3fnXUumgjN9Dt
         7HZF2IWMtUja+x4mM9PByK1Ru70Ip2pspPXsNusnvPeWKn7EUPZvkPqGL2Jm2cb+3PBE
         J3RsykAKJQWKxqtDjeANghGX054kEe5e/3x68End9EPYR5HD4eCKtu0Srs+F9/Thm56k
         sAPA==
X-Gm-Message-State: AOAM532JqFbIUAX/Lq2WpUrqa93KxVO37noRd2C0SbYf4jLmw2oJL5/S
        KhSDIkQyf7xxHq4XPdq3JRk=
X-Google-Smtp-Source: ABdhPJzTOFGF33TPzBo+kbuXuIEVovrBBhmGDVuKZqsKz3S+0IG70LLGvd0QdY8yw99+kVf8vs/r8g==
X-Received: by 2002:a05:622a:2d1:: with SMTP id a17mr18608482qtx.196.1642492631252;
        Mon, 17 Jan 2022 23:57:11 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o7sm10070549qke.44.2022.01.17.23.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 23:57:10 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, Hawking.Zhang@amd.com, john.clements@amd.com,
        candice.li@amd.com, lijo.lazar@amd.com, lang.yu@amd.com,
        Oak.Zeng@amd.com, jonathan.kim@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] amdgpu/amdgpu_psp: remove unneeded ret variable
Date:   Tue, 18 Jan 2022 07:57:02 +0000
Message-Id: <20220118075702.925929-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from amdgpu_bo_create_kernel() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index dee17a0e1187..ac2b87f81ef9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -914,19 +914,15 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 static int psp_ta_init_shared_buf(struct psp_context *psp,
 				  struct ta_mem_context *mem_ctx)
 {
-	int ret;
-
 	/*
 	* Allocate 16k memory aligned to 4k from Frame Buffer (local
 	* physical) for ta to host memory
 	*/
-	ret = amdgpu_bo_create_kernel(psp->adev, mem_ctx->shared_mem_size,
+	return amdgpu_bo_create_kernel(psp->adev, mem_ctx->shared_mem_size,
 				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
 				      &mem_ctx->shared_bo,
 				      &mem_ctx->shared_mc_addr,
 				      &mem_ctx->shared_buf);
-
-	return ret;
 }
 
 static void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx)
-- 
2.25.1

