Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2FC4E6038
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348818AbiCXITI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344245AbiCXITE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:19:04 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA929BAD8;
        Thu, 24 Mar 2022 01:17:34 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k6so3940796plg.12;
        Thu, 24 Mar 2022 01:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hORjNt7p5srcJ67bMMlDpkQB9q4uSrSXFGrY1gkdpyM=;
        b=DtTX2JxVBf6yhnC62Db+CzG9bXaA8mhg9UCbbPZNW+GyzyL7rBq86kihF/Opgl3srC
         38XE78gQnh4WIDQ8vO5spyJ2XP7JictzL0wMOB1efDlfBP/LYGn47CCKtq7Iz8k0QQdP
         VGVTum9u1MHagE3tymJ5NzU7qLJiv4+sXKF2SIEK5CFfoN0nqilJkW1qwyB0CsM/MvAk
         TJgVac41aq77uuevcv0RxJRhmees0hJsOBsxU8WEFycsr8JDRPa50Lk8EQWzGgAjTWNw
         EEx5iufcBP4b2G3eKNFf8sMYzvqEAkGJB+dnyb8DkuaR0G9x9BgnXPGF8HlCUlt7ZYZS
         N9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hORjNt7p5srcJ67bMMlDpkQB9q4uSrSXFGrY1gkdpyM=;
        b=zhLxCJUaU+3IADyvU6K7Wj61rMm17eXgNq1iTZ476Wg/ceh0JzGdE2WZt4SfCBLDgZ
         VCDh8gKwDYewLjCOXAQki8JuS+cp1UfaWDYVLi3FgQ+CtVEHLyndzmv6XHB6HlelWHaK
         VSvR0m9tqAkVP19kz3WGSWXcKhyzMVtYPQl33nDjMMoCvfTzPgMM9i2pCVld9sMkmv91
         yoYe3D8cy38iLDbZgi+SJjwu6uZcKCQVLOK/i+WEgYuqQHv6b2qhdIivgoA0dlCaIhCh
         s6N2+Ppw2Z7GldOZpXgJXaEX3+x+WJkVamCkRFe5ZJjZ/nYgUAO3/u9xsaXELxjK+sX0
         vIjw==
X-Gm-Message-State: AOAM532tNsvrUvfmgbXLNh5b7rU5xluJCOv28pRum9wswSC08UTd7RQg
        3W4g0akRAA4CKFYWt1c2CFA=
X-Google-Smtp-Source: ABdhPJx0Aio1HaPIhWX18pWOGE3LqBOkeNBrQ1px/ic2IcbQkrSdu4cDz1rcU3RndGPZjxu3+CngSA==
X-Received: by 2002:a17:902:930b:b0:14d:b0c0:1f71 with SMTP id bc11-20020a170902930b00b0014db0c01f71mr4574601plb.113.1648109853554;
        Thu, 24 Mar 2022 01:17:33 -0700 (PDT)
Received: from slim.das-security.cn ([103.84.139.53])
        by smtp.gmail.com with ESMTPSA id y9-20020a056a00180900b004faa45a2230sm2451502pfa.210.2022.03.24.01.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 01:17:33 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] media: uvc_v4l2: fix possible memory leak in uvc_ioctl_ctrl_map
Date:   Thu, 24 Mar 2022 16:17:18 +0800
Message-Id: <20220324081718.41091-1-hbh25y@gmail.com>
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

map->name needs to be freed when uvc_ioctl_ctrl_map fails.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 711556d13d03..e46a2f3b06cb 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -93,6 +93,7 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
 
 	kfree(map->menu_info);
 free_map:
+	kfree(map->name);
 	kfree(map);
 
 	return ret;
-- 
2.25.1

