Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52679485A16
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 21:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244145AbiAEUh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 15:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244103AbiAEUg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 15:36:57 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B990C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 12:36:57 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id l68so396983vkh.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 12:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PFpxL8eNjWfN9L9+3lNFj3nd+2+vNaUo9b7OlF5oUWU=;
        b=MOzaZyxBX3Mcp7NycsdG6RBaO+0oKmPOdqDAe0sh0Ods0J5BVgNQd6WTsHq2z1dTNR
         0Hcz5XTpa1HDn+ljXWi3Ene9RxrMrhMORzMtuo07KYswBrsYQoLvVp+VEhJ9G+8W3uTY
         9Xog4dUYCz+RzTl5ZFiABiDCkHGiIo273jK8g73H+BXwGqg7uzbTyHbGBngCabCI8W1l
         v08A9+HNolepnYcvf1WKrgMKMDiCBNCWbVXeDBS7/axpTkNuep8e9tVZkSw5oM9qYCkP
         XTwlaov9v8uFIu1QBUYUc1Cyy5L5gV7G3tGqBci2Ms/IPXOeGkeiISEh7OzAVhDU3Dj5
         Tg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PFpxL8eNjWfN9L9+3lNFj3nd+2+vNaUo9b7OlF5oUWU=;
        b=3OZQj/AJSJ1+pu/kcKeIW7kE7ba4/EPDl5m2EKXJeKL/FGQE4VCQzDP8WlX/oki7ef
         Wx0iVSWr/uDPR+jIYxzcyT+h7PsP+5AcnazBixDGuvk7wSuw4WmM/ye5rNbJjvQH9nBq
         bSEz+vXjB2IdxBk8PoXXJedfWbIQ9aNay8gyAjObW8msBHzaDn9jpbEMhDcfO9hv2rhE
         Q+lleyyAh7vnKX3dpnZvas9eWvAV+7AcLLqUuhq2NuTF7dm5A/fd9u2xGim3SBIONBl4
         yl5ogMAPspCanRqgjQBMyhyvvqqnJ9JFdB1PGA73eafn4NayzE+QlrOKOwNF9nbYIyFR
         I1WA==
X-Gm-Message-State: AOAM531FvqaPy2QXogDZW4xXgPzhPLBnSBKRnZGrtuDsdVOz36QleIVd
        7H6P53hJjKK7L9Y61YrxnRs=
X-Google-Smtp-Source: ABdhPJwDAuwT6naxOjUL5AyLq0SJlsEUSbEgq7WuMoQW8aEYk8+Vovkwf4Cg53hxRuabgFrryic7GA==
X-Received: by 2002:a05:6122:d0f:: with SMTP id az15mr20333761vkb.28.1641415016836;
        Wed, 05 Jan 2022 12:36:56 -0800 (PST)
Received: from localhost.localdomain ([181.22.170.52])
        by smtp.gmail.com with ESMTPSA id t130sm7860vkc.32.2022.01.05.12.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 12:36:56 -0800 (PST)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        juerg.haefliger@canonical.com, rdunlap@infradead.org,
        dave.stevenson@raspberrypi.com, stefan.wahren@i2se.com,
        unixbhaskar@gmail.com, mitaliborkar810@gmail.com,
        phil@raspberrypi.com, len.baker@gmx.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 4/6] staging: vc04_services: rename string literal containing bm2835_* to bcm2835*_
Date:   Wed,  5 Jan 2022 17:35:46 -0300
Message-Id: <91caae07fce0e4511f283388304e935526ba29ed.1641414449.git.gascoar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1641414449.git.gascoar@gmail.com>
References: <cover.1641414449.git.gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the kernel, all names related to the chip BCM2835 are always named
bcm2835_*. To avoid confusion, and to make things more consistent,
rename the string term bm2835_* to bcm2835_*.

While at it, some realignments were made to improve readability.

Suggested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../staging/vc04_services/bcm2835-camera/bcm2835-camera.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index cbc881e19f65..aaf529f2186c 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -884,12 +884,10 @@ static int vidioc_querycap(struct file *file, void *priv,
 
 	vchiq_mmal_version(dev->instance, &major, &minor);
 
-	strscpy(cap->driver, "bm2835 mmal", sizeof(cap->driver));
-	snprintf((char *)cap->card, sizeof(cap->card), "mmal service %d.%d",
-		 major, minor);
+	strscpy(cap->driver, "bcm2835 mmal", sizeof(cap->driver));
+	snprintf((char *)cap->card, sizeof(cap->card), "mmal service %d.%d", major, minor);
 
-	snprintf((char *)cap->bus_info, sizeof(cap->bus_info),
-		 "platform:%s", dev->v4l2_dev.name);
+	snprintf((char *)cap->bus_info, sizeof(cap->bus_info), "platform:%s", dev->v4l2_dev.name);
 	return 0;
 }
 
-- 
2.34.1

