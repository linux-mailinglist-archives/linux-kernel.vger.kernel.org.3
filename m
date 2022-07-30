Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFBC5857BD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 03:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239751AbiG3BLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 21:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239740AbiG3BKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 21:10:49 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1187C8AEDF
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 18:10:48 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id b2so3053834vkg.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 18:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=EXcx83ZCGKGC5SWB/05DKVL5trtEdgyIefeqFTLbxmU=;
        b=nqH35WOEqeaaV3rWES5oh+tbu7iyeSzn+7k3m/1+JY0iGtZefI8/K9Peak3GWeNiZM
         AeObWBj4g8Ms5Cz71F80tn5h2CVFAqakCW/V2H6XfWbo9x+qnMz9k3BvFu8rUgO4azuL
         oLYha79NrEwGXTARdVmxjSCv8WXOMDczq9tNdL4gL8sZYOcqP/qcvtPtafK+kQY4cZ0H
         ivqAxBY3hv+d/OWQ/ZhsvGqwhCvMbMhjkkX3H+Bsd52rj+mLdLGiHlR/iyzcGQrT6V7X
         Z5++dMtt6pdDKSB1Sl+TdgiT2EOcOak50jjtyvDHgtb6cey4BDIH4KpOu3qb/S7xo6tV
         ASuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=EXcx83ZCGKGC5SWB/05DKVL5trtEdgyIefeqFTLbxmU=;
        b=ORT7LGHbERYtGDFyYgDwnxXXbtHKiG7gx/K7Yg5s60XPPwn4u/cGIVQhVX8U9tLYJc
         zK3ZBMPoNzIS0TCfV+xBFi1XcQ1DD25AR1u8JSPeMA+nM98mb1k2GSeFBYoHMAGozLUq
         EZoQY0p2A0BblvckkLgTwhDdhbiiebAvsIhkaCNDyJEzS7OW142MiOl9J1E6CAzMclIH
         OCPpA9A41F1b9X0ttb55WiHlKbbCIE4XTU8faie0v2Wt+dLOOhWkGdnfErhhOSND/q5Q
         N4DlxNKP4FU4DsEsPvGHzf0P/cOIJUDk++E0lDQDyrKuW4aop8e25SVhIpxsU/laLL16
         7ZXw==
X-Gm-Message-State: AJIora8XkO0clXW/miX3kJEUWqzlcXq81JhrDuIDIeuwBk4w0Cb73S1v
        ralve0x/r52t/vguYyyk4r4=
X-Google-Smtp-Source: AGRyM1uJ1ktVWvmgN8VnXITJwjJwAVAlzQaQIMt2sto+TIUlZd7N/VUYhdchN0Cp4mnwauIz2Rqwjg==
X-Received: by 2002:a1f:df41:0:b0:376:ecd7:4930 with SMTP id w62-20020a1fdf41000000b00376ecd74930mr2615048vkg.11.1659143447011;
        Fri, 29 Jul 2022 18:10:47 -0700 (PDT)
Received: from fedora.. ([2804:14c:bbe3:4370:95da:f07f:e927:6958])
        by smtp.gmail.com with ESMTPSA id a11-20020a67b30b000000b0035860d6caf8sm1708047vsm.2.2022.07.29.18.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 18:10:46 -0700 (PDT)
From:   Magali Lemes <magalilemes00@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, mwen@igalia.com, mairacanal@riseup.net,
        alex.hung@amd.com
Cc:     isabbasso@riseup.net, siqueirajordao@riseup.net,
        andrealmeid@riseup.net, tales.aparecida@gmail.com,
        Magali Lemes <magalilemes00@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] drm/amd/display: include missing headers
Date:   Fri, 29 Jul 2022 22:07:02 -0300
Message-Id: <20220730010700.1824647-3-magalilemes00@gmail.com>
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

Add missing headers to solve the following warnings from sparse:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/dcn20_fpu.c:656:17: warning: symbol 'ddr4_wm_table_gs' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/dcn20_fpu.c:693:17: warning: symbol 'lpddr4_wm_table_gs' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/dcn20_fpu.c:730:17: warning: symbol 'lpddr4_wm_table_with_disabled_ppt' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/dcn20_fpu.c:767:17: warning: symbol 'ddr4_wm_table_rn' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/dcn20_fpu.c:804:17: warning: symbol 'ddr4_1R_wm_table_rn' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/dcn20_fpu.c:841:17: warning: symbol 'lpddr4_wm_table_rn' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn301/dcn301_fpu.c:217:17: warning: symbol 'ddr4_wm_table' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn301/dcn301_fpu.c:254:17: warning: symbol 'lpddr5_wm_table' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/dcn31_fpu.c:53:30: warning: symbol 'dcn3_1_ip' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/dcn31_fpu.c:197:30: warning: symbol 'dcn3_15_ip' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/dcn31_fpu.c:293:30: warning: symbol 'dcn3_16_ip' was not declared. Should it be static?

Fixes: 490d2bc889f1 ("drm/amd/display: move FPU code on dcn21 clk_mgr")
Fixes: 83916f9a32a4 ("drm/amd/display: move FPU code from dcn301 clk mgr to DML folder")
Fixes: 26f4712aedbd ("drm/amd/display: move FPU related code from dcn31 to dml/dcn31 folder")
Fixes: fa896297b31b ("drm/amd/display: move FPU related code from dcn315 to dml/dcn31 folder")
Fixes: 3f8951cc123f ("drm/amd/display: move FPU related code from dcn316 to dml/dcn31 folder")
Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
Reviewed-by: Maíra Canal <mairacanal@riseup.net>
Reviewed-by: Melissa Wen <mwen@igalia.com>
---
Changes in v2:
  - split commit (Melissa)
  - update the commit message accordingly
  - add Fixes and Reviewed-by tags.

 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c | 1 +
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c   | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index ca44df4fca74..d34e0f1314d9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -30,6 +30,7 @@
 #include "dchubbub.h"
 #include "dcn20/dcn20_resource.h"
 #include "dcn21/dcn21_resource.h"
+#include "clk_mgr/dcn21/rn_clk_mgr.h"
 
 #include "dcn20_fpu.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
index 7ef66e511ec8..d211cf6d234c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
@@ -26,6 +26,7 @@
 #include "clk_mgr.h"
 #include "dcn20/dcn20_resource.h"
 #include "dcn301/dcn301_resource.h"
+#include "clk_mgr/dcn301/vg_clk_mgr.h"
 
 #include "dml/dcn20/dcn20_fpu.h"
 #include "dcn301_fpu.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 5664653ba5ac..149a1b17cdf3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -25,6 +25,9 @@
 
 #include "resource.h"
 #include "clk_mgr.h"
+#include "dcn31/dcn31_resource.h"
+#include "dcn315/dcn315_resource.h"
+#include "dcn316/dcn316_resource.h"
 
 #include "dml/dcn20/dcn20_fpu.h"
 #include "dcn31_fpu.h"
-- 
2.37.1

