Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EFC5223F6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 20:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbiEJS23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348882AbiEJS2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:28:21 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B2C33896
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:28:20 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id hh4so14179300qtb.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/xXStdS/6Ecb3QM+NfwKwg0qrP8dEo54D+TLTJCNtQU=;
        b=oSTgF171IFOwfEXynDmFNdUOlkACxoWv+6GMKX9CSWUKgxxAGgiWWEImQB8LktpivY
         AmRbQ3VoyHMAJoumcQJa4GQGnWzoatgBvdWKP2i9auMTZcYOQ9BIcBZzxGgjr1Rn/3OK
         LdyM+NOco9xY7Ydsenb8gtmkmwLPh9ySNRY94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/xXStdS/6Ecb3QM+NfwKwg0qrP8dEo54D+TLTJCNtQU=;
        b=Pp2xwRoHErLSIYXtK+tYBqWZ1IP10LvWCFVUS4k8pGlozptOpsxzZg0GL1t+Pmjqsg
         fm97Y2/78hO1vf6dZaz/yvSx0sGjjkhxcL9d7B8QL3AERV2llr7hcEPfTHDAehAlAjqv
         YYfp3Zkc5HobLGmGVH+6qR3jcUkvunOpD+T5kT1h75DsY0HjHvRCxisaVGh5FRFmu4OE
         Z3kx3QXmEUTPuKpDXe5erQg9KfGEo4m8vhAZ1r+A8vcI257n9al2Pf6WFH6kDAHALgCU
         8lsktXQ56caH6BZjIg6+MiDI4Ccz0CvN9uiHtJpHr5mXgSL3cVMtkDN0Y5zFAHwCUlwq
         zKuA==
X-Gm-Message-State: AOAM530Q5howPtkSwH/c0pJqpL5z5vcO+jvz9VohEahN3fGjveUsJ7ck
        y7BxyhNywhzj+s+/8hhHz+OZPQ==
X-Google-Smtp-Source: ABdhPJwh5JavPhYpKz08mTjksCjblRKzyYKZLVzoqxjqLQzYJy+qhKbbe4mJH+/vvFqtue9Asub9yQ==
X-Received: by 2002:a05:622a:50e:b0:2f3:9a86:6e3 with SMTP id l14-20020a05622a050e00b002f39a8606e3mr21035101qtx.374.1652207299802;
        Tue, 10 May 2022 11:28:19 -0700 (PDT)
Received: from markyacoub.nyc.corp.google.com ([2620:0:1003:314:141d:f589:29f6:2a25])
        by smtp.gmail.com with ESMTPSA id g25-20020a05620a109900b0069fc13ce1e3sm8815496qkk.20.2022.05.10.11.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:28:19 -0700 (PDT)
From:   Mark Yacoub <markyacoub@chromium.org>
Cc:     seanpaul@chromium.org, markyacoub@google.com,
        markyacoub@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: Add a debug message when getting a prop is missing
Date:   Tue, 10 May 2022 14:28:03 -0400
Message-Id: <20220510182810.1223574-1-markyacoub@chromium.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Why]
If a connector property is attached but
drm_atomic_connector_get_property doesn't handle a case for it,
modeteset will crash with a segfault without.

[How]
Add a debug message indicating that a connector property is not handled
when user space is trying to read it.

TEST=modetest

Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index acb1ee93d206..36b0f664dd80 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -884,6 +884,12 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		return connector->funcs->atomic_get_property(connector,
 				state, property, val);
 	} else {
+		// LOG that the kernel is missing handling this property as a case here.
+		drm_dbg_atomic(
+			dev,
+			"[CONNECTOR:%d:%s] Get Property [PROP:%d:%s] is not handled\n",
+			connector->base.id, connector->name, property->base.id,
+			property->name);
 		return -EINVAL;
 	}
 
-- 
2.36.0.512.ge40c2bad7a-goog

