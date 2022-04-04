Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4506D4F1151
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244313AbiDDIuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244363AbiDDIt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:49:59 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24D73BBDB;
        Mon,  4 Apr 2022 01:48:03 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id b130so7750774pga.13;
        Mon, 04 Apr 2022 01:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4A8goeGhaPhZ1beeVbOmqSl7OQXT8O1NS+m0bvoRpjo=;
        b=Z5fOUGpEhMxgb4z/mtIOFAioIea+f/nCbEWUv8Yc6LLoDU5lLJDNnCsq5hFzojhak0
         Cpd/FUmkGKRxZm8OAqAhKgAQvxZc7WWQUMQqWe16bro7kvVcDjmeE8HdAc3xNj2Uc9Z3
         3MKyhPIweU/fiD2Iu5nHmMxT1satV8rgRS0NvN/KSMPMTw9Xtn8fydugpQ3kxsTigncU
         +6KFV45Hw5cXz1Tt6bMiBFJErOKt8U5tsxq9xs/X8aNgAZXjcSL4WDEJIMfU7HrruZJN
         xGklKNJLiDWylzwjOKJpGorgKod+gO4IL8JbhP/zGQ/gzFGsJEd4j516K772rau002Dh
         LB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4A8goeGhaPhZ1beeVbOmqSl7OQXT8O1NS+m0bvoRpjo=;
        b=AwQORM+bQltJ2HNAb+1dLd4Rk7OSmE10Ks0rgtP4nC4JpRPlVx2/o+hDkqswQ8/kWc
         bosv3r+xy0W6YBDwTRy9LscRQOIUpaA5xPqgJ0zgD/FsY2bQz2oehaPNYHBUUrQlN5qx
         zcn4rHOqtSZBSeuM4ynBYXuZ1ZF880pfqu3Ei3Uch7VsHZNj+22QZnGk4XYhulUbfewd
         LSu1WWy3uu/8axOYYh0FJedwU46Yu+TojIuNUiUf4T93da6s500gct/h+ojV9r9hyx3L
         6rIjdi0GOZzRQ7GtM+e7Nbb17Sesup5hpdY+kkbuUl3WaDfhBAuVUJfnXb1roeA9i5iB
         YUtQ==
X-Gm-Message-State: AOAM531WYqv4Nj3kZWpj5IeiHIS4GVGJBBt7htJ66VU0yirGkRkq1W1q
        KK2G/YoGWi4x93F7eZxlerliHvV8ktDgxCUZvw==
X-Google-Smtp-Source: ABdhPJy6JgPINls43h0o9/63+vpTSZFuQEI/lBMSWnAyDFK5g+Sq5Oe+7B9z4yzg4UkAlq/ZDjIVVg==
X-Received: by 2002:a05:6a00:228b:b0:4fa:e12b:2c7b with SMTP id f11-20020a056a00228b00b004fae12b2c7bmr55776235pfe.79.1649062083039;
        Mon, 04 Apr 2022 01:48:03 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090a3fc600b001ca88b0bdfesm3991960pjm.13.2022.04.04.01.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 01:48:02 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 7/7] video: fbdev: s3fb: Error out if 'pixclock' equals zero
Date:   Mon,  4 Apr 2022 16:47:23 +0800
Message-Id: <20220404084723.79089-8-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220404084723.79089-1-zheyuma97@gmail.com>
References: <20220404084723.79089-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The userspace program could pass any values to the driver through
ioctl() interface. If the driver doesn't check the value of 'pixclock',
it may cause divide error.

Fix this by checking whether 'pixclock' is zero in s3fb_check_var().

The following log reveals it:

[  511.141561] divide error: 0000 [#1] PREEMPT SMP KASAN PTI
[  511.141607] RIP: 0010:s3fb_check_var+0x3f3/0x530
[  511.141693] Call Trace:
[  511.141695]  <TASK>
[  511.141716]  fb_set_var+0x367/0xeb0
[  511.141815]  do_fb_ioctl+0x234/0x670
[  511.141876]  fb_ioctl+0xdd/0x130
[  511.141888]  do_syscall_64+0x3b/0x90

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/video/fbdev/s3fb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/s3fb.c b/drivers/video/fbdev/s3fb.c
index 5c74253e7b2c..b93c8eb02336 100644
--- a/drivers/video/fbdev/s3fb.c
+++ b/drivers/video/fbdev/s3fb.c
@@ -549,6 +549,9 @@ static int s3fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	int rv, mem, step;
 	u16 m, n, r;
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	/* Find appropriate format */
 	rv = svga_match_format (s3fb_formats, var, NULL);
 
-- 
2.25.1

