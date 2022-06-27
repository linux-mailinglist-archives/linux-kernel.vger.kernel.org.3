Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5A655CDB0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiF0PFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237635AbiF0PFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:05:08 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC794175B7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:05:05 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i67-20020a1c3b46000000b003a03567d5e9so6057256wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mbhraybs4BrIz6d4796cwXXFW6lfNPQ37w8o2Zpee1o=;
        b=KupZZ+sarY3guqQXY2ptFD5NlYKfyYBs2ZTgqZ0qkyAc7wHfgowtz1NZmiJdEnK+wo
         n1x4HvtvDNXbDaaHIfajhHX2qAR/vhf5P44qF9fLXEjvmB2olv9CHMsGOToomOpgv6kS
         AyNKEk/UWWE1IkxXRE2nAUpJtMUklGWeZx35I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mbhraybs4BrIz6d4796cwXXFW6lfNPQ37w8o2Zpee1o=;
        b=lEtO2If7yUPYUndsNo8eKY6kXwMCjR9lQ+yiLFZ1tBWC0Q3ehO7GsxOg+Ns7kPph2v
         YOvMuLjc0G4cj2cgySlgFUuezVClQfrZnvS9uoprEhB7FVNTRtyOTvxYYjT0OcP2a3cG
         SGBPl0WOSnP/35mFkGUh1CRmrsWAUthek9EQ3ZNrMwjJ8HW5uHYtaioWzlDWZozOktoO
         e9Seb+7Vd/zuT+zqccsaWg6SNtu7mh0gdSR5KW1Q7n2ieqckkLAkDpchOTM6Cr3k0BtL
         TWOwIoKe+9AXDo6dntpER83vWNpbX0HFb+zZKZACXcYXyeKrt5IwM9VL6/3o+mDU+4bf
         066g==
X-Gm-Message-State: AJIora8ZOmEIAmjebEzRQGx3++wNYvd4rTEoRllxeGpKKXZRq8jmXM5F
        4rZDo3bYpeb3OwoLub5lG/l8ug==
X-Google-Smtp-Source: AGRyM1v+UVG8BbbMwMvAW42KVwxZzoiPd+lqZKHuXK/Mx/9tVTy1Cb9XbuPSeO1lJZzpIbjguIVojw==
X-Received: by 2002:a05:600c:228c:b0:3a0:43ee:d88b with SMTP id 12-20020a05600c228c00b003a043eed88bmr13081363wmf.135.1656342304223;
        Mon, 27 Jun 2022 08:05:04 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id d18-20020adfe852000000b0021ba3d1f2a0sm10581250wrn.48.2022.06.27.08.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 08:05:03 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] media: ov5693: rename ov5693_check_hwcfg into ov5693_get_hwcfg
Date:   Mon, 27 Jun 2022 17:04:51 +0200
Message-Id: <20220627150453.220292-6-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220627150453.220292-1-tommaso.merciai@amarulasolutions.com>
References: <20220627150453.220292-1-tommaso.merciai@amarulasolutions.com>
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

