Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5DD4711A2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 06:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhLKFRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 00:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhLKFRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 00:17:01 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013A1C061714
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 21:13:25 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id i12so10241207pfd.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 21:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=HPz5KT2mlUOGAVIQewUx7xYrSU7qalaA7GN54BzaQqo=;
        b=kFywBCHA6o5wOc7sB4y95LFCdeTM/ymqUU8kwXwvbZm0AvYB2xxj+YoeFeOccGFGt/
         SwsejP3jCvQQatIiLkKUXMV8MX/pWphygt0o5mbLOWwh811knZXhHUBEWsLN1XHk0AXi
         hNQgkkP0/sc/mrXGyXtqSchJmfGxaQLggXlflAeI56yN+Gg7ZPvQKXYLMQCsJblIs803
         rqZSQBYB9J64lZOJxKeiK/H0T6YkqHpI8vabNI3h3tY0EUZgSZolEWmdrSOINz8fre/J
         SORMlTo4bcOSiFRc4BCSHZ4SRivSnttqZnugpqAdVpNdi0z0RZc33CMFzeqYR702tlhX
         kBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HPz5KT2mlUOGAVIQewUx7xYrSU7qalaA7GN54BzaQqo=;
        b=e7PPk3kowtlebNeLjUyizFCnu78rTKEsasnsqyDg2BgSimhS6ZqmT2vguqzlN9P6A7
         /4CObj3ysBPcNpRxzBk+eVDtzAHtPb5TMEo1Ydyu1D+CodvLAwHljUVnxmYXzqL0a+Ho
         Cq0reG+F9CirsSoQhEATWMwSlbtK7uWxUzgx0ojcxvRm1vPkZrb1F3RtFnTQwrZF2bhz
         YMQGacbuMFHL50lSqymB87s8PrGxmquL1AoyJEeM7LtBA9PQLSSULCqeG7KFQ9k5YmT6
         PukBzNS2IHCj5rtMxvUvkPQCZeC/UNXrBGT53bUFWoVaOZikcePECEjbeb+fdI4+n3ef
         HrEQ==
X-Gm-Message-State: AOAM531lBjw0qkTtJauOG6W/ynxerX44GneFQmsrlKvpPtgxyTVnGkeR
        YDYXINd+ioNb+EMAxxoWwww=
X-Google-Smtp-Source: ABdhPJy/Dpdme6VU3FrIGyQYkZ0873nkd/b/+WDaocU7BTrb6XbofkoMHf0wGJRhBhaTvpTreVfXdQ==
X-Received: by 2002:a63:5f14:: with SMTP id t20mr34299854pgb.382.1639199605443;
        Fri, 10 Dec 2021 21:13:25 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id fs21sm551147pjb.1.2021.12.10.21.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 21:13:25 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: stratix10-svc: fix NULL vs IS_ERR() checking
Date:   Sat, 11 Dec 2021 05:13:19 +0000
Message-Id: <20211211051320.2206-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The svc_create_memory_pool function does not return NULL. It
returns error pointers.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/firmware/stratix10-svc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 29c0a616b317..492c0bd0a76e 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -989,8 +989,8 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 		return ret;
 
 	genpool = svc_create_memory_pool(pdev, sh_memory);
-	if (!genpool)
-		return -ENOMEM;
+	if (IS_ERR(genpool))
+		return PTR_ERR(genpool);
 
 	/* allocate service controller and supporting channel */
 	controller = devm_kzalloc(dev, sizeof(*controller), GFP_KERNEL);
-- 
2.17.1

