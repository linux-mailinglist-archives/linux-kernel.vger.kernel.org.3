Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC45A5A235B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbiHZImn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbiHZImV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:42:21 -0400
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8B8D5DF9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:41:33 -0700 (PDT)
Received: by mail-pj1-f68.google.com with SMTP id p9-20020a17090a2d8900b001fb86ec43aaso951903pjd.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=HIeIpyWVKIcmfqIV5lirkvwwNNDOVYt8bI+0hEb74pQ=;
        b=DUH+MQJsHF9tYYoi6UpreC4MA3N6wPyDdRiQECCqaBn4lPmjLvr0Y7Zu06ux03/HtQ
         yLsK/TJKXJoOMbmX90R6TOaNg9HNlfbDf2gaNugS6PafcRjgfc+BS3yGwnXcSOZaMbqB
         5rNyitH9KulbhHE9PEUepmnoxWmUEzc/uhNvlPcFUoSPSlTksjYxXW+O8qbN3U8tcgJm
         iTVsDdjUKFqQmKE0UEBBRuMmj0f0IHA+56zGSUuWjs4g+sbeAfOzDZjxjpGsJvwGSqwR
         upsOF1i2Ci1DKDU9X3P9wmOCrliw5T8GNSHyAmen45e6IrSXgfUhSQ9u8Jy8gtbyF2f0
         WdMw==
X-Gm-Message-State: ACgBeo0BRsmHtRDvx8MEL5vbuW5lL8Pcs9NtS39HRbzWpIy3lWh3oZHx
        fIdv2x+Q4vSR6WZfhG1/zQ==
X-Google-Smtp-Source: AA6agR7Xwb0bLnunGKQsV2loxRVQznyp5x72nqQRbT4GixsvoFpb2+hG9OudZfw7hw450gqkeA/meQ==
X-Received: by 2002:a17:90b:1c0c:b0:1fb:6b2c:ca9f with SMTP id oc12-20020a17090b1c0c00b001fb6b2cca9fmr3421599pjb.90.1661503292597;
        Fri, 26 Aug 2022 01:41:32 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
        by smtp.gmail.com with ESMTPSA id n33-20020a17090a5aa400b001fb371c01bfsm1075740pji.37.2022.08.26.01.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 01:41:32 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] drm/amd/display: Fix variable dereferenced before check
Date:   Fri, 26 Aug 2022 16:41:21 +0800
Message-Id: <20220826084121.94319-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following smatch warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:311 dc_dmub_srv_p_state_delegate()
warn: variable dereferenced before check 'dc' (see line 309)

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 09b304507bad..ebf99e8f93e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -323,11 +323,13 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 	struct dmub_cmd_fw_assisted_mclk_switch_config *config_data = &cmd.fw_assisted_mclk_switch.config_data;
 	int i = 0;
 	int ramp_up_num_steps = 1; // TODO: Ramp is currently disabled. Reenable it.
-	uint8_t visual_confirm_enabled = dc->debug.visual_confirm == VISUAL_CONFIRM_FAMS;
+	uint8_t visual_confirm_enabled;
 
 	if (dc == NULL)
 		return false;
 
+	visual_confirm_enabled = dc->debug.visual_confirm == VISUAL_CONFIRM_FAMS;
+
 	// Format command.
 	cmd.fw_assisted_mclk_switch.header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
 	cmd.fw_assisted_mclk_switch.header.sub_type = DMUB_CMD__FAMS_SETUP_FW_CTRL;
-- 
2.25.1

