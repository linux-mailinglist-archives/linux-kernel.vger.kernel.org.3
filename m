Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20A247B66A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 01:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhLUAPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 19:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhLUAPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 19:15:43 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B10BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 16:15:43 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so810928pja.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 16:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vMLGlhdQvs0uCAmUR/fFNn0WcxyOsoS8aXqwvGhFftE=;
        b=bejoLr+BiWV8PozTtoSIXr+HkkIoT6s3990SzimJq9MqSeC8Tk6YshZxFP4fHvfkrM
         bjvfGZd6BvggoRSQMuaR/hqSbunCoL7u4qPBfpj6K6E5uHwryjZSu0bAjY/s9SqaITP+
         vI0XX1lLsczhX7/wz/bulfYkL1R7AIKV7BbLHVpcJjtbjkCTiCydIH7iUOGrV15Gx6JO
         mx2Yg0h5YTvRJ1kxVrvu+gIqDv2WJE6nCrAOPO4rGbDuc8ARbfn3oKmgKQEpwDQSbhlU
         9Jr1U0zAcmGtHDh0VI4xsaFwFUHcFBd25/3J94idJhcFoVQrIiXZr47mODLGUCAdpXJw
         7qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vMLGlhdQvs0uCAmUR/fFNn0WcxyOsoS8aXqwvGhFftE=;
        b=xksIGTdRe8VE6o1u5zlRcyMQa6yVLkoC6KGuZYUao0Fr+j0fZHmMdglh4ZqUXEEfYn
         ZYLRtElT55Yf27dGfJuK8SS//kVFrUladWe1ox9HyCiZb7abqriUW+Htl7QEz5KsmsTN
         gfX+n2e88OL1/p1j5XEWTN1RF39oGbli62eEzV4opgpqP2Bg5fySxcaxGxaQ8cy2VP6O
         gyxFv9LvV+ByvjEYp7MP2G0SDaPjUl8i0/6YtWJucz2r4kJ3uin60ud//1PYudVxX8rL
         LqbCm2rl/sknEniHX5RFVUQwNKehL2Gmon/CeSE0+eZJKaVLW+JECEW84IQBrK46zNuL
         m9hQ==
X-Gm-Message-State: AOAM531q4f3ueQN9z0JjugnH0mOwNGDur0fEy/r2+6564EfKi+cXUazk
        gcCqI1Iiz3SEiW42vuteNEA=
X-Google-Smtp-Source: ABdhPJxM0IqoXIj7/yiD6C2d/nkUWdkfa+7bojfj2ZSNYe/rJ2dWsBfUomXyybVtDBv+FDengbF6lA==
X-Received: by 2002:a17:902:9306:b0:148:ca7f:9309 with SMTP id bc6-20020a170902930600b00148ca7f9309mr736549plb.68.1640045743148;
        Mon, 20 Dec 2021 16:15:43 -0800 (PST)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id gg23sm482262pjb.31.2021.12.20.16.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 16:15:42 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     zbr@ioremap.net
Cc:     davidcomponentone@gmail.com, gregkh@linuxfoundation.org,
        yangyingliang@huawei.com, ivan.zaentsev@wirenboard.ru,
        yang.guang5@zte.com.cn, dan.carpenter@oracle.com,
        unixbhaskar@gmail.com, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v3] w1: w1_therm: use swap() to make code cleaner
Date:   Tue, 21 Dec 2021 08:15:28 +0800
Message-Id: <2becaf314c17f5bff4c6af4a8bd05039dde68497.1639988198.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

---
Changes from v1->v2:
- Delete the curly {} braces.

Changes from v2->v3::
- Add --- line before version info.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 drivers/w1/slaves/w1_therm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index ca70c5f03206..565578002d79 100644
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
@@ -1836,9 +1836,8 @@ static ssize_t alarms_store(struct device *device,
 	th = int_to_short(temp);
 
 	/* Reorder if required th and tl */
-	if (tl > th) {
-		tt = tl; tl = th; th = tt;
-	}
+	if (tl > th)
+		swap(tl, th);
 
 	/*
 	 * Read the scratchpad to change only the required bits
-- 
2.30.2

