Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B028550936A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354986AbiDTXNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383099AbiDTXNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:13:14 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A19111A08
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:10:27 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-e5e8523fcbso3622753fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TRei6a1qHKhnvQ3GEDyy4E1WwK9zRMbycKgIfFir6MI=;
        b=aicu3OOVauGYbi8Leet6cjCpJNEgBJymsZ53QG5imPcqz+s0HavG6bOHqFTs66yXIv
         LrBNrePj1v5MHkeJVRGkNxlEl4w8DZeajSPgP4ajg2fo0tpcYidi6/McS2LDw9BkQUZS
         r2a/rcaqJ5rb8AH4YWOmMMNcZ9dZ/NrIz/2dLjfJAOAhMPDZiZEkIzZfD/ELmXSU12W5
         w3BhYqm0iLRcUZ3zYV6DJgIPvHxd0IAK+TkTwur23IHBuYYHbOErXj+E8w/RhFeP6ibL
         kjTYwtJXxLTUoJb0vT2X+frl2s81XACMBnaR4bw4+tn8zgLS5xDLAUqoQ6X9QHutROOZ
         0GUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TRei6a1qHKhnvQ3GEDyy4E1WwK9zRMbycKgIfFir6MI=;
        b=bTmnoBHlDTWf9iOWpdkgAFLpmnb6NCXlnrXIMwUuzX2utbrfMRJEDWhBa+1ZjWwz1l
         s5R+MqigiB7q+8JCpM1owd5R581Dm+p+ZYGcp2eNkw4w6ZiPcehnaG/OAKXzTqjZCBTb
         h4A0vl55FsRGo3030rlbYFdZtCOHHvCdBfPVL2hxJce+n6dFitUJK6DEYcirEj4GIi05
         FRnzFABZcxHua3Yoo0IwZyvJPKOYYaD61kOzFCipeFwp09uCWFRmjzekMDDe3O1j9cho
         95jagY3dP2v09txomS1kV4dEY12Q6pSzPnvYpAd/KiKqQaOBc+Qb4oHX6QbmKMTUYhqH
         qRdA==
X-Gm-Message-State: AOAM533hQGEGpZ1e9jUqfiGC6aPljda797s8r7nvaPOJjKqLOgN3qkg3
        vjURTOV11G3Uh6wjeXNzpyaNTw==
X-Google-Smtp-Source: ABdhPJwFhn3WUPESS5w8sSu50szxQr6qmD32XDF7sWlOuuj5eugzUOUVYzym5mk0Jr/OIAp4Jq2Jiw==
X-Received: by 2002:a05:6871:1d0:b0:da:b3f:2b28 with SMTP id q16-20020a05687101d000b000da0b3f2b28mr2674159oad.199.1650496226847;
        Wed, 20 Apr 2022 16:10:26 -0700 (PDT)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id a17-20020a4ae931000000b0032933be7230sm7424481ooe.4.2022.04.20.16.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 16:10:26 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Revert "drm: of: Lookup if child node has panel or bridge"
Date:   Wed, 20 Apr 2022 16:12:30 -0700
Message-Id: <20220420231230.58499-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420231230.58499-1-bjorn.andersson@linaro.org>
References: <20220420231230.58499-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit '80253168dbfd ("drm: of: Lookup if child node has panel or
bridge")' attempted to simplify the case of expressing a simple panel
under a DSI controller, by assuming that the first non-graph child node
was a panel or bridge.

Unfortunately for non-trivial cases the first child node might not be a
panel or bridge.  Examples of this can be a aux-bus in the case of
DisplayPort, or an opp-table represented before the panel node.

In these cases the reverted commit prevents the caller from ever finding
a reference to the panel.

This reverts commit '80253168dbfd ("drm: of: Lookup if child node has
panel or bridge")', in favor of using an explicit graph reference to the
panel in the trivial case as well.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/drm_of.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 026e4e29a0f3..9a2cfab3a177 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -244,21 +244,6 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 	if (panel)
 		*panel = NULL;
 
-	/**
-	 * Devices can also be child nodes when we also control that device
-	 * through the upstream device (ie, MIPI-DCS for a MIPI-DSI device).
-	 *
-	 * Lookup for a child node of the given parent that isn't either port
-	 * or ports.
-	 */
-	for_each_available_child_of_node(np, remote) {
-		if (of_node_name_eq(remote, "port") ||
-		    of_node_name_eq(remote, "ports"))
-			continue;
-
-		goto of_find_panel_or_bridge;
-	}
-
 	/*
 	 * of_graph_get_remote_node() produces a noisy error message if port
 	 * node isn't found and the absence of the port is a legit case here,
@@ -269,8 +254,6 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 		return -ENODEV;
 
 	remote = of_graph_get_remote_node(np, port, endpoint);
-
-of_find_panel_or_bridge:
 	if (!remote)
 		return -ENODEV;
 
-- 
2.35.1

