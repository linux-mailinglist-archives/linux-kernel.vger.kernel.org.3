Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0626A50C1FB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiDVV5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiDVV4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:56:39 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2215402AC5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:39:19 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id i186so8519698vsc.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=636ibPgFBEDCNtk4r1DwpQyk0v+PRhTEdZcUsDYNVIg=;
        b=sRjkhgqjYM8j6vS5P/KtvB1pENWCXp5ERJZm0ptJnuSLh35evlHXLcp2tHFtyPbkvu
         n42ZGBRzHqTVCF5h7nOsRSQivHEYu24Z8bpDJKu+5Bf4qHpwObEh04fsXTy0PqZbTfgb
         D0zytecyNVQct/JUcnFrDFSutilFOVSJi5M8dUnBg+BjTld6UmgYRArYp5eetd5S2F0/
         ejSrW5DBpXXB1Mh9tTVHom21F71XPL0YzXUjYQr7S6fzNVwyrDsv8ekiQ0LSSkKgy9k8
         Hg7SW5Gtoai9vlWGQq8mkD2bm7ey6gs9+pCLLA9Kt8/Wqo6Q684Oni8eBvVXwDz63grl
         DWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=636ibPgFBEDCNtk4r1DwpQyk0v+PRhTEdZcUsDYNVIg=;
        b=JRmQhwf/dofwLqtpz+znsptkPBDOdymJfnNpRveS9QCudv2ahqEaSLeZ+fNQB8m6zP
         xCSFchSnu9bzfFsjFB2YKwqKpO4Xbl+UcYTbb6J/7K9/Bu/x87X/Ls5cZ3WS4PFUgxC7
         lXU1NZv5iVsW1iaZVf5yMMahvRLkP5jtsQiHChqEfw8t95KNK7j9vEM05ODPjYekTU85
         L22OHy+xYwe0haig94WvQ31K9FFQH6M3eV7W4kJLQED3fncGIh9IaKtluR+f8nPQtbsF
         HMhY4NiGWRVjeNtQh//uwyvoIPzwiGkfwSyPO6eWZXJfMlDqixfMxIEhwPIugSH98lzT
         gTpw==
X-Gm-Message-State: AOAM533ViekwLni2Uf/0bBa1iPYpy/1pZN8ueE2O4Anf8Nbk/18uY0hD
        +lbDX2xwHsMLRlcqaI9KLu/G42Qd3FFLFP91SGpegQ==
X-Google-Smtp-Source: ABdhPJwbPGbnoKceZbheoWAfNjsWNKYJ91xGxsuWJOybpvBayAMeD9nFHp9ALQapbpy/NtsnN8F2ogXlrYWPuRlqWkA=
X-Received: by 2002:a05:6102:3106:b0:32a:18c8:1633 with SMTP id
 e6-20020a056102310600b0032a18c81633mr2082151vsh.51.1650659958845; Fri, 22 Apr
 2022 13:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220422195516.10769-1-jvgediya@linux.ibm.com> <20220422195516.10769-6-jvgediya@linux.ibm.com>
In-Reply-To: <20220422195516.10769-6-jvgediya@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 22 Apr 2022 13:39:07 -0700
Message-ID: <CAAPL-u9yxX=DyYHeS-DS=S47JfW9CQmKmdRLYFOv49C-XSwgCw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] mm: demotion: Build demotion list based on N_DEMOTION_TARGETS
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        dave.hansen@linux.intel.com, ying.huang@intel.com,
        aneesh.kumar@linux.ibm.com, shy828301@gmail.com,
        gthelen@google.com, dan.j.williams@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 12:55 PM Jagdish Gediya <jvgediya@linux.ibm.com> wrote:
>
> Only nodes which has state N_DEMOTION_TARGETS should be
> used as demotion targets, make nodes which are not in demotion
> targets as source nodes while building demotion target list
> so that demotion targets are only chosen from N_DEMOTION_TARGETS.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> ---

Acked-by: Wei Xu <weixugc@google.com>

>  mm/migrate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8bbe1e478122..5b92a09fbe4a 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2366,10 +2366,10 @@ static void __set_migration_target_nodes(void)
>         disable_all_migrate_targets();
>
>         /*
> -        * Allocations go close to CPUs, first.  Assume that
> -        * the migration path starts at the nodes with CPUs.
> +        * Some systems can have DRAM(fast memory) only NUMA nodes, demotion targets
> +        * need to be found for them as well.
>          */
> -       next_pass = node_states[N_CPU];
> +       nodes_andnot(next_pass, node_states[N_ONLINE], node_states[N_DEMOTION_TARGETS]);
>  again:
>         this_pass = next_pass;
>         next_pass = NODE_MASK_NONE;
> --
> 2.35.1
>
