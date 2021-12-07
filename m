Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2479C46C800
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242470AbhLGXKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242406AbhLGXKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:10:43 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A93C061574;
        Tue,  7 Dec 2021 15:07:12 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a18so818972wrn.6;
        Tue, 07 Dec 2021 15:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DcCZDxr7SMu2ST2bCheW+pTmK2hn1qh9rUqEtH0VUFo=;
        b=bLQ2O/CdKWEqQVuAVdO65WBB0M2/5v9FbfRJZlgTL1a6fZdOm60L8EVFRtZl1mSzRN
         lpXQRlmtBNRG3eeemQ0jK7wp0+jAUFxD6LmbFkcGJdN1cRMCXEDIFpgHkfbPC09TroDF
         MOkrvDP+n4vr/5mQg5hD7WWKfCX7exPlczzEcZJB+h1pxQWZFqIrWGeZ9Ubl9o9uvI2X
         4Ady/A9V6ADi78PMsJCEme/6ZkplYHqorKoYRy/wfJ9XEW++pG2XtTzO9QSsFbwF6FhH
         FcM0qQAViW46Hwx9G7s+/8byiIsBF9+i+w8ErT14ZdlAX4ZSR8PZXu4Illr/2i4ax2eN
         CKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DcCZDxr7SMu2ST2bCheW+pTmK2hn1qh9rUqEtH0VUFo=;
        b=ok+s+x6NaGQoJZCy9J46Q5akUJaFhoJxFx4sg0I6KbYiY6b7i3wmgVeGsgFy3gFojc
         IkBrLvhoQuoItK2DH8FCc95POH0PimraT2nA3tKuU8f8Z1n+4+N2Qdf/8naKHY/1EJ5Q
         8OwaKiDbckvW13LpoxLdaoi7Zwkss62KcjOJIkLepojNGjtKEkpGsINXxZIIktXOyTnx
         8QRgO2mnXs7QVJc9d4p/n1DMI6vxo7p56uGR5qzy94tvZlvylXjx9vc31BGjhnR6zUeK
         T/B66oAfWDcgJxEPyvq1o3MOHyOnNtBlxZruB0mKxNX5Xwb9YkTwypjRQFTTxdKa3ORn
         0ohA==
X-Gm-Message-State: AOAM533Sc62J1N0hNn+i95cqvfUe5zSwW1WhRPTdspSjJhZo0AaNafMb
        nvqR12fW/3PD1DeNMZBGbhw=
X-Google-Smtp-Source: ABdhPJzTUl2RXqgh7/qMQVxbAj5Aiu1asHPEJJWP4qPZPg/jkBlMGIyTKf399nxU3h/Rw7buDUr0gA==
X-Received: by 2002:a05:6000:1201:: with SMTP id e1mr56646984wrx.298.1638918431085;
        Tue, 07 Dec 2021 15:07:11 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l11sm988962wrp.61.2021.12.07.15.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 15:07:10 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH][V2] intel_th: remove redundant re-assignment of pointer hubdrv
Date:   Tue,  7 Dec 2021 23:07:09 +0000
Message-Id: <20211207230709.121444-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer hubdrv is being re-assigned the same value as it was
initialized with only a few lines earlier. The re-assignment is
redundant and can be removed.

As Dan Carpenter pointed out, the pointer hubdrv is hub - some_offset
and in this case some_offset is zero. Since hub has already been
dereferenced hubdrv can't be NULL so the NULL check is redundant
and can also be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

---

V2: Remove null check, kudos to Dan Carpenter for spotting this.

---
 drivers/hwtracing/intel_th/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 7e753a75d23b..bf4ee2a31006 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -1048,8 +1048,7 @@ int intel_th_set_output(struct intel_th_device *thdev,
 	 * hub is instantiated together with the source device that
 	 * calls here, so guaranteed to be present.
 	 */
-	hubdrv = to_intel_th_driver(hub->dev.driver);
-	if (!hubdrv || !try_module_get(hubdrv->driver.owner))
+	if (!try_module_get(hubdrv->driver.owner))
 		return -EINVAL;
 
 	if (!hubdrv->set_output) {
-- 
2.33.1

