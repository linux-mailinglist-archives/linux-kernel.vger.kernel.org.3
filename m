Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646534FA1C4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 04:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240658AbiDICj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240633AbiDICjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:39:15 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89E7C31F9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 19:37:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so13461447pjn.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 19:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fymhEmFv/O8Tuh2GeqHqqsiXL5aZG/ohxN9zZ7IUhcE=;
        b=i+Scf6wXGKJdppgcWPtk6/VxfqcDhX6IxbHqkMo9S9/gnqJfZJZ/jFMAnhpL7M2Qx0
         eVfB4+aLpgVl0JDgirYwZ4r2JL2A6MM6//5/GgcKMkp63LMC3g2r6AxLsfiILIhWsl4P
         HA7k1MrDAfJlFt/ATY9UBfp4U4kxIIca89fAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fymhEmFv/O8Tuh2GeqHqqsiXL5aZG/ohxN9zZ7IUhcE=;
        b=QxbNzOJvUlDPY+CAtjFHsifChantDT6MhzuQl6G9YLrTveuNifmpqOriwzkINAPoGg
         ifIVhyVbSjQN2IvYdSKGdY5WnWxOycWKXrNr1HBSeVF57qyeN2ExLHwuCCGZzNNQ9MyK
         RqpfkIww/a9ludSDNY//pK1b5/IOXAmYf9EgsgymXT2hJBamGC2uYzOv4H7RKxnbqrUX
         +OqO1SCoWOfvvcAt0/aYzq5bTK7ASNlvinY68QT0RvKkgqO11Jrjr0mUMrUKUeELTa4d
         4OSEgdWnCBox30QW9o9Il1R+F6W/USTNVx7puuDveN3IhAXRaTN2Kc9dlaoTmG6prxT5
         btgA==
X-Gm-Message-State: AOAM532mtDsUdVHuXy7aJuDa1VAlp5X/B+KDC+BTLBC/y3WUnJfVH7eB
        tp30MgLzd0YQFw12NwiTtxKSLg==
X-Google-Smtp-Source: ABdhPJy7nNxWCXeW3m5jAZNd2k2Rh17DkzCXweSCpmeLDWahQW5YDzra5ADMhXthsjGqsE/I0/FyMQ==
X-Received: by 2002:a17:902:f652:b0:156:701b:9a2a with SMTP id m18-20020a170902f65200b00156701b9a2amr22122893plg.14.1649471830116;
        Fri, 08 Apr 2022 19:37:10 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:17db:64e:48d4:a4e])
        by smtp.gmail.com with ESMTPSA id 188-20020a6215c5000000b0050597294893sm759999pfv.124.2022.04.08.19.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 19:37:09 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Robert Foss <robert.foss@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/6] drm/dp: Add is_hpd_asserted() callback to struct drm_dp_aux
Date:   Fri,  8 Apr 2022 19:36:25 -0700
Message-Id: <20220408193536.RFC.3.Icf57bb12233a47727013c6ab69eebf803e22ebc1@changeid>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
In-Reply-To: <20220409023628.2104952-1-dianders@chromium.org>
References: <20220409023628.2104952-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

 include/drm/dp/drm_dp_helper.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/drm/dp/drm_dp_helper.h b/include/drm/dp/drm_dp_helper.h
index dad1442c91df..a12951319573 100644
--- a/include/drm/dp/drm_dp_helper.h
+++ b/include/drm/dp/drm_dp_helper.h
@@ -2021,6 +2021,20 @@ struct drm_dp_aux {
 	ssize_t (*transfer)(struct drm_dp_aux *aux,
 			    struct drm_dp_aux_msg *msg);
 
+	/**
+	 * @is_hpd_asserted: returns true if HPD is asserted
+	 *
+	 * This is mainly useful for eDP panels drivers to query whether
+	 * an eDP panel has finished powering on. This is an optional function.
+	 *
+	 * NOTE: this function specifically reports the state of the HPD pin
+	 * that's associated with the DP AUX channel. This is different from
+	 * the HPD concept in much of the rest of DRM which is more about
+	 * physical presence of a display. For eDP, for instance, a display is
+	 * assumed always present even if the HPD pin is deasserted.
+	 */
+	bool (*is_hpd_asserted)(struct drm_dp_aux *aux);
+
 	/**
 	 * @i2c_nack_count: Counts I2C NACKs, used for DP validation.
 	 */
-- 
2.35.1.1178.g4f1659d476-goog

