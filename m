Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94DD4BBA5D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbiBROCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:02:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiBROCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:02:33 -0500
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834B81728B5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1645192929;
        bh=qFiwwr0reEBhyd7hFYLdtwUqMteCjHucyPOYfaKvMa8=;
        h=From:To:Cc:Subject:Date;
        b=RioFuSeEYA1GFNZLLYnd/QcK+qbcU20EQyUatENx5EqmE+hv7xggJHijRbeFJJGpr
         yXY8ALAfn/74GEsp4C+q0C+KpxO5jh8mpgBltQywUEGXo0EqR/scSHlSSShJoqb1+z
         DIIyeCZMsgZxkHN4ob136MahpdaxCFCnTLneoSgo=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszb6.qq.com (NewEsmtp) with SMTP
        id 860FEF6; Fri, 18 Feb 2022 22:02:06 +0800
X-QQ-mid: xmsmtpt1645192926t3ivp4976
Message-ID: <tencent_24A24A3EFF61206ECCC4B94B1C5C1454E108@qq.com>
X-QQ-XMAILINFO: MdoRYM9mYrydrO9bnt62FOp77WWGswLWGtNzJf2HAwkGjbv4V/V7+iAu+HO9nL
         XP5zfz8Y2QMz4EbSBF3uPnd4u3dGCKiec8Jk0x+txDYtguAqAHDx4r4c2yhg5DD1eO7Mbbrsnp93
         zRNwQ3IvggBryDsjWDrrERajOVKYVUDCKYu8SM4VgQHYXGbWLcKDCBto3QwO/+4FdIQX2Hfyf80t
         HOX2BO+TMCcnIfMxpPvX7d7D9ePNjROWS/ET1+sFV5+Jd2dYG0N5z1I4IZvezBratMvvodR6PoN0
         WOnXAMmPs6/sngah/3Dg/ulKB9R+8OXs7dHCQ8yvZ1M7f464OXKiOoDEvmzbvEQwNlEklXlYfRlG
         MePwtnndwUUfxI+V5YwcX5gJYjad//lkb2/gEFbUEESbAV/dkGNANVaAOlU/Z/AE7JCuPkzxQqll
         0/ILRs/5yGB5zccCmOQMPgFRKK3MqbDEyljKpC5gvZJJrO61AqdWTd/HRyrzrdP6B1a/FW6i8Sx/
         lOfXIeIsQGTMx7XzwwzYcTWRj39h43BruBCkt9kwnj8O2jrUN7RZo6dwjWTOPwp0U4npLzrtf7W0
         Oq3UhxhbuqDq6Bb8QHPlFJmFh4sL7/e1mlQtG4FRyq5+XHiH43r/0HzOBaaSxO0U776UCRqQ84b7
         W9pzLChR6c389+K6+FZEGXtKf4w7ZKCWBSsf0Jus5EEUUQEpFBD2SdKRYwfFMx1qv5qlf4fV5W18
         87PJKbe2mVuoxm2YyZ8cbHPXw9onNxFMalQVPxQLWq3/3wdBjMMVlgBuuLSsMlb4+k6h+yjUzLKQ
         YJykswUNvggKcnN2c/04wLfvM5CLBYkI8rAldzLmCf7Zgps3BRDvUAKC/eYDS1/zCe8Zf1tL5a7d
         I/BMga+YXRdeeNUFrTr4JlU5L1kqrmG5AqYzUHbJZJb7LO9nJ6FTA9J6hJEXC6eA==
From:   xkernel.wang@foxmail.com
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2 1/2] staging: wfx: fix an error handling in wfx_init_common()
Date:   Fri, 18 Feb 2022 21:59:45 +0800
X-OQ-MSGID: <20220218135945.2239-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

One error handler of wfx_init_common() return without calling
ieee80211_free_hw(hw), which may result in memory leak. And I add
one err label to unify the error handler, which is useful for the
subsequent changes.

Suggested-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
Changelog
v1->v2 restore the wrong modification of a return statement.
 drivers/staging/wfx/main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
index 4b9fdf9..9ff69c5 100644
--- a/drivers/staging/wfx/main.c
+++ b/drivers/staging/wfx/main.c
@@ -309,7 +309,8 @@ struct wfx_dev *wfx_init_common(struct device *dev,
 	wdev->pdata.gpio_wakeup = devm_gpiod_get_optional(dev, "wakeup",
 							  GPIOD_OUT_LOW);
 	if (IS_ERR(wdev->pdata.gpio_wakeup))
-		return NULL;
+		goto err;
+
 	if (wdev->pdata.gpio_wakeup)
 		gpiod_set_consumer_name(wdev->pdata.gpio_wakeup, "wfx wakeup");
 
@@ -328,6 +329,10 @@ struct wfx_dev *wfx_init_common(struct device *dev,
 		return NULL;
 
 	return wdev;
+
+err:
+	ieee80211_free_hw(hw);
+	return NULL;
 }
 
 int wfx_probe(struct wfx_dev *wdev)
-- 
