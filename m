Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1CF52E1FB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344485AbiETBcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344481AbiETBcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:32:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A589AE49
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:32:02 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so10253367pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T/ssDZXDd7/eY1p7k+SveQN0HGUJT39mZvyN4cT8bOs=;
        b=MGDrvFhqVt1UaJVCqugH5mSYTS/PN5XNnCCEu83rTagPjTOjW5FKf8YAGySUgotOpx
         R3egCdeVk0b6TNnmJhK+OHqnSKgSaPkZTwuf4N28K1EclMUtZW2ngCNJ9GKWb1M09NNM
         p6yPYpspcTAIYLpqF9zbExjFFPXIWKrLwE6abB+MJ8B1ktXVMPJtQwAWYC8TOV0MK+vM
         AnXXkajSjSnTpVMukTlLUDEeG1339zUOhmlTBh0CiSenS7giG2aExVZH20O7ZMbfWKJg
         UShqmt0jZQaBtxnWY5z9PYRHcmdXTH3SaTwt0NOP8PeoCITIujj0O0klbRScpYOUoCfw
         6Dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T/ssDZXDd7/eY1p7k+SveQN0HGUJT39mZvyN4cT8bOs=;
        b=DdMW4pelUCm3a2T70lZ6+7O0U7l2ZfTv4TkHMLCYlaWnvBRnMx+BKH+pex+M4MH9aD
         fwyBsPjhQDsqXum8QSZl/c1mOWxkbVzlb+WDGLvZGqg9SuMSJUErhyAtV55gAmfCfm5P
         HmIzLVEhRU7nlsdmoeT2vYpdsKhWQ/6DSxXMTy+BgtQ44X4Atm83zHrBg9DTse5gE8AO
         r6Rm6iGJMr50Zpb4PRGjuVvpXOqb9LMmCh4RHkbBUFNBgI/s4Izz+O3GSxLmbjg43Vy6
         3n598mUxwCgW3F5RpxWrBl/IyqnwxTWl+rVrrUGp6UBEyxTgHVgjxUeVRzebfqnU2yYi
         oasA==
X-Gm-Message-State: AOAM531eu/lBv/q8p65yE4AtZSkCR884IJh6LiTveoEql+bvowYG/k7W
        cA6OfbDUGGkMfPL5TCDTuVXudSctQvA5rXX9nX9l5gHyR0yu7g==
X-Google-Smtp-Source: ABdhPJyUX6MZJuJbZsq4Wq1zFkX71UftjVuEG+BXp3xVM0yqi40RJuUAsM5Ayphy7+jawFiI5Sv+Y1md+q6m85oOssY=
X-Received: by 2002:a17:90b:1d86:b0:1df:f670:dc51 with SMTP id
 pf6-20020a17090b1d8600b001dff670dc51mr1126375pjb.126.1653010321917; Thu, 19
 May 2022 18:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <Ynv7+VG+T2y9rpdk@carbon> <a17be77f-dc3b-d69a-16e2-f7309959c525@openvz.org>
In-Reply-To: <a17be77f-dc3b-d69a-16e2-f7309959c525@openvz.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 19 May 2022 18:31:50 -0700
Message-ID: <CALvZod5pFkm36r1nT2vmUX+Q1hy-MTKaGXOXpcT0Wra1oU=etw@mail.gmail.com>
Subject: Re: [PATCH 3/4] memcg: enable accounting for struct cgroup
To:     Vasily Averin <vvs@openvz.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        kernel@openvz.org, LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 8:52 AM Vasily Averin <vvs@openvz.org> wrote:
>
> Creating each new cgroup allocates 4Kb for struct cgroup. This is the
> largest memory allocation in this scenario and is epecially important
> for small VMs with 1-2 CPUs.
>
> Accounting of this memory helps to avoid misuse inside memcg-limited
> containers.
>
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> ---
>  kernel/cgroup/cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index adb820e98f24..7595127c5b3a 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5353,7 +5353,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
>
>         /* allocate the cgroup and its ID, 0 is reserved for the root */
>         cgrp = kzalloc(struct_size(cgrp, ancestor_ids, (level + 1)),
> -                      GFP_KERNEL);
> +                      GFP_KERNEL_ACCOUNT);
>         if (!cgrp)
>                 return ERR_PTR(-ENOMEM);
>

Please include cgroup_rstat_cpu as well.
