Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550884DC83D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbiCQODZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiCQOCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:02:46 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DA11E5A48
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:01:22 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id x8-20020a17090a788800b001c662c78b4fso2450275pjk.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AmXJz1T+DxTQ8cL3dWsBE4Euit10u/N4HtWuky6pYRE=;
        b=V3L1f0OpwlX27SXl8xzlUHsJrCaxgwXpjZ+thrxdmTARlLRSDFFBJ+xnGGLhlQsqqr
         tbkJyFaGSVmhVw5j9pAG34Rz8abgBSa0naQxCePa/cLUQx3nRMu9coTIGQ4vldyONv2K
         CMCnM93OSf6m0LNZ8U8XdMEZoOuwaLPvngsPbxN4Uxw/Tb/OW4209S1m0e9ri3orbvU/
         lAvYKhGN8KXNAv1FpIFUv/VOJSK3nG1Nx19pmWs7x5bECEHXR2C7f822KvYKqD5zP0M3
         UaNy/efqhy+qXYIxgLxHYB/ZbLn/li1zjGa9muAEbrTmPYtEZKC3/t2JySghT+nFOyXe
         LU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AmXJz1T+DxTQ8cL3dWsBE4Euit10u/N4HtWuky6pYRE=;
        b=jdU1FCDLmbiHExhsnzLGhuOvowZC9sijmmmhYV9IV03oXIe1+orEwX/YwoCzERHRIF
         r/shFD/IaOUJch1+nQfLkI4qnk6v8X/5QjxldZBn9yP/MsIwTrt2a73ZF4Ul2ldB9vwg
         78Js1LuDymUrhWsQ/rk9A1EMPcFlpr5/LCJ0wLd39u1aXbabE39wiiXs5CPUrAnKm2bH
         foZvhGZRN/Se3Rt3PUclxR1FQcI/0XOGXmZHuvlSi5LeqwYSLrQkQa+Tt13ywSTnnMM/
         OvHPn98DyP5Wsg68yxNIRYpBZRb+EmC663madPEREKwAADCRNVK8iKaYZLxMIi5Mvozw
         80mg==
X-Gm-Message-State: AOAM531mR4RE9Irnu4cOyyaciB9vyW5ZhTLZJPaF4HHPZxqsjIAUDxvg
        YfK51zoM+ZwlQ2lnAQzg5IVj5jsTs5D2
X-Google-Smtp-Source: ABdhPJxvoaqHM4SNfI3emat8G4zJ6gXkRPEt1XpB5btefTfHzZkskzhJq8f5SToxX3rJ2wl3pkTrR0UzOIew
X-Received: from ezekiel.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:108e])
 (user=shraash job=sendgmr) by 2002:a62:3896:0:b0:4f7:87dc:de5b with SMTP id
 f144-20020a623896000000b004f787dcde5bmr5201915pfa.49.1647525681892; Thu, 17
 Mar 2022 07:01:21 -0700 (PDT)
Date:   Thu, 17 Mar 2022 19:31:15 +0530
Message-Id: <20220317140115.541007-1-shraash@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH] drm/amd/display: Fixed the unused-but-set-variable warning
From:   Aashish Sharma <shraash@google.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
        Jake Wang <haonan.wang2@amd.com>,
        Anson Jacob <Anson.Jacob@amd.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Anthony Koo <Anthony.Koo@amd.com>,
        Wayne Lin <wayne.lin@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Aashish Sharma <shraash@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed this kernel test robot warning:

drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2893:12:
warning: variable 'temp' set but not used [-Wunused-but-set-variable]

Replaced the assignment to the unused temp variable with READ_ONCE()
macro to flush the writes.

Signed-off-by: Aashish Sharma <shraash@google.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 873ecd04e01d..b7981a781701 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2913,13 +2913,12 @@ static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
 	uint32_t wptr = rb->wrpt;
 
 	while (rptr != wptr) {
-		uint64_t volatile *data = (uint64_t volatile *)((uint8_t *)(rb->base_address) + rptr);
+		uint64_t *data = (uint64_t volatile *)((uint8_t *)(rb->base_address) + rptr);
 		//uint64_t volatile *p = (uint64_t volatile *)data;
-		uint64_t temp;
 		uint8_t i;
 
 		for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
-			temp = *data++;
+			(void)READ_ONCE(*data++);
 
 		rptr += DMUB_RB_CMD_SIZE;
 		if (rptr >= rb->capacity)
-- 
2.35.1.723.g4982287a31-goog

