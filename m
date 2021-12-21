Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0F747C81F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhLUULh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbhLUULb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:11:31 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EA2C061574;
        Tue, 21 Dec 2021 12:11:31 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x15so56633161edv.1;
        Tue, 21 Dec 2021 12:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86w3eyiKacs5uaGphCz79xA1hlTYBtSnubTIMb1PBmo=;
        b=C6NNhnaC5dQsip41C8bA79Pb6VEgDKG+PlB2pjm/+yDzAaZpn9T+tKxOA9AYTqCF+m
         BAnY6S3mKuFr/+0J4XMBpFP1KG6fzgnI6HOqlzef0qC6nvSWSkeLWAw3DPIL4hmsue9E
         j5gXWG8Jxc6YsMLUnzbcP29KjQAk3Bks+xfQonqJLqQowixlivU7BwZech7LWtqwbg/h
         fDVqROqgJmOkSDa7Qo/LCtUaIx8VVorq3v35yOpbIcVdYUdpJIldbJzSIFcb6kG4tLnp
         6pbqur8YM3hhkUDfgS67IIFC/MOHv3RuiUKlIgRSgyYvVCLsbPdXoXbqCJbdJ7S4nSNQ
         kvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86w3eyiKacs5uaGphCz79xA1hlTYBtSnubTIMb1PBmo=;
        b=Nr6zGoVXpNGoAFz7phfAQHo6YLtqGYwwMqSObnf7MaRwBFIFLDWYxHZyO6zQtb1wci
         IKiMwXf9X7jaugLRrMOrwLn9YP5IvWHUdtjROjcuzkKRsnQdIUIJBek3yc0y9pqOAM05
         FDYUlBEtCUCiwn5ePZLjRiDRMmsc7KYSIj/VP9MD2h/h8V+D1oCSEbcbnU8HIe9QElEs
         t5VzGDHhmRiSZG2kpj41K9TIbKKTDXd/Y8rfNqADy9SiDPlMMOK0G2CjVh6t0ttHGSRW
         ppy4rAZzVnsBAkK/v1cpVYeo8ygB0dJGbdSCdUXjb5J1vsF538D+X6FwVPF9FllHgMEM
         d6dA==
X-Gm-Message-State: AOAM53208LG2EAbQRprY8rF/xNnfNn5c2bESvpFdjXvVAkezyiMfHsBx
        Ub7XK2EcXghIpObOp12PFek=
X-Google-Smtp-Source: ABdhPJwHyi9UMUfHXV5nwZ+yYblHiXV94EW7QH/Ab6j80kL0vyUJNb9nggswXNFmDPlMe5OXHmpc+g==
X-Received: by 2002:a17:907:72d1:: with SMTP id du17mr3947583ejc.3.1640117489628;
        Tue, 21 Dec 2021 12:11:29 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id b7sm8648418edj.24.2021.12.21.12.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 12:11:29 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/8] hwmon: (adt7x10) Use devm_request_threaded_irq
Date:   Tue, 21 Dec 2021 22:11:10 +0200
Message-Id: <20211221201113.752827-5-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221201113.752827-1-demonsingur@gmail.com>
References: <20211221201113.752827-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

To simplify the core driver remove function.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/hwmon/adt7x10.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index 2e6e54bf1d15..84e8879d4ca7 100644
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -450,9 +450,11 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 	}
 
 	if (irq > 0) {
-		ret = request_threaded_irq(irq, NULL, adt7x10_irq_handler,
-				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				dev_name(dev), dev);
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						adt7x10_irq_handler,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						dev_name(dev), dev);
 		if (ret)
 			return ret;
 	}
@@ -463,8 +465,6 @@ EXPORT_SYMBOL_GPL(adt7x10_probe);
 
 void adt7x10_remove(struct device *dev, int irq)
 {
-	if (irq > 0)
-		free_irq(irq, dev);
 }
 EXPORT_SYMBOL_GPL(adt7x10_remove);
 
-- 
2.34.1

