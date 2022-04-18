Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CA7505D33
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346729AbiDRRBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238355AbiDRRBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:01:17 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411C5265
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:58:35 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s17so1974201plg.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6oixKBcCsCGFR4aUQt/tdt+p4qsIdjpTUDNTqLJ+UgM=;
        b=DsxdfJZZnKidzVPkjEN8yyUDWjCsJqByNG9+TdHU4o42WMmxNPH8Yp36mIV/daIscW
         7cNxu8SvonrXTSDpOOOipLirQYrOlf16tNmZ0+vxdb/wGZXfxZA404ipdOazg3I/OkrM
         0+zvrl6X1pFZbr0+SitCe57qkBRmdQco5No2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6oixKBcCsCGFR4aUQt/tdt+p4qsIdjpTUDNTqLJ+UgM=;
        b=d6yBl3H/wNBzK5r6WfwxJ/PE5JcVyyVlfPi1m6lKy0caD/MfVCWDn7D+gXMN22Umed
         cg5zNPc8bR8FMmyWmanlilgwKlpn/Mi/PIq7DBwnsu05ihSYHlggxwISUxYXG0nSUTp2
         73iWcg1uISooWZr9OCDZCapJ0/CCnAgEFNBmTAM1Wbl+iVFUee8Mqrg+hHQ1K6OdtFfH
         j4GIJs8ADoihqWvbGXbtCyIFoImQDnme7DVt4Q3CzH/nw3bIAAlujdWV2JUUpusgipXV
         xJsGVqQwVlrYNDUorgNLPKSQt2Hmqga+UuG9EdzLrzVUCLKcPkbEERxmM5df16QHLuTq
         WtkQ==
X-Gm-Message-State: AOAM532cZ9GC1DBbpk9DvTzLUDkcp63n7g94nBv81RNx/YMEdGXP232e
        u6yI9o167fRfJdSAQs6wDLTbyA==
X-Google-Smtp-Source: ABdhPJw5Ni08pwShHanj9IT5Yn5mjBegsZi5inslW8DtFVC0iBkiQhglSWrJEcEEcbje89EQVRuy/A==
X-Received: by 2002:a17:902:70c8:b0:156:509b:68e3 with SMTP id l8-20020a17090270c800b00156509b68e3mr11594454plt.113.1650301114799;
        Mon, 18 Apr 2022 09:58:34 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:94f4:f90:c59f:129b])
        by smtp.gmail.com with ESMTPSA id l8-20020a17090a150800b001cbaf536a3esm17700980pja.18.2022.04.18.09.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:58:34 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Philip Chen <philipchen@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] drm/dp: Add wait_hpd_asserted() callback to struct drm_dp_aux
Date:   Mon, 18 Apr 2022 09:56:39 -0700
Message-Id: <20220418095557.v2.1.Icf57bb12233a47727013c6ab69eebf803e22ebc1@changeid>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220418165642.2218514-1-dianders@chromium.org>
References: <20220418165642.2218514-1-dianders@chromium.org>
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

