Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDE359651E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 00:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbiHPWGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 18:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbiHPWG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 18:06:28 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536DF72FF8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 15:06:27 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s206so10445739pgs.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 15:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xsBdI6TSxfWyoZQzEtdTKDjNFKRklp/Qj7KShglt0Qk=;
        b=hMnUic3qQq0HLIZNOhUZeDw6iBDDbHjQMKshXUA6XQtPWFUXR1pRy1CGLBGDulkZTt
         jJQMScRHIjExRTDpled6nwJp0I7Fz+e9Cp37Pxni6yVbKuv8ot4lSAvhj60c88kYBi3b
         U3xvmOupwH00xFmN6UgwXm4GJKN3w7/DaQfrPfaf5N7li637MndH2bJxJALWqB2hy3kT
         0e8Uu8fXDQyUpj1ko0EBgsd5vjRjPCggF65QC83j9OqH+grhl58WqiAj35XPfpRNpw1u
         W+rA0vk2SVf8i3NlcOInp6GkfvXLQ3NquCSMzgPZpK8kJU9mFcDloCEkivNoEhDAYDqI
         idXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xsBdI6TSxfWyoZQzEtdTKDjNFKRklp/Qj7KShglt0Qk=;
        b=3gYKm/R5g95YtEYIQtvttU45ocEpzRH1ucqnMyzgRIchtubT8IUjervb5bRgCMljuN
         G/KQYRPn/3dXCpmvhJvZtbQ1gkmNP6DhCx7ziJ+D8Z0f/Om/WMyum5+r2CoTodzpNapl
         AqXUDWKG2KI/Y85pDDoYZgaoF4A1pN+ZQyh5F98Cyf0HfwFZnKii/OQwbRpoxSEBY071
         a1dcjy+f9+84+jcJpCATxbJ4CWV33fUUga+UDAsBgxjhz9OfjQExLKGva6smuytDx43s
         KdW2hMx1VGYOz2Dmp3eLCsnHy/0T58/D9b8tu/c/7JYRJtUU68O2UCsOq7pu3dvSCc7G
         Aoig==
X-Gm-Message-State: ACgBeo2nUFoOC8GdpvkCR2icX9j2XeMLDlmVh5JC3s44S1dbchu4u/Gn
        hX9rii5i7LgeMWiiF/8tiCnEXh5/G5aY8aRXAbmbNA==
X-Google-Smtp-Source: AA6agR66Eb2drsgo0xC0IsiAl2PXcMRX7zfibAHC48aSSjgpYKXqJIogSAcpz1yWsdrnwY/vgyl9I5HjpChP7FKsVkY=
X-Received: by 2002:a65:494b:0:b0:428:d68c:35bf with SMTP id
 q11-20020a65494b000000b00428d68c35bfmr10005680pgs.509.1660687586695; Tue, 16
 Aug 2022 15:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220816185801.651091-1-shy828301@gmail.com>
In-Reply-To: <20220816185801.651091-1-shy828301@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 16 Aug 2022 15:06:15 -0700
Message-ID: <CALvZod5t7Qo1NQ040pRyWco+nJGn3hSrxZyuFQ0UBi31Ni6=_g@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: export workingset refault stats for cgroup v1
To:     Yang Shi <shy828301@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>
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

On Tue, Aug 16, 2022 at 11:58 AM Yang Shi <shy828301@gmail.com> wrote:
>
> Workingset refault stats are important and usefule metrics to measure
> how well reclaimer and swapping work and how healthy the services are,
> but they are just available for cgroup v2.  There are still plenty users
> with cgroup v1, export the stats for cgroup v1.
>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
> I do understand the development of cgroup v1 is actually stalled and
> the community is reluctant to accept new features for v1.  However
> the workingset refault stats are really quite useful and exporting
> two new stats, which have been supported by v2, seems ok IMHO.  So
> hopefully this patch could be considered.  Thanks.
>

Is just workingset refault good enough for your use-case? What about
the other workingset stats? I don't have a strong opinion against
adding these to v1 and I think these specific stats should be fine.
(There is subtlety in exposing objcg based stats (i.e. reparenting) in
v1 due to non-hierarchical stats in v1. I remember Yosry and Muchun
were looking into that.)
