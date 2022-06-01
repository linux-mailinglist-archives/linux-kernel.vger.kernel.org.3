Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6106753ACB7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 20:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356244AbiFASXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 14:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbiFASXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 14:23:33 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0F466C9E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 11:23:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gd1so2801882pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 11:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/JhQL6K3uh3O984WIozZ8SgUhIwo1E2fCaDixGouuFc=;
        b=bQe+znboLg5KVUPXFanhDzZUyTtd8/DqaO3vDJEG8jvos5lAcS8YRMPwR4YULDJXsj
         VUwdHTs5Rva3cnmIkL6+hJJYk5zczz5bB21jHPGfDzUxQeai6Mz3pg6hyEPKCZRlKVL6
         8XfbVXwlYmCQe4tsOJqMV7rgw065OFTvi1l/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/JhQL6K3uh3O984WIozZ8SgUhIwo1E2fCaDixGouuFc=;
        b=BAYi+sKBcrchtcp4qU8qPbrkzNWkQ2XWTMNkJiVu/m4KzlQlEx44Di5bce+DkUHWq7
         BhhY5+bZ2Jv9uJzeiXOXuG10qViOmenrscJ4mUCHfI46n96n8QMBsi5662GbrepovzSb
         pFN3vqd82HVP3cLO5EOJvzc2w/q3CRYrkrJYqpnr8j4ZDOHRtAi4dpURcVY0KyHAK2gk
         4wbzXr2pBcp8+3j19l8j15Qh7vTrhXG6lTvpF/beiGy1/+0mzCG23g71HXoogPipCMwW
         2UOPGUMq4UpjwoQLUyekXXVNb7EJpkLXfvvrYaK5C3VcY+6SsKyFbtpJ4iBhnJOV+CMD
         4MYA==
X-Gm-Message-State: AOAM530NIHf2Cw0GXiCj//MVxmDgV6+u1OyJropjllVV0+X0VhJZppoJ
        SUR6oL5tqF5I2OeAYzJLM+70vA==
X-Google-Smtp-Source: ABdhPJxkZcEEXs4C3T4YbCZSNWjdVM2FImDp58YVkoQ7Y7Nye2+tmcgRAy4DLVeQEFjt+JV58ido0A==
X-Received: by 2002:a17:90b:33ca:b0:1dc:e5b8:482b with SMTP id lk10-20020a17090b33ca00b001dce5b8482bmr35533108pjb.165.1654107811654;
        Wed, 01 Jun 2022 11:23:31 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:2f43:87c7:551a:ca93])
        by smtp.gmail.com with ESMTPSA id ie12-20020a17090b400c00b001e2f0333a86sm1702300pjb.12.2022.06.01.11.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 11:23:31 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Cc:     dmitry.baryshkov@linaro.org, tzimmermann@suse.de,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        ville.syrjala@linux.intel.com, quic_sbillaka@quicinc.com,
        quic_khsieh@quicinc.com, quic_abhinavk@quicinc.com,
        robdclark@gmail.com, freedreno@lists.freedesktop.org,
        jani.nikula@linux.intel.com, quic_aravindh@quicinc.com,
        Douglas Anderson <dianders@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] drm/probe-helper: Default to 640x480 if no EDID on DP
Date:   Wed,  1 Jun 2022 11:23:24 -0700
Message-Id: <20220601112302.v4.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we're unable to read the EDID for a display because it's corrupt /
bogus / invalid then we'll add a set of standard modes for the
display. Since we have no true information about the connected
display, these modes are essentially guesses but better than nothing.
At the moment, none of the modes returned is marked as preferred, but
the modes are sorted such that the higher resolution modes are listed
first.

When userspace sees these modes presented by the kernel it needs to
figure out which one to pick. At least one userspace, ChromeOS [1]
seems to use the rules (which seem pretty reasonable):
1. Try to pick the first mode marked as preferred.
2. Try to pick the mode which matches the first detailed timing
   descriptor in the EDID.
3. If no modes were marked as preferred then pick the first mode.

Unfortunately, userspace's rules combined with what the kernel is
doing causes us to fail section 4.2.2.6 (EDID Corruption Detection) of
the DP 1.4a Link CTS. That test case says that, while it's OK to allow
some implementation-specific fall-back modes if the EDID is bad that
userspace should _default_ to 640x480.

Let's fix this by marking 640x480 as default for DP in the no-EDID
case.

NOTES:
- In the discussion around v3 of this patch [2] there was talk about
  solving this in userspace and I even implemented a patch that would
  have solved this for ChromeOS, but then the discussion turned back
  to solving this in the kernel.
- Also in the discussion of v3 [2] it was requested to limit this
83;40900;0c  change to just DP since folks were worried that it would break some
  subtle corner case on VGA or HDMI.

[1] https://source.chromium.org/chromium/chromium/src/+/a051f741d0a15caff2251301efe081c30e0f4a96:ui/ozone/platform/drm/common/drm_util.cc;l=488
[2] https://lore.kernel.org/r/20220513130533.v3.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
I put Abhinav's Reviewed-by tag from v2 here since this is nearly the
same as v2. Hope this is OK.

Changes in v4:
- Code is back to v2, but limit to just DP.
- Beefed up the commit message.

Changes in v3:
- Don't set preferred, just disable the sort.

Changes in v2:
- Don't modify drm_add_modes_noedid() 'cause that'll break others
- Set 640x480 as preferred in drm_helper_probe_single_connector_modes()

 drivers/gpu/drm/drm_probe_helper.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 425f56280d51..75a71649b64d 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -569,8 +569,17 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 		count = drm_add_override_edid_modes(connector);
 
 	if (count == 0 && (connector->status == connector_status_connected ||
-			   connector->status == connector_status_unknown))
+			   connector->status == connector_status_unknown)) {
 		count = drm_add_modes_noedid(connector, 1024, 768);
+
+		/*
+		 * Section 4.2.2.6 (EDID Corruption Detection) of the DP 1.4a
+		 * Link CTS specifies that 640x480 (the official "failsafe"
+		 * mode) needs to be the default if there's no EDID.
+		 */
+		if (connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort)
+			drm_set_preferred_mode(connector, 640, 480);
+	}
 	count += drm_helper_probe_add_cmdline_mode(connector);
 	if (count != 0) {
 		ret = __drm_helper_update_and_validate(connector, maxX, maxY, &ctx);
-- 
2.36.1.255.ge46751e96f-goog

