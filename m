Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705824628DF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 01:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhK3AKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 19:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhK3AKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 19:10:50 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F154C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 16:07:32 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v23so13938508pjr.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 16:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yLroyclqA7COdzkeGPg4v5EHelvIwAsUxd1X4mQaBh0=;
        b=oVZiDleNTBieFGQT1vWlQLpNNvmIpfgLebXbskRGsBaGYkKs2YZOcnldKh2VPOL0oO
         wtmPJl2ZZDk523mRkJEzpY2T+3dQ54hLG2b1ZglA4hKh1WF/7u3mhrfFatMH+vYkX5Qq
         PSaaweiUUmPn9u+by56tc88LxehK2cm4wj5Hp1u0itUzJTWK6XXfaeW6pp+Vn5d2+ob8
         mLKs4uPuQrPmDarxiIEzxVLTmPNBiTXyXa6yOKP7D5HQW22RgV/HUC9Bgm3MmkSsR/pK
         we+PJWbLTi3/ltn/3KBJZBkl3W5k16Bq9Y8Y8OJieJNW5JDycAHbztVlrFpKIE3TgNYb
         bdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yLroyclqA7COdzkeGPg4v5EHelvIwAsUxd1X4mQaBh0=;
        b=evn8beR9SkDyJ4oCesehg+A7Nw0YekugrZ7RfBZGEuNdPD0oXY25+Ae4LAh55JWM2F
         KSzyImCtzsdU6dmmtyFEmJ663Z0mkjDdd9okOCgFLQ2SOvJ1HH6tuhG9G8lm+r2mwRux
         v2UHJc9pXXUf89q+TZqZl1OTVcTenF8DTtrV91qUHH3pk2B2oPnJA+R97tNM6UxC9zjP
         8sAkZtevVF/qEatoddEOJu92Pc7DWr9c+RlsJ1aJBPiM524mhw7Ld4VRM9ZeWcvLfmfd
         7tVRtXxBOsmuU4b2rqMxgPyejTpKnE77ZyjbFFJvITKQrtwBHN/fuOsn/BFUS4yZGyjT
         yNRg==
X-Gm-Message-State: AOAM530I0jhXhGnrmplHVCWoe9nyxKWFgUPmf7H9114CXobxXTGXXpCq
        X+sqJgvQmkQK64Tz1rb6/h0=
X-Google-Smtp-Source: ABdhPJyg9nks96NZQCGBQ2/wyNf2fPNd0KsWM06DlMcci1jiFulf+PxRX1jdZPLwin+RrkTqp9maUQ==
X-Received: by 2002:a17:90b:1e51:: with SMTP id pi17mr1613000pjb.245.1638230851814;
        Mon, 29 Nov 2021 16:07:31 -0800 (PST)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id m24sm13098152pgk.39.2021.11.29.16.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 16:07:31 -0800 (PST)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     TheSven73@gmail.com
Cc:     davidcomponentone@gmail.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] staging: replace snprintf with sysfs_emit
Date:   Tue, 30 Nov 2021 08:07:21 +0800
Message-Id: <21e2111f6c2590ac24ad15d39e87160f9425045b.1638186054.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

coccinelle report:
./drivers/staging/fieldbus/dev_core.c:73:8-16:
WARNING: use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 drivers/staging/fieldbus/dev_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
index 5aab734606ea..01862fe8e4cc 100644
--- a/drivers/staging/fieldbus/dev_core.c
+++ b/drivers/staging/fieldbus/dev_core.c
@@ -70,7 +70,7 @@ static ssize_t card_name_show(struct device *dev, struct device_attribute *attr,
 	 * card_name was provided by child driver, could potentially be long.
 	 * protect against buffer overrun.
 	 */
-	return snprintf(buf, PAGE_SIZE, "%s\n", fb->card_name);
+	return sysfs_emit(buf, "%s\n", fb->card_name);
 }
 static DEVICE_ATTR_RO(card_name);
 
-- 
2.30.2

