Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4485266BC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350988AbiEMQIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiEMQIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:08:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A8E4E38E;
        Fri, 13 May 2022 09:08:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 109F0B830A3;
        Fri, 13 May 2022 16:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33F3C34100;
        Fri, 13 May 2022 16:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652458107;
        bh=zfD3VvBeoPFrFgvT7yZssD+YHa8RXtYOmfIAjowEaLA=;
        h=From:To:Cc:Subject:Date:From;
        b=OJ/uTz7zYugR1Z4Ld/VIl89CLCjfz0Mwn+01ZMfD1Z0GaO6APk7tT2jfL6+YgjAfU
         Egfnot0MNZYsQdG33LmCL6ehP86LEyvIHdhQlTFCVP78EM9oiZwIAvEZHB/nQerALw
         7hS8C+TPIBKmuGfu0cosCHpC+G3XTS70qWcz80UgdDXegjWrh+70Qi9q3jM4sXw462
         8FmqNj0/7xg8hDf18Ty9a1BjpOxBYfOVXJyjQfmrgy7PFqfqerbCdX8wBx3yhsGmCC
         9n3MAT72EQxRNfVQlpsEPXk29tea8Z8/tZxZF9ec1H6bVr80zlDQFR4KqOg4V1EFev
         CMgwJgUC6KaAw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1npXq5-0079QZ-81;
        Fri, 13 May 2022 18:08:25 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH] media: ov7251: fix mutex lock unbalance
Date:   Fri, 13 May 2022 18:08:24 +0200
Message-Id: <fd0d823dce99b4014713c476c750b2a76d825d3e.1652458100.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by smatch/sparse:

	drivers/media/i2c/ov7251.c:1381 ov7251_s_stream() warn: inconsistent returns '&ov7251->lock'.
	  Locked on  : 1381
	  Unlocked on: 1377

There's a lock unbalance at this routine, as it keeps the lock on
certain errors. Fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/i2c/ov7251.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/ov7251.c b/drivers/media/i2c/ov7251.c
index 4867dc86cd2e..0e7be15bc20a 100644
--- a/drivers/media/i2c/ov7251.c
+++ b/drivers/media/i2c/ov7251.c
@@ -1378,6 +1378,7 @@ static int ov7251_s_stream(struct v4l2_subdev *subdev, int enable)
 
 err_power_down:
 	pm_runtime_put_noidle(ov7251->dev);
+	mutex_unlock(&ov7251->lock);
 	return ret;
 }
 
-- 
2.36.1

