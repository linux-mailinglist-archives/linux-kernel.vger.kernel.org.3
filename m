Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A934F4A36
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454052AbiDEWhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572975AbiDERi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:38:29 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9A6B8202
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:36:29 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id h11so18095903ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 10:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hKOYgRsFR0laaLuRCNcCw4kzlI2NLR4gbF3cCQ5uqJo=;
        b=BVr2YLDF7/GGyceZtEIm5ngSV0ZtewWefzWQMZJrDgToXi9Raa7zKK44DLjRVzPSqP
         rsZLh6unBOu9b8DWnbG/ulO/wlcI8YZUN880shObyr6Um/tVfTBF3cpDo2m1IIKVXFXc
         zuEn6HEaMmx6K8GTOTGE4Mblhp0TiZE2FitQh5Rr8gfwTotRoebmdrpUBkbSJQqBH8oj
         W1xHElC1X+BR49CMwpETUiRpdxyPiM6vQ59CHEktyrUKPaIaztu332GBp/js3CB90ZAn
         r78X3f+ujP//edJmpYijII+/KADwpeHvELEGDupRr4+0b1KDmJ35cLhgmUM4MdeHvqp9
         rfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hKOYgRsFR0laaLuRCNcCw4kzlI2NLR4gbF3cCQ5uqJo=;
        b=0JSYmqfoFhsvXI90WHtgPkA1/AT0y7s3iP58rb9Twg6AYJq35Q919S5jnXI/l3Hc8G
         xqBgrRDm3t2hboKXOuiZ13NPlwo8BK0jxq4N4Zb3reUhu5BlC/6GypUoLxe3cuPx1SKp
         CEiVRUlB8TRYp+XZl5zOWv/jdclPWIqJrWX8LhO8uVYFSU7ThYEjLy+UUfDnd1rtG4Vu
         ml09q4S3fQW3JDUU8RSFQeDiAHAyUKRNMu5uGnzU4hhUC7vfKVDrm0Prl1boKNCHJ+nc
         03jZVJNfheIzcVZJjXYXjpIMitC/40E+l7IK+0wndRdd+ThDxaX+d+mDRw7SQflqsOjD
         nTdA==
X-Gm-Message-State: AOAM5302mvcsr7aJhOHQwrrrbRMKHbfnbrCcsyMTZ6hjbdJhWVSd9jOT
        FWEZzYontzq73iAleLB3GwM=
X-Google-Smtp-Source: ABdhPJx9gURcfFhpkbU9G9qwJXgvTRqcQU7EZfhQn5YZ/YhwpA3vtsYFCnXigwEL5XUSIkyEiMsvQQ==
X-Received: by 2002:a2e:a490:0:b0:249:894b:ce20 with SMTP id h16-20020a2ea490000000b00249894bce20mr2753320lji.301.1649180187930;
        Tue, 05 Apr 2022 10:36:27 -0700 (PDT)
Received: from noname.. ([2a02:2698:8c2a:226e:6d9:f5ff:fecb:a8ab])
        by smtp.googlemail.com with ESMTPSA id j11-20020a196e0b000000b0044a3f007893sm1563825lfc.286.2022.04.05.10.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 10:36:27 -0700 (PDT)
From:   Grigory Vasilyev <h0tc0d3@gmail.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>
Cc:     Grigory Vasilyev <h0tc0d3@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@intel.com>,
        Jiawei Gu <Jiawei.Gu@amd.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Senseless code and unnecessary memset
Date:   Tue,  5 Apr 2022 20:36:31 +0300
Message-Id: <20220405173632.2663-1-h0tc0d3@gmail.com>
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

Using memset on local arrays before exiting the function is pointless.
Compilator will remove this code. Also for local arrays is preferable to
use {0} instead of memset. Mistakes are often made when working with
memset.

Signed-off-by: Grigory Vasilyev <h0tc0d3@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index be9d61bcb8ae..537e48fbbe6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1538,11 +1538,9 @@ struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
 int amdgpu_atom_asic_init(struct atom_context *ctx)
 {
 	int hwi = CU16(ctx->data_table + ATOM_DATA_FWI_PTR);
-	uint32_t ps[16];
+	uint32_t ps[16] = {0};
 	int ret;
 
-	memset(ps, 0, 64);
-
 	ps[0] = cpu_to_le32(CU32(hwi + ATOM_FWI_DEFSCLK_PTR));
 	ps[1] = cpu_to_le32(CU32(hwi + ATOM_FWI_DEFMCLK_PTR));
 	if (!ps[0] || !ps[1])
@@ -1551,10 +1549,6 @@ int amdgpu_atom_asic_init(struct atom_context *ctx)
 	if (!CU16(ctx->cmd_table + 4 + 2 * ATOM_CMD_INIT))
 		return 1;
 	ret = amdgpu_atom_execute_table(ctx, ATOM_CMD_INIT, ps);
-	if (ret)
-		return ret;
-
-	memset(ps, 0, 64);
 
 	return ret;
 }
-- 
2.35.1

