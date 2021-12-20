Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151F747A57D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 08:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbhLTHsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 02:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhLTHsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 02:48:50 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67390C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 23:48:50 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id i12so8027295pfd.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 23:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wUXslFjSoqFOsezb5mHKcnmwU4rjTf0lDYh+g5cJETQ=;
        b=qbkfMZ3VO1a64cHXhDs3vfN6cLRDp7wHjnYa82/Ii2QtplFtm1KzNIhKbV2t18tiEY
         Jr/Fms65MbjdaLKZ0rpV+ihRjlORijXfP60wLl3VX9YK1hkZacDrXymgylZfwxZNa/jI
         xWXjAOl1r3Y7rXGOxkhNZoqx9Bdf0JDeo4cRX1HOtGkrxbvGrAx82iqETzQ3ZuIYfqAF
         eDYQENhdUK7F4T+ZRgVFD/VOp9E48PoIuTA4BXLYsYZn6pTy2liy8HXyX/XqV+TxUQDs
         U56LgIxBSLYE2ME2G5+vRqlywVxtpD//5zqEmg6HnvWaaznKVoJexQkDP9DwwZie1/W5
         jd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wUXslFjSoqFOsezb5mHKcnmwU4rjTf0lDYh+g5cJETQ=;
        b=WOC6Ag4zL07BbyhXzlqO21goiBph2rNB/RBssFyW6/4rIuBH+YiWI5r/jHz+i9kP8s
         6jkPpRHUX5DI28wHV6Z3lkKNR8EMN7g1hZz5gOWLJsbYVx4zk8Z2HQc8KLTXeyPL0U6O
         xzgOV/eSXgVs0BBKTLhN4EULFeMAU2KiNlKNA86uhzU4UdnwltJQSiO6GkoIQWdqJrnz
         RbHfoEYyQrAj3cMtLhZHNcaQT7bmaQ9eg4E98B6lBTOA6pOAHchiRDsFNaaFtttYBw9Y
         Wg/7QWiGQ/EOtDmNxLk93lsSKfcRogMd4fSNHDIRrVBE1r437mm9xNDLn9fOoGQ2qulm
         Wxtg==
X-Gm-Message-State: AOAM530aeGvokwUllRZrDOWWpfAEXc4A1bBHA23/hF1AcfcNTbL3ckHw
        qXfYXAJLnz2TcX/jmwCNfkbUd6n5wX0=
X-Google-Smtp-Source: ABdhPJyUhIojSQVNPnpxmHkoCNJLvgNrQjVQPQDXNsSmttCyzfypXM8nQRWYAuICbXoPkyMg8LAxGQ==
X-Received: by 2002:a63:190b:: with SMTP id z11mr13813689pgl.414.1639986529975;
        Sun, 19 Dec 2021 23:48:49 -0800 (PST)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id h19sm2429897pfh.30.2021.12.19.23.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 23:48:49 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     zbr@ioremap.net
Cc:     davidcomponentone@gmail.com, gregkh@linuxfoundation.org,
        yangyingliang@huawei.com, yang.guang5@zte.com.cn,
        dan.carpenter@oracle.com, unixbhaskar@gmail.com,
        ivan.zaentsev@wirenboard.ru, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] w1: w1_therm: use swap() to make code cleaner
Date:   Mon, 20 Dec 2021 15:48:36 +0800
Message-Id: <cca30ad2a63eb710736b0b968d489c509716ecbc.1639961946.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Changes from v1->v2:
- Delete the curly {} braces.

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

