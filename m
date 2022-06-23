Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C00557503
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiFWIKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiFWIJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:09:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B184147560;
        Thu, 23 Jun 2022 01:09:49 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id e5so10557390wma.0;
        Thu, 23 Jun 2022 01:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WUf4hh7XmxGqI1TyChD6Q9Q40vdp6ztxwpVVqyoKOb0=;
        b=M/Ksx3wAMaMxEES700OFBcZXpRa4wc0oINeNKEcajTDoEYnhRbdBv4KdmPmYqil1rp
         s67yY7qs7Z9uMQX9abv80e6zOAxDf0D4FQ9gS8Ga6gTnE2vJi86reVunCnB/mp9/pQNX
         0plD3hZ2Om0IwBM8oJlmj9IJZ0h+C6PSU8pSut0A69n3kNt5ZW2TV9wEfEzQLC1agRLE
         +d/BDuJsc7ByQwocxAPKAwfkXzenkyPNr1edj63us5r9waaF8KjiU8C4Fb4STONfOx86
         mtkXTc5YDmD6uI+sZyTbh64Tn0D6Ey2JmdkqzHdBVvVuJQIlPIkk3XGshW5rM3RJKjgC
         LKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WUf4hh7XmxGqI1TyChD6Q9Q40vdp6ztxwpVVqyoKOb0=;
        b=JgSROAbTUpcCGWtZr/skmtehZ9CWqS5DhQlxnpr6rBdft70YTZ69DX8cY4cLMaRVVU
         vOomEEO8/E20UursnBdfgH9bH01CqYjG9jcDZNFRQZJJ39XMqoPIZ9Idn9CPoT7U07Er
         kXGJJtru4rLMG5E7010Ip7bjDgMylksNS6spkVQPRbdGjoBD37j6rvubia0xCSspWpJv
         xP85D4aD6NkOuKQxeNjL+VCFGyYCevGbPY71LwfiB7avsVZI2+bKiMukQ5ftN29ReRUi
         IIDqnNOAPeMHbs35y7+XkKyzRyoaUf3X5pw/KlplxeNijeuha+ylM8qC+I9FQk4JLQPP
         EJ6A==
X-Gm-Message-State: AJIora++1uq0HIfjH2RuavKRKXifZgq/W2qUsCeHpOaEFUmDEF6i6+Zp
        b+DVACCwHnVod1gdvkQUp7k=
X-Google-Smtp-Source: AGRyM1tQCbkUDkb6HTKJP5xcbeP5k2VYytY3SaNTGGVmqI0KWdLDTOTW45BA4TJBrtuUMuOyZy642Q==
X-Received: by 2002:a05:600c:6020:b0:39c:5cec:da86 with SMTP id az32-20020a05600c602000b0039c5cecda86mr2610353wmb.75.1655971788177;
        Thu, 23 Jun 2022 01:09:48 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d6e91000000b0021a39f5ba3bsm21009445wrz.7.2022.06.23.01.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 01:09:47 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdgpu/display: Fix spelling mistake "supporing" -> "supporting"
Date:   Thu, 23 Jun 2022 09:09:46 +0100
Message-Id: <20220623080946.19116-1-colin.i.king@gmail.com>
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
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 7f144adb1e36..7d536c2f4477 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -1098,7 +1098,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 				if (mode_lib->vba.ImmediateFlipRequirement[k] != dm_immediate_flip_not_required && v->ImmediateFlipSupportedForPipe[k] == false) {
 					v->ImmediateFlipSupported = false;
 #ifdef __DML_VBA_DEBUG__
-					dml_print("DML::%s: Pipe %0d not supporing iflip\n", __func__, k);
+					dml_print("DML::%s: Pipe %0d not supporting iflip\n", __func__, k);
 #endif
 				}
 			}
-- 
2.35.3

