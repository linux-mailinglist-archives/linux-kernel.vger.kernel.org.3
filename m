Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFB35803EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbiGYSS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbiGYSSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:18:52 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B328A1EEE4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 11:18:51 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id j70so14480989oih.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 11:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQraKRTwranfua7QFRgcXvvnBZubuSnmpInT6C6BiTs=;
        b=lJBLleC/MSm8LzkLYV2TFqVj17DZr991BpjRXmIa+izgTEjUAp9YOpnt3Xf8+xdAlr
         XNcmnXcHLilfFftYcQgQkSNs5Vffc3jg3GIhKZ6HmBn3Fp/BgmVbLjAR+L5t5aLUTkpr
         /+yQ5p5RvLFyU2/kdDN0dSwX4ER5xLhe3FWE4udNphySk0kHUIWEasTQroA0W4vo6ubD
         GlZXK1wHXUtZ/EWBlqvc/uLyh8nIyesv3SxWBIFsVO5Iil0qraDmXBBZQVYPMGz7sszY
         cszVwDEoyjr78VBEWrkwMjAQkLtBhMO55ERJfsy3Tuy579+s72tyJ8Dtd/9RYlSslq1q
         kVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQraKRTwranfua7QFRgcXvvnBZubuSnmpInT6C6BiTs=;
        b=vsHgLwZSw66bV05ifa0VT4XZ95wROKVgkeOmxT8R4oqQS2cgolHj0X2eMLt3eUAy/A
         fJZDrOv0deXHCWhTggVxU8fGlPu2W76lfoOL+ibQ3x6k8aAr6lCWgUy+ivkmThUBxaoE
         XqODi1xQbDz4kQYALnKn2RDwT0YswEmHbbLyMG1LnkOR8ZZ+MaG4d8AUKPuuxnE2BQbw
         IjR5W1B/46bBBH2VreuaLiezjBPynrKbVtE8SFrggkE7mHGDMdv/k8mVCrrRZu+Zx8A6
         HA8Hwku+KW7U3zo2MT6Ymv0e+zm6kBacLdrn804Tt0xqjub+uhrpm/QFy62FOmfesl6n
         Opjg==
X-Gm-Message-State: AJIora+1hDMnSIfcqZfwX0RpHBlFfI4rh9C2NyjEmWEBZ0VJeX6maC8g
        4zpOmo/1xvDaxLrCz7CEcrQ=
X-Google-Smtp-Source: AGRyM1t/JIwxEKJ3eL15RARypEuL6HM72lc2k52SQPSuMWI1RceloJpl+n7nsnxiriqT2oDP/wMpqQ==
X-Received: by 2002:a05:6808:1a0b:b0:33a:72c6:c96e with SMTP id bk11-20020a0568081a0b00b0033a72c6c96emr13157252oib.176.1658773130913;
        Mon, 25 Jul 2022 11:18:50 -0700 (PDT)
Received: from fedora.. ([2804:14c:bbe3:4370:95da:f07f:e927:6958])
        by smtp.gmail.com with ESMTPSA id m42-20020a056870562a00b0010db1a8d931sm5358484oao.28.2022.07.25.11.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 11:18:50 -0700 (PDT)
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
Subject: [PATCH 1/2] drm/amd/display: change variables type
Date:   Mon, 25 Jul 2022 15:15:58 -0300
Message-Id: <20220725181559.250030-1-magalilemes00@gmail.com>
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

As "dcn3_15_soc" and "dcn3_16_soc" are of type "struct
_vcs_dpi_soc_bounding_box_st", change their types accordingly.

Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
index 39929fa67a51..45276317c057 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
@@ -32,7 +32,7 @@
 	container_of(pool, struct dcn315_resource_pool, base)
 
 extern struct _vcs_dpi_ip_params_st dcn3_15_ip;
-extern struct _vcs_dpi_ip_params_st dcn3_15_soc;
+extern struct _vcs_dpi_soc_bounding_box_st dcn3_15_soc;
 
 struct dcn315_resource_pool {
 	struct resource_pool base;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
index 0dc5a6c13ae7..d2234aac5449 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
@@ -32,7 +32,7 @@
 	container_of(pool, struct dcn316_resource_pool, base)
 
 extern struct _vcs_dpi_ip_params_st dcn3_16_ip;
-extern struct _vcs_dpi_ip_params_st dcn3_16_soc;
+extern struct _vcs_dpi_soc_bounding_box_st dcn3_16_soc;
 
 struct dcn316_resource_pool {
 	struct resource_pool base;
-- 
2.37.1

