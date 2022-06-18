Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2188655014D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 02:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383601AbiFRA1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 20:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237031AbiFRA1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 20:27:04 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711F43B013
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:27:02 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id w29so5303023pgl.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ei+HgXYmUs7VuH9SzfrkiDUXFHl2YpLCKGNXmwvOLnE=;
        b=EWsGb7fKekXlYZrIKe4UPS69h8iiPXw/cnxRSMzwwldkX4FkEyUTUcvp7P5lfRPTNr
         nDid7kyrMvZ3zddxkFLYpG7B7vsJROo7d73nGflocZyFwJBJpNdDBJJJSb5bAziRza3z
         gcLjjTlxLWgJJ0+mlS6JJqIGvGEOQytfZm0PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ei+HgXYmUs7VuH9SzfrkiDUXFHl2YpLCKGNXmwvOLnE=;
        b=Ev01vY2hr5C2o6XtRHOibTGljc3DwQR+w5Cs0DW43Ugda7fHvJQrklNujW4SG2l3Gw
         16JvV95Hb3KCRHj9N1wUAm9bG2Nqc/JFjHId1KfH5pNkegIu1xqraaFb2p0VHaKSNg9A
         oDk3s2PYxDcKDndRf8CW7b+T2niwEqLUBu54wk1BFihtwk+RkUTchVMtiPDg5Q90ib9R
         v1TwHnI7FQGaRd+wZfG7PU+feIPf7SfUeaC51a7UXEigsgzVgM0UvwiCaKKW/3L6GTnt
         ENBv6CkE1KtoW+USBzfGTnpOgq3cIhlYyf5GuTUdIfnd0Jr6xbwKIbt99sys+XDbswt8
         Ye3A==
X-Gm-Message-State: AJIora+s5gDcNN7kTGEPS+F8WOtAJeMX0GAVQj/Ty/hZipEvWPiI9bwo
        n5Y/4ptorgS+O7SG2eTTbkcf2SM8eg6eFA==
X-Google-Smtp-Source: AGRyM1v/jglTlJSjuanGgPXZVW8dGNByT2BJv5Y9gHNgbkzDuTqe//AQccZr4N7r9rUR1So2ivva1A==
X-Received: by 2002:a63:360b:0:b0:40c:2d81:9a86 with SMTP id d11-20020a63360b000000b0040c2d819a86mr8664644pga.60.1655512021857;
        Fri, 17 Jun 2022 17:27:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6844:cedc:a28c:44b2])
        by smtp.gmail.com with UTF8SMTPSA id p2-20020a62b802000000b00524fdb94c53sm66903pfe.132.2022.06.17.17.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 17:27:01 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sandy Huang <hjc@rock-chips.com>,
        Doug Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] drm/rockchip: vop: Don't crash for invalid duplicate_state()
Date:   Fri, 17 Jun 2022 17:26:52 -0700
Message-Id: <20220617172623.1.I62db228170b1559ada60b8d3e1637e1688424926@changeid>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible for users to try to duplicate the CRTC state even when the
state doesn't exist. drm_atomic_helper_crtc_duplicate_state() (and other
users of __drm_atomic_helper_crtc_duplicate_state()) already guard this
with a WARN_ON() instead of crashing, so let's do that here too.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 74562d40f639..daf192881353 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1570,6 +1570,9 @@ static struct drm_crtc_state *vop_crtc_duplicate_state(struct drm_crtc *crtc)
 {
 	struct rockchip_crtc_state *rockchip_state;
 
+	if (WARN_ON(!crtc->state))
+		return NULL;
+
 	rockchip_state = kzalloc(sizeof(*rockchip_state), GFP_KERNEL);
 	if (!rockchip_state)
 		return NULL;
-- 
2.36.1.476.g0c4daa206d-goog

