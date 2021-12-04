Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6687A468795
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 21:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352942AbhLDU6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 15:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243137AbhLDU6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 15:58:45 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5DDC061751;
        Sat,  4 Dec 2021 12:55:19 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u1so13426286wru.13;
        Sat, 04 Dec 2021 12:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NTCctj97Zxd8lKdqZzyesNpAWdRl9W1/NJ/qFrT1pRE=;
        b=fS0oh9ctQzndOqm0jVP3O08T57VGure0mAxIWUdyUTkVlAf+/OIAft2yHGV+G7RMct
         eXtTq44Ex7CdmXw/veunUzn7H3xfo02CgN0RH9Z49vLn7Ri+X/l2lX8c8bHY4weRhBOd
         Mr4fes+Exjy0dg13PCofcZEVqnRkKEk6txiVaYkgBgS5S1hMrS3G9RVIONVJnTOj++4p
         L2VB9NcdumbWT37mPYJycdTk8MWBfONImVd9C0KE5fm8UKkVQt1WaakRUHdfZvgJRA26
         9zimv0CIEYWWbGmr4QxwsCZFo3n26m4ZGtV9GnnD0WkGKCI7KT0k3NtMtjV/ds2e9vju
         4h3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NTCctj97Zxd8lKdqZzyesNpAWdRl9W1/NJ/qFrT1pRE=;
        b=LAMa/wtS+jrXeGi9e0eRAJB54vYDY9Z9GMZbmFUx4F+50YK4XrCISkGdm1UZZRRgFd
         fgx1jKBbie0ln+jTxFj7zF65/XqO8N1AJiqEQOZE4xL5z+AsYZPaN5KqVFGG5iGkT6oC
         M05QTvrRBqS3LqS+9ou8JeJkEAn3pCi/K+dj7lyb58/J5pPQBrTZXWrVL/PPUfbGJ3Vx
         y3hdjfqYAPGxBnA7ZuX1q3aC4Jthbfql1fKQVV3EYjEzLuE2BbH5buJy4kj/G2mzVqs1
         2YgWIx9fFNe0FrzuW3svityhcL63T0KMhdWqW/c/x0GaDxOkqcDj2adg+HGFQ6fmddN1
         /Uew==
X-Gm-Message-State: AOAM533PZNTtnv1QtPJpB3NYEuf+ivdwsNII9uThBLfSF3TpupbQIs4O
        cPSM+7Jcm+78s6yHWm0vcdf+t9+JhE5UjIsb
X-Google-Smtp-Source: ABdhPJyw4cDNytGSmcjYD5bX6H8SxpgosFXNztNh0HXmh0oSmGbkFx1V1FuYfQIcDSFdjG28Y5X9RQ==
X-Received: by 2002:a5d:4909:: with SMTP id x9mr32215147wrq.313.1638651317618;
        Sat, 04 Dec 2021 12:55:17 -0800 (PST)
Received: from localhost.localdomain ([39.48.154.188])
        by smtp.gmail.com with ESMTPSA id l5sm8826304wms.16.2021.12.04.12.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 12:55:17 -0800 (PST)
From:   Ameer Hamza <amhamza.mgc@gmail.com>
To:     stanimir.varbanov@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kieran.bingham@ideasonboard.com,
        amhamza.mgc@gmail.com
Subject: [PATCH v2] media: venus: vdec: fixed possible memory leak issue
Date:   Sun,  5 Dec 2021 01:55:04 +0500
Message-Id: <20211204205504.6550-1-amhamza.mgc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163864977875.3153335.18099399866051099554@Monstersaurus>
References: <163864977875.3153335.18099399866051099554@Monstersaurus>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed coverity warning by freeing the allocated memory before return

Addresses-Coverity: 1494120 ("Resource leak")

Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>

---
Changes in v2:
move kfree() immediately after kfree() as suggested by Kieran Bingham
---
 drivers/media/platform/qcom/venus/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 84c3a511ec31..0bca95d01650 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -189,7 +189,6 @@ int venus_helper_alloc_dpb_bufs(struct venus_inst *inst)
 		buf->va = dma_alloc_attrs(dev, buf->size, &buf->da, GFP_KERNEL,
 					  buf->attrs);
 		if (!buf->va) {
-			kfree(buf);
 			ret = -ENOMEM;
 			goto fail;
 		}
@@ -209,6 +208,7 @@ int venus_helper_alloc_dpb_bufs(struct venus_inst *inst)
 	return 0;
 
 fail:
+	kfree(buf);
 	venus_helper_free_dpb_bufs(inst);
 	return ret;
 }
-- 
2.25.1

