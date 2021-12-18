Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5CE479817
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 02:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhLRB65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 20:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhLRB65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 20:58:57 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E616EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 17:58:56 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id m15so3757334pgu.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 17:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vHq0eUZZjxDi4yxUE8e7N7cUvG7XfIEqIwuJ3JY1aqg=;
        b=hriL3SqzyczX6i3GSDwG9hMjDVvEuWRYu+X5IaZZgHnpyMEEgay19AHeW0YY996lN2
         0phyT6QA68QXkPKCSoJDoS19SF7fndVLJPyCUb9vTIuPPDisM6Eu1ksJC/LiypMG+/jj
         iW4dT2H4gWM1n1pgAAg8P/Uzrx/lTQLkg+exjh2hgUkpVd5ICWKiex8s7yjm8fi0b+1T
         CLtTTB/+YJSNcww47B599ADNmkIzN62LjPLONi6ebXiBLwz6mtMCRfEINN7ZSI2ozopS
         s6+tGdSOxcX5wlkKNMYDl4oYFN3pq2Vl4lhnqvIhnTUuqWe5FtBRvMDCbyJ3cE9n2v6f
         RfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vHq0eUZZjxDi4yxUE8e7N7cUvG7XfIEqIwuJ3JY1aqg=;
        b=ZGpPgqGWIjt+AR9tHjtPLHAdqgXMSaX0bSA/8zPbKFWmsdvHpI7JK1uJlc3NT/rs3R
         GH53oC35g37u0JUAafzBmqwZ25GoF8RoHfpKtEwbAxfsx83iGc+2hxRYprBRWSi2gJbZ
         vhJI2RVP5BoIx+FQ1t9OY1RIo9lkLV4RZjLT0DgPV2NrOLOX+5PJ8gDIk7qcKpDXgYI+
         BGkAd4LEpDplLwXoFU2pRIPqVtSqDbObc2Dj6vxBZMIA8h6WnKDr6DfzHzN1gnRF5typ
         C0LBEUARnSyuH3+AH6P26pMhZLNyHuLCil71QNyj0t/hBRbXQs7bdQliAKg4WwCPMUPN
         aQkg==
X-Gm-Message-State: AOAM5302QtoNMZFs3sdp19tVOlNY2Qe6KbA4Cm1TW58PAIFIyeLLagrF
        idYZzLjgKpLYe97sO9qFcd4=
X-Google-Smtp-Source: ABdhPJxb8Q8ilCZLthpnqQOkD5zumCw07H/M81yB42/gd1Tf7qN3OflxpG3plj7pui1xImEYV1yamA==
X-Received: by 2002:a63:205:: with SMTP id 5mr5372109pgc.57.1639792736447;
        Fri, 17 Dec 2021 17:58:56 -0800 (PST)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id o15sm4982195pfu.34.2021.12.17.17.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 17:58:56 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     zbr@ioremap.net
Cc:     davidcomponentone@gmail.com, gregkh@linuxfoundation.org,
        yangyingliang@huawei.com, unixbhaskar@gmail.com,
        dan.carpenter@oracle.com, ivan.zaentsev@wirenboard.ru,
        yang.guang5@zte.com.cn, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] w1: w1_therm: use swap() to make code cleaner
Date:   Sat, 18 Dec 2021 09:58:44 +0800
Message-Id: <91568d9c9ff18bb9c850687252cbc38389786229.1639792249.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 drivers/w1/slaves/w1_therm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index ca70c5f03206..c743cb3d277a 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1785,7 +1785,7 @@ static ssize_t alarms_store(struct device *device,
 	u8 new_config_register[3];	/* array of data to be written */
 	int temp, ret;
 	char *token = NULL;
-	s8 tl, th, tt;	/* 1 byte per value + temp ring order */
+	s8 tl, th;	/* 1 byte per value + temp ring order */
 	char *p_args, *orig;
 
 	p_args = orig = kmalloc(size, GFP_KERNEL);
@@ -1837,7 +1837,7 @@ static ssize_t alarms_store(struct device *device,
 
 	/* Reorder if required th and tl */
 	if (tl > th) {
-		tt = tl; tl = th; th = tt;
+		swap(tl, th);
 	}
 
 	/*
-- 
2.30.2

