Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8C25476A6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 18:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbiFKQzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 12:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiFKQz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 12:55:28 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8007F44
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 09:55:27 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 15so2107143pfy.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 09:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2zoTb5k5EV/NF02gzMw6UTCx2uR15xgLzy53hNpxo78=;
        b=VgDv7nn4q0/TTWEqYvRIch9uffEkgT/6W7sM+ndk4pwN9b7GzTpFq9HuDDGUmal2A0
         d2+D7jx090DtcDd/IuWHBJxCjj5hD71h+ZaclAl3jDtzqC0CICpuCMqlX5SSlR2EZZN+
         r9NWcCs1Yj95xStZDSO8gkkT0yvX2DIiiS0hM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2zoTb5k5EV/NF02gzMw6UTCx2uR15xgLzy53hNpxo78=;
        b=1Kvn9JPm/uveW0so7zLQSaBOGdIo7qQ0nxLWwJ3u3WC5uchfb4SKD+nbHpGcfuQX5y
         UAZTuiKI/SxRk5nZKATphMduF1tU1ep6dRhZ6SDhR/j4JmJ9U3dIli2s56FLb0j17s5c
         ZemP6RAPxxK3cJ/qIC9eAV5XH1U21AryfelrpL+k6FqTbz3JBuvJ2gy/32/xCNC0tsl9
         RemTS7cPaa+YCRArGZR2lyxC8Wbyvzs0Eu1iLDGLMY4Hr/gv4rGZkjZ0SKkBJ2EoBWVD
         pCqhWOkPNzBYGpw+Ce3qmrXpBYc8aJoc20gXdjjtkTuFBiJMoM2+H1ZnmRG7hj05UlZG
         +0dA==
X-Gm-Message-State: AOAM530hXKV48Cf02cbM8mg6nokZ1QjcCd5vV5seFJ5d4qZG3xjHbzNu
        Pb/1MaoVHdZKwtwP2EyeMLRUCA==
X-Google-Smtp-Source: ABdhPJxyOIJIVHsi9TiIYxc/i6gBtrPGAM+dWl536891vIHEVw5CCtAWjYJBtI28CFbRzjy/cjL4NQ==
X-Received: by 2002:a62:4e92:0:b0:520:6870:fc38 with SMTP id c140-20020a624e92000000b005206870fc38mr8415682pfb.8.1654966527300;
        Sat, 11 Jun 2022 09:55:27 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:1400:c3e5:17df:f636])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902654800b0015e8d4eb2ccsm1726604pln.278.2022.06.11.09.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 09:55:26 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: Fix htmldocs indentation warning w/ DP AUX power requirements
Date:   Sat, 11 Jun 2022 09:55:04 -0700
Message-Id: <20220611095445.1.I534072d346b1ebbf0db565b714de9b65cbb24651@changeid>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two blank lines are needed to make the rst valid.

Fixes: 69ef4a192bba ("drm: Document the power requirements for DP AUX transfers")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/drm/display/drm_dp_helper.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index dc3c02225fcf..c5f8f45511ed 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -372,8 +372,10 @@ struct drm_dp_aux {
 	 * Also note that this callback can be called no matter the
 	 * state @dev is in and also no matter what state the panel is
 	 * in. It's expected:
+	 *
 	 * - If the @dev providing the AUX bus is currently unpowered then
 	 *   it will power itself up for the transfer.
+	 *
 	 * - If we're on eDP (using a drm_panel) and the panel is not in a
 	 *   state where it can respond (it's not powered or it's in a
 	 *   low power state) then this function may return an error, but
-- 
2.36.1.476.g0c4daa206d-goog

