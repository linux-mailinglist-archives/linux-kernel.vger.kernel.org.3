Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9B250DE53
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbiDYK7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238526AbiDYK7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:59:19 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76E520F55
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:56:14 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c1so10414042qkf.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oDOO1VMKAFSvRA+jbY7XrQpvEA7oAfz0Z+1NK5bO8FY=;
        b=KJv8igdiiZufNLVMSZZt2ISU+Ufbg4Y5Wc23m64y3yHYylsk1aSmkpHZEMSSWlATOM
         7YmTFBoMEurJd3ZCoqvMos0FO1E7htItiRpACDs/fc3t8ymL4m2T6Iwfvna33QX2kp8l
         wiR3wqc7xaD6VXY1knNCL5/T5X8kpj5ldDmGDwiw5btgHuXsaUqiHnB3bohg7kpWIu6s
         vBERqsW6/nhYrzIhiOiLIG2NMJZUkjJ6J27c7B4GSOzagtvopS4otR5wyX90Ybq10TYa
         Zv83lqtpNPsyVgHdhrjPT2b7hcMbAQKpZSugd7lS3gc+VYdrx3NZSnC+g2zI3ewNGMLb
         zwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oDOO1VMKAFSvRA+jbY7XrQpvEA7oAfz0Z+1NK5bO8FY=;
        b=k5fPcb36EfASSPtVIRmBAwEEHtobbimy3YaKND0zunbgExqABQbkV9s7eAwVuZ4StC
         YrLaXLnyLy4MAbVQBWvRp7kpNNOvIXBKesqi6zYnstN/AmOMQXjmaRGeD4u6nCxKrsyX
         hdAv5wfUqYEXiyboYG0P2l7hkT0VH16y5xgOL5VryaZkyiMFIFtpOGEupVWsx8zyPCeG
         NKRwT67GR4GBS/uiQqoV10oQBOt+F24OGz086WIS40C5Dc9MLwH54xqp+eSLO0m9DIQ1
         zCpBqIIndmcu++SfBI5t00Y1whL77nNCQdZm3ACAJwo3TEcXb6aRERLqxNkDgHEoXE/A
         pJYg==
X-Gm-Message-State: AOAM533HfWJ7cawX5fNkXQxp9dCHsmrbdmnwQAkDFfSr3mONuTpku3yi
        h2t3vwmJrC09wrr9VyuxqNk=
X-Google-Smtp-Source: ABdhPJwKYoo+D+f18HGcHSdbt3nOkwr+JitifQR9BtifSH2hLs5zSHXuEoBrb3IEnL05jkz7fvBhHw==
X-Received: by 2002:a05:620a:408e:b0:69f:5b92:8356 with SMTP id f14-20020a05620a408e00b0069f5b928356mr2206864qko.562.1650884173222;
        Mon, 25 Apr 2022 03:56:13 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id r7-20020a05622a034700b002f337000725sm5870146qtw.42.2022.04.25.03.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 03:56:12 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ndtest: use kobj_to_dev()
Date:   Mon, 25 Apr 2022 10:56:07 +0000
Message-Id: <20220425105607.3515999-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Use kobj_to_dev() instead of open-coding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 tools/testing/nvdimm/test/ndtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 4d1a947367f9..b32ee76e0c17 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -725,7 +725,7 @@ static DEVICE_ATTR_RO(format1);
 static umode_t ndtest_nvdimm_attr_visible(struct kobject *kobj,
 					struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 	struct ndtest_dimm *dimm = nvdimm_provider_data(nvdimm);
 
-- 
2.25.1


