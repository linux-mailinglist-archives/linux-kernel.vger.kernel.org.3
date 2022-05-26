Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3111534D80
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbiEZKjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiEZKjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:39:51 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9011CC16D
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:39:50 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso1420961pjg.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2nB3L+cKWVC+0i7cUASK6ah3sRfXIWNbzDbdAe4fH/k=;
        b=lrOCz4T1Kq/4W3W3DfQN6ue+qXNmVXqTe6fzUsfeA/2NQ36CGyDQmRAHR3iSD8a4X8
         ZOZXWBH7bRSO+cHYu7TugmjR9tcRXkGjOq24Rqtwy9Y2l+4G5PkwLkIDkAwYlsd9Vt4M
         O2RXvTlBe1yrCKrq0jcyifYZ4KFly/6RPyTlJzYdzOwWJoOyN4ahVNBXw84NIM5ln7Sp
         4QP3OAWmHCOZOMvO0VVkWmvSWZ2DPEmO2US4EX+Q6vWRwfnnTZAPYdJl6DL9lt9DWHDe
         4UfH9VORSfwWwzCaFTAarVhRCi7MvEmT4J8ENW5YzRL1CDeOWjGSfrEPeBCU3LWjzcew
         KzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2nB3L+cKWVC+0i7cUASK6ah3sRfXIWNbzDbdAe4fH/k=;
        b=UGCLNUxjwKmHmyeSf0S4ZhdXRc8muA7h0Tl1qxThI+fLVEAwsmPOllq1fObzM95OuC
         Es6BFP9HK4JFsPj0dH/vU4Soj8wqyLPLWoJJZEbRIOHQ4R8TyFK27fMCEkBWNOdQjqHQ
         xrY6tK22EP1O6xVo/ZGnVBWYPeL8MWR+9oEkxsUVO+7jGnK+yJTf17+JCtwvv+vQcqaf
         VzRVKFVdOJSqop0EjWIGXQ+HT8yrkDxDYH35lhxV3gOYe8Lu9WVcMOyF0FkrZ4k+DDF4
         N/oTHIKRrhSRTrSsmE0ak7Fk0EvFFQEj66+3zbfEtRCCkz8Y/H4ZcVCa5n8Pnm/3qb4A
         dzAg==
X-Gm-Message-State: AOAM533y084JYm7cVtEXy6s7lVyo4Wu8Lk+a+mzekjfwY09U0PSd24or
        vJU46CAl02sYlq39QLU5Vjegkw==
X-Google-Smtp-Source: ABdhPJwqmMrK8dU/zABGxmNoJt1CjpCsAmUOcwOZazxgjQ9rXrXLuauYbBMKJBrSd/GHbm4NdNajKQ==
X-Received: by 2002:a17:90b:3142:b0:1df:77f2:e169 with SMTP id ip2-20020a17090b314200b001df77f2e169mr1883385pjb.245.1653561590489;
        Thu, 26 May 2022 03:39:50 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b0015e8d4eb23dsm1257311ple.135.2022.05.26.03.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 03:39:50 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, odin@uged.al
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 0/2] sched/fair: optimize and simplify rq
Date:   Thu, 26 May 2022 18:39:27 +0800
Message-Id: <20220526103929.14976-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This version is based on [1], which try to not put cfs_rqs in throttled_hierarchy
on the rq leaf_cfs_rq_list, simplify the leaf_cfs_rq_list maintenance and
optimize the periodic load decay.

Vincent suggested moving throttled_hierarchy() outside list_add_leaf_cfs_rq()
because the task will not be added in this case which is quite misleading.

When do that moving in propagate_entity_cfs_rq(), I found it has problem
with propagation upwards. So add the fix in the first patch to be easier
to backport, please see the details in its commit message.

[1] https://lore.kernel.org/all/20220427160544.40309-1-zhouchengming@bytedance.com/

Chengming Zhou (2):
  sched/fair: fix propagate during synchronous attach/detach
  sched/fair: optimize and simplify rq leaf_cfs_rq_list

 kernel/sched/fair.c | 87 ++++++++++++---------------------------------
 1 file changed, 22 insertions(+), 65 deletions(-)

-- 
2.36.1

