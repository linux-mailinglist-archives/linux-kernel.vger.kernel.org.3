Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFBD569C7B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbiGGIIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbiGGIIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:08:04 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30F133E24
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:08:03 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id o18so15926353pgu.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2JMkXDEWsNUyTV2UFLqYbO8oSrxA6PJmtCKjhOjVVJ4=;
        b=nWYmo88lUUMdAAw/AyAA10vGHCXrzofBxrdXE1qJ963zAeRDuNtSuDr+VV8zmRubSq
         9lUhLXxg/R4MjQ11mEQilzJuJU957zpgOqCfmn3PfrdcSeCw74kjSaKWfy4g8OM6/LL9
         m+13SWwSSgiOVzEAvOch/Yr8Y5m6CyMbhf1ErWIE+EXTbEO0Z9Kw82BQQ1prM3ORrzUk
         VXsM4Aajba2dQA0Qav2OT3AnMxsW4zLEAfkWgRmWZEvxxioMH6pdmy++vMMk0cblfj3I
         Im5Gn3/9qc/1jZW+bedAApaLjpiXSJhCTcVf1JFt4aIg77Mb4E9SD8Ba098UnwN1i0VU
         5v7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2JMkXDEWsNUyTV2UFLqYbO8oSrxA6PJmtCKjhOjVVJ4=;
        b=zWAgv8pzcuhHzWOOJcEjRPthjr2HFxkmoorWdAoNzWdV+w+b6jwn6wDcfS1JwYTUmv
         VglAXWreYLbe19AFH5jsU7eOep7a5pQjKQfzYahTeWk8InT/jPsgMs04HGahQqiI7tNi
         uOEUOcFZbxdh4pe0b0D9Htyh0FZpEbWksp8AHXxiIUz3Saysf/10W4B7WsXSH1KGkKji
         by74UEkoIPhFt+QjEpDppkbXvTs0kaCUH7iCEcGL2bgxUxSz/0MXY13+KxxbqdBsEATm
         uVUsD79d1EonYjhB8OVdDh0w7xRI2aSXaZtW9dmaOjCsQASqut9s3I0Vh3O14MNNRsah
         liPQ==
X-Gm-Message-State: AJIora8tIdHgtwfj/4cuXXOCNfgZlbRZ5dL8nIGTQz/ZxQjPhsj0R4ym
        R63QbFUaiJNON5PykidL6yR5D+dF/X/l8g==
X-Google-Smtp-Source: AGRyM1vAj9M28V9eEUa1ApSChnk2UKy2aafHz1z3Exu9j5+0/rqmJGtoPCJzhLb48Tq8hU5ivANbJw==
X-Received: by 2002:a63:c006:0:b0:411:c33f:b4bb with SMTP id h6-20020a63c006000000b00411c33fb4bbmr31162443pgg.433.1657181283214;
        Thu, 07 Jul 2022 01:08:03 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:a3e3:ea8c:2267:a237])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b0016c0c82e85csm1377374plf.75.2022.07.07.01.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 01:08:02 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/3] xtensa: iss/network: provide release() callback
Date:   Thu,  7 Jul 2022 01:08:00 -0700
Message-Id: <20220707080801.3496148-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220707080801.3496148-1-jcmvbkbc@gmail.com>
References: <20220707080801.3496148-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide release() callback for the platform device embedded into struct
iss_net_private and registered in the iss_net_configure so that
platform_device_unregister could be called for it.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/platforms/iss/network.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index 2d566231688f..2a22e80a488d 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -466,6 +466,15 @@ static const struct net_device_ops iss_netdev_ops = {
 	.ndo_set_rx_mode	= iss_net_set_multicast_list,
 };
 
+static void iss_net_pdev_release(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct iss_net_private *lp =
+		container_of(pdev, struct iss_net_private, pdev);
+
+	free_netdev(lp->dev);
+}
+
 static int iss_net_configure(int index, char *init)
 {
 	struct net_device *dev;
@@ -516,6 +525,7 @@ static int iss_net_configure(int index, char *init)
 
 	lp->pdev.id = index;
 	lp->pdev.name = DRIVER_NAME;
+	lp->pdev.dev.release = iss_net_pdev_release;
 	platform_device_register(&lp->pdev);
 	SET_NETDEV_DEV(dev, &lp->pdev.dev);
 
-- 
2.30.2

