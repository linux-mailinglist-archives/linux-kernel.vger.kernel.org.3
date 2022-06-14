Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C71854BAA9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiFNTik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbiFNTih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:38:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DC9252BE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:38:36 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so1857681pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6suMNuGHuSDsw0pLQAqfVU17KHFUlWhOVs8BXzvdiJ0=;
        b=CJRRBZCVIYsnpsfarBBshKo0pkqKKszQaCSWy27RJR+7HFDByXfb9KMqryM+oGYhI+
         kraivrZ1V32QRBaiM1Fr5KY7uqQEFXp6Q9zlZZUfhVf6eqtcnemzzc/7OLxuVV+EXnn2
         HsoXo/ySmJGJw1s8uWAhumVopWWsPqjKibo/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6suMNuGHuSDsw0pLQAqfVU17KHFUlWhOVs8BXzvdiJ0=;
        b=WHeUuySlK/SRvjKNXRGkXLZiOWvgTsuJo5bntFURYTTHrr7E1Ht71vz5NPXIWqsPNP
         Ll+3/ESBNQw0tDx51s93TRznXVJZUnzV7kPMrJVQP6VCuHFcKlLryUa9rfXiRsIdvPsg
         D2enqD9FdiWCo/9iTzU+VPHJ1S9oYnXcJ9nWg4Da5mIuYwsUuYZRVMlxvom3gZ+TXIcZ
         0nB7slE+W7+iXZTJJa6FdC9A96n3Pwj6j1HoCoSV4Ks+MQMREGaY+fVPrRoOppuLM5Wk
         jq5lOdXRmMtQEN3/mI7VbTvS/xTHoKFmiVoUQnaaG9AjO+6B5PU9fQW9EhnjxF5vwLLe
         zwBA==
X-Gm-Message-State: AJIora9TUXAk/nwiq0C9jYwhc0/9NHAOyKqpM9wpc05iQRti64itY68F
        Jme6pxMF412XKS2dblPWQbDhDL1AeL0fTw==
X-Google-Smtp-Source: ABdhPJzWQShfjuuRnM5cKGPTLqxKZJI0nl9fyd7df9syqwjta/A2JOAfmod995fY5TCIJSpa7xgtXQ==
X-Received: by 2002:a17:902:ea85:b0:168:c1f7:ea72 with SMTP id x5-20020a170902ea8500b00168c1f7ea72mr5773877plb.86.1655235515470;
        Tue, 14 Jun 2022 12:38:35 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l21-20020a17090a409500b001df3a251cc2sm10014426pjg.4.2022.06.14.12.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:38:35 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
Subject: [PATCH v3 1/7] usb: typec: mux: Allow muxes to specify mode-switch
Date:   Tue, 14 Jun 2022 19:34:35 +0000
Message-Id: <20220614193558.1163205-2-pmalani@chromium.org>
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

Loosen the typec_mux_match() requirements so that searches where an
alt mode is not specified, but the target mux device lists the
"mode-switch" property, return a success.

This is helpful in Type C port drivers which would like to get a pointer
to the mux switch associated with a Type C port, but don't want to
specify a particular alt mode.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

Changes since v2:
- Included Reviewed-by and Tested-by tags from v2.

Changes since v1:
- No changes.

 drivers/usb/typec/mux.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index fd55c2c516a5..464330776cd6 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -281,9 +281,13 @@ static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
 	if (match)
 		goto find_mux;
 
-	/* Accessory Mode muxes */
 	if (!desc) {
-		match = fwnode_property_present(fwnode, "accessory");
+		/*
+		 * Accessory Mode muxes & muxes which explicitly specify
+		 * the required identifier can avoid SVID matching.
+		 */
+		match = fwnode_property_present(fwnode, "accessory") ||
+			fwnode_property_present(fwnode, id);
 		if (match)
 			goto find_mux;
 		return NULL;
-- 
2.36.1.476.g0c4daa206d-goog

