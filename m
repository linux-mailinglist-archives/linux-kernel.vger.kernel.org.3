Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1876E51B5BB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbiEECW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbiEECWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:22:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6944C483AC;
        Wed,  4 May 2022 19:18:47 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o69so2884850pjo.3;
        Wed, 04 May 2022 19:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oqH/dbbnTtMr+EJMMPwH7Zk0jku9Sj+hQp0KzdVsugw=;
        b=T9u9/ydtEfx4h7GiWCbnQJEONx/wv/NLn/Q8oiiIpydcJ6xFfpYHLZBlEFO/4CoCir
         ShGNzad5HoGqrhfRFKHINOHXjSiUAdKBWGoLNj2Mb4LAV+tXIhwn9PQGsJ2eD9XZOxsy
         Hco8NgdM0V2bscMlgx4+3zFgkZ4U881TpMXTELfTXwT84ZSkWaZaqDKKNC3m9EYEEH6U
         BQ0RmjmCB6tleevSaYtC7jnckQ8L2Aj3F9y959NMrCEPiTZJFUTiuBZ7dFa5BA15CBpI
         g4pNflh+Uep4NpERyidWv2Tg+Wx2JmqOkWnZ1lvO/YnYjxiNo1ugb6QSq9O2RwtWpY5J
         OhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oqH/dbbnTtMr+EJMMPwH7Zk0jku9Sj+hQp0KzdVsugw=;
        b=2miliKcK+BQJl06G41NCkHSl2LUCKZ7ngrDN4D6vpQap2RoHM1XIlw82WO2/kaLQ57
         jc0vP2zyDgUrRMFritChSJhj2k+3/ycIa+gtj2XgIvyAs4pGJgcSP17LyzXujkaTCE0S
         6QnDdtBqgIHwY1bz6/9SO1M+1g7kwJL/p0UHliQLIHFY8MhLd9xE8e2nzzPUQpsdryp2
         F5QbPAuO2OykeJBXViu49liXgJneQs03NOL9KZn9/2te9ueC2Z0ClF6XJ1aPkcZgPvzD
         bTIBXqnKeEsnRxqIERKOpALu00SgiTpsuGLxtpXQ82iwvV+Nqr3MfNqJ+b3AsIcY8lht
         Ukww==
X-Gm-Message-State: AOAM532EFSFChoaaN/5/SsFvs/zScq7/uI8OyPjpLi0CHCzZyUlvS9g+
        M+K+Du+1je5yxdYCKeLGM59j4tGp7Cs=
X-Google-Smtp-Source: ABdhPJwgy/prmxbKZo0DsO2jpkkSYuhFpok7c1JvIOChR1kwDE++l6JWyaMFGipguogzHTqWR0xKTw==
X-Received: by 2002:a17:902:be03:b0:15e:cac2:f98c with SMTP id r3-20020a170902be0300b0015ecac2f98cmr5230043pls.172.1651717126996;
        Wed, 04 May 2022 19:18:46 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b5-20020a17090acc0500b001d792761e2esm2653102pju.47.2022.05.04.19.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 19:18:46 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] Input: synaptics-rmi4: simplify the return expression of rmi_driver_of_probe()
Date:   Thu,  5 May 2022 02:18:43 +0000
Message-Id: <20220505021843.54399-1-chi.minghao@zte.com.cn>
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

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/input/rmi4/rmi_driver.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 258d5fe3d395..eec5d926da25 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -991,14 +991,8 @@ static int rmi_driver_remove(struct device *dev)
 static int rmi_driver_of_probe(struct device *dev,
 				struct rmi_device_platform_data *pdata)
 {
-	int retval;
-
-	retval = rmi_of_property_read_u32(dev, &pdata->reset_delay_ms,
+	return rmi_of_property_read_u32(dev, &pdata->reset_delay_ms,
 					"syna,reset-delay-ms", 1);
-	if (retval)
-		return retval;
-
-	return 0;
 }
 #else
 static inline int rmi_driver_of_probe(struct device *dev,
-- 
2.25.1


