Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D150253DF76
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 03:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352037AbiFFBn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 21:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiFFBn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 21:43:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DDD48311;
        Sun,  5 Jun 2022 18:43:57 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u12-20020a17090a1d4c00b001df78c7c209so16637848pju.1;
        Sun, 05 Jun 2022 18:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wWxlBe2giDtCo7oDbL9azFDz5P3ZAGti7xLPxv0r0Y0=;
        b=ZvGRiB+8gRkZMDwImgw3R8T8kSCKQirSNzn9vI8TBRy9lRhJWUXXcEimgpF/bi6NIL
         nLQlICWu8kjkou8emQREYIbIogB4XWhkitnQTK/rU3k/Edr2WZVZFkcXp4mO6Dnc7QQ6
         Bapz7uxbrG472Wmczg9qmtEnVMLvsZR4NcRnI8dagRlNo98UbL7hZNKz/Fm7z5dUtqnC
         HdKuR+T2d/CoSQyUpKoECx4E97Focx+P1NRIkdwfDegxAnqDInbvwMmjnIstWnU50mYo
         EKbIVCeSVeZl7XIY4DPtqj6PHKrCxuZnzI3Q1gyoleHF2hzmRqDsa0TkjncG6ZMLxADy
         OmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wWxlBe2giDtCo7oDbL9azFDz5P3ZAGti7xLPxv0r0Y0=;
        b=N4tZj7w1klxTmskUrA9vLAlNDwC4Hz6C6vo6qRPCo8z6xcXBYnMZrg32ZdQm4Y0Mi+
         mjnsWpnwk6Phrj8rvvuzXW4k8Lq1nmCl8pnXOm2FDLUnOSZXIPkyoGm9aK0NdaOlyBzX
         NAFtAMN6CcaAWK74BwS370oqtZKR0hmLKSGNYRp3kAJavX8SOefhAUECzgkNHt1ziRvm
         cG6TRZD0dt6qmvWrkTzSzKYkwUG14kbc7IqTfPR5t5ZbDb1q/KVgWoeM0W0xVDu8TrP8
         Zcs+C6WVPu5fVZLvGIC4eatGItYIJv6SvzaXSmO7cYlHq0xocGGgJCU5faqjj0bwKgtB
         GISA==
X-Gm-Message-State: AOAM533oP8IAkplPzFBg3AKn9pVnFhIue+//1jYdcwGWMqaGqCTlUUlB
        Uj3fuHh3zzQRzlftRx7D2U+V2A2/9IU=
X-Google-Smtp-Source: ABdhPJxb0r/aQKzedv+VX+GLuYDZexJq+UL7AGYoc+lqjAdQYsN0CsWfjiH1jZkHmwL/4CI6jgGFjA==
X-Received: by 2002:a17:902:f789:b0:156:5f56:ddff with SMTP id q9-20020a170902f78900b001565f56ddffmr21730502pln.116.1654479836657;
        Sun, 05 Jun 2022 18:43:56 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902759500b001620eb3a2d6sm9185348pll.203.2022.06.05.18.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 18:43:56 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     gregkh@linuxfoundation.org
Cc:     oneukum@suse.com, olebowle@gmx.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] usb: core: Remove redundant NULL checks before kfree
Date:   Mon,  6 Jun 2022 01:43:52 +0000
Message-Id: <20220606014352.290600-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Checking a pointer for NULL before calling kfree() on it is redundant,
kfree() deals with NULL pointers just fine.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/usb/core/quirks.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index f99a65a64588..7e918e4a95f2 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -56,10 +56,8 @@ static int quirks_param_set(const char *value, const struct kernel_param *kp)
 		if (val[i] == ',')
 			quirk_count++;
 
-	if (quirk_list) {
-		kfree(quirk_list);
-		quirk_list = NULL;
-	}
+	kfree(quirk_list);
+	quirk_list = NULL;
 
 	quirk_list = kcalloc(quirk_count, sizeof(struct quirk_entry),
 			     GFP_KERNEL);
-- 
2.25.1


