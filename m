Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA7D46FA9A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 07:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbhLJGZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 01:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhLJGZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 01:25:26 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43821C061746;
        Thu,  9 Dec 2021 22:21:52 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso6712178pjb.2;
        Thu, 09 Dec 2021 22:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C8BS4uByosa1EDbI+XGv6haeJe9mKfz064lJbpyXMW0=;
        b=FwClcQDkEU9X7OFujzMIPmJTlWmTv1SY8rAq9BAt+hM3xvn5eVfEA/cgsvgDKXFL8t
         pjibn3ahS3RmREuZuLqsfyTHWUn7+CIv9aqdhRpljFbmlCgn3MR8J11/BUirhF1rAMsL
         iO2FaHLzQd/vEOR8MmbxWZoPWkiZ6v7fPyv8sMwetPT9Zf5ALCJnbfjctbQodJ0wjb30
         Skl244ccJRj+dcMeJ4qAYPU5BpZv5oifH7bR5mRFjywbINaxc4KX6RXK4gCiREVJGO5B
         ZEUw54RiUfy/dXcnDsi62FnYhHzR5AP0GxSBpDAPNPByy206/x3+5ipIvpj6DnWSZtFA
         2a0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C8BS4uByosa1EDbI+XGv6haeJe9mKfz064lJbpyXMW0=;
        b=0VPzqYGwnKESrWjk74Kq5KMxhHlMwRjI+nI2pA2o0T+K5/gTCZr6PmS9IZEdmHBdFt
         P13FLf63N5K1jTmOIt32YffcJxxoNtPU2cwTh1ktPNTOe+UIZGUqWXeOGlshGuOowXGP
         Dr6a1t6T7blTDGTb+kLHQWu6KXt8dKy471D94CWQnKeHBhjFvdX+BSnG5sRNAlJi9c6w
         XzmcdcZ28kIPt1EsGhkwkLXc1OnzrWur7oK9zarGSj2VUdzFdC8MocRfQ1tc3fUlHlL5
         uBGId3pAoXzyB/T9iqregZ4hvQi7vwab2t/nSrnbOM4kyaqvQyWzsZ9251EC/6/tNmjl
         E4YQ==
X-Gm-Message-State: AOAM533fSZBd3Smdf2B3gRiW9RxBgfPA6gf3ZjDua88LiusZ8hbZQgfU
        rNqHv1pXqZ3irJMZQ64/QXI=
X-Google-Smtp-Source: ABdhPJzy5rbBLOUngt3qODtQFd8ir8VEGJYe/T8wk5P4O/RORLP8qAX5desVtyVew0K4N2o+gZbFXA==
X-Received: by 2002:a17:90b:1a87:: with SMTP id ng7mr21609604pjb.86.1639117311576;
        Thu, 09 Dec 2021 22:21:51 -0800 (PST)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id v13sm1832031pfu.38.2021.12.09.22.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 22:21:50 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     agross@kernel.org
Cc:     bjorn.andersson@linaro.org, davidcomponentone@gmail.com,
        kishon@ti.com, vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] pyh: qcom: fix the application of sizeof to pointer
Date:   Fri, 10 Dec 2021 14:21:19 +0800
Message-Id: <8d75af8e322a7e5839d2dd4320b696ee09ec0843.1639100549.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

The coccinelle check report:
./drivers/phy/qualcomm/phy-qcom-edp.c:574:31-37:
ERROR: application of sizeof to pointer

Using the real size to fix it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 17d5653b661d..a8ecd2e8442d 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -571,7 +571,7 @@ static int qcom_edp_clks_register(struct qcom_edp *edp, struct device_node *np)
 	struct clk_init_data init = { };
 	int ret;
 
-	data = devm_kzalloc(edp->dev, sizeof(data), GFP_KERNEL);
+	data = devm_kzalloc(edp->dev, struct_size(data, hws, 2), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-- 
2.30.2

