Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B51747F69A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 12:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhLZLZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 06:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbhLZLZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 06:25:18 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA71DC06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 03:25:17 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l4so7907074wmq.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 03:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JVsPYyeSs0Z89jpnz+/jWObtkdsoENnAN2PsMGBB0X8=;
        b=Ay89gIcMZst8GS6tyGXp98KOAC6Qgvu1V13cw/bSJfQ0fXJgZG1CyQSXYBVYyvR85x
         chNrltN4WsAL+D/E3LN61lFu800OdW4YqE6Db671ZbGItmrxctjiekoTQY0QMokGJw5/
         dFUWjTEqmeu7+zjUpWpFiuLEq/JaQFOlkPTQPKbBf+sB0HwATkpJjBjYCpHkXvy3l+LB
         Xg+NBHYtfxiRQwHcnYXOynDBNnmRXqt1Y9sodZKjUdDsfBRynMJBPd+bt21AhRYc69WM
         DOS4WhO6K4Oo4XOYxTYk8cqZyoBIkjRq7c4O3pNViYg5skoeqHc5uCCEZq03e9AUZ3xI
         FgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JVsPYyeSs0Z89jpnz+/jWObtkdsoENnAN2PsMGBB0X8=;
        b=7ohHfOcNjZ4CBizkSoc3tovBHrqy71IgUGwR3q2h7X5xRzULVoxHKstD8RjbDeyjwM
         HC2Push9lc8uC1yDL+k7hzCURStgeIC6YUyeHNE2pxYaGDjUWk+AmaIlUFXjv1xgkjP/
         Uko4HfGwzGAtQm6bp0/pwApIYdXIvOaub+Eqb1coAAKfoOQ3LTuPDEcPb+UHU9BpTLPL
         olVJy+gE7EHBY6FeBQXbIFn4DwcQivTfe20FpYCaKOfSuvUnnjwqLI5QjLaZcRreQF+1
         xqFhso2mOWcoZgSMoI+mCbSSpJIrfRSwAL2aZKoTOXKEenA7v7Q7KzcSLHciSbjAYH++
         PY6w==
X-Gm-Message-State: AOAM530Ne/KZGkY72ZYDLInax57WihmXrxNsSH795iuAJCBCx9KVl7ev
        XQJxFL2OffmeEVwWPWLzaTo=
X-Google-Smtp-Source: ABdhPJw57VZXKuh209lrx9BjCOI+QhODbcZjFyWAqCKVxPAtqvffXu2BoHojbDQtI0Ncc1Ggqfq3oA==
X-Received: by 2002:a05:600c:6018:: with SMTP id az24mr9821191wmb.103.1640517916521;
        Sun, 26 Dec 2021 03:25:16 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id g12sm13654743wrd.71.2021.12.26.03.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 03:25:16 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     contact@emersion.fr
Cc:     ville.syrjala@linux.intel.com, dmitry.baryshkov@linaro.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, marex@denx.de, stefan@agner.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, yannick.fertre@foss.st.com,
        philippe.cornu@foss.st.com, benjamin.gaignard@linaro.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 2/6] drm/plane: Fix typo in format_mod_supported documentation
Date:   Sun, 26 Dec 2021 12:24:59 +0100
Message-Id: <20211226112503.31771-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211226112503.31771-1-jose.exposito89@gmail.com>
References: <20211226112503.31771-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix minor typo: "valdiate" -> "validate".

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
Reviewed-by: Simon Ser <contact@emersion.fr>
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

