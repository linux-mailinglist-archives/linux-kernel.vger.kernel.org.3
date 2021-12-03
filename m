Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1594672D9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 08:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350233AbhLCHro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 02:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhLCHrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 02:47:40 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE64C061759
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 23:44:16 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id x32so6722430ybi.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 23:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UAVL9gAJ9L8uH+kEA+xjZGKt7HfdI9ctRFtotrW3lBk=;
        b=ib9GmhM7RHt8aAYLVx/Kgn+4sCphD+hO/mq/WH0eps59vJyGA040zGmkt/I2f5wNQO
         q/7qoqL35jF7fImXFJzFCwzsCNAc2I/2epM3ycQjb1OdNc7cW6+emTFAKT5uXZuSTiiE
         LJTQR7ejxp7GMzSCTW5frYCpBvLB0VwVMRoEjogXzKQf5hbqpMZxwhYuOqxhHM5/S33k
         kllBkKI8wNTHL4/PmqMCMNyYqAyg9N8oVxDtKeNUMSpThIIoHhB/yWr5HYgDulgMHCpR
         UEzBcf7JpUqB73tkeKA+hxjkpNjuv9+FIlvPI9bVjLmrUecmIGuWNKniRrHNF5l0JR6K
         P+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UAVL9gAJ9L8uH+kEA+xjZGKt7HfdI9ctRFtotrW3lBk=;
        b=3dQx0juvt+F0KsY8rl71uZZafcJJfqgY2hPvY4sHOrEGCBWq4KULDy7HM6T4EQi3yd
         fi0SDCScSJd6D+chI5AQNWGmmAeZqD63abWUxlh0ogAHA7XnAFj0iTgHbR4vV7bJe/Ge
         r5xPZ2Tc8wYXFuPRcsfExpL0/6e0kqB/agLgazHRUJhwS2j0zCVlmM6AFvrLsyRxB5DL
         NLuGqxEU9ZBagbBELUA4nwcA5h6KngsKZZ1WlDd/6HS/2TLdtj4H/FJVvmqQ8UdCYrkM
         0Bxnt133nhLCcw3SFg10XFp+lupo2xIktdZVS7LCN0ht28wD8c6obpLoNhmfp4evC00F
         IK2A==
X-Gm-Message-State: AOAM532O5o2WeDFUrBIiNA/dalWshoEsvDujrGFfB033ROmC+Qe5xO6x
        vyB5YRQ+tSoxlzFq9iL2RRgFziC2OXAEPZLPOVAs/ktsXmAiqHac
X-Google-Smtp-Source: ABdhPJyU7RtgdFpAiVz5xqahn/qyuv+79mBq3j9EZn5MJCyqHFBNnd+/EJH7t6ORkJIAzd+WWu3ypyX5expzKX/cRug=
X-Received: by 2002:a25:d685:: with SMTP id n127mr20888122ybg.523.1638517456254;
 Thu, 02 Dec 2021 23:44:16 -0800 (PST)
MIME-Version: 1.0
References: <20211203065647.2819707-1-keescook@chromium.org>
In-Reply-To: <20211203065647.2819707-1-keescook@chromium.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 3 Dec 2021 15:43:37 +0800
Message-ID: <CAMZfGtX-V35SbUJ6BE7Psa6dqrbcoyP9ABcjroAn_bO8rQ-6wg@mail.gmail.com>
Subject: Re: [PATCH] hugetlb/cgroup: Fix copy/paste array assignment
To:     Kees Cook <keescook@chromium.org>
Cc:     Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 2:56 PM Kees Cook <keescook@chromium.org> wrote:
>
> Fix mismatched array assignment, reported by an -Warray-bounds build:
>
> mm/hugetlb_cgroup.c: In function '__hugetlb_cgroup_file_legacy_init':
> mm/hugetlb_cgroup.c:850:35: error: array subscript 8 is above array bounds of 'struct cftype[8]' [-Werror=array-bounds ]
>   850 |         cft = &h->cgroup_files_dfl[8];
>       |                ~~~~~~~~~~~~~~~~~~~^~~
> In file included from mm/hugetlb_cgroup.c:23:
> ./include/linux/hugetlb.h:625:23: note: while referencing 'cgroup_files_dfl'
>   625 |         struct cftype cgroup_files_dfl[8];
>       |                       ^~~~~~~~~~~~~~~~
>
> Fixes: e45f4726bcad ("hugetlb: add hugetlb.*.numa_stat file")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
