Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99E64DE9F5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 19:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243812AbiCSSL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 14:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243768AbiCSSLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 14:11:54 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B84E8FE60;
        Sat, 19 Mar 2022 11:10:33 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gb19so9933036pjb.1;
        Sat, 19 Mar 2022 11:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4eyuItiM/A2/gLReN5fqpzJcJZBVqcz5QpX+I81RvDQ=;
        b=ITbEe0spxcop3l4lw8f2wpC83b6CpC/c3HCA2ypD6PvqkKpXl1wnaGJ1EmBSk8Py/D
         udHlBKrBmHneKEIPQQweHCVDaUtOIFR3EnjaGZ5qXMPvMVLG6hGuzM/GHbBXFZosnYb0
         2xe9Mh73bEN5AwPZNZJYQrAb3ryrNG0IRtuDU9W2T8Qq80fosOytRN46rDxtKt8uFErN
         W5qCFYbDnXNcyACG0UFpmTWtH2zroHLvpYF+lVmrk7qngNZ/Zn0tUi+hFgN5+K44SF1G
         LkpezG8ZVBj5Y5xi/lXqck5ZcsJSxtQcoGevlLLFzhWpRBwltOj33qKYpy2yOf6cSmat
         R4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4eyuItiM/A2/gLReN5fqpzJcJZBVqcz5QpX+I81RvDQ=;
        b=fkAEYzpVYdtP4RVa594qG/CbxY1zf49dFbnKQj/aU8RVlfSX0XyGI07g24+8VhIqvJ
         hcZRVVJI2bpxYL7cGXgGNDRHmHoMJUTIbV0WTc9FrO7NiRyJCcE8DJfBumm+yDcUhOku
         cx7jkHRjmvICtBdXhmGJO7gK5EVczemlYW1IKj9L2RpASw1MeSWq2BR9AC332Zp6e8Ko
         IBxdAn36e6XmistfWL7Toe6AFRmn0SwU/KNDd3K6aP3VnCwXk0WCA6+MQJvFmC9UsKi4
         ogyc2pcNIzNIrpAz39CaBlZo/hQKIEagk5XlvJY1DAPd+1pMqMLhdrSzOCVR01+y+5N8
         +uWw==
X-Gm-Message-State: AOAM532V4papImBSfjHLmz2BTOTOB5B49/Om3+m1JLtOofVsKZOL0rYj
        TOokwPCpc76y1B22aC+otks=
X-Google-Smtp-Source: ABdhPJwMDVrPFtyiIIxYdx1qIJwb064CN2ndi0y6LLkfa6zzQB1QDr1FPevzboMZYjw+4eotQcuzcA==
X-Received: by 2002:a17:902:e78f:b0:153:29c8:5395 with SMTP id cp15-20020a170902e78f00b0015329c85395mr5285082plb.55.1647713433068;
        Sat, 19 Mar 2022 11:10:33 -0700 (PDT)
Received: from localhost.localdomain ([115.99.145.231])
        by smtp.gmail.com with ESMTPSA id nu4-20020a17090b1b0400b001bf497a9324sm16413981pjb.31.2022.03.19.11.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 11:10:32 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] iio: accel: bma400: changing scale min and max macro values
Date:   Sat, 19 Mar 2022 23:40:20 +0530
Message-Id: <20220319181023.8090-3-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220319181023.8090-1-jagathjog1996@gmail.com>
References: <20220319181023.8090-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing the scale macro values to match the bma400 sensitivity
for 1 LSB of all the available ranges.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index e938da5a57b4..cfc2c9bacec8 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -83,8 +83,8 @@
 #define BMA400_ACC_ODR_MIN_WHOLE_HZ 25
 #define BMA400_ACC_ODR_MIN_HZ       12
 
-#define BMA400_SCALE_MIN            38357
-#define BMA400_SCALE_MAX            306864
+#define BMA400_SCALE_MIN            9583
+#define BMA400_SCALE_MAX            76669
 
 #define BMA400_NUM_REGULATORS       2
 #define BMA400_VDD_REGULATOR        0
-- 
2.17.1

