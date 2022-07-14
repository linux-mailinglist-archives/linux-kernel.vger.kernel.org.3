Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9742E574AB1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbiGNKee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiGNKeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:34:31 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AA74B497;
        Thu, 14 Jul 2022 03:34:30 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so941043wmb.3;
        Thu, 14 Jul 2022 03:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pC66SMISxswpCgrA0kH+9OIYYeRJxezyms4h+DmQEVU=;
        b=WYO169N6L97QHmWqgss2/YWVR6YdUUzTbwOhAJSVFU1PEQ8kMqZBDicC68o07P9q28
         EEmuC/mKE53/poe+vlYtxqMaZ+PGZyrZbq2eRvdu5aRT6bArMjBK06GnSwCI1PkYV8x7
         UVCaVzMlf3W+ycBWFVoF9L83DY5tT97R24OrEMBDW5VZsJeqwuye8oTIOqHSGq714blI
         Wk/JILDt14y+ugO98wHXHVOtXlAw+wfAhbECEKwfxHSbKek2VkQuyXmSWmHG/m0aETRg
         pYgtSHJavQ5/qFeqk+bzDe5Q5xU4RXUi4MDpWF2WSdlG1KEgTcQheOshDYdeDck/jLyt
         lK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pC66SMISxswpCgrA0kH+9OIYYeRJxezyms4h+DmQEVU=;
        b=mHPRDvGzib8rk7CnXXVtJRY6nElmqlbfDb8I5hsRAu1dz6VxdNq2qlawmTSrtP+L93
         DS9Mpz00yILWIdcqxLXBLmGNq5tYgLD7h5cY0yfSXwuT4GW7Zv7aTvM7nushpRzdraYR
         CIPIE8nk6h4TNg2omm6EdJb2jRl9EpsMjtN0cl4S5RVEBJOmej8ZL3d1dyksxxPpEQiC
         +myYM744IpoiUHTZESObIePZERVdc9ca0/iHtqrTkxIJmtqXMLVAL1SKEuf9NENu+vCU
         5JdoT+gTMrWKNbHwvhhgsJ59q4qvwhFEumtuQ6Yja3np+oU0+IIQBVRTgIWP62+rI7Jz
         Du6g==
X-Gm-Message-State: AJIora/FrAbDkU3gAyn1notGMAk3AplJSKeloq6YkZQjiNbhec1cRuZa
        3QgqoF0vOEI7np4o55S5pF4D3pHZiHNdRg==
X-Google-Smtp-Source: AGRyM1tzgGbSFb97riqzZ4HULy1PRelNWUuo0QfgWlU5yTDw80hM5eCb4WBNauTxsQxuKHokkxRFQA==
X-Received: by 2002:a05:600c:3506:b0:3a2:feb0:9f8e with SMTP id h6-20020a05600c350600b003a2feb09f8emr5482096wmq.42.1657794868604;
        Thu, 14 Jul 2022 03:34:28 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d16-20020a05600c049000b0039c96b97359sm1386358wme.37.2022.07.14.03.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 03:34:28 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/display: Fix spelling mistake "supporing" -> "supporting"
Date:   Thu, 14 Jul 2022 11:34:27 +0100
Message-Id: <20220714103427.23255-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a dml_print message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 6101c962ab0a..fc4d7474c111 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -2994,7 +2994,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
 				if (v->ImmediateFlipSupportedForPipe[k] == false) {
 #ifdef __DML_VBA_DEBUG__
-					dml_print("DML::%s: Pipe %0d not supporing iflip\n", __func__, k);
+					dml_print("DML::%s: Pipe %0d not supporting iflip\n", __func__, k);
 #endif
 					v->ImmediateFlipSupported = false;
 				}
-- 
2.35.3

