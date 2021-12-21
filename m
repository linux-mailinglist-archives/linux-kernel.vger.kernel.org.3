Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A6347BCA7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbhLUJQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbhLUJQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:16:16 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9864EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:16:16 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so1964440pjj.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8EsGnshXfcZm5X8JF48f68HIdM6rixfzvS0sOuAOM94=;
        b=FBndaJ35a2OUCC76qCIfWefUx0X7X2H/zJlN7LhxKINDNNQRkNIwKwj2TrdTbHueeM
         0uY3TVdZnSpxyI411wRA2XncVEY5TB4muR2ifCM/hXcQ6T4WLMZeMA+RJI0GeZyfBi+C
         T4o5shVOrLPzNmSmkmysOaEt6s26pj+EMJMbPSq07da725rKHLuoMQp1dvhHkpcVdHL0
         7DVJuFNFuR1WYy2Abi0wZ89W+AudKwq+jmVaD1VxxwDnq8O0YElAyUA8PzmZf9ehL2SH
         gB/+eIHtTRXft7TtdQY0XtGmvOXjg9VlLTRzszvJBsRzguwo31OJrIpM7N3XsD6EkZLH
         vrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8EsGnshXfcZm5X8JF48f68HIdM6rixfzvS0sOuAOM94=;
        b=b67qzkOmFpq7wxN2rYQaWNVHgU9fNC8eOOTSh0BC9qV8y9mhfCdRUjyCiySTXF+cT2
         W/SZhRhn6SHuzar19eRMaN4TY4iP+AFIVtkFP9PuiS/7dTxzb4WTVMeFGWTlOkbbvmQ9
         9CLCMQ3ZiecrSZBNDlw+c4XhASY1CvlvHglZVO4XW5pg8UQExNDcbK5f9Bubjhf+l8u/
         UAuOr2zTC67jiVLZCDAVZ0Ez60ForsHvBfR5HC1Ip3Un1xCyl70cLz2zdDoTKNySiQNh
         f+3GVFLwgMdvdigO/9Lyha7+3zoFqiiBKWV0Ju5hYY7fr+SwRRx71G0axI10usE07kd4
         wmEg==
X-Gm-Message-State: AOAM530U7mpu//YEmnGnMladlwUK+IkMqSIot5aW/t9ER8/tjAKOWHjk
        2KeIszy3xmN3425qtWWxl3c=
X-Google-Smtp-Source: ABdhPJyk2imjdrB18WJISyiHcGn+q+74rlm4+TV5O3u+tsctQRmJpIvnlZ11KVwRfJNRhNtcx9NZpg==
X-Received: by 2002:a17:902:bb0f:b0:148:b895:4995 with SMTP id im15-20020a170902bb0f00b00148b8954995mr2139724plb.99.1640078176180;
        Tue, 21 Dec 2021 01:16:16 -0800 (PST)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id kb1sm2222459pjb.56.2021.12.21.01.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 01:16:15 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     zbr@ioremap.net
Cc:     davidcomponentone@gmail.com, gregkh@linuxfoundation.org,
        yangyingliang@huawei.com, dan.carpenter@oracle.com,
        rdunlap@infradead.org, yang.guang5@zte.com.cn,
        unixbhaskar@gmail.com, ivan.zaentsev@wirenboard.ru,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v4] w1: w1_therm: use swap() to make code cleaner
Date:   Tue, 21 Dec 2021 17:15:59 +0800
Message-Id: <cb14f9e6e86cf8494ed2ddce6eec8ebd988908d9.1640077704.git.yang.guang5@zte.com.cn>
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
Changes from v1->v2:
- Delete the curly {} braces.

Changes from v2->v3::
- Add --- line before version info.

Changes from v3->v4::
- Move signed-off-by above the --- line.
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

