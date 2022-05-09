Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A3651F2E6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 05:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbiEIDZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiEIDUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:20:39 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3B78D689
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 20:16:46 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t13so10906393pgn.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 20:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=mGLnYbyWy3fukJswEp9IMLmfe70M5gIojdWHv7IthTA=;
        b=auR+URWKiWFfJyG/fsqIQf0vnL6S0nPYypZ8QzJRZwQmiSPJyqbGlgNV1qJJrnNJb/
         2MtWQaEjw8JHkrOHRI9b+f37Gu8ovmCtYLprcKH8BDVpVGqywxhbg0P4NlNgXxPq+MqJ
         M4IrKCoJeKkGYljyjI1KVc9u0cRqD3KujEuEot3SQndNVKjsdLYO6ENwJLbk6Vwn06iJ
         oFRf9SOJCR36gAjFDvoQhT9bxVwAmunRiqSAgFH3UE2UlJAlXdt/Cc8eJqGzRyumQPoI
         VcwdvOtP6fvfM9lJ1oaDo/fVcf8mFk1z0toapKVrRo8hLQ8xghE8FiZqQ6xkelIwhN4E
         DeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mGLnYbyWy3fukJswEp9IMLmfe70M5gIojdWHv7IthTA=;
        b=zjAtXY3bBbB0yRqHToKB39NebamdUw5S8JtzSBKmL9lAUHdWf+FLL4vBkPMgMeG3z0
         apUC19hbfrI/dHz5+sJJC8Fs3akaAZwQvAQvk7akZZbHTUyM90i65qUTHOk6qc4EFch/
         WpngcY3mh0BjFiEgl38Ad4NKgY00ZAMt0ai+reKbH3fk33w72wxdVkuwj0+wOCRWPSmw
         PsgSAnViKLM9Oh8JRUo+NIIiy02HCTEFym4kEN4C21rfABg3bIE9ySK0dA9S9V4LAjzY
         Fi1Dpn4xaSVCu0ZQmT1oWcBRpmMZO2YH2WOPYqRBXpPbjGByBKrtiPJPrh6rFUDaw3jO
         norw==
X-Gm-Message-State: AOAM5304XaGvDYL6I31qbc2oOvoLVa7xSfomco8I2Lvo1PrF2ssH3Uxl
        FrTddEKSJpY1ninqFeiu/s1IIw==
X-Google-Smtp-Source: ABdhPJzJK0vs7q/AKrPCsKyKNE9M0w84YFSVer5E+6oTuEGz+/2/BjRUesGm3oLMvYB/yIrIzU1SKA==
X-Received: by 2002:a63:1904:0:b0:3c6:3fd3:4c28 with SMTP id z4-20020a631904000000b003c63fd34c28mr11551134pgl.308.1652066206426;
        Sun, 08 May 2022 20:16:46 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id gi2-20020a17090b110200b001d952b8f728sm11531672pjb.2.2022.05.08.20.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 May 2022 20:16:45 -0700 (PDT)
Message-ID: <20b9822d-4a87-c868-1683-30b0a7e97777@bytedance.com>
Date:   Mon, 9 May 2022 11:16:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/2] sched/core: Avoid obvious double update_rq_clock
 warning
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220430085843.62939-1-jiahao.os@bytedance.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20220430085843.62939-1-jiahao.os@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping...

Hi Dietmar Eggemann & Peter Zijlstra,
If you have time, please review these two patches.

On 2022/4/30 Hao Jia wrote:
> These two patches are about the kernel scheduler:
> 
> patch 1: fixed the issue that kernel may trigger WARN_DOUBLE_CLOCK warning.
> patch 2: removed some no longer needed comments in the deadline scheduler
> and cleaned up the code.
> 
> Thanks for suggestion from Dietmar Eggemann & Peter Zijlstra.
> 
> v3->v4:
>     - Modify some code formats and commit messages.
>     - Add Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com> for
>       patch 1.
>     - Add Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
>       for patch 2.
> 
> v2->v3:
>     - Modify some descriptions and errors in the commit information.
>     - Fixed a bug that might trigger the WARN_DOUBLE_CLOCK warning in
>       migrate_task_rq_dl().
>     - Add Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com> for
>       patch 2.
> 
> v1->v2:
>     - Added double_rq_clock_clear_update inline helper to clear RQCF_UPDATED
>       of rq->clock_update_flags.
>     - split into two separate patches.
> 
> [v1] https://lore.kernel.org/lkml/20220418090929.54005-1-jiahao.os@bytedance.com/
> [v2] https://lore.kernel.org/lkml/20220422090944.52618-1-jiahao.os@bytedance.com/
> [v3] https://lore.kernel.org/all/20220427080014.18483-1-jiahao.os@bytedance.com/
> 
> Hao Jia (2):
>    sched/core: Avoid obvious double update_rq_clock warning
>    sched/deadline: Remove superfluous rq clock update in push_dl_task()
> 
>   kernel/sched/core.c     |  6 +++---
>   kernel/sched/deadline.c | 13 ++++---------
>   kernel/sched/rt.c       |  5 +++--
>   kernel/sched/sched.h    | 28 ++++++++++++++++++++++++----
>   4 files changed, 34 insertions(+), 18 deletions(-)
> 
