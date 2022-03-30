Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B494EC394
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345003AbiC3MVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347292AbiC3MGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:06:08 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE25F25
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 05:03:22 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e5so20260882pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 05:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AvqwHy5iP7QDYL90jHvlfS06VpNkgs2PdfjMbWdFXfE=;
        b=CUSnOCzxqgVRMtGhfZ4Fy+WyRU2GGqdh5D/k3XFkbJDJPj/P66POAZKY4dNjn2XQkf
         FSlZOHnmvEeO1rwpxooAaYyRSdT+Xdb2zuHBGjfhISLnyARzPggG/rs5cxIlTaxzOzki
         A8HjFhdN0mp0ByA1LrCj6pRVd8XmdIfw4qCmhwju5c9OCFwblO4rU4c2bYCPUhdSrgG3
         iSMgDyu2u2O0bI1bCgtlaeVvd3mT/iQaNvyn3xfH+kFktz4VewiRslZ/lxD2rTIPLgC6
         Fd5DsWOQ6etUz2D6YMpdVyiFPCQIMMduoPTX4tB+mAfH+d5Fa+b+PWAfkmhiWoZBVn1U
         pgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AvqwHy5iP7QDYL90jHvlfS06VpNkgs2PdfjMbWdFXfE=;
        b=49O7hMJe9wBnC/K3ps35HHX3gGk0hwkSOP7SLkvb4H60DBPAhY3BCw3MdN4ONbgqFH
         dJ4LZAmVCv91Ek+KuuPTvU1uXC0F54P9BplBzmpvfDtBiB2w/O9bdriyNIrf9clfAwmg
         ltxbj2580WLZmONvKFGJbO0BnM+zvPfoQwUbpsiTIXfX1jbOvHhF0j8Hvdep9JJnvUTd
         Uw1eTad7AeC7XGq7bKF/+nilDau1ZEYfJkTiq++JHK1BgA3PNwdK9rYSMhK92ll2fxGO
         Eqjl0pOOIGKg6WKnsjgcrUNXI/aAKOoyXPnnyIKPDZBc8xJkmuQ6uIGZQ+UIhcZtiYJc
         X61w==
X-Gm-Message-State: AOAM531ZQPXadro5JySIPAOvQIcOkReghrsEJPCtUOGUYpk7kMnb3sEi
        wGtIUMinDAvIv3zYTQB9e8g=
X-Google-Smtp-Source: ABdhPJy0jqMqa9ZIkbR+7qbrpJnbD0474GqIHiQoKDnZ/tH3sXBv6IRUdF4/oiU/ag6EBaHguPWVSQ==
X-Received: by 2002:a17:903:41cf:b0:154:25bf:7d0f with SMTP id u15-20020a17090341cf00b0015425bf7d0fmr34409382ple.41.1648641802229;
        Wed, 30 Mar 2022 05:03:22 -0700 (PDT)
Received: from localhost ([119.3.119.18])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7982d000000b004fb199b9c7dsm19622304pfl.119.2022.03.30.05.03.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Mar 2022 05:03:21 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     patrik.r.jakobsson@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     rob@ti.com, yakui.zhao@intel.com, airlied@redhat.com,
        alan@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH 2/5] gma500: fix a missing break in cdv_intel_crtc_mode_set
Date:   Wed, 30 Mar 2022 20:02:43 +0800
Message-Id: <20220330120246.25580-3-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330120246.25580-1-xiam0nd.tong@gmail.com>
References: <20220330120246.25580-1-xiam0nd.tong@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of exiting the loop as expected when an entry is found, the
list_for_each_entry() continues until the traversal is complete. It
could lead to a invalid reference to 'ddi_select' after the loop, and
could lead to multiple 'is_*' flags being set with true mistakely, too.

The invalid reference to 'ddi_select' is here:
	cdv_dpll_set_clock_cdv(dev, crtc, &clock, is_lvds, ddi_select);

To fix this, when found the entry, add a break after the switch statement.

Fixes: d66760962d75 ("gma500: Program the DPLL lane based on the selected digitial port")
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/gpu/drm/gma500/cdv_intel_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_display.c b/drivers/gpu/drm/gma500/cdv_intel_display.c
index 94ebc48a4349..3e93019b17cb 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_display.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_display.c
@@ -616,6 +616,8 @@ static int cdv_intel_crtc_mode_set(struct drm_crtc *crtc,
 			DRM_ERROR("invalid output type.\n");
 			return 0;
 		}
+
+		break;
 	}
 
 	if (dev_priv->dplla_96mhz)
-- 
2.17.1

