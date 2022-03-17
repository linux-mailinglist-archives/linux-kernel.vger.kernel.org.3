Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FF04DBC28
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355529AbiCQBTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240599AbiCQBTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:19:37 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B97A1D313
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:18:22 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m22so3665487pja.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oLpYHLZCJ24kas5e3Zof4VJHtpGpyJ5qADfg51D+s5g=;
        b=jHrodcVUG7Sic9BYmXMfR2KV+dEpahvIxiM0XqJ2O8ODqyiQ2VprEQpg7CKT69D/7I
         7M8JivSGfoTy5C10PuX549FF2jhK+OOPOtlVS8BV2UbRLBU3wZ8VNAGieFSD65DqPH0V
         Qi64vMPbimnHuLYOlFDw9GnGUDa0qIGg+e93Sdld2xr1P6RBnaesS2Q1S17XukNGRdTM
         Apv+p4IqDvyt9o5RszKO/FlFY4/q6AnG3P8DlaP7FyQFY/89nr/zExi5mRt1jOUSfyYp
         9SzXxj5N9t2wp+ZfV2BVhrNWYZ+acQ/q+q8+AVgAUcZaUkKLxdfhui9pJN+EwRH/gJG7
         mlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oLpYHLZCJ24kas5e3Zof4VJHtpGpyJ5qADfg51D+s5g=;
        b=oC2c0m9Q5dmlr2ZxYbULvp5UxYuvY695oeW8p3JoPF/1rU+w1yY0d32fOo4hhX8Vsc
         pwRrvE7BiUf6bktoqcog5J6hLQ7Fl2R4KGxuv/7Oomwo3iYC8PlUl5Wt5Q4b7EU4Km3u
         KYGOvqKg0xoSeka4QLx7a8Tl+BXCmDrf7bvY6bo43BDFZoPrqtmVVEmstAZoO9hnT8FP
         jeERtnwHIjge6FFQkIC/V3wBVfqgiScU44xZ10ydDHnwgHljvdlQnmeYuMIPXxg3LhtZ
         5rIBVc/eQX9syP+p3gHtJdZqTKBhDOSllQG37fBXlLDQf67eIj2OaIrh4jlTCP+E62WE
         4xkQ==
X-Gm-Message-State: AOAM532PZo/f8/Zma+gkjIHcNOcXo4he43SQ01kGQpeQ91qbX1P/UpQQ
        Tj/Fo/qxkV8R/xoeJ9wFkAI=
X-Google-Smtp-Source: ABdhPJyuRfZZsKQAHO/ZgPW0lze2VYcegiuiRUJPmNSOIyGL6YVw/v8Qlnh10K08sDnkGOzI39PKww==
X-Received: by 2002:a17:902:e141:b0:153:ec10:4acf with SMTP id d1-20020a170902e14100b00153ec104acfmr783147pla.167.1647479901820;
        Wed, 16 Mar 2022 18:18:21 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t7-20020a056a0021c700b004f7916d44bcsm4593781pfj.220.2022.03.16.18.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 18:18:21 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     mingo@redhat.com
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] sched/headers: remove duplicate include in 'build_utility.c'
Date:   Thu, 17 Mar 2022 01:17:23 +0000
Message-Id: <20220317011723.2134485-1-deng.changcheng@zte.com.cn>
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

From: Changcheng Deng <deng.changcheng@zte.com.cn>

'linux/psi.h' included in 'build_utility.c' is duplicated.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 kernel/sched/build_utility.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
index eec0849b2aae..350e07d87309 100644
--- a/kernel/sched/build_utility.c
+++ b/kernel/sched/build_utility.c
@@ -33,7 +33,6 @@
 #include <linux/nospec.h>
 #include <linux/proc_fs.h>
 #include <linux/psi.h>
-#include <linux/psi.h>
 #include <linux/ptrace_api.h>
 #include <linux/sched_clock.h>
 #include <linux/security.h>
-- 
2.25.1

