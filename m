Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA24D54BAAD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243033AbiFNTkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbiFNTkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:40:02 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41514275E8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:40:01 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id e11so9456346pfj.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X4y09CKhEKSaAIT/j96bs/qEeHv9usgEjzmQybc1t0A=;
        b=CtlXGh7aAuuavGs8UilVy+VnypIwaHyMERCE9mfQ1Fz7il/9JQIR0SPkAP4hwFL5Hs
         J1PBuztOxKvrn96WWxvUtSLLgzGBgW0O/eBxDI8hApvB3OFqKs6tu6NkWNyEBm01bEJ6
         vTvpfF/WlT+TQTbOinp9WKfXfAN2cjuRM4Gvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X4y09CKhEKSaAIT/j96bs/qEeHv9usgEjzmQybc1t0A=;
        b=xEPdAnolVjMqtaiuNjffVT9tB5FT5HEWja7lRDYv9aETQ66UT3rcQ+z3dWaFtQC7Mz
         dAEOVDavYdy40vo7D1O+GsbOud5ndQ+8m04eiKvvFkr2lRz8Hr/yILsUCkw2b3tlm4mL
         ayMlEDFdvlPuJ9f+r0PUJLX9U0EWwdQlGidvPGte+ZzB6lw2ZRaZGmlTCou7VDY+Zk3m
         Ebk3pSjfXk0nS4dDSnUMzs+O6QYssO5rMfqXp/p0QxL1ckYntuO09n0cPtrRG3LF2qFq
         vKKWaflkM7hV38W5coljKFkBAYPy6N9DY4CGZyEKiFeLSw2t83LxfGg1WQRumbex7Gov
         TKrw==
X-Gm-Message-State: AOAM5303TPjMdAtu28sAAl8ww5brAsVhN702bUPYAdG5FSICFHGyIrI0
        SZ3N1fqk9T53K/BS7vW1uTtyvHNhHL9JuA==
X-Google-Smtp-Source: ABdhPJzdtJZrWEATlgJ1gB9krYfHIvQVtDgAhv2CpgRMXIVNfK1xIMMGtDzKVDhTGWvEy8euHjofEA==
X-Received: by 2002:a63:8b4b:0:b0:3fc:ea73:db40 with SMTP id j72-20020a638b4b000000b003fcea73db40mr5698179pge.399.1655235600547;
        Tue, 14 Jun 2022 12:40:00 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l21-20020a17090a409500b001df3a251cc2sm10014426pjg.4.2022.06.14.12.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:39:59 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        kernel test robot <lkp@intel.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
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
        Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
Subject: [PATCH v3 2/7] usb: typec: mux: Add CONFIG guards for functions
Date:   Tue, 14 Jun 2022 19:34:36 +0000
Message-Id: <20220614193558.1163205-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220614193558.1163205-1-pmalani@chromium.org>
References: <20220614193558.1163205-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes since v2:
- Fix up return types for some of the stubs. Remove 1 unnecessary stub
  in the else condition.
- Remove unnecessary IS_MODULE config guard.
- Added Reviewed-by and Tested-by tags.

Changes since v1:
- Added static inline to stub functions.
- Updated function signature of stub functions from "struct typec_mux"
  to "struct typec_mux_dev" in accordance with updates from commit
  713fd49b430c ("usb: typec: mux: Introduce indirection")

 include/linux/usb/typec_mux.h | 44 ++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
index ee57781dcf28..9292f0e07846 100644
--- a/include/linux/usb/typec_mux.h
+++ b/include/linux/usb/typec_mux.h
@@ -58,17 +58,13 @@ struct typec_mux_desc {
 	void *drvdata;
 };
 
+#if IS_ENABLED(CONFIG_TYPEC)
+
 struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode,
 				       const struct typec_altmode_desc *desc);
 void typec_mux_put(struct typec_mux *mux);
 int typec_mux_set(struct typec_mux *mux, struct typec_mux_state *state);
 
-static inline struct typec_mux *
-typec_mux_get(struct device *dev, const struct typec_altmode_desc *desc)
-{
-	return fwnode_typec_mux_get(dev_fwnode(dev), desc);
-}
-
 struct typec_mux_dev *
 typec_mux_register(struct device *parent, const struct typec_mux_desc *desc);
 void typec_mux_unregister(struct typec_mux_dev *mux);
@@ -76,4 +72,40 @@ void typec_mux_unregister(struct typec_mux_dev *mux);
 void typec_mux_set_drvdata(struct typec_mux_dev *mux, void *data);
 void *typec_mux_get_drvdata(struct typec_mux_dev *mux);
 
+#else
+
+static inline struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode,
+				       const struct typec_altmode_desc *desc)
+{
+	return NULL;
+}
+
+static inline void typec_mux_put(struct typec_mux *mux) {}
+
+static inline int typec_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
+{
+	return 0;
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
+static inline struct typec_mux *
+typec_mux_get(struct device *dev, const struct typec_altmode_desc *desc)
+{
+	return fwnode_typec_mux_get(dev_fwnode(dev), desc);
+}
+
 #endif /* __USB_TYPEC_MUX */
-- 
2.36.1.476.g0c4daa206d-goog

