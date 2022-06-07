Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D07541FA4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 02:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386013AbiFGWrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 18:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380750AbiFGVif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:38:35 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9713FC047E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:05:33 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 187so16302273pfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 12:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zrwToAbRm/8o4mYKXHsvwuZsdzi56cDWjWGCsMFQCq4=;
        b=IJmEKjbu0NsIQ2TIKKHgQBPdu95rE+fxg/uNfUr8lhMeiyM3S3ZNsC45sqxk/R9FaT
         /r8eY4OIvLSDUSY2xX5aGB0rM79qaZ0k5s1ANX+OWkeNYD2rYOnI8ALWyLGqAVuXsJB6
         i/HNUOWDOs5Bk+bD/8AV47NIeWcKF4/IUypi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zrwToAbRm/8o4mYKXHsvwuZsdzi56cDWjWGCsMFQCq4=;
        b=77E3pC4FdmQZYF2FLNULXeBhxlIZu4vBLiiROm8NVageP1DJ6G/pTDKqCvKIVZ4VQV
         RUDZQa5XI88nWHFoUJn+POsF4WH5VQO6110kZeYoM9zDHtXmxTlgAhr20JkzN6Qo0lrM
         TbgL3tDHlc6k75m11bU4Kdzpo3oGD/k6C6Lq/hXCz+OlFZ1wMVL6aqYl08Bz9+EIFEdO
         OHfW0A0/38IXlPdWYcjpkkcIBj9ZvyPgM/7jemHAgM2b5vFAaw6JPZN9Jn0ErDxwPblC
         L1U9PAupPBZEnKepYmzYpcDS6x/qQCVjrL3P3IQYlOveUTNe016aZy4shVa+2+B8Pyg9
         5kNw==
X-Gm-Message-State: AOAM531iM305ykfAYoi9XhZ1qFv3mxS6PnUE0qxkLV2tJC0GLRbYFcR0
        84ZyrNCjJ99Lc1zVbksQcd5KLL+AstbxDw==
X-Google-Smtp-Source: ABdhPJyUhy7+cJfaDKfU+dlJllV7FTT99DCfwfNrat7f5aIWF9lfM1q5wj8dxgFa13yBRD3PkrsPDQ==
X-Received: by 2002:a63:8841:0:b0:3fc:704c:24ff with SMTP id l62-20020a638841000000b003fc704c24ffmr26783832pgd.116.1654628732819;
        Tue, 07 Jun 2022 12:05:32 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g29-20020aa79ddd000000b0050dc762819esm13236084pfq.120.2022.06.07.12.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 12:05:32 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
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
Subject: [PATCH 2/7] usb: typec: mux: Add CONFIG guards for functions
Date:   Tue,  7 Jun 2022 19:00:20 +0000
Message-Id: <20220607190131.1647511-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220607190131.1647511-1-pmalani@chromium.org>
References: <20220607190131.1647511-1-pmalani@chromium.org>
MIME-Version: 1.0
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

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 include/linux/usb/typec_mux.h | 38 +++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
index ee57781dcf28..758d34ced1f8 100644
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
+struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode,
+				       const struct typec_altmode_desc *desc)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+void typec_mux_put(struct typec_mux *mux) {}
+
+int typec_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
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
+struct typec_mux *
+typec_mux_register(struct device *parent, const struct typec_mux_desc *desc)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+void typec_mux_unregister(struct typec_mux *mux) {}
+
+void typec_mux_set_drvdata(struct typec_mux *mux, void *data) {}
+void *typec_mux_get_drvdata(struct typec_mux *mux)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+#endif /* CONFIG_TYPEC */
+
 #endif /* __USB_TYPEC_MUX */
-- 
2.36.1.255.ge46751e96f-goog

