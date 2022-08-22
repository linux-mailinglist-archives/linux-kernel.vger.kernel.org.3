Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E740C59BB9C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbiHVI3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbiHVI3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:29:00 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AC91208A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:28:59 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id n24so7853307ljc.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=lH4KCYA0tDYicXuh7eysNLzDATaZ84jOALftQHolB1U=;
        b=aCULbciO1ggeOHcFCOF7CiArmPGsT72MmuExifFcijVPEkTfqd6Fr3pv3wztCwWVwJ
         wlbbR+szm7RgiU0VZMdTdxxIOWUBv93C/M4auYayX65iZKyne1ydwh6VWb2UZqheDnZW
         UzhqAGZLZbPe4dT7wvz70/0WQb6S5AHg7eu42uBtSM5+C4nWFcs8+k7cM7P0o3XPPUQ6
         5OZq8ieXNOUQHEen5C1ZJLa0ks8QiQB9xAHV+OhRWk8HISWY2M2n3JKO7n97JavsVie4
         maeEfFe9WJEWL0F9pcW5T1GRuItWJAkCXIOUDM/XNXoNACgo/X3xd5pgcDXdiHX7n5bE
         AwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=lH4KCYA0tDYicXuh7eysNLzDATaZ84jOALftQHolB1U=;
        b=Pl8DCaZoim6CDw4v270wCAAJab8aFLjn2XREIoLkXm3v4rhpbWw05k8B3QirVvANQ4
         VwA9iWw8JRqgD7B2tphlXvF9h/58LJuikQ/Pw9k0+lUicBcv8JsSP4mqv9ub4bPuIDSo
         EADSgXzkxkNm1322edsZghCAlKj3OrcIqyzgBB7WWl2RzML9o2awauR6YRz7eUGHjKZh
         DoKaFmwEEMQk4RP63CzUsX22TuN3+ffeIOsSNXZpc3iK5bmj3LDHCEHgzw4zerkliy0x
         l9WtYSffbULf2M4ObF+S2ITXWO4CS7WfMAAj3HF1fgu4ZiHnMXB0pryAbXn716oIxGNS
         y2hw==
X-Gm-Message-State: ACgBeo2s2qhcbkC/mEXzPmnLYBe9heWS4SsqmApHPNI4pEU3XPY7Sk2t
        RkHzFa+L7eY55PtiNlrryEZYsaBwvG30CA==
X-Google-Smtp-Source: AA6agR5AlT1cYgjE5rcGRMW+9WUwoDN3OsEZt0iPP9NMLLBErxfokEBMK7hJS0sPyuYPaogox92BYQ==
X-Received: by 2002:a2e:9e50:0:b0:261:bbc4:249e with SMTP id g16-20020a2e9e50000000b00261bbc4249emr4197860ljk.265.1661156936997;
        Mon, 22 Aug 2022 01:28:56 -0700 (PDT)
Received: from jade.urgonet (h-79-136-84-253.A175.priv.bahnhof.se. [79.136.84.253])
        by smtp.gmail.com with ESMTPSA id o2-20020a198c02000000b0048b183d9752sm1813320lfd.211.2022.08.22.01.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 01:28:56 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] tee: fix compiler warning in tee_shm_register()
Date:   Mon, 22 Aug 2022 10:28:46 +0200
Message-Id: <20220822082846.3558520-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include <linux/uaccess.h> to avoid the warning:
   drivers/tee/tee_shm.c: In function 'tee_shm_register':
>> drivers/tee/tee_shm.c:242:14: error: implicit declaration of function 'access_ok' [-Werror=implicit-function-declaration]
     242 |         if (!access_ok((void __user *)addr, length))
         |              ^~~~~~~~~
   cc1: some warnings being treated as errors

Fixes: 573ae4f13f63 ("tee: add overflow check in register_shm_helper()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_shm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 1175f3a46859..27295bda3e0b 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -9,6 +9,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
+#include <linux/uaccess.h>
 #include <linux/uio.h>
 #include "tee_private.h"
 
-- 
2.31.1

