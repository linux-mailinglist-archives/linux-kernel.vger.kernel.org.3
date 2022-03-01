Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A19F4C84D6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbiCAHUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiCAHTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:19:55 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3989C1E3EC;
        Mon, 28 Feb 2022 23:19:14 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id a5so12551278pfv.9;
        Mon, 28 Feb 2022 23:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A1lj7LEB75AIU+mhZtWLXPbM8kNEvm/1mDDk0FG6IYs=;
        b=Rciq4IPJmStry+us4STQnTBTmtXlSxYpTIz8rEuJGRFEmxLK3FEgRxjQw0xWxhCZ7M
         JYR06XDsCNZgcye7JBhMoOsvinZEqzb3+/UB8VbNSOgOMg4eDVfGFTbnGijGCn2lbNu2
         kZth8tSXBSabnD3MDGhSsmxcXpMIdA3PaLrFsCMBP8ZEwKAUg6f6swNd3z/vTuFwkDbO
         NB5SQ/0QIiX7QlfapMhZEOxsalmLh9K7ZNjwUSS8QOTwGqeptCCq1PA7EKaoj9ChEjX/
         1ny5Mvfv36DToM5cg7IU0o2ZGcfiSCyI7kQzLW8R73I2KdeGpOQWX+2ZOLX32B9vl5dQ
         ec9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A1lj7LEB75AIU+mhZtWLXPbM8kNEvm/1mDDk0FG6IYs=;
        b=6QV3LoAKJQp0sigT/TlzAvyY5RslEk+zMqcNRf0lM1OEuHL4nOCAa8IJyrq54Unrg1
         113INdUQ9HiNvvDlD0C9BPuMNg3D/BR+Hh3/+AudFnU1ljdbnBAS3W3NXVq6hI6mZxTN
         JIaL/Py51GeNJIKBMAj/8k1WPLd41l3NjhhebByM5dtmS+UD8UwDubRIlgBejkAdukoX
         IKD0dSCm35vYqvvH18M02lpWbIWgxl1gLQk8qKYw6DrFovIMaQCNg3LjAcG0OB8cnhXd
         GDSnHY0RORMzb5Je/Bwdc5ILaNc8AyQd55JBfhoa1cjh1axVJ9xoqlIZNL6RqoTIZuEf
         otAQ==
X-Gm-Message-State: AOAM533/0cBa1hkg/l1u57PHA2pbxLXy6gR7/DuTtTDmXgCtPJo7lcmg
        1qMpgi0QYZLCUQqH1dLJltU=
X-Google-Smtp-Source: ABdhPJzdVAn5YJ22/1qh7uw75lH1QnoryDX1v0cXPLqNGJ+2cWPYVeMF4fypeXkiRX8UCTvqiEwYfA==
X-Received: by 2002:a63:343:0:b0:376:7f43:ec77 with SMTP id 64-20020a630343000000b003767f43ec77mr17555410pgd.320.1646119153804;
        Mon, 28 Feb 2022 23:19:13 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id r15-20020a63ce4f000000b00341c40f913esm12028169pgi.87.2022.02.28.23.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 23:19:13 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] media: atmel: atmel-isc: Fix PM disable depth imbalance in atmel_isc_probe
Date:   Tue,  1 Mar 2022 07:18:59 +0000
Message-Id: <20220301071859.24285-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220105111056.4662-1-linmq006@gmail.com>
References: <20220105111056.4662-1-linmq006@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm_runtime_enable will increase power disable depth.
If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable().

Fixes: 0a0e265 ("media: atmel: atmel-isc: split driver into driver base and isc")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- remove unused label.
---
 drivers/media/platform/atmel/atmel-sama5d2-isc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
index 1b2063cce0f7..7f1ebbb25437 100644
--- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
@@ -559,6 +559,8 @@ static int atmel_isc_probe(struct platform_device *pdev)
 cleanup_subdev:
 	isc_subdev_cleanup(isc);
 
+	pm_runtime_disable(dev);
+
 unregister_v4l2_device:
 	v4l2_device_unregister(&isc->v4l2_dev);
 
-- 
2.17.1

