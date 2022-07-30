Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00CB5857BC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 03:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239782AbiG3BKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 21:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239880AbiG3BKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 21:10:37 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2FB1704E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 18:10:21 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id c3so6163985vsc.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 18:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3Sz2rolMVv0cdP4ostXteQeLyc14aNYq/ZCxOFD4XiM=;
        b=VP+ID6vLjTJHOLcQEZvpz/7ErDjng1bhyuCfCC5R1jQVkEijl2P7TAClNxXRskI5ls
         8a5wzfhLwgQxHN41hTDnkGx7VtosqGN0XsCJ9Exb1Lz+ERfnTgl/RxcN4q0PWxWAmlxi
         qHjTkg8H8+6TQGmTz/XK1MiFjKwPzeMej2k9RgA4T3a4K8gXBNIHx4WD5lGVPESTt0L+
         v8g+wuvy2byGJCHPsmLanQEMWoRqXTqZU70NoJpOfDnK7XFIg6jHDgF4dnzXRcyQqJPX
         FRUliBWODW9pn9oLV3dsGzZfK4LSzXvux+25UoA6UriMcSqLgyj4UzAfKWCFXoGyo2NS
         0x9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3Sz2rolMVv0cdP4ostXteQeLyc14aNYq/ZCxOFD4XiM=;
        b=LyEuhPorx3hHHhvbpA+qPhBT4Vjtiq2eIldZDkOANLObzPgg7n1WRfvHOHcjZ/+q98
         viMHd/XmRWSrRmHtdbX8566PWAlHezbNm/DqI+0OJFMMfMzNGNLxNcoluGpGqFqVWULL
         ogOLylKCFqZsnRrv9xZzwG2pwHL+sbjzgozLt9orfIRC3dxGFp+6srIUpT9Ga3Uf37kz
         nPRAWHF+h5PsUb7WzAAdAOjGQI/z/xg/0o5l799H+pCTGCLlNHxNlagJvntUiwb6uNFZ
         3h0LZZGaN4HR7ATMFJXU+kuBy01aiEx9OmKhwKfQR6hSpkOMNhmHlqsQkAq/v94g9kR/
         RpdA==
X-Gm-Message-State: AJIora+xIUspbzrdmdhQFLxeT36gTFo8XNMGntvrZDZ2BR2v8sUXOZEO
        1IWLG+muTremYN24FnWutTM=
X-Google-Smtp-Source: AGRyM1uewnPKiyg7SneKT+OvpGqlbZdRlix+UMbcuDNXx3y0wOk1FNpXVlBV+1imyExWtxmwu0wjPA==
X-Received: by 2002:a67:c902:0:b0:358:743b:d0e3 with SMTP id w2-20020a67c902000000b00358743bd0e3mr2602562vsk.68.1659143420270;
        Fri, 29 Jul 2022 18:10:20 -0700 (PDT)
Received: from fedora.. ([2804:14c:bbe3:4370:95da:f07f:e927:6958])
        by smtp.gmail.com with ESMTPSA id a11-20020a67b30b000000b0035860d6caf8sm1708047vsm.2.2022.07.29.18.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 18:10:19 -0700 (PDT)
From:   Magali Lemes <magalilemes00@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     mwen@igalia.com, mairacanal@riseup.net, isabbasso@riseup.net,
        siqueirajordao@riseup.net, andrealmeid@riseup.net,
        tales.aparecida@gmail.com, Magali Lemes <magalilemes00@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drm/amd/display: remove header from source file
Date:   Fri, 29 Jul 2022 22:07:00 -0300
Message-Id: <20220730010700.1824647-2-magalilemes00@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220730010700.1824647-1-magalilemes00@gmail.com>
References: <20220730010700.1824647-1-magalilemes00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since "rn_clk_mgr.h" needs ‘struct clk_mgr_internal’ which is declared
in "clk_mgr_internal.h", include "clk_mgr_internal.h" in "rn_clk_mgr.h"
instead of in its source file.
Because of the change above, change the order of '#include
"rn_clk_mgr.h"', so that the necessary structs are visible to
dcn20_clk_mgr.h.

Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
Reviewed-by: Maíra Canal <mairacanal@riseup.net>
Reviewed-by: Melissa Wen <mwen@igalia.com>
---
Changes in v2:
  - split commit (Melissa).

 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 3 +--
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.h | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 0202dc682682..ca6dfd2d7561 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -24,10 +24,9 @@
  */
 
 #include "dccg.h"
-#include "clk_mgr_internal.h"
+#include "rn_clk_mgr.h"
 
 #include "dcn20/dcn20_clk_mgr.h"
-#include "rn_clk_mgr.h"
 #include "dml/dcn20/dcn20_fpu.h"
 
 #include "dce100/dce_clk_mgr.h"
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.h
index 2e088c5171b2..f1319957e400 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.h
@@ -28,6 +28,7 @@
 
 #include "clk_mgr.h"
 #include "dm_pp_smu.h"
+#include "clk_mgr_internal.h"
 
 extern struct wm_table ddr4_wm_table_gs;
 extern struct wm_table lpddr4_wm_table_gs;
-- 
2.37.1

