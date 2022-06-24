Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C825F55A495
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 01:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiFXXDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 19:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiFXXDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 19:03:37 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849E188953
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:03:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id h23so7480961ejj.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mbhraybs4BrIz6d4796cwXXFW6lfNPQ37w8o2Zpee1o=;
        b=gH2Z7bGufOOexKb1QCi6vG5Jtst7PDiEp12YxfktJF6iT9LumdlhD7WGjFie91X0EY
         EpBVumPmxwiot9IDUQdu/IHpt23AG03XrapwS25ESQZzkMcVJHogiTvYkEhc6/qwIFDs
         lNllUY9JchYHRn/k/rpE8Qnl6m8JU+JCnqUO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mbhraybs4BrIz6d4796cwXXFW6lfNPQ37w8o2Zpee1o=;
        b=e5B36us+UO/KYo7IpJTQ8LQHmolLxItCYBSJfujGtTT7orOZEfKHfDdbQsm9WDjKNI
         qy/3MgRYyXgTj8bmNqLpeD1rbQrQo9A9dNIoevnqFEAO5C2vTQB4fnBPlwYFhj+A1G2w
         79njZ4I4qRAzZkwfjNlda52MWwhVyToitEQthoIiPGAeZAtoTyR722yxSxbWEZUZmfsw
         KzgdIiBlREb9hRpQBvShsXwRnNSqd4/ufHGWXEZot/2CqfZAoUbRVW7boCMG/vlAvxE6
         OPtKn0UUPtyPvOuLCoSFwGEGiVpiF5cDQwyYKc6ahG+zsE05cxRxgIK6VKozwq8q/n6v
         ZGOA==
X-Gm-Message-State: AJIora+9FQWPMeyqb7YCHdxj8GG1GpsMDcKDiuY5b7DYBeki7WrAEkre
        hB5hZYr1bE5yqsDxa56jDt10mQ==
X-Google-Smtp-Source: AGRyM1sJyFili14FlSFtjNScmHSlGY/vuxR8LImiMA2h51vjwTyXUpuN4qaa6WmJWtoJh/H7vUvGeQ==
X-Received: by 2002:a17:906:4f87:b0:718:c7ce:bd64 with SMTP id o7-20020a1709064f8700b00718c7cebd64mr1236330eju.507.1656111815169;
        Fri, 24 Jun 2022 16:03:35 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id w1-20020aa7da41000000b004356a647d08sm2880291eds.94.2022.06.24.16.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:03:34 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] media: ov5693: rename ov5693_check_hwcfg into ov5693_get_hwcfg
Date:   Sat, 25 Jun 2022 01:03:05 +0200
Message-Id: <20220624230307.3066530-6-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624230307.3066530-1-tommaso.merciai@amarulasolutions.com>
References: <20220624230307.3066530-1-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ov5693_check_hwcfg don't only check the hw configuration but
also get the hw configuration. Is better better to rename this into ov5693_get_hwcfg

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
---
 drivers/media/i2c/ov5693.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
index d5a934ace597..273caef467fe 100644
--- a/drivers/media/i2c/ov5693.c
+++ b/drivers/media/i2c/ov5693.c
@@ -1339,7 +1339,7 @@ static int ov5693_get_regulators(struct ov5693_device *ov5693)
 				       ov5693->supplies);
 }
 
-static int ov5693_check_hwcfg(struct ov5693_device *ov5693)
+static int ov5693_get_hwcfg(struct ov5693_device *ov5693)
 {
 	struct fwnode_handle *fwnode = dev_fwnode(ov5693->dev);
 	struct v4l2_fwnode_endpoint bus_cfg = {
@@ -1431,7 +1431,7 @@ static int ov5693_probe(struct i2c_client *client)
 	ov5693->client = client;
 	ov5693->dev = &client->dev;
 
-	ret = ov5693_check_hwcfg(ov5693);
+	ret = ov5693_get_hwcfg(ov5693);
 	if (ret)
 		return ret;
 
-- 
2.25.1

