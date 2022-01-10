Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DEC489F80
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242238AbiAJSrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242217AbiAJSrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:47:47 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACF0C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:47:47 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id h1so13285832pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ShvwMaotgmHYVdyRN67h92I9DP3zj/wpQ1GkBlk/Io0=;
        b=bY3Jr6clk/F1DeLvYYTFQrOpmv3r+/HIgddPZvgbu9aU7WONBEcBhaxAx3gTkoKgUW
         rZEn23pieFdWmQP/CjGjD1akaeFOmUriPWVKAoxKRxh0H3k53xsZqK1leMpg9z8kxXeK
         BlWU1lQNk2TTML9iyGAIAXnvBh7NZvUJsg09M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ShvwMaotgmHYVdyRN67h92I9DP3zj/wpQ1GkBlk/Io0=;
        b=g8bcAeyKtWn5HoQkqW2Z5DEod7oGB7zqxnxxMF07RD4lmI/kmFw5BhdA+MdG/ZcSxu
         LSU8tsJM7Ur9FDIYY82SutfAeb2DFpe/VzaLC8beH3oZQfrhFVZJ9yXf20MqtWjeWdG1
         vNrJgk6oObYcNCCc6/kmHg7s+oZBPVCr73dP9vUl7E+YFSKXNKScKorqsqWhbtM+5Fjj
         jlT+fTxNG3IyrpPBF8BZd0evXDihIbY951nlFWd+yntDepDhUS/Bm/suZDJ4vlZKBrjO
         lvzIl/wnjxESZrOUfZPDWLCQy2Bbd1a6jsGyiR0/uFNHtdIaKfz445NDpnVLZ6zb3XqT
         R7EA==
X-Gm-Message-State: AOAM530U9Bnyv3rtD6oM6GYkybqT0PJqYsOPueouAUvyj1aNaxQmPyew
        14MsCGhveYygMHAg1fv7GRILUwBJyZDkOw==
X-Google-Smtp-Source: ABdhPJxderP7otW8Zajj9tFh0nOWHilY6JOnS9jnc7szLXg+tzFHs2CFgUsgiuNM5SOx2QsQuKyMnA==
X-Received: by 2002:a17:90b:1e50:: with SMTP id pi16mr1104987pjb.118.1641840466651;
        Mon, 10 Jan 2022 10:47:46 -0800 (PST)
Received: from localhost ([2620:15c:202:201:470e:3451:3aa4:4b43])
        by smtp.gmail.com with UTF8SMTPSA id s35sm7393137pfw.193.2022.01.10.10.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 10:47:45 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Sujit Kautkar <sujitka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH v6 2/2] rpmsg: char: Fix race between the release of rpmsg_eptdev and cdev
Date:   Mon, 10 Jan 2022 10:47:37 -0800
Message-Id: <20220110104706.v6.2.Idde68b05b88d4a2e6e54766c653f3a6d9e419ce6@changeid>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220110104706.v6.1.Iaac908f3e3149a89190ce006ba166e2d3fd247a3@changeid>
References: <20220110104706.v6.1.Iaac908f3e3149a89190ce006ba166e2d3fd247a3@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct rpmsg_eptdev contains a struct cdev. The current code frees
the rpmsg_eptdev struct in rpmsg_eptdev_destroy(), but the cdev is
a managed object, therefore its release is not predictable and the
rpmsg_eptdev could be freed before the cdev is entirely released.

The cdev_device_add/del() API was created to address this issue
(see commit 233ed09d7fda), use it instead of cdev add/del().

Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---

Changes in v6:
- remove cdev_del() from rpmsg_eptdev_release_device()
- added 'Reviewed-by' tag from Mathieu and 'Suggested-by' tag

Changes in v5:
- patch added to the series

 drivers/rpmsg/rpmsg_char.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index ba85f5d11960..49dd5a200998 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -92,7 +92,7 @@ static int rpmsg_eptdev_destroy(struct device *dev, void *data)
 	/* wake up any blocked readers */
 	wake_up_interruptible(&eptdev->readq);
 
-	device_del(&eptdev->dev);
+	cdev_device_del(&eptdev->cdev, &eptdev->dev);
 	put_device(&eptdev->dev);
 
 	return 0;
@@ -335,7 +335,6 @@ static void rpmsg_eptdev_release_device(struct device *dev)
 
 	ida_simple_remove(&rpmsg_ept_ida, dev->id);
 	ida_simple_remove(&rpmsg_minor_ida, MINOR(eptdev->dev.devt));
-	cdev_del(&eptdev->cdev);
 	kfree(eptdev);
 }
 
@@ -380,19 +379,13 @@ static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
 	dev->id = ret;
 	dev_set_name(dev, "rpmsg%d", ret);
 
-	ret = cdev_add(&eptdev->cdev, dev->devt, 1);
+	ret = cdev_device_add(&eptdev->cdev, &eptdev->dev);
 	if (ret)
 		goto free_ept_ida;
 
 	/* We can now rely on the release function for cleanup */
 	dev->release = rpmsg_eptdev_release_device;
 
-	ret = device_add(dev);
-	if (ret) {
-		dev_err(dev, "device_add failed: %d\n", ret);
-		put_device(dev);
-	}
-
 	return ret;
 
 free_ept_ida:
-- 
2.34.1.575.g55b058a8bb-goog

