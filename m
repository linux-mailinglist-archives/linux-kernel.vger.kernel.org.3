Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F0F5453DA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345313AbiFISNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345307AbiFISNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:13:33 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DAB3B1E82
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:13:31 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s135so6928352pgs.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 11:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2e9qvlBS9PXaO5KE3mr93HDyloUdR6RQhfh7PY4trpc=;
        b=bVTK7bj9dfeUzdpypMRl3axVPchhhLdpkvoCdpiGZmX4x1R1qqXlxgDgwFMD9kS/mc
         bUkGyKfPmCn7w7ROYEY+7xXoqyYi3jHBCgpGPVfTp7Hv5R5fXbX0V+bBKuL4gu8esPsi
         oF4RVO8/CzhB8skKeL4HWnvxHG9r7jUfP6/Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2e9qvlBS9PXaO5KE3mr93HDyloUdR6RQhfh7PY4trpc=;
        b=y8BzFO7NHyTEDicY6RB1/4j4iuuYS9VHcRncrgFSqYrhRKrqqaR4TX0AzmGllDyVPW
         366Ldf8emPZNMmUl3JBIwBCzIgPxGU7522YEnZ5MpOBUIGZ1caQfWpZOKsjfYQNb4g+L
         fRB8evWhwJP0KnXx5hooiZbU6HV15aEqetwsgdI1gyebG2F7zE1UMS5JfZHJiXkDhRAI
         hP0sMoISu48No+jOk6+QhIuJkZwsI8u6iXpMVJei9/9uDhECgy3CLssGk8qJJG0wjyuI
         6fu7mF0MksbwlRxaF3byMTGBlL2IqhiX7hLBsoPBhTI8WgBdH2Iqdq/Xj0CxPc/3lqLB
         kPCQ==
X-Gm-Message-State: AOAM532UFsdBC0RLs/ijnfzFXFtAKZxuMUf+BPqh94Kqu1bH7/VdXAzC
        QXYA9x9KCadwROMxmm9VP5+S16PF61sgEg==
X-Google-Smtp-Source: ABdhPJxtb6tPpdUzJnjTltj9Coiem1A+RGPdXWPqKUhy8JD+8XnMOcg0fFOe5P80fHg5Fk+die1qiw==
X-Received: by 2002:a63:b57:0:b0:3fb:a948:6d96 with SMTP id a23-20020a630b57000000b003fba9486d96mr35379670pgl.596.1654798410404;
        Thu, 09 Jun 2022 11:13:30 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id r14-20020a63ec4e000000b003fb0354c43asm17728049pgj.32.2022.06.09.11.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 11:13:30 -0700 (PDT)
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
        Xin Ji <xji@analogixsemi.com>
Subject: [PATCH v2 1/7] usb: typec: mux: Allow muxes to specify mode-switch
Date:   Thu,  9 Jun 2022 18:09:40 +0000
Message-Id: <20220609181106.3695103-2-pmalani@chromium.org>
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

Loosen the typec_mux_match() requirements so that searches where an
alt mode is not specified, but the target mux device lists the
"mode-switch" property, return a success.

This is helpful in Type C port drivers which would like to get a pointer
to the mux switch associated with a Type C port, but don't want to
specify a particular alt mode.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

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

