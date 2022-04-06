Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089A64F6937
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 20:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbiDFSTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 14:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240809AbiDFSRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 14:17:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B334DB2EC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 09:55:31 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k23so4143604wrd.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Brc5sUVC73xpzNVMY8eIEmfdgN51pWWRYrH2qSgq75o=;
        b=nT9FCG1nc9hgRjXNNEpzWPUpQ5PojjQAMUumt/NiFssL0aqZRp/qouxeaDAXsBdAjm
         wK0dL/+Z8a9V4Puu02rv2z0du9c1gtbLgKuhXN68KFvnfqs5qOZmOJBD++mWiRRvOv7D
         LCZ+tPcEitRE8DSB77Ko1vPjl9VahjMnfmwoEqmxhVkzdAbZ76Esu+FPHJfFijdNX/Rp
         2r2LWIl7Z4qZK8f1AZ5PSAqy8vgxwsAMlHjxz/7jKOdZDvsdvG7E2VjHmdMBgc1Gz0MV
         ezE4GkIxyDl1x2Ty7rbohCgUqRZmHg7XndH7hqHdH1+F62idcmQypsSeaZlDeHFQfPRG
         PA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Brc5sUVC73xpzNVMY8eIEmfdgN51pWWRYrH2qSgq75o=;
        b=VHYnxoFUFQU4ekn0kcy3L3jEeevT5Rc4IpcdZiUWBV94aNQxlPHvfq7ZdEoWULoHkW
         SqWDiLIOoEj/oUQ8J4JO13EYA+az1vrPS8egZk29VRFN9BXdT8yKG1jI0uRaJsRfW3LI
         2MKgL7PoQzeKSJbWDunUhzIsZMTM8yiYbNNtSVwIlawMmOMtaG5H/XbyshAep4CmdWmY
         oQARRuGKOGzmaa+F+ZQbcHf6QwaMKUvwY5LA9cWi5sjFn254vpYrEKT9CnxSZE6aIwIv
         RaVx6L0cE2CYYnFBuJIR0hBQNpG03Hj/uso+YzeBNCQl+ZJi4OpvdHZhxXE3O4H5FJzy
         BGcQ==
X-Gm-Message-State: AOAM533QURFWVwIpzkt91kq4fg1455SDKvM0Jt/y/5FcuiZPzymanKXq
        8GEm7lTCGuRWAhnXYUN9JUU=
X-Google-Smtp-Source: ABdhPJyPO9myg44y/8FXgf9FElA/EI9EQTODsY0bVDuMEU4VBW5owNAPHxuejsQgef0qBC7QlPorHg==
X-Received: by 2002:adf:e104:0:b0:206:109a:c90f with SMTP id t4-20020adfe104000000b00206109ac90fmr7374435wrz.259.1649264129576;
        Wed, 06 Apr 2022 09:55:29 -0700 (PDT)
Received: from localhost.localdomain ([217.113.241.148])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038c9249ffdesm5694484wmq.9.2022.04.06.09.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 09:55:29 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     emma@anholt.net
Cc:     mripard@kernel.org, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, daniel@ffwll.ch, p.zabel@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 1/1] drm/vc4: hdmi: Replace drm_detect_hdmi_monitor() with is_hdmi
Date:   Wed,  6 Apr 2022 18:55:14 +0200
Message-Id: <20220406165514.6106-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220406165514.6106-1-jose.exposito89@gmail.com>
References: <20220406165514.6106-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Once EDID is parsed, the monitor HDMI support information is cached in
drm_display_info.is_hdmi by drm_parse_hdmi_vsdb_video().

This driver calls drm_detect_hdmi_monitor() to receive the same
information and stores its own cached value, which is less efficient.

Avoid calling drm_detect_hdmi_monitor() and use drm_display_info.is_hdmi
instead.

drm_detect_hdmi_monitor() is called in vc4_hdmi_connector_detect() and
vc4_hdmi_connector_get_modes(). In both cases it is safe to rely on
drm_display_info.is_hdmi as shown by ftrace:

vc4_hdmi_connector_detect:

    vc4_hdmi_connector_detect() {
      drm_get_edid() {
        drm_connector_update_edid_property() {
          drm_add_display_info() {
            drm_reset_display_info();
            drm_for_each_detailed_block.part.0();
            drm_parse_cea_ext() {
              drm_find_cea_extension();
              cea_db_offsets.part.0();
              cea_db_is_hdmi_vsdb.part.0();
              drm_parse_hdmi_vsdb_video();
              /* drm_display_info.is_hdmi is cached here */
            }
          }
        }
      }
      /* drm_display_info.is_hdmi is used here */
    }

vc4_hdmi_connector_get_modes:

    vc4_hdmi_connector_get_modes() {
      drm_get_edid() {
        drm_connector_update_edid_property() {
          drm_add_display_info() {
            drm_reset_display_info();
            drm_for_each_detailed_block.part.0();
            drm_parse_cea_ext() {
              drm_find_cea_extension();
              cea_db_offsets.part.0();
              cea_db_is_hdmi_vsdb.part.0();
              drm_parse_hdmi_vsdb_video();
              /* drm_display_info.is_hdmi is cached here */
            }
          }
        }
      }
      /* drm_display_info.is_hdmi is used here */
      drm_connector_update_edid_property();
    }

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 6c58b0fd13fb..ecdb1ffc2023 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -216,7 +216,7 @@ vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
 
 			if (edid) {
 				cec_s_phys_addr_from_edid(vc4_hdmi->cec_adap, edid);
-				vc4_hdmi->encoder.hdmi_monitor = drm_detect_hdmi_monitor(edid);
+				vc4_hdmi->encoder.hdmi_monitor = connector->display_info.is_hdmi;
 				kfree(edid);
 			}
 		}
@@ -255,7 +255,7 @@ static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
 		goto out;
 	}
 
-	vc4_encoder->hdmi_monitor = drm_detect_hdmi_monitor(edid);
+	vc4_encoder->hdmi_monitor = connector->display_info.is_hdmi;
 
 	drm_connector_update_edid_property(connector, edid);
 	ret = drm_add_edid_modes(connector, edid);
-- 
2.25.1

