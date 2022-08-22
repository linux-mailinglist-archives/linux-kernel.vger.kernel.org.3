Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3442759B74A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 03:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiHVBil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 21:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiHVBij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 21:38:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4090D13DFD
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 18:38:36 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y4so8627582plb.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 18:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=K7UprDRIIcI1lBn04E49aPjKkq0MqHdFyTOxCUBbGvE=;
        b=d29onEhm91OYy3o9+ePmWmv2+7JpIwwMCfKpunKYrezd3VDEmO2PKd2iIsJ8kLayXM
         xn8iUjKiVhMsDpkihjF2EbJAWg1kndYVuSEFKYfBrdP3WwJq2tItKLTparATI5vk9Alr
         u14AsNsRqGOhw7/FApUFeYE/TR8r2FE6Lw1murnq11bLYFaO2jHK579hdUWzGfcWbmMI
         tgGwDEPVuZcfcKiKFthT3RFWqtcOqtapBMaND3R/+u154qIsdq2bbcUvtGP5cBJq11Tt
         ONdX6ZyiUXl4Hv7YhfN8zkmQkVy2VuidaLSBhir9eU4+smyw297/9YAh2J0LTHGRz7JV
         yx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=K7UprDRIIcI1lBn04E49aPjKkq0MqHdFyTOxCUBbGvE=;
        b=UnnMqcZUOp4wEGdPm5E2ITO8LFcsmo9t07wV2Ji5jxdhMHo8+3eGTqwq5EiIBxFRhG
         dDzCEFoHKoOOxJnFxAZJNGlC8Qq7R10FBGcyzUjId8uS3kZRjKsDuZwfNdBQQaLpo7OZ
         xRmir1O0LJVovMRHiQ8CH3Mb2wMv+FgEDVZxCFXhyUGPKZtKT1imK3VMmrGZjj9Bsc7E
         XIq42+VjhGGZ1rd1CvX6ne3nrdTVLQ9sb+hgbiMwXauQYOzoxOAm2Mu7GDPUKAuarj1u
         MoGAwRcWxVf+CY/LTfQ7E/wOezyxEzQolDt3gPu0FE7y5kt/wJW0UEXqcAhWuNIwfI9Z
         TCrw==
X-Gm-Message-State: ACgBeo19k64XZLJG87GxFifAMILyjtnkKMN8dPf3aX6xFaf82Z45YCJI
        q0EUrcP0Cn0lyG9E1pXczS0=
X-Google-Smtp-Source: AA6agR7sT+0zMr7sSM9aLeDqrNyvdPYvi9pKXGNznYOUScC/7aadUH1MYNjptASgAyPCLb+UfCG1eA==
X-Received: by 2002:a17:902:e3d5:b0:172:a78f:dbc with SMTP id r21-20020a170902e3d500b00172a78f0dbcmr17828611ple.144.1661132315747;
        Sun, 21 Aug 2022 18:38:35 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d5-20020a623605000000b0052b94e757ecsm7258352pfa.213.2022.08.21.18.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 18:38:35 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     42.hyeyoo@gmail.com
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next v2] mm/slub: Remove the unneeded result variable
Date:   Mon, 22 Aug 2022 01:38:30 +0000
Message-Id: <20220822013830.199836-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value from attribute->store(s, buf, len) and
attribute->show(s, buf) directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
v1 -> v2
Add the whitespace between subsystem and summary in subject line.
 mm/slub.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 6953c3367bc2..7bea010a20ff 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5852,7 +5852,6 @@ static ssize_t slab_attr_show(struct kobject *kobj,
 {
 	struct slab_attribute *attribute;
 	struct kmem_cache *s;
-	int err;
 
 	attribute = to_slab_attr(attr);
 	s = to_slab(kobj);
@@ -5860,9 +5859,7 @@ static ssize_t slab_attr_show(struct kobject *kobj,
 	if (!attribute->show)
 		return -EIO;
 
-	err = attribute->show(s, buf);
-
-	return err;
+	return attribute->show(s, buf);
 }
 
 static ssize_t slab_attr_store(struct kobject *kobj,
@@ -5871,7 +5868,6 @@ static ssize_t slab_attr_store(struct kobject *kobj,
 {
 	struct slab_attribute *attribute;
 	struct kmem_cache *s;
-	int err;
 
 	attribute = to_slab_attr(attr);
 	s = to_slab(kobj);
@@ -5879,8 +5875,7 @@ static ssize_t slab_attr_store(struct kobject *kobj,
 	if (!attribute->store)
 		return -EIO;
 
-	err = attribute->store(s, buf, len);
-	return err;
+	return attribute->store(s, buf, len);
 }
 
 static void kmem_cache_release(struct kobject *k)
-- 
2.25.1
