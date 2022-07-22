Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F7457D833
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 03:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbiGVB5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 21:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGVB5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 21:57:36 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7079B9748B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 18:57:35 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id o12so3317423pfp.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 18:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h3RzxpAVVByCjwBrnRNMmteMftmAUf7kNK0naWg1+X0=;
        b=DRJrCdqYrCZqsdPfa+8CWArPfpN54dSzOiYKbuoWrzIzRmBBhB6ny95JaOZ9roe3NR
         tu/1aArvhUmRb9rDa5sZ0ai5HlYmM9UAkbtvU0pCXFnCMX1wAUUZXIEHjqEHoICKmAF9
         0o+ANpCYv2BWcXifheR+NTZD/OhWVARKjkl7SrBdM/J2DTIGxZTbdoImFhSrRXKIG8ib
         HXa1eM3jN0Fk5O5cmWczEF6VxaOnW8blZWVyYnk3LXY0CUgvjdfxxgRahezP7TD3Sfgk
         GQIP3BTYADTS8JVF0CbWVlhHlfVxO4UhwJNKMVFnoSI0jxyLy7enI1xd57b86lquOd0B
         6avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h3RzxpAVVByCjwBrnRNMmteMftmAUf7kNK0naWg1+X0=;
        b=U5ynVFwWqWpfbfHgMe+oNBR7Rptdn+9ZhvX301uUbIroZzYc7m+EChr+/2B72fhpOv
         5AvkFYb+aHcmcWHvKnWtzsk3vla49LK6zb986j4HJP5IxSm8Qs/EOmF5E79CjxqQxLDC
         D+5uAzxV8WZSii9k1f5xd+SAjQaaVh63feniNilSWUixWdG31xrWKT2B/MHa24etv3o7
         tqpfXKillDEA6fYAV98WWrUQB6vJkX5Z1Wbh8oZEknTNegyNY7mph3PIaeYjXOotjQB3
         PGT54B3SSbILGVkA/VcCHdQQAo4PLf1CivDfU4lblMDbDrvLFxzq0VoQRy3t/9ua9JXK
         Njtg==
X-Gm-Message-State: AJIora+kjW6sd3RBrjcNUcaS8KJ/jGgqnI1ujx54Sh88TvUSLcQ4fn9Z
        creZswe3vro3tf5yUROE3KQ=
X-Google-Smtp-Source: AGRyM1uQ9TVglu4x0aMb9atG3TbJswbQcXq59N03iTJjd28Ma/TnbozmfRE6FNtJGCsw8k+4coABfw==
X-Received: by 2002:a05:6a00:1a46:b0:525:82e2:a0d3 with SMTP id h6-20020a056a001a4600b0052582e2a0d3mr1108603pfv.48.1658455054839;
        Thu, 21 Jul 2022 18:57:34 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d50800b0016c50179b1esm2398861plg.152.2022.07.21.18.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 18:57:34 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     andrzej.hajda@intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        xji@analogixsemi.com, hsinyi@chromium.org, sam@ravnborg.org,
        tzimmermann@suse.de, maxime@cerno.tech,
        ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH linux-next] drm/bridge: anx7625: Remove redundant 'flush_workqueue()' calls 'destroy_workqueue()' already drains the queue before destroying it, so there is no need to flush it explicitly.So,remove the redundant 'flush_workqueue()' calls.
Date:   Fri, 22 Jul 2022 01:57:24 +0000
Message-Id: <20220722015724.1500787-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Reported-by: Zeal Robot<ye.xingchen@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index d1f1d525aeb6..732647beb2ef 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2700,7 +2700,6 @@ static int anx7625_i2c_remove(struct i2c_client *client)
 
 	if (platform->hdcp_workqueue) {
 		cancel_delayed_work(&platform->hdcp_work);
-		flush_workqueue(platform->hdcp_workqueue);
 		destroy_workqueue(platform->hdcp_workqueue);
 	}
 
-- 
2.25.1
