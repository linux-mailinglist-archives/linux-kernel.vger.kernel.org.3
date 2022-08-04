Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F24758996A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbiHDIlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239343AbiHDIla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:41:30 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3146610E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 01:41:00 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso4597951pjo.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 01:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=708QVR8ULFWukUiEUmJH7O0JEBFAFzLzIg7WVeUtPxg=;
        b=OxTUh2nhcrkfShZ1PhvoX3EBXpK17kyGw1s016rcFqCXGbQWqHZrcVnWGjb3IFbA9v
         sxw7RqFxZxuD7tnHhhlhTHFutOskYMTyLTYuwstEhFGA0/sSySkluEG/vpKs+M67ce5C
         2a/mkgV3Dpz58UczXONCpW+m/dOXdjpRRSPnHbluTW4/qJo0sWkGH9FUbgZnZcMbdMtV
         Fif2Tg0ps1kn5PnXk4+IpmittQqYK+iNYeNnk/NJFNB39PrpU7vNpyoYm0BXCNGhvLiJ
         gyQrxc2VorbuLGXOXyBMmSuzIc7fGZNDXyyav92uiwoDUMjnDt8ygGZxl95CaIeIQL3T
         XVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=708QVR8ULFWukUiEUmJH7O0JEBFAFzLzIg7WVeUtPxg=;
        b=DTlmCSihwA7Y5MDZSceB5lC4f08WWfbNG1Krh3ie1JMxhKLJfePR6aQHt3JrBnEraA
         HZ35QjkOD4cYUrjAAVa84uPcpyb0Guk6D3KhyNXPlbBjCNd3U0J39RZJE+VTRxeLLJAc
         YNq+wlCRAQs9i6ewOCm8fWWGvchjg0SKbt2b/fIsfP58fo/StfWhQ+bTYTCxgWLkR0vl
         VMSjHwIT98+NM8QUybSo5e0A76EGjQYDhoQjcwpKBFdt+Kh6Wu/QVldSHZrQDEdYjpDH
         8UqklYFYGowhPZ6NSOWcNCltqn5iPfALMOYTXV/aC6PhEm4gW23TMa7hbgzXHlItK5hI
         3x+A==
X-Gm-Message-State: ACgBeo14q7J3Ry6wQunYcSZQAZj739AnXhExMAtrHlBhEEqqO3CI18is
        jpIQtURddEeGTfk3uQ3EHnyGmyJ3Ed8=
X-Google-Smtp-Source: AA6agR5NtqWTdH7rLWKdq8erbGeQV37dwwisMIYnS/HBxLBXEHfbClNi40x9bRlu0CxNPhE8jc2wTg==
X-Received: by 2002:a17:90b:3586:b0:1f4:d507:783e with SMTP id mm6-20020a17090b358600b001f4d507783emr9180173pjb.171.1659602459295;
        Thu, 04 Aug 2022 01:40:59 -0700 (PDT)
Received: from localhost ([47.254.32.37])
        by smtp.gmail.com with ESMTPSA id s18-20020a170903215200b0016c3affe60esm329613ple.46.2022.08.04.01.40.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Aug 2022 01:40:58 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [RFC PATCH 5/8] workqueue: Use worker_set_flags() in worker_enter_idle()
Date:   Thu,  4 Aug 2022 16:41:32 +0800
Message-Id: <20220804084135.92425-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220804084135.92425-1-jiangshanlai@gmail.com>
References: <20220804084135.92425-1-jiangshanlai@gmail.com>
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

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

worker_enter_idle() is only called in worker_thread() now.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7fc4c2fa21d6..afe62649fb3a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1799,8 +1799,7 @@ static void worker_enter_idle(struct worker *worker)
 			 (worker->hentry.next || worker->hentry.pprev)))
 		return;
 
-	/* can't use worker_set_flags(), also called from create_worker() */
-	worker->flags |= WORKER_IDLE;
+	worker_set_flags(worker, WORKER_IDLE);
 	pool->nr_idle++;
 	worker->last_active = jiffies;
 
-- 
2.19.1.6.gb485710b

