Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A61D58B427
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 09:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiHFHFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 03:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiHFHF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 03:05:28 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8A2F5B2
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 00:05:25 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id KDsAokBsU9RnzKDsAo3rnw; Sat, 06 Aug 2022 09:05:23 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 06 Aug 2022 09:05:23 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: ov5693: Simplify some error message
Date:   Sat,  6 Aug 2022 09:05:21 +0200
Message-Id: <2937ae40c2043cff0eee238877da9656475b18df.1659769500.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err_probe() already prints the error code in a human readable way, so
there is no need to duplicate it as a numerical value at the end of the
message.

Fixes: 89aef879cb53 ("media: i2c: Add support for ov5693 sensor")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Sometimes, some people complain that dev_err_probe() calls should be
limited to probe functions and functions called from probe.

So maybe this should be converted to a plain dev_err().

Personally I don't fully agree. dev_err_probe() also has the advantage of
not being a macro and avoids some inlining.
So it can help to prevent the filling of the instruction cache of the
processor with things unlikely to be needed.
---
 drivers/media/i2c/ov5693.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
index 82a9b2de7735..8cf9516b6d57 100644
--- a/drivers/media/i2c/ov5693.c
+++ b/drivers/media/i2c/ov5693.c
@@ -403,8 +403,8 @@ static int ov5693_read_reg(struct ov5693_device *ov5693, u32 addr, u32 *value)
 	ret = i2c_transfer(client->adapter, msg, 2);
 	if (ret < 0)
 		return dev_err_probe(&client->dev, ret,
-				     "Failed to read register 0x%04x: %d\n",
-				     addr & OV5693_REG_ADDR_MASK, ret);
+				     "Failed to read register 0x%04x\n",
+				     addr & OV5693_REG_ADDR_MASK);
 
 	*value = 0;
 	for (i = 0; i < len; ++i) {
-- 
2.34.1

