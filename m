Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9529B505D69
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346927AbiDRRVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243899AbiDRRUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:20:55 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8AC24F18
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:18:15 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t184so7005777pgd.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+5hNAQUGRBcWMyhUpii4SZ/5UNEY0wJyFcuVeraWLE=;
        b=U9m9xDxROs6AJXCzZAbutdOmIcD7SEJEZyfVo4+CqKf1YtHMSEAC89p81Qq3A1HSzg
         sRZWMfN4cZg7GlQ0cjKBsgRDzAL4x/cV2ZmLrMe20ZJ/20tThrCmscLUXDNWs+xxmHYE
         VUfQkvIOnGAd16z5FgdCUu7QL8dWIpV3pNqf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+5hNAQUGRBcWMyhUpii4SZ/5UNEY0wJyFcuVeraWLE=;
        b=xhyGmFaEngaMNAnoxQ0KZMYo6RoszpCrCpgvCfUqjNGTGhsC33VhhITVTsN3OY0rk0
         za4aw4N9li51RHK6NpMK1JSHiXHhOjC8iiBd79XDWbndYfMDpoe8Xt9gKmzOB/S+BBno
         AyesefXsiMAmgf2/OFe0ttw+uwj/kO6kvs32J9RoKDBEr51X+PDhCKxBwS/BKOrvZv2e
         djKEvKKciS3evzYmGQ34FpqD97rWTCA7oPZFOKOtBEhj5qTGvUdpknKK0DK9OvCOE0zk
         rAb7xn47XNmz/FMYh5zaPasZnBXWz7OoUfrAIXs3FY59f4G6NVjd2Sl52Zz2WoUcaByo
         VxxA==
X-Gm-Message-State: AOAM5316A9PsKpwCcYG31I2IqK/+7vU5KWg8Fd1l93STeuZvs1ZJxNqW
        bAU89ilAoJXtmqk4Hsb0FddYRw==
X-Google-Smtp-Source: ABdhPJwB+bu7EH+6U633uQKznBlc8LCNPkt9FKjrOTOZQoBsIoc+zKqtsdsUrREDVd7x4JZVu6g/Cg==
X-Received: by 2002:a63:fd05:0:b0:3aa:127d:538a with SMTP id d5-20020a63fd05000000b003aa127d538amr3006395pgh.95.1650302295398;
        Mon, 18 Apr 2022 10:18:15 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:94f4:f90:c59f:129b])
        by smtp.gmail.com with ESMTPSA id n184-20020a6227c1000000b0050a3bbd36d6sm12152126pfn.204.2022.04.18.10.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:18:15 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] drm/dp: Add wait_hpd_asserted() callback to struct drm_dp_aux
Date:   Mon, 18 Apr 2022 10:17:54 -0700
Message-Id: <20220418101725.v3.1.Icf57bb12233a47727013c6ab69eebf803e22ebc1@changeid>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220418171757.2282651-1-dianders@chromium.org>
References: <20220418171757.2282651-1-dianders@chromium.org>
MIME-Version: 1.0
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

Sometimes it's useful for users of the DP AUX bus (like panels) to be
able to poll HPD. Let's add a callback that allows DP AUX busses
drivers to provide this.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Left Dmitry's Reviewed-by tag off since patch changed enough.

(no changes since v2)

Changes in v2:
- Change is_hpd_asserted() to wait_hpd_asserted()

 include/drm/dp/drm_dp_helper.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/drm/dp/drm_dp_helper.h b/include/drm/dp/drm_dp_helper.h
index 53d1e722f4de..0940c415db8c 100644
--- a/include/drm/dp/drm_dp_helper.h
+++ b/include/drm/dp/drm_dp_helper.h
@@ -2035,6 +2035,32 @@ struct drm_dp_aux {
 	ssize_t (*transfer)(struct drm_dp_aux *aux,
 			    struct drm_dp_aux_msg *msg);
 
+	/**
+	 * @wait_hpd_asserted: wait for HPD to be asserted
+	 *
+	 * This is mainly useful for eDP panels drivers to wait for an eDP
+	 * panel to finish powering on. This is an optional function.
+	 *
+	 * This function will efficiently wait for up to `wait_us` microseconds
+	 * for HPD to be asserted and might sleep.
+	 *
+	 * This function returns 0 if HPD was asserted or -ETIMEDOUT if time
+	 * expired and HPD wasn't asserted. This function should not print
+	 * timeout errors to the log.
+	 *
+	 * The semantics of this function are designed to match the
+	 * readx_poll_timeout() function. That means a `wait_us` of 0 means
+	 * to wait forever. If you want to do a quick poll you could pass 1
+	 * for `wait_us`.
+	 *
+	 * NOTE: this function specifically reports the state of the HPD pin
+	 * that's associated with the DP AUX channel. This is different from
+	 * the HPD concept in much of the rest of DRM which is more about
+	 * physical presence of a display. For eDP, for instance, a display is
+	 * assumed always present even if the HPD pin is deasserted.
+	 */
+	int (*wait_hpd_asserted)(struct drm_dp_aux *aux, unsigned long wait_us);
+
 	/**
 	 * @i2c_nack_count: Counts I2C NACKs, used for DP validation.
 	 */
-- 
2.36.0.rc0.470.gd361397f0d-goog

