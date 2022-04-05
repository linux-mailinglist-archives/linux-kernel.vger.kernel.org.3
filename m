Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424054F490B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389563AbiDEWBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572973AbiDERiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:38:10 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60027B8202
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:36:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id m3so24486489lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 10:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yax7P8EHkvsWnyvnaOpe3ZP8r2G7HKN+i3pXtBsfClM=;
        b=eX6mY5a8lSH1hyqUbeznreGC7UTb6M0TABj5aCC7d1j7X8S5tKD7PEwqCQaBddz1/U
         WYtwfZYDDw/dYD4JRG69cicx99gRc3R8NnjE0szGGh5jJkHDDH5nlg7OI0bG7Kg8MvUt
         N+02SEESeCp662srZbhhQwqKi0sqlYTzC14XKEFwtf+XzOMQkJL0/ayQRgyL6zt44GOi
         2WpLLgAmNUr9+ojdOcvdbvkIjm2clTL7i6syEiYxeCCrWBRdEoiNP34kFDSfWc2U4KKK
         FpMo3KNFr4Fb3z/FJBcbBLfeTTQjOep3Ufsp+c/ZStiy+0xbxfOQ5uPnPUdxYBkipNHr
         btyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yax7P8EHkvsWnyvnaOpe3ZP8r2G7HKN+i3pXtBsfClM=;
        b=p2b2g0Fh9hNjnxXgogdifcYQgBj5y+fUQ/moLTPXluu8HaYUMiuysL8NAeWBFy2CEa
         Zzt0s+XTwd2YQ+yeh7v5lcobf0Vqy+16bamR16bOjK+KhQvyZB5ChLawDvRxHTluQzB7
         SqjyEFHLeTcWg/RyjtogV82ldRTKhvK6iuciMVZHIGpdZ3BtQ7QdeqXh/Y49ZepOj2+N
         /CpmLglg7fpzhPQRCOzTQFqemZWY66XHxrNxVBR6cECGNNt8wS0jMkZNyQLl8zj2NHvH
         chJQjWuc5ykASEyLyfsj7XUlmhp5LoEGHn4hSgISY3YiYtfy5epgR8v13Me4gcf5lfjR
         Pp+g==
X-Gm-Message-State: AOAM530UlWuVDaw5Cu9egaXwI9SiknVBdwahIbh2BtBSaW9PJlppRFDT
        GjCIdJ7Tk8pHiEmS0SK/jC8=
X-Google-Smtp-Source: ABdhPJzAigPVYUbSH1vQDPC4sxC9WAI5tvVCVverTI7h3DMZJH8eYPENeqhDI61Vlsdt1H9euBwtiQ==
X-Received: by 2002:a05:6512:15a6:b0:44a:a117:f1d3 with SMTP id bp38-20020a05651215a600b0044aa117f1d3mr3461530lfb.216.1649180169117;
        Tue, 05 Apr 2022 10:36:09 -0700 (PDT)
Received: from noname.. ([2a02:2698:8c2a:226e:6d9:f5ff:fecb:a8ab])
        by smtp.googlemail.com with ESMTPSA id i33-20020a0565123e2100b00452f78ea43dsm481430lfv.297.2022.04.05.10.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 10:36:08 -0700 (PDT)
From:   Grigory Vasilyev <h0tc0d3@gmail.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>
Cc:     Grigory Vasilyev <h0tc0d3@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Jiawei Gu <Jiawei.Gu@amd.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/amdgpu: Accessing to a null pointer
Date:   Tue,  5 Apr 2022 20:36:12 +0300
Message-Id: <20220405173613.2611-1-h0tc0d3@gmail.com>
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

