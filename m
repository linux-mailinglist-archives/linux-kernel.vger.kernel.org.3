Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBD851E4F4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 08:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445943AbiEGG6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 02:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445902AbiEGG6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 02:58:15 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42995DE42
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 23:54:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id e24so8869889pjt.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 23:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RRa4965RJ8y32BByKAGeELe6oxXld3+6IanDwJTYWnY=;
        b=xNQKDdJP4WbwJcuJABhBBVkZABgGtp/lIpUgcfm4U35ypS+0RPtYoa7EyuOaUS0e99
         5Q5J1qXVN8JrP3Xb1ZYvXZCKvfJiuFGO5eoZDsVx11rO2LvAEXtz9xt0qTLksGz/L4k4
         9eKTTxI2lJR+mi65seLq0E2Q9l5H+VhaXY8SkhgOPvxWWfe4BKYuQfJCieuJ1x0kuYjC
         jeIKxfLH8Fz8iZLmkAWbkbH9AG8zdYR2ESnXCSOHsnU+iCzCWj5Vi7r5jDXBpopFHyVj
         65QaL1taLk1grCv16rfwwrFqoakS5TagNUPQ7Gc22lvIGeuH7TNZK5bAQtQP8L58ebyv
         MLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RRa4965RJ8y32BByKAGeELe6oxXld3+6IanDwJTYWnY=;
        b=1Evx711SHBmXPbv6Ys8bMqSlyJ5V0ZsWdcX6M1tVYigZOzCHTBHXoyeqCV2bNurm73
         VdxpIiOO20xNdaInsEV1vAEM1Ijk0pvFAItmHPnTBnzMdkDiNaAdcLYKRWo+qQBwIf90
         ozCASNd70j3VyP1pWhv5+s6C0rvx/WAjAtIXGdT4vRE/ZQcETvBddA8Bb56z5Thl/tDo
         hsrNbti72vEKTb5lenhxc4/zyrc89og8sorcQMveagzQX9oAmaesG/gmnYCLBQRQlNvH
         DUKAIFdnvgjJwgRiaU8YeMmqtJ+qqN+wXSgYlmWjJZwJF4sryQibEJye7AXuAZLyht6W
         4SBw==
X-Gm-Message-State: AOAM530s8JMCsQdaAs88cVqSaPS0ULb+6nRRyCQh9pzBg+m1Hz+cxxQz
        RMUX9hyh0bPMiDnN7cT6xqoIvBqo5N4hiA==
X-Google-Smtp-Source: ABdhPJy+ytxstxUEpu8mNGXpx9L/zPq4dqAsHosZjVqYEE5lXWnzQpcO+5TlDLudLY7n4T8N+OY7KQ==
X-Received: by 2002:a17:90b:38cd:b0:1dc:1ebe:2c6c with SMTP id nn13-20020a17090b38cd00b001dc1ebe2c6cmr8313033pjb.149.1651906469423;
        Fri, 06 May 2022 23:54:29 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id y20-20020a1709027c9400b0015e8d4eb1ebsm2905162pll.53.2022.05.06.23.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 23:54:28 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     kbusch@kernel.org, hch@lst.de
Cc:     sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 2/3] nvme: introduce smart bits of aen cfg
Date:   Sat,  7 May 2022 14:50:25 +0800
Message-Id: <20220507065026.260306-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507065026.260306-1-pizhenwei@bytedance.com>
References: <20220507065026.260306-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to NVM Express v1.4, Section 5.21.1.11 (Asynchronous Event
Configuration), introduce bit 0 ~ bit 5.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/linux/nvme.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 882ad7523127..e9f1563ab878 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -688,10 +688,21 @@ enum {
 };
 
 enum {
-	NVME_AEN_CFG_NS_ATTR		= 1 << NVME_AEN_BIT_NS_ATTR,
-	NVME_AEN_CFG_FW_ACT		= 1 << NVME_AEN_BIT_FW_ACT,
-	NVME_AEN_CFG_ANA_CHANGE		= 1 << NVME_AEN_BIT_ANA_CHANGE,
-	NVME_AEN_CFG_DISC_CHANGE	= 1 << NVME_AEN_BIT_DISC_CHANGE,
+	/*
+	 * NVMe SPEC 1.4: 5.21.1.11 Asynchronous Event Configuration
+	 * bits 07:00: SMART / Health Critical Warnings
+	 */
+	NVME_AEN_CFG_SMART_CRIT_SPARE		= NVME_SMART_CRIT_SPARE,
+	NVME_AEN_CFG_SMART_CRIT_TEMPERATURE	= NVME_SMART_CRIT_TEMPERATURE,
+	NVME_AEN_CFG_SMART_CRIT_RELIABILITY	= NVME_SMART_CRIT_RELIABILITY,
+	NVME_AEN_CFG_SMART_CRIT_MEDIA		= NVME_SMART_CRIT_MEDIA,
+	NVME_AEN_CFG_SMART_CRIT_VOLATILE_MEMORY	= NVME_SMART_CRIT_VOLATILE_MEMORY,
+	NVME_AEN_CFG_SMART_CRIT_PMR_UNRELIABLE	= NVME_SMART_CRIT_PMR_UNRELIABLE,
+
+	NVME_AEN_CFG_NS_ATTR			= 1 << NVME_AEN_BIT_NS_ATTR,
+	NVME_AEN_CFG_FW_ACT			= 1 << NVME_AEN_BIT_FW_ACT,
+	NVME_AEN_CFG_ANA_CHANGE			= 1 << NVME_AEN_BIT_ANA_CHANGE,
+	NVME_AEN_CFG_DISC_CHANGE		= 1 << NVME_AEN_BIT_DISC_CHANGE,
 };
 
 struct nvme_lba_range_type {
-- 
2.20.1

