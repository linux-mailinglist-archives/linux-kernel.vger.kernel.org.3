Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C00587BED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbiHBMEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbiHBMEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:04:24 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC3D4D4F1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 05:04:21 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-10ee900cce0so4972605fac.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 05:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=szYfKRIZN4aoaPi+n+sh0rtODD9V4WUQ86iOcou1vWc=;
        b=oK2qLNS+/lw0sDZfBE5EQTadYWmFV/JngipxsStwS6KTzNB4WUJSIMNGKytqFhaA/d
         M/zcuLITulXEKXcMePbof/mlSkYJ3bTUVD6hFy496E9wwbFjv/Fl5McX5cX9GCs0yzf6
         qZZDiTi/dFHwb+btKQhDthZRDb+HiewJyWrNM8TLN/7I+Xm8G36Oobtzgze3ly1g2c1A
         V78qryB2Qi39uBY74mCKJ4Hkd1vPG20wjLy8udYCS2w0CUq78muKipVBYBD9Oqblp/hY
         /2/ISp8sxNy4ae7WuVTjumldtMdTwU9HK/VepctP5fdVMRgy9OtdCBm3FfHg8qfxlwhI
         6Amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=szYfKRIZN4aoaPi+n+sh0rtODD9V4WUQ86iOcou1vWc=;
        b=eRoiRwMQe6RZiW7LLICk+paG1Trqx6q49NjieUUrhE/KZpbS6E7lD/ehscvR8gYB2b
         6pp6e9yZCUNkWBdqzeQSbRV/dl5Ni/T4oNOmOA3SQy2BQFgi6AOohgp9qAwqgBsDMZmk
         s5StMfSSEejS+oG+3x1inT7EDYi5Km1BRZysggGC1QGtJb+RcOKfPF/4e2JFcenUzYcO
         S8ahJiYK+xaaQ2Z9THWnvP8r9xOKJMlMmaOLkrSMnGb3MM9K/nseJByTEOkxVNvyZUgZ
         Q/ATTgg4U1spKBRZ2DSokt7A6osXMGVxY8J+H0LIxwyu/pugMcEEA5RnpnLPIHYt33xm
         pj5Q==
X-Gm-Message-State: AJIora9g+JelbFA84QH7EOL37A+UcuqNWD3aj2FB5D+fok3nI9deBQm/
        PZLD5jjmnRUcvzsKFLfzCGs=
X-Google-Smtp-Source: AGRyM1svY/0B68XGxStthRsoaBRtKTt1WYTXp9V8T35AelYJoa3etN88MMK3a7AZi8f8kIXMJPe0Fg==
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id ba11-20020a056870c58b00b0010bd21dad5emr8912499oab.287.1659441860757;
        Tue, 02 Aug 2022 05:04:20 -0700 (PDT)
Received: from fedora.. ([2804:14c:bbe3:4370:95da:f07f:e927:6958])
        by smtp.gmail.com with ESMTPSA id eo18-20020a056870ec9200b0010f07647598sm78318oab.7.2022.08.02.05.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 05:04:19 -0700 (PDT)
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
Subject: [PATCH] drm/amd/display: remove DML Makefile duplicate lines
Date:   Tue,  2 Aug 2022 09:04:06 -0300
Message-Id: <20220802120406.88845-1-magalilemes00@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
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

There are two identical CFLAGS entries for "display_mode_vba_20.o", so
remove one of them. Also, as there's already an entry for
"display_mode_lib.o" CFLAGS, regardless of CONFIG_DRM_AMD_DC_DCN being
defined or not, remove the one entry between CONFIG_DRM_AMD_DC_DCN ifdef
guards.

Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dml/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 359f6e9a1da0..41bb6c3cc2d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -61,7 +61,6 @@ CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn10/dcn10_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o := $(dml_ccflags)
@@ -82,7 +81,6 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn302/dcn302_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn303/dcn303_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o := $(dml_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags) -Wno-tautological-compare
-- 
2.37.1

