Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02ED504F42
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbiDRLJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiDRLJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:09:21 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D721E167CA;
        Mon, 18 Apr 2022 04:06:42 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id j9so3460257qkg.1;
        Mon, 18 Apr 2022 04:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lqJmuDMxHf0+2DSiEcjcAGw9d4Qde4FyLEfuQ+SFSHM=;
        b=CnglA6xk2NZryMtm33UXdAO03ocKVbgcmV2BauxBuUyRitBKeWS0agJLi5sHze5JNo
         m6nld8pbSw7H5nbGAWaMHgf+jQXd/9Cdjdm5MyewtKKURfv/DhnyDUcXpUnPRUmTCFb5
         IePPpRSuVwqipEAgZSA2DhquU+ftdVw2Nle8dDVxuFW7tkavJ3KrmK/e4EqdnNKWx2k7
         oxhgZykU5H2HpsNnMDg5Y4ip7CnQT6xGQ+dInyYIz4/onA0rE6BiUkAKNX+/p1JPUpmY
         uM1WmsxXJxtCh3okRyFZrRw00xl5UNyz8eJEl5wxYPchvsABCWCC+YLi6xyWTc6MsF8z
         tcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lqJmuDMxHf0+2DSiEcjcAGw9d4Qde4FyLEfuQ+SFSHM=;
        b=J6nE7A7TEh/3SMYpXvS2QOCgW3yJyKLa3xduQwZY3Lg63SvSHIr0ynVv7DRA+4+Qf7
         kKi98PNO1tn350UzRfgKfMAk41KXi3ETvLXHbSnmVhXLkmTmMAGm00ewyJrJqyCaRxwY
         WevPZJI8IwLoEZ/zkALbuOZrZuL49mbP2w72LhdTyFht4/Ex+xBgQUzxe6Fd2z0bqG/f
         kVl3DUMUzzueg1ou60NXgB2MVdvzkHyi4Emmpp3Ko7vukn9ZYZ81uuy4zgYra7521W3t
         eznsa5zU9GYhVWnGxz18iLhpb442tKzkUO3FyWg2vkjQkdr9Hh5ahWmAMIhqOUQK8MJA
         6XDw==
X-Gm-Message-State: AOAM530jl27cKSNjleTb0muZ9sCd74WzM3G2vVD/csOviIu0aQWjDM5Z
        L9UMcsuTt729BqktFgr4Y4Y=
X-Google-Smtp-Source: ABdhPJxNgNMH4f+6bA2msZobJNl4R8938/9xGvUG7VsuEH/doVkNMOxMxEiGkxOGHju6jcrMCIHZlw==
X-Received: by 2002:a37:697:0:b0:69e:6246:b69a with SMTP id 145-20020a370697000000b0069e6246b69amr6168569qkg.206.1650280002050;
        Mon, 18 Apr 2022 04:06:42 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z64-20020a37b043000000b0069c0a57f42fsm6588987qke.24.2022.04.18.04.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 04:06:41 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     robh@kernel.org
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] tty: serdev: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Mon, 18 Apr 2022 11:06:35 +0000
Message-Id: <20220418110635.2559391-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Using pm_runtime_resume_and_get is more appropriate
for simplifing code

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/tty/serdev/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 0180e1e4e75d..e550ad3e7f2b 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -156,11 +156,9 @@ int serdev_device_open(struct serdev_device *serdev)
 	if (ret)
 		return ret;
 
-	ret = pm_runtime_get_sync(&ctrl->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(&ctrl->dev);
+	ret = pm_runtime_resume_and_get(&ctrl->dev);
+	if (ret < 0)
 		goto err_close;
-	}
 
 	return 0;
 
-- 
2.25.1


