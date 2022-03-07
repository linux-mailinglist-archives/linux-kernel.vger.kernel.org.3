Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ADB4D062D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbiCGSSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244730AbiCGSSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:18:01 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF08675E47;
        Mon,  7 Mar 2022 10:17:06 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so9804421wms.4;
        Mon, 07 Mar 2022 10:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sayrSIk+NDM65AKvFJGH6QJQ+sc3l62Epi/p4rWp0co=;
        b=oax+5ZR4uPTHvguofbQbtcUO/6gTvB/BultTtgRVppN+Esz2DDuKovZi47mRi4VUab
         voCR7Gz7m8k+D6WiKFDW3fubOt1z2EDvArL67+T8JgyD66xpEXqa/Toqn6f/pbrOJrcF
         ETUjSWPZgFa4LgVcFGzB51T78/WUfxACryDkxzAEaDnCyAh+gQU9Nww5E78NzHrPbPx7
         BWxccytxW3SW0v5bf85gZrIkwmECGTbOepkjvCgh7A7f9x46chlArdPVMQfq7+55wTtk
         xW18sa01nWH81gCf828GYjkClQEkYyP0WHjSMrXK60GYrwDbNx8GqV65ygerkdG0lx0C
         KGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sayrSIk+NDM65AKvFJGH6QJQ+sc3l62Epi/p4rWp0co=;
        b=YKz67wbCqRYiC+kUh5MHUlRV6e1nkWmFx+7oLeYL6EOqwexcblaMGqGMnqgcW36k/b
         V720LXbGX3AwpQS50kSZZW5gebGuyInF1fqh2bQsj5N37EUFmFatVoQBR9cOFrLqxd73
         4ELTBzckIWbEU1qXkzBq+fvHmRmrh5EiSSmssYeSd7Anpr04ow7Dvg08HBOsKPDUEB8h
         Xe0TNdlnNNu3WAOI2IuSW7cFDnF+HWI8QXMTMscrInB7978iEy+YhhAO7bSiDnicEfa8
         siGGf77TxtBedTuMEgHfcqDnA3QwxhDTAbYLCTpICGpoyEf2ku01AA21Uz+6w9pWielI
         jP8A==
X-Gm-Message-State: AOAM531mZjOcbiYu5g8GGTVu6ddX+SldRD0XipGtxbJNuJpAAoqqpaoB
        /GdWiwY2odrJ7Uv0wm6SAIaYF8qzChNgEg==
X-Google-Smtp-Source: ABdhPJxdUz78okhuvUq7H9aHqcb9xUZ5Eomn4OM9KtxAU3Wo+/Qd9m5moXVVdWEcWCu0X3A31wQ3Ow==
X-Received: by 2002:a7b:c8cf:0:b0:389:a5f5:5b0 with SMTP id f15-20020a7bc8cf000000b00389a5f505b0mr145235wml.37.1646677025308;
        Mon, 07 Mar 2022 10:17:05 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a10-20020a7bc1ca000000b00389bc87db45sm66515wmj.7.2022.03.07.10.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 10:17:04 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] drm/rockchip: remove redundant assignment to pointer connector
Date:   Mon,  7 Mar 2022 18:17:04 +0000
Message-Id: <20220307181704.149076-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
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

The pointer connector is being assigned a value that is never read,
it is being re-assigned in the following statement. The assignment
is redundant and can be removed.

Cleans up clang scan build warning:
drivers/gpu/drm/rockchip/rockchip_rgb.c:153:2: warning: Value stored
to 'connector' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_rgb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
index 2494b079489d..92a727931a49 100644
--- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
@@ -150,7 +150,6 @@ struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
 	if (ret)
 		goto err_free_encoder;
 
-	connector = &rgb->connector;
 	connector = drm_bridge_connector_init(rgb->drm_dev, encoder);
 	if (IS_ERR(connector)) {
 		DRM_DEV_ERROR(drm_dev->dev,
-- 
2.35.1

