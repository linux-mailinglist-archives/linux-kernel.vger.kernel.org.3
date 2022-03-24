Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078704E5F15
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346084AbiCXHII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiCXHIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:08:07 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A62491AE6;
        Thu, 24 Mar 2022 00:06:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id qx21so7200568ejb.13;
        Thu, 24 Mar 2022 00:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gyjq9zdDhX6RlmCOAFpwWrWqHwqUR/OK0/YrxmP9mpE=;
        b=Nkjpyy9ZyUVLrvtPqSrFBmdZO0gQSf1HZ/lGBJRfGxBuIBZvGttXqZ9Yi3goQh7XwP
         tfW0Aw+eZLOvvUmz/j/Ai7HSKUSx6k+BabRVwHINjfk8kUS2Uw21dwDbKlTNdy8KtMM9
         p/L3+1ko9RSZVa0HmXTnTCIYJjgGNZCLW3T6qf+DSysj0876kU9Eq+/DTF/Lr4o7XEri
         4TuTn/f6u+YF6CY1ZRbfdZWyq3ruzVaUw/79lzXKHUckh9mj1k+XyDdXCoLwR983TPN5
         /atmeF97PAqqSGvq9PatGilN75mw2mcLsQz0DM5cVYj0HVJBseb8f40KfqE3m/EuD1a1
         GCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gyjq9zdDhX6RlmCOAFpwWrWqHwqUR/OK0/YrxmP9mpE=;
        b=GQaGX8FUnvLt1BpqLeVedrXeRHOGwoRcCfsd5uOg4y+OUXpDRuFGuZ/w98Px5z+Dqh
         ClS1dDItgg0/+dT63cNgkrZg5iOa2l1uRobm3mtFZBL6thzPP8VbLiZ8wgJI+xtWBw/q
         V1QABMOIDIiMhD2LpFleSWOjFtn/5LGkFZBF0D+SsaqVfUf15O0ygpxurVSD3T+UfO55
         nPKd2E+f7pY9azfNPUwvs3AG52Hv5AI/4sv8eLn+xxZbWhVQ+5/ajBtzKgq0prkWcCTc
         x9p2qEXbb6oL+exy2j3s3ChcixaG6nO+HlkAZhd2x972uItDF8fOKPjsQ29lbb1CVCLI
         +s1g==
X-Gm-Message-State: AOAM5314nk0lHpnqzeQhJZRCGXdSy33J1le/lMJHM2+0OZivGHf+3lxe
        k7mICAfjG/XQ6UHsS7CWQHU=
X-Google-Smtp-Source: ABdhPJyUE78skfv/AqLpnp/mVa6k6QKT8XGbJKI2o7hjsYtY7V0495iNlUhXbzcX1tm6egg7oWrh5w==
X-Received: by 2002:a17:907:60c8:b0:6da:83f0:9eaa with SMTP id hv8-20020a17090760c800b006da83f09eaamr4064343ejc.605.1648105591138;
        Thu, 24 Mar 2022 00:06:31 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id o7-20020a17090608c700b006cef23cf158sm763537eje.175.2022.03.24.00.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:06:30 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] backlight: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:06:08 +0100
Message-Id: <20220324070608.57057-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/video/backlight/backlight.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 4ae6fae94ac2..c05380d7a09e 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -479,19 +479,18 @@ EXPORT_SYMBOL(backlight_device_register);
  */
 struct backlight_device *backlight_device_get_by_type(enum backlight_type type)
 {
-	bool found = false;
-	struct backlight_device *bd;
+	struct backlight_device *bd = NULL, *iter;
 
 	mutex_lock(&backlight_dev_list_mutex);
-	list_for_each_entry(bd, &backlight_dev_list, entry) {
-		if (bd->props.type == type) {
-			found = true;
+	list_for_each_entry(iter, &backlight_dev_list, entry) {
+		if (iter->props.type == type) {
+			bd = iter;
 			break;
 		}
 	}
 	mutex_unlock(&backlight_dev_list_mutex);
 
-	return found ? bd : NULL;
+	return bd;
 }
 EXPORT_SYMBOL(backlight_device_get_by_type);
 

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

