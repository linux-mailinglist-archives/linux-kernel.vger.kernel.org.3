Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B39527C3B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 05:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239580AbiEPDMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 23:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiEPDMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 23:12:14 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD4611C01;
        Sun, 15 May 2022 20:12:13 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id k8so11414572qki.8;
        Sun, 15 May 2022 20:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iknl9FGNjcSKriVQ8ROc164iV8qluWzwBBYuxxLunGQ=;
        b=Bsbk8Y0yg5VxbQEpNpD579fQ1Jdbh8Tc00NPMDYN65Kd6bwr6CayognJQIG7jL7Z/o
         MHH5OkbN57AW6FSdXW9EOCyJbg/uQ+hT8uT7ZkSRM3xwsOKsJnjSJQ9MkUKgsU15criK
         NUgjyzxFUT+23G+ri+8Yotz8JKrE9073pl2GUL28wBvelugkksLGfCMPwU5tWLL2le8G
         9fHFnVZOgBInIPTAXJ/fl4YjYGNOHgUStQM5ImS+mOEKCH4PDnaiaZDmDcoo0zYJjTs4
         DaVia075alP46+fk/Cs+S6cmqPxyu2+l+GDl47nPqZagp1tKlMIKGGTBkn26ggmiYh+3
         qC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iknl9FGNjcSKriVQ8ROc164iV8qluWzwBBYuxxLunGQ=;
        b=WadKUsooTwzoqZZTKFaRQD+oTH9U53W4s4dndlqGf0bZBNCu6aWapPcgCT/5NwtGuB
         4pea9cNopzZAB8BzW1rLCzEVVwJdSAlQfPezrtNn/scXcQGeRb/ccwjAZa6oJ6pQ8nDp
         xVTq4w1Gf5FR9xS31APwMD5ML+r3oaZiS0kW9QpbcS8xIoX1CGi7KeIubdb4qbZdt8U+
         Vt7Lac0oSkEv8zFpDIgQOADylooUdDcnv6fwKfZmxB2jHJfTq6dxb//a3OHIhkbRdhJD
         CedVyCqYXES/dKYWWYlFn583ct0gB2S8UetMyDB7iEcWAOh3zg146Qk3f+tlJYtgWSrN
         eC9A==
X-Gm-Message-State: AOAM530CPyqe8AVi/PgM4B1gipf+5+aZ8L5xIsqUj/Goe17qdJNrrDeB
        i5j51SB5b9EVuFHP1aT45/QB3IDeE1/0GYAZ
X-Google-Smtp-Source: ABdhPJxzeagnTfennb3tUjiwr3t6TASF6USpu1oN2N0cKvtXfHTLhLn4KYzsX3gNxz2eFkw9IEiaKQ==
X-Received: by 2002:ae9:df46:0:b0:69f:b616:762b with SMTP id t67-20020ae9df46000000b0069fb616762bmr11030804qkf.600.1652670732521;
        Sun, 15 May 2022 20:12:12 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id 186-20020a370bc3000000b0069fcabfdaebsm4993072qkl.70.2022.05.15.20.12.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 May 2022 20:12:12 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        schspa@gmail.com
Subject: [PATCH v6 2/2] cpufreq: make interface functions and lock holding state clear
Date:   Mon, 16 May 2022 11:02:51 +0800
Message-Id: <20220516030251.42323-2-schspa@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220516030251.42323-1-schspa@gmail.com>
References: <20220516030251.42323-1-schspa@gmail.com>
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

cpufreq_offline() calls offline() and exit() under the policy rwsem
But they are called outside the rwsem in cpufreq_online().

This patch move the offline(), exit(), online(), init() to be inside
of policy rwsem to achieve a clear lock relationship.

All the init() online() implement only initialize policy object without
holding this lock and won't call cpufreq APIs need to hold this lock.

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 drivers/cpufreq/cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index ba73be6f0490..ccb774e02934 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1339,12 +1339,12 @@ static int cpufreq_online(unsigned int cpu)
 		down_write(&policy->rwsem);
 		policy->cpu = cpu;
 		policy->governor = NULL;
-		up_write(&policy->rwsem);
 	} else {
 		new_policy = true;
 		policy = cpufreq_policy_alloc(cpu);
 		if (!policy)
 			return -ENOMEM;
+		down_write(&policy->rwsem);
 	}
 
 	if (!new_policy && cpufreq_driver->online) {
@@ -1384,7 +1384,6 @@ static int cpufreq_online(unsigned int cpu)
 		cpumask_copy(policy->related_cpus, policy->cpus);
 	}
 
-	down_write(&policy->rwsem);
 	/*
 	 * affected cpus must always be the one, which are online. We aren't
 	 * managing offline cpus here.
@@ -1536,7 +1535,6 @@ static int cpufreq_online(unsigned int cpu)
 		remove_cpu_dev_symlink(policy, get_cpu_device(j));
 
 	cpumask_clear(policy->cpus);
-	up_write(&policy->rwsem);
 
 out_offline_policy:
 	if (cpufreq_driver->offline)
@@ -1547,6 +1545,8 @@ static int cpufreq_online(unsigned int cpu)
 		cpufreq_driver->exit(policy);
 
 out_free_policy:
+	up_write(&policy->rwsem);
+
 	cpufreq_policy_free(policy);
 	return ret;
 }
-- 
2.29.0

