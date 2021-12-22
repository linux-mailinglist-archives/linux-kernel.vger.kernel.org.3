Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7AB47CEC9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243705AbhLVJGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243680AbhLVJGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:06:01 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6676C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:06:00 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s1so3512015wrg.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qqsydkxhhK8OhNALZ+VHv5FZny2skJQWB82QtY63Q9s=;
        b=iD43qYAfHKgHEkC7nFjFdmgKXSLsUqD1tOX38fFtuZq3qwU1j0wOHmZyk7cmiVanwf
         giLn4KfQ9FO/4viWuK2riNg5PiCPdD4ewWsqhFlEkiTV3nTPKAyrcHFu7M1bsoRhNrHb
         DdjPxoxSwSl/T6YDCv1lW4ghDMwcvgq1aFQVMWAxSSg+mmGR6ivWF3EEl+DT2KkwejeC
         q4iVCkw85/sEWSRS0UaCHotTDsBlulj+yeCrxqRIlEoCSP9aawdEQovt91JUKIKS4xmj
         fwAYgHhTLBy0VF70R1A+BOhUwvuYUvC2NVVlPdorxD2IOIdOmjlLF/8qIHczAgPfW/R/
         huXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qqsydkxhhK8OhNALZ+VHv5FZny2skJQWB82QtY63Q9s=;
        b=dG/FZjOELvGsXUflJ3GW1JScgzTQUUZCw7Sqc2fAk/3Jiq+otNcO4PDB3UgSaO1qrI
         TfbjtWuMXNeN4H2ua2DHNjiTAlnRFDmjomcY0B7RnoooQuEEp8jHj0S/mk7VfJ3vBrit
         J8DRrrs1tBbfvkvIPgV2W3D1Ft+ymoKDfl1w7Pxy0Cxmk9eWIxAN6eJGaGxM8y3pEUQ/
         DNcSarY/5pNeJpyN9k/ws39sR1FPrX3Vg4taF9F9ugtLOyfUz+MQF/3bSlT1M1Pd07HD
         /HaeL6ExVLBoEbrooRSM6kIu1TaceJsJN7eTh20g66+6y3IoJhqtS2dupULQiGMI0h+f
         gT9A==
X-Gm-Message-State: AOAM530N131yyRBRMlMYua1a7BdeWtO/PSi102Qjd4V6eshdU5VwYq6H
        ObY/y0DkGypK2FZMqhci580=
X-Google-Smtp-Source: ABdhPJyT0Au4GEtGNae85W38GmiNwbKwrmg900dN5iNRMKkALJW8orth+l2K+OpmtdJEWYLlqaDVRg==
X-Received: by 2002:a05:6000:1ac9:: with SMTP id i9mr1363329wry.531.1640163959472;
        Wed, 22 Dec 2021 01:05:59 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id a22sm1139775wme.19.2021.12.22.01.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 01:05:59 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     contact@emersion.fr
Cc:     dmitry.baryshkov@linaro.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        daniel@ffwll.ch, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        marex@denx.de, stefan@agner.ch, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, yannick.fertre@foss.st.com,
        philippe.cornu@foss.st.com, benjamin.gaignard@linaro.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 2/6] drm/plane: Fix typo in format_mod_supported documentation
Date:   Wed, 22 Dec 2021 10:05:48 +0100
Message-Id: <20211222090552.25972-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211222090552.25972-1-jose.exposito89@gmail.com>
References: <20211222090552.25972-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix minor typo: "valdiate" -> "validate".

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 include/drm/drm_plane.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 0c1102dc4d88..06759badf99f 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -516,7 +516,7 @@ struct drm_plane_funcs {
 	 * This optional hook is used for the DRM to determine if the given
 	 * format/modifier combination is valid for the plane. This allows the
 	 * DRM to generate the correct format bitmask (which formats apply to
-	 * which modifier), and to valdiate modifiers at atomic_check time.
+	 * which modifier), and to validate modifiers at atomic_check time.
 	 *
 	 * If not present, then any modifier in the plane's modifier
 	 * list is allowed with any of the plane's formats.
-- 
2.25.1

