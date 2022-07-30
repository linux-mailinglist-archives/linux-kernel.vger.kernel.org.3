Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C255857BB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 03:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbiG3BKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 21:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239855AbiG3BKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 21:10:22 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5A882F8C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 18:09:38 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id x125so6133798vsb.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 18:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=vARix7LjC8+V2lUGH4a8vd6kYiVRgsW91KpYoaINCzQ=;
        b=h113yoKonBCsoBgBIJRG7TYW5IdVv4PVNH8xQ8/CeD83AaZBkSm1tPLxlHGG5I3izq
         XE1LWdsManpW3WR2GsEBJzEWbaCqJRKau3bfdKkYJGf0SiPg/mHwRGDgCZoJgqGjAgwZ
         pubW0SNyRXvkcuaL1RZ6TOu3hgvThYRGYIEn54dnyCIkgwOgXK1EwUaCY6lSJn/Pgy7P
         IPbornuOuO5c14lTFpbpKB+3gTQXOEeRo8QPFNZgX04+1QRD13i/5kZrySmeCWmK80BG
         aFDOjS211eIPiWia8ebJGIKoZ5impL7Ay3b82rVVLHVGOXAmRTCoPV8jNXB995mpKbPn
         /r1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=vARix7LjC8+V2lUGH4a8vd6kYiVRgsW91KpYoaINCzQ=;
        b=EvcoPRmnDfbS4goKHy31jRN9fWngnLeIHEsXAfK3+T/AYon1qkQJvTmsqYzzZRTjph
         znNn70l7mOhr5Nksg527PYlMJ24XQ9q2sJMOOS4TpszrTXM1ktB2vNgPOZKWWFz170Iy
         7hu0RPqqfCsDuNEFKGoN08uQYULkXrBF75ax+O2DRJlhLKwErqaFtezmkt81zd/2Sfik
         wIyuklhcuwi4lQzc1jWTh8HuqBQHxdAckMrfr+NFewlHWgquk+gx67Y/21Ysa+/EiF3g
         VFbKxsYs+cuf7FEeKmEB7oUQZho17pmQQvhORFSINC8+HqBRWgHTJxIRYD2HVOXnuS4E
         zjwg==
X-Gm-Message-State: AJIora/51wZmhOoWRfEsNrWX0SQxQXvlu24N4pWOYD1x3DhbbyOgNUS8
        xnQK42ILLw2u7IwzxcOllGdbe6MSvpZB8ImT
X-Google-Smtp-Source: AGRyM1vUkskwW8/ECjR5ojI7xK86Qa6NccAqCTnIOvLVkS0dbaeXNnOBlj+kxpSaep33CjcVICgjcg==
X-Received: by 2002:a67:2486:0:b0:354:565c:62ec with SMTP id k128-20020a672486000000b00354565c62ecmr2562697vsk.26.1659143377041;
        Fri, 29 Jul 2022 18:09:37 -0700 (PDT)
Received: from fedora.. ([2804:14c:bbe3:4370:95da:f07f:e927:6958])
        by smtp.gmail.com with ESMTPSA id a11-20020a67b30b000000b0035860d6caf8sm1708047vsm.2.2022.07.29.18.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 18:09:35 -0700 (PDT)
From:   Magali Lemes <magalilemes00@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, mwen@igalia.com, alex.hung@amd.com
Cc:     mairacanal@riseup.net, isabbasso@riseup.net,
        siqueirajordao@riseup.net, andrealmeid@riseup.net,
        tales.aparecida@gmail.com, Magali Lemes <magalilemes00@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] drm/amd/display: make variables static
Date:   Fri, 29 Jul 2022 22:06:58 -0300
Message-Id: <20220730010700.1824647-1-magalilemes00@gmail.com>
X-Mailer: git-send-email 2.37.1
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

As "dcn3_1_soc", "dcn3_15_soc", and "dcn3_16_soc" are not used outside
of their corresponding "dcn3*_fpu.c", make them static and remove their
extern declaration.

Fixes: 26f4712aedbd ("drm/amd/display: move FPU related code from dcn31 to dml/dcn31 folder")
Fixes: fa896297b31b ("drm/amd/display: move FPU related code from dcn315 to dml/dcn31 folder")
Fixes: 3f8951cc123f ("drm/amd/display: move FPU related code from dcn316 to dml/dcn31 folder")
Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
Reviewed-by: Maíra Canal <mairacanal@riseup.net>
Reviewed-by: Melissa Wen <mwen@igalia.com>
---
Changes in v2:
  - remove the extern declaration of "dcn3_15_soc" and "dcn3_16_soc"
  instead of just fixing their type (Melissa and André)
  - apply this fix to "dcn3_1_soc" as well
  - update the commit message accordingly
  - add Fixes and Reviewed-by tags.

 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h   | 1 -
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h | 1 -
 drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h | 1 -
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c    | 6 +++---
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
index 41f8ec99da6b..901436591ed4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
@@ -32,7 +32,6 @@
 	container_of(pool, struct dcn31_resource_pool, base)
 
 extern struct _vcs_dpi_ip_params_st dcn3_1_ip;
-extern struct _vcs_dpi_soc_bounding_box_st dcn3_1_soc;
 
 struct dcn31_resource_pool {
 	struct resource_pool base;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
index 39929fa67a51..22849eaa6f24 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
@@ -32,7 +32,6 @@
 	container_of(pool, struct dcn315_resource_pool, base)
 
 extern struct _vcs_dpi_ip_params_st dcn3_15_ip;
-extern struct _vcs_dpi_ip_params_st dcn3_15_soc;
 
 struct dcn315_resource_pool {
 	struct resource_pool base;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
index 0dc5a6c13ae7..aba6d634131b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
@@ -32,7 +32,6 @@
 	container_of(pool, struct dcn316_resource_pool, base)
 
 extern struct _vcs_dpi_ip_params_st dcn3_16_ip;
-extern struct _vcs_dpi_ip_params_st dcn3_16_soc;
 
 struct dcn316_resource_pool {
 	struct resource_pool base;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index e36cfa5985ea..5664653ba5ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -114,7 +114,7 @@ struct _vcs_dpi_ip_params_st dcn3_1_ip = {
 	.dcc_supported = true,
 };
 
-struct _vcs_dpi_soc_bounding_box_st dcn3_1_soc = {
+static struct _vcs_dpi_soc_bounding_box_st dcn3_1_soc = {
 		/*TODO: correct dispclk/dppclk voltage level determination*/
 	.clock_limits = {
 		{
@@ -259,7 +259,7 @@ struct _vcs_dpi_ip_params_st dcn3_15_ip = {
 	.dcc_supported = true,
 };
 
-struct _vcs_dpi_soc_bounding_box_st dcn3_15_soc = {
+static struct _vcs_dpi_soc_bounding_box_st dcn3_15_soc = {
 	.sr_exit_time_us = 9.0,
 	.sr_enter_plus_exit_time_us = 11.0,
 	.sr_exit_z8_time_us = 50.0,
@@ -355,7 +355,7 @@ struct _vcs_dpi_ip_params_st dcn3_16_ip = {
 	.dcc_supported = true,
 };
 
-struct _vcs_dpi_soc_bounding_box_st dcn3_16_soc = {
+static struct _vcs_dpi_soc_bounding_box_st dcn3_16_soc = {
 		/*TODO: correct dispclk/dppclk voltage level determination*/
 	.clock_limits = {
 		{
-- 
2.37.1

