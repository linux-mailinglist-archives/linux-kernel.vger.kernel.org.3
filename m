Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB2557D6D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 00:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiGUWYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 18:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbiGUWYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 18:24:04 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DACA95C09
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 15:24:03 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e132so2900837pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 15:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=deNvbs3qYKL1JRrzER9SspNMUOrIoxIui7ZX5V+JLIY=;
        b=e5rJiANtFt5gfhuP8SpDzFLRuphuqpFoj6Lu7gZl+xJY9yml8Aqdg46TPEZl5GBmas
         dX0+EQBxvL1vBjAZaUkJNovqgRUTPlICeTOTSR9IVyqIf7rzg+tk8e70egqb0AHpSj2C
         Bye7taMr00CtAqIfvlf+r0c4XN9cnckKaj0J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=deNvbs3qYKL1JRrzER9SspNMUOrIoxIui7ZX5V+JLIY=;
        b=Hk++ybAxref97pJH7/HfeCD+6fcqvbh1CUWZ6cqokWzL2BdBGGw2dnO3xtZH65iWe7
         eMg1zybP0rgtf+5a8uj01aCKZSBGH3Lm0iH7cbKguU6eXIX9Bwzx5BYcaeo5d6mpFNO0
         zBbyW5W3oxBpATR1vy49t4GHSprtAMnuAbK2NyTWPsVjziXbipkKN3r3Nh44ad+XBJk7
         eAGcjyZOiX5j6jDijRDI9LS/SZ9Tn6XSBcvOT9YqtXZqfFangRygfXs/dXd8TE7aFMkr
         CMXVbvIyr9oXqUdXGnhg1GcV7DAAdKCQnfQO4njZ8U1f40cVKB8UCJmmCTf3x1v2bxy1
         8RrA==
X-Gm-Message-State: AJIora/rfqGGnllkCFLtbNo69Gvs4ygPvyHXkVMtSzQytIDoivohAihD
        2UFc4/iayplChPNe9u2VYAYf0w==
X-Google-Smtp-Source: AGRyM1ucmGbzlsf5miZykSaJZXCq20zaDUKzLsPufJXzF3FOBiGnHuUiUhGGwYQQmz3a3+Q96KwlRA==
X-Received: by 2002:a65:58cb:0:b0:415:ea6a:c535 with SMTP id e11-20020a6558cb000000b00415ea6ac535mr486685pgu.100.1658442242856;
        Thu, 21 Jul 2022 15:24:02 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:29c7:7a23:197d:913d])
        by smtp.gmail.com with ESMTPSA id y189-20020a6264c6000000b0052594a3ba89sm2248779pfb.65.2022.07.21.15.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:24:02 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        freedreno@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] drm/edid: Make 144 Hz not preferred on Sharp LQ140M1JW46
Date:   Thu, 21 Jul 2022 15:23:40 -0700
Message-Id: <20220721152314.RFC.1.Ie333b3e4aff6e4a5b58c4aa805e030e561be8773@changeid>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sharp LQ140M1JW46 panel is on the Qualcomm sc7280 CRD reference
board. This panel supports 144 Hz and 60 Hz. In the EDID, the 144 Hz
mode is listed first and thus is marked preferred. The EDID decode I
ran says:

  First detailed timing includes the native pixel format and preferred
  refresh rate.

  ...

  Detailed Timing Descriptors:
    DTD 1:  1920x1080  143.981 Hz  16:9   166.587 kHz  346.500 MHz
                 Hfront   48 Hsync  32 Hback  80 Hpol N
                 Vfront    3 Vsync   5 Vback  69 Vpol N
    DTD 2:  1920x1080   59.990 Hz  16:9    69.409 kHz  144.370 MHz
                 Hfront   48 Hsync  32 Hback  80 Hpol N
                 Vfront    3 Vsync   5 Vback  69 Vpol N

I'm proposing here that the above is actually a bug and that the 60 Hz
mode really should be considered preferred by Linux.

The argument here is that this is a laptop panel and on a laptop we
know power will always be a concern. Presumably even if someone using
this panel wanted to use 144 Hz for some use cases they would only do
so dynamically and would still want the default to be 60 Hz.

Let's change the default to 60 Hz using a standard quirk.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/drm_edid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index bbc25e3b7220..06ff8ba216af 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -160,6 +160,9 @@ static const struct edid_quirk {
 	EDID_QUIRK('S', 'A', 'M', 596, EDID_QUIRK_PREFER_LARGE_60),
 	EDID_QUIRK('S', 'A', 'M', 638, EDID_QUIRK_PREFER_LARGE_60),
 
+	/* 144 Hz should only be used when needed; it wastes power */
+	EDID_QUIRK('S', 'H', 'P', 0x1523, EDID_QUIRK_PREFER_LARGE_60),
+
 	/* Sony PVM-2541A does up to 12 bpc, but only reports max 8 bpc */
 	EDID_QUIRK('S', 'N', 'Y', 0x2541, EDID_QUIRK_FORCE_12BPC),
 
-- 
2.37.1.359.gd136c6c3e2-goog

