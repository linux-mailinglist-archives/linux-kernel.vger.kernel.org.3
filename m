Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B82584572
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiG1SAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiG1SAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:00:37 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDEB683E6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:00:36 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id o2so1936408iof.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nCov8FRHa/Y3WlCrgO3ByBndA0cH8Dsr76Rv0iqZvhk=;
        b=MFXTorzN9HfVbCWJvb8LnqZJt18x3Jre8H0O+MmqTYbWRYedlH3VQJFqv+fdcQ1J3J
         IIhHqv9gbF7usEeMubH/xq3+4IQZbgPUZ2Do1ZNH57WByFBV2qqVUyoOFRUdAuTNIHwl
         fEtBJ+s+GC02PMzH2/4TG99jBqetQFhS/neRqLn7wM7I/4vhssmTXY9ju5z1sbolK1jL
         DVr8sgdvDvFJbyKdF298oGsNnHJ38ExfMibWh+3rz2GqdFWTBn7P/Hn1MOmFYM3E82Ug
         cbD4zfNz+/1xAVHMcgS4evVpKm8iG+bj7+wn5tOP95RDOq+T3x7HVV0V5d5ggalIsW+h
         NpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nCov8FRHa/Y3WlCrgO3ByBndA0cH8Dsr76Rv0iqZvhk=;
        b=sqW92rUxv444/AB9H4NdUUG+tqODmwLKfI/bdFOY4c5SAhsILt6cmMbqhSd3bZJ+FQ
         qo2Vovc2tQg3WZkoh5gaat0hynb7XYdapVl0GpArb/0pbd+H9fx+bf3GKEVeiQ6vHPtl
         5PwQaIi7s3+CR6psjX6I5xfsiJ79xsZPJo22NNhN/lK6EVSeD2k9Q0t9pl77dtG8ldq3
         ed1HPVwEg+Ko+xYAvw5qOF2v1+95hMdxJbJnisah6KGuAmQWQXl0VBasB0yz+dZwfGT9
         Z41ygqRaL/POYSjH048prgLTFrEn9WaeFVrEq8HxLDOS+lqlvUvNeT3yzLzm4S4U2FSy
         4zvA==
X-Gm-Message-State: AJIora8RQ6f793Oy3NSMy9DNi6d4J97NvKrxgbs0a6GBb5gVDgr27y/f
        N4pVbfzrEJvo24dkBKiGdGsacGolpLMQtaBmo/eTFQ==
X-Google-Smtp-Source: AGRyM1sPIe+RIV+y/3FLq45Y8+1JDmnIKY3tNadQz5QP+aZxYEPXsrlHwk/ygeTsRfDASjnqcNiyO5wLNgqQqlrPqiM=
X-Received: by 2002:a05:6638:2391:b0:341:48b3:29c5 with SMTP id
 q17-20020a056638239100b0034148b329c5mr10970147jat.293.1659031235477; Thu, 28
 Jul 2022 11:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220728121949.20985-1-linmiaohe@huawei.com> <20220728121949.20985-6-linmiaohe@huawei.com>
In-Reply-To: <20220728121949.20985-6-linmiaohe@huawei.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 28 Jul 2022 11:00:24 -0700
Message-ID: <CAHS8izOyzU9D8iTzhe-nbtxfFyhwLur5EHv+z0N5NMTLQobY7A@mail.gmail.com>
Subject: Re: [PATCH 5/6] hugetlb_cgroup: use helper macro NUMA_NO_NODE
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Thu, Jul 28, 2022 at 5:20 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> It's better to use NUMA_NO_NODE instead of magic number -1. Minor
> readability improvement.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  mm/hugetlb_cgroup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 7e0bca52c40f..13ec091385af 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -153,9 +153,9 @@ hugetlb_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>          * function.
>          */
>         for_each_node(node) {
> -               /* Set node_to_alloc to -1 for offline nodes. */
> +               /* Set node_to_alloc to NUMA_NO_NODE for offline nodes. */
>                 int node_to_alloc =
> -                       node_state(node, N_NORMAL_MEMORY) ? node : -1;
> +                       node_state(node, N_NORMAL_MEMORY) ? node : NUMA_NO_NODE;
>                 h_cgroup->nodeinfo[node] =
>                         kzalloc_node(sizeof(struct hugetlb_cgroup_per_node),
>                                      GFP_KERNEL, node_to_alloc);
> --
> 2.23.0
>
