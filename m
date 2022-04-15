Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3BE502D51
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355632AbiDOPu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355285AbiDOPuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:50:23 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4332898F43
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:47:55 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t1so11091847wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eVzMG+zpu3+1hRtFVA+ruZ6wFZcWgleiqmePRHdUybo=;
        b=qZz7Q6sxtsctCU+AZWdIgKNJKHt4F7pgzRWBWcwwkztrzO4hMxC+3y6bM+aQbE2xPm
         ZgDOt/of8dP232h4DWHKBZdrlFl7mr/rHPWLMlTUAIgQShx/CLBs7x04LE2hA4klZfjd
         W3bXY/m5KdcR0T/MgcaxM6ZN3LAMge79NTXnUcoGdGzzo1aJuBQrv7EwuBB0yst9SEeQ
         SqZ5p94yOj0JYqxZpDZUQrI50oNOazZEPOOIs36FyidDLsR1wcEYZqF52fn0aTdqFSru
         f/OHnqPmd3EHYQVhLnCWJUJ+ZdbHsz4kHAKKZict87s4Il+PYOPtJNePZ6nVOBeHy0PA
         d8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eVzMG+zpu3+1hRtFVA+ruZ6wFZcWgleiqmePRHdUybo=;
        b=wTSiT5q2AxApe0ParW98yAeGdD5XM2A2kBWBbQ3A1PSJLOI59KW9v7+Op8pi3pYFcc
         0JEwF0f4QE7qeibEm1razX8p2WGfjcrI8kqSej66bCDaoOSxWl58Vm5N25MFI9MCX66n
         hQ+hluphmV2ScsVGGbJstcSiV/ClyqWG100C5ZWJFWIFq/t54JWBy8B6c6r5iLv/IZi6
         f0MISJN3IqdVNBTSRmPIKS/G432cl8th32+lLE/hYP7SrD3fc16haCPz8TFJQiXFLLQ5
         8yeDltQPj7Ru7TXCYLsYLQFF7dIBBbCIEht++SFTZn+yQx1/JD+D/Lc7xnmj6Kl0XMoz
         ZFyA==
X-Gm-Message-State: AOAM533L21vdI+cp3Eugc0OoBpcXfE95KSmiwD5niZ5+/w6Inmq67Cz4
        yh+Wxq3Qoz2ETVIrEbL/M7U=
X-Google-Smtp-Source: ABdhPJy53CGJvYDdnX2i/uwKm+d/NbMdizBcSF/BiT2v5dFHuYNgxTBoU3cJqgveJRQqMg297/59Kw==
X-Received: by 2002:a5d:5705:0:b0:207:a299:27e2 with SMTP id a5-20020a5d5705000000b00207a29927e2mr5877936wrv.59.1650037673765;
        Fri, 15 Apr 2022 08:47:53 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id a7-20020adffb87000000b00207982c7f4dsm4349655wrr.67.2022.04.15.08.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 08:47:53 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     emma@anholt.net
Cc:     mripard@kernel.org, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, daniel@ffwll.ch, p.zabel@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 1/2] drm/vc4: hdmi: Replace drm_detect_hdmi_monitor() with is_hdmi
Date:   Fri, 15 Apr 2022 17:47:44 +0200
Message-Id: <20220415154745.170597-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415154745.170597-1-jose.exposito89@gmail.com>
References: <20220415154745.170597-1-jose.exposito89@gmail.com>
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

$ sudo trace-cmd record -p function_graph -l "vc4_hdmi_*" -l "drm_*"

vc4_hdmi_connector_detect:

    vc4_hdmi_connector_detect() {
      drm_get_edid() {
        drm_connector_update_edid_property() {
          drm_add_display_info() {
            drm_reset_display_info();
            drm_for_each_detailed_block.part.0();
            drm_parse_cea_ext() {
              drm_find_cea_extension();
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

