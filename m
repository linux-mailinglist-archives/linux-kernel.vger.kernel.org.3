Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831754C359C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiBXTRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiBXTRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:17:04 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1962198
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:16:31 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id s5so4336062oic.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=89DjEEGsLwYVVyD3+lmgDuUkvgmk0sfi5HizC/FoSH4=;
        b=nLE4O+3a20KBgtMfBCmxPYKi2/yST1qDItJARMiJsPchNEAXZvAamWBMyYOiminHO0
         f+ViAwcqCo4QglNR7wsM980DfeBcDWIeXP0DYzmx/DqMcfWrtZ0qz7I2c6TyfMpnqz5e
         IIrErJME1K4nHTD3xFi2OsblyMCLWHZZg2NowBgylgzBMhK5gmry6+qQriY1+WUDSWE6
         /aEFiwDOdPhuNf0jeGDVq+lwdlyUtTcGnYpJm+09UMFwfVMDtVx6vKhlmy/4PH4m/aKb
         UWZ9VWjZbyyiYhWMeuu7xRiXXM1TtorNBbw1NozVfPlBs2nnV16Te7V6YlMrspA53Cnx
         9uIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=89DjEEGsLwYVVyD3+lmgDuUkvgmk0sfi5HizC/FoSH4=;
        b=Dz75lfN2rIwU7ABDCrhEkcs/0cPca+oVDS7WUVtYHjqCVCpsVoZWou9HuwxBlwNEJK
         U+p98jOJ+Pzwcz7XmTbiJxtaZuaIgPg7XasdF2VKBosYdqyODO2QH90juDJ2besljD18
         v3i7t54fJDCj8yzYoNpLcA3VMOaq+2F9p0I+ItOE3SC2/QE4rQNdpEA/YykHg9wuIoVA
         DR3yuvfW038XhIXrJ6+4UEQRb18pD92tLrDdqZZNCc/wCs/AEoG8J6mnmZSjdObgRjY2
         SL4u2FzfKhwL+81hItZ3MIwVqGjRp9JQTtc26IA9Cmng7Bq4RZOFlwJDmjKsJK+UlTsC
         efGw==
X-Gm-Message-State: AOAM533LHRpZ5fnvC+Cc60WX6IZyxBJ/T1Meb2D5WflnNDZ9OSAKq4c9
        3/9RUrSFr6WQL3VhnE/ZMyE=
X-Google-Smtp-Source: ABdhPJxkqDmRQVez9RKGPAup0tMKEJD6hMNayVig2vxoittVpi0Y4s2/5JCsUDFjoJX87Eht8C51Wg==
X-Received: by 2002:a05:6871:b10:b0:d3:a3f7:89f9 with SMTP id fq16-20020a0568710b1000b000d3a3f789f9mr6920606oab.163.1645730190688;
        Thu, 24 Feb 2022 11:16:30 -0800 (PST)
Received: from localhost.localdomain (189-47-54-110.dsl.telesp.net.br. [189.47.54.110])
        by smtp.gmail.com with ESMTPSA id w3-20020a056830110300b005af14392276sm79509otq.62.2022.02.24.11.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:16:30 -0800 (PST)
From:   Magali Lemes <magalilemes00@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     siqueirajordao@riseup.net, mwen@igalia.com, maira.canal@usp.br,
        isabbasso@riseup.net, Magali Lemes <magalilemes00@gmail.com>,
        kernel test robot <lkp@intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drm/amd/display: Add conditional around function
Date:   Thu, 24 Feb 2022 16:15:49 -0300
Message-Id: <20220224191551.69103-3-magalilemes00@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224191551.69103-1-magalilemes00@gmail.com>
References: <20220224191551.69103-1-magalilemes00@gmail.com>
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

When CONFIG_DRM_AMD_DC_DCN is not set, the function
'dm_helpers_enable_periodic_detection' doesn't have its prototype defined,
causing the following warning:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:805:6:
warning: no previous prototype for function 'dm_helpers_enable_periodic_detection' [-Wmissing-prototypes]
   void dm_helpers_enable_periodic_detection(struct dc_context *ctx, bool enable)
        ^
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:805:1:
note: declare 'static' if the function is not intended to be used outside
of this translation unit
   void dm_helpers_enable_periodic_detection(struct dc_context *ctx, bool enable)
   ^
   static
   1 warning generated.

This commit silences this warning by adding a conditional directive
around the mentioned function, and also corrects a small spelling error.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 010498ff5911..f5f39984702f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -977,7 +977,9 @@ void dm_set_phyd32clk(struct dc_context *ctx, int freq_khz)
        // TODO
 }
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 void dm_helpers_enable_periodic_detection(struct dc_context *ctx, bool enable)
 {
-	/* TODO: add peridic detection implementation */
+	/* TODO: add periodic detection implementation */
 }
+#endif
-- 
2.25.1

