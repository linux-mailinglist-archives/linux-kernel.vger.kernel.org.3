Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D30A4F4E60
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1589101AbiDFASj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573225AbiDES0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:26:54 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14578419A4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 11:24:56 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p15so24754271lfk.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 11:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yax7P8EHkvsWnyvnaOpe3ZP8r2G7HKN+i3pXtBsfClM=;
        b=ahjOaaJmEvTMuw04XfKy8Q/jCeHjGJeiKqvnNpxDiZbgbug2iTCIFR8Le7QuzbJ0sA
         woMR7Bdoa2OJ21AmrWpJ9wf5UeYzp2npgxgZT+buKF6ZPXRPo7D1odBGOr2gDXJBnEo1
         dkWcurhuvdFNP8Dk650l2JhDA0fOvj008COWZUoCNgTJfeq4MP8RN6j7rsMKr8OLgz/g
         +REZDqGSM3Il7wPm+eIG3XRLQMRqOgjGT9K2/gEEyEEZPbgRlOUmBBozA2zAXYVf2nhK
         G8VsNSrxXA6MnMp6WQTrLd05UsiB5sx51uWWPhPAVm2lr97Bkt0pI2fpK8iXvhS5wgCO
         +jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yax7P8EHkvsWnyvnaOpe3ZP8r2G7HKN+i3pXtBsfClM=;
        b=vd84ONRVKPWOLA2ybPVoXzrGNUrjp6dV6i9Q1P7pBfgQEqar/uOfRfTdCYf6cDDrNC
         NVBHu+2QfGe5nRYO96aga1OkZVPB6fk1UxutgqUfGKweW475LlwEPuSkIFisbVhdQ+Yb
         iHMeiRC7OV+gBJSSdMrOfU//ervUbR7G+qvl1CSajSz+ARXIbzfQGomhUL8n3WH3NbsN
         IDJGnTtPcWtGmILV64+O/r5VZ7pf/C8tRYOpwPeUy+NNn7H+OV+xKVdgRPD0WYFXtPyc
         kFoMRgGW1mPoSq2VRsVvgDDCrEs0TXz76xuIfZCVP/m/Nj17G9AVJkLddN6aQ8ur1rmq
         1qjg==
X-Gm-Message-State: AOAM530QYZYubzgDQIYjDaTl9V8VINs9aH0Rdg+8HhbBzIFDJ8XhfRmZ
        m/U5Rw68E4SFiXM2opIRbnY=
X-Google-Smtp-Source: ABdhPJxOhepnKOoKA4RqwLPJjMXDoxl/v8mx8vWmtqquCH1q7VX7Pr+WalSB0nHIR8npx8CG+gkjhw==
X-Received: by 2002:a05:6512:3988:b0:44a:f02e:f28e with SMTP id j8-20020a056512398800b0044af02ef28emr3627503lfu.458.1649183094333;
        Tue, 05 Apr 2022 11:24:54 -0700 (PDT)
Received: from noname.. ([2a02:2698:8c2a:226e:6d9:f5ff:fecb:a8ab])
        by smtp.googlemail.com with ESMTPSA id bg19-20020a05651c0b9300b002497beec608sm1422452ljb.87.2022.04.05.11.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 11:24:53 -0700 (PDT)
From:   Grigory Vasilyev <h0tc0d3@gmail.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>
Cc:     Grigory Vasilyev <h0tc0d3@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Jiawei Gu <Jiawei.Gu@amd.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Accessing to a null pointer
Date:   Tue,  5 Apr 2022 21:24:55 +0300
Message-Id: <20220405182456.8798-1-h0tc0d3@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A typo in the code. It was assumed that it was
possible to shift the pointer to sizeof(BIOS_ATOM_PREFIX) - 1.

Signed-off-by: Grigory Vasilyev <h0tc0d3@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index e729973af3c9..be9d61bcb8ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1426,7 +1426,7 @@ static void atom_get_vbios_pn(struct atom_context *ctx)
 
 	if (*vbios_str == 0) {
 		vbios_str = atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX, 3, 1024, 64);
-		if (vbios_str == NULL)
+		if (vbios_str != NULL)
 			vbios_str += sizeof(BIOS_ATOM_PREFIX) - 1;
 	}
 	if (vbios_str != NULL && *vbios_str == 0)
-- 
2.35.1

