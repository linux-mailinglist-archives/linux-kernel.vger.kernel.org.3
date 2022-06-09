Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AF15453E2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344119AbiFISPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242704AbiFISPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:15:12 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F234EA5A8F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:15:10 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id r1so3628248plo.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 11:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IdvgLXoLjev9GttM62EnYpKkz6LMe+X1VjPPPf04Vxw=;
        b=aFTtmBkmw+81PJHigGOzSJ9dxv6Y0l82wBq2QqDYzMnyv2bWhO+CrXtdyt4rP7cKXL
         AqCwxOfduRVJ7NcQgfN130U3Op7vInZ8ZeU23poXFYbm6ttLE+Lu5KfQ3rpF4P2DdiKs
         5aLOZbTt35XDan6HUVt+O0GTCFrGVsv92oq2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IdvgLXoLjev9GttM62EnYpKkz6LMe+X1VjPPPf04Vxw=;
        b=uyoemPk1lxLSrQTTMcpBpjHBM0uQXmRhDOCl5n+DKw7GfUn+3SXqp0liz3OqiiOPy0
         eEvy36iFZ0FGRvI/JuUT09/AUB6Ipe2VG8Ixh4QO9QmLaoM83B/PA89eWN1LF2Qx6Jc4
         FU98/vE+qIvQEREpqizYOJruCo3FhCKdvT7ziREhtVrCGAJO1HRoe+nq0qiSeSyzoGBI
         zfL5bUKf9kE5oXKD6DeuSUUd2UdMpZuxrKk6zSIgCFTrwZ2B/+Vjx5bJi/zjZrqefKNS
         NOiuffsa5FbC+BTeYMwdPnLUNMU9Z/dptSqRRB26qgHGoRo9Y4ox73JP7b+x4uVDcwx5
         LFrg==
X-Gm-Message-State: AOAM5322dHa8K8R5zN9/KbD6mplHk/aoALElNGS409Kk+WHHh5B68+mW
        AFasvZkYVdg8CIBUNx9QWqeanAnisBxWrQ==
X-Google-Smtp-Source: ABdhPJyyxKehQjOB+Zv3pFD43mnT309OZvZX/yFQjg61a5xqnEbUihmeZDKxY5G0TJCdWiVeDy0Spw==
X-Received: by 2002:a17:902:b692:b0:14c:935b:2b03 with SMTP id c18-20020a170902b69200b0014c935b2b03mr40668224pls.81.1654798510324;
        Thu, 09 Jun 2022 11:15:10 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id r14-20020a63ec4e000000b003fb0354c43asm17728049pgj.32.2022.06.09.11.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 11:15:10 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>
Subject: [PATCH v2 2/7] usb: typec: mux: Add CONFIG guards for functions
Date:   Thu,  9 Jun 2022 18:09:41 +0000
Message-Id: <20220609181106.3695103-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220609181106.3695103-1-pmalani@chromium.org>
References: <20220609181106.3695103-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some drivers that can use the Type C mux API, but don't have
to. Introduce CONFIG guards for the mux functions so that drivers can
include the header file and not run into compilation errors on systems
which don't have CONFIG_TYPEC enabled. When CONFIG_TYPEC is not enabled,
the Type C mux functions will be stub versions of the original calls.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes since v1:
- Added static inline to stub functions.
- Updated function signature of stub functions from "struct typec_mux"
  to "struct typec_mux_dev" in accordance with updates from commit
  713fd49b430c ("usb: typec: mux: Introduce indirection")

 include/linux/usb/typec_mux.h | 38 +++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
index ee57781dcf28..9eda6146fd26 100644
--- a/include/linux/usb/typec_mux.h
+++ b/include/linux/usb/typec_mux.h
@@ -58,6 +58,8 @@ struct typec_mux_desc {
 	void *drvdata;
 };
 
+#if IS_ENABLED(CONFIG_TYPEC) || IS_MODULE(CONFIG_TYPEC)
+
 struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode,
 				       const struct typec_altmode_desc *desc);
 void typec_mux_put(struct typec_mux *mux);
@@ -76,4 +78,40 @@ void typec_mux_unregister(struct typec_mux_dev *mux);
 void typec_mux_set_drvdata(struct typec_mux_dev *mux, void *data);
 void *typec_mux_get_drvdata(struct typec_mux_dev *mux);
 
+#else
+
+static inline struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode,
+				       const struct typec_altmode_desc *desc)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline void typec_mux_put(struct typec_mux *mux) {}
+
+static inline int typec_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline struct typec_mux *
+typec_mux_get(struct device *dev, const struct typec_altmode_desc *desc)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline struct typec_mux_dev *
+typec_mux_register(struct device *parent, const struct typec_mux_desc *desc)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline void typec_mux_unregister(struct typec_mux_dev *mux) {}
+
+static inline void typec_mux_set_drvdata(struct typec_mux_dev *mux, void *data) {}
+static inline void *typec_mux_get_drvdata(struct typec_mux_dev *mux)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+#endif /* CONFIG_TYPEC */
+
 #endif /* __USB_TYPEC_MUX */
-- 
2.36.1.476.g0c4daa206d-goog

