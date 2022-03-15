Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD194DA366
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351432AbiCOTk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351407AbiCOTkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:40:20 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEC727FF6;
        Tue, 15 Mar 2022 12:39:07 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 13so299447qvq.8;
        Tue, 15 Mar 2022 12:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6n/GEXN5lDYLZ4JxfAxl/V57o/OOb9d29VzaUpcLpQA=;
        b=AechcBsRHkC9FhFZuNbA/sO4Tuy863lBtYizhPTaLsA7vMEys8NaWH7RHaAH3i3YnX
         z3YhRd53z1vErumO0rFGcBwk78KLYV7YtNI6nMwaVnmYrFcrtswMV0nYhLIPNqOPChDi
         6Xv2tf2Xav5AECI4FcXDALrtvTN9/Npk6HtPTHJcuXvzQ9/6bN2Gjs2rBOCBIq4KjPl0
         YxgZ7JjtvcM+yAz/Bbb1O4LzrIicf5iaXsx7pA6h4ibw/5LmXcrYPEy1WHVU90xFI0Nt
         vxnkIaX8vDe+JW7zE5bKqTvWYHAhjWFFx6HgY8mIUTGGxmScIWjVW4YbvOCUQDjvGPTx
         lzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6n/GEXN5lDYLZ4JxfAxl/V57o/OOb9d29VzaUpcLpQA=;
        b=KGi/sVyk/C9jiJhIN7guqfk7Dgv21Z3Nh50gu+/MrCsNdXTdU8RXVmmNVnemxe51j/
         1v/7FMk5qKapeVzQVGaATA9e3P8fF7bPh6vGN8/f51FjCzoh6cag0HA4YrNYhXVAvyNs
         e8lVe66IiW9sZy/488x78y1HR1DN5Un/wpZtM86udWBXj/SN4gMA1b/9UFkb+Mn+XncX
         QBVngN9xrt1ehsaip4Pr/wjBqz9+rZV1LQKsyquUuvuQvcfhf7Jn3OMqUHoR8fRHdwqP
         4gxTso+5O6LfkYxVK3RmeiJ8De8NL4xi3wG8dBnbQhshzGS1px6vaCV8MAz25QAEsQYg
         47gg==
X-Gm-Message-State: AOAM532//Pfn5SR0ZYh9iEaVgCnLWcist+c9/Q5GxNDLCGYrq3KSWfsR
        dizdBF9ZyhU5JCEsYDGQucQ=
X-Google-Smtp-Source: ABdhPJw7whkPdA/y1cLsh5cBY3dhhlYpNL/ZKq60sS4Ygc2RxvxnjPZp9tBKybKPBT9qXoeIjIHCtA==
X-Received: by 2002:ad4:594c:0:b0:435:6a5e:ebeb with SMTP id eo12-20020ad4594c000000b004356a5eebebmr22645843qvb.96.1647373146965;
        Tue, 15 Mar 2022 12:39:06 -0700 (PDT)
Received: from ishi.. (072-189-064-222.res.spectrum.com. [72.189.64.222])
        by smtp.gmail.com with ESMTPSA id o4-20020a05620a22c400b0067e02a697e0sm1440798qki.33.2022.03.15.12.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 12:39:06 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [RESEND PATCH 2/6] counter: Set counter device name
Date:   Tue, 15 Mar 2022 15:38:53 -0400
Message-Id: <87cc8eb4c84f49f89290577dc9231b2e4d7d3e8c.1647373009.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647373009.git.vilhelm.gray@gmail.com>
References: <cover.1647373009.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naming the counter device provides a convenient way to identify it in
devres_log events and similar situations. This patch names the counter
device by combining the prefix "counter" with the counter device's
unique ID.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20220204084551.16397-1-vilhelm.gray@gmail.com
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/counter-core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 869894b74741..938651f9e9e0 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -22,6 +22,8 @@
 #include "counter-chrdev.h"
 #include "counter-sysfs.h"
 
+#define COUNTER_NAME	"counter"
+
 /* Provides a unique ID for each counter device */
 static DEFINE_IDA(counter_ida);
 
@@ -113,8 +115,15 @@ struct counter_device *counter_alloc(size_t sizeof_priv)
 
 	device_initialize(dev);
 
+	err = dev_set_name(dev, COUNTER_NAME "%d", dev->id);
+	if (err)
+		goto err_dev_set_name;
+
 	return counter;
 
+err_dev_set_name:
+
+	counter_chrdev_remove(counter);
 err_chrdev_add:
 
 	ida_free(&counter_ida, dev->id);
@@ -247,7 +256,8 @@ static int __init counter_init(void)
 	if (err < 0)
 		return err;
 
-	err = alloc_chrdev_region(&counter_devt, 0, COUNTER_DEV_MAX, "counter");
+	err = alloc_chrdev_region(&counter_devt, 0, COUNTER_DEV_MAX,
+				  COUNTER_NAME);
 	if (err < 0)
 		goto err_unregister_bus;
 
-- 
2.35.1

