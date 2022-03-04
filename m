Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B15F4CDCFD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241879AbiCDSyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiCDSyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:54:20 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D1D1BD04D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:53:32 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id z30so5827642ybi.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 10:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bEOxM9dCTwOgx3v/sybpuLomdOANvZM0pQSflYOHu1w=;
        b=i652L4F2GnSj5foPdKPemlgr6xx94ua5Ic9XEX8NWr98rE/J8kp3lucWhLtM4AOES3
         T9r1sjUabt2iScIDVpUdwI7AvcDZFK6NUnb+i966anXeK79MKuuIqPU7cQfPEN83otOC
         mKwkhFqmQ0lI9vTrYAN1FaKXTRwQdjLTY1yTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bEOxM9dCTwOgx3v/sybpuLomdOANvZM0pQSflYOHu1w=;
        b=uFBaPYnCScUil39kAQ2FL0jZSXpYUn0vnQg3iI+LoIaaB0B2e5jFu93ootydc3i7hA
         c1oY7z5pK10+Cfy/T6N2Qw7aFYLfUyUGcpc5t6Mnn6Iv/Ee7NQE4uIlRWfuKu3YqJLtR
         QyItwilzIEd8njWkxNlu11tqJqkAE37yb2Sgv728gBIPAKBrfuFwfIzOdXOUg9DSgDNw
         PMX/sHmXYMzmvoOuaF86Od9QjbqlSIL6k6I7kuApJtLjBaXYSwWticH4ZSELUK4B34YT
         ih5Lady4cuyLGGLcw5uGhiX7IB0Da3MfscaP65bXvNuWkARgCk42WbKtHY2+wg0nH7RL
         S9/A==
X-Gm-Message-State: AOAM530NiYQTYv2FiaFPeuohB/v8ZyJD5hlBalkZrY9+jbVitY+KEPp2
        7YGrUeW1iwC/Oac0wg9pcmCCH5MDddG9tedRjTYeqQ==
X-Google-Smtp-Source: ABdhPJxmeYC7TAv458Sge2scZxXaYjCZnTUCKtizCBToEOesPPQLwrIAjrV205QglSMumtJodE5x7d4SMdWgl+HQSTw=
X-Received: by 2002:a25:bc8:0:b0:628:80d9:526c with SMTP id
 191-20020a250bc8000000b0062880d9526cmr17661448ybl.115.1646420011206; Fri, 04
 Mar 2022 10:53:31 -0800 (PST)
MIME-Version: 1.0
References: <20220304184040.1304781-1-shakeelb@google.com>
In-Reply-To: <20220304184040.1304781-1-shakeelb@google.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 4 Mar 2022 10:53:20 -0800
Message-ID: <CABWYdi0t6W4269g5OMLuLG=SWESDDEDPF-1kv1OKnzua=6=mBQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: sync flush only if periodic flush is delayed
To:     Shakeel Butt <shakeelb@google.com>
Cc:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Frank Hofmann <fhofmann@cloudflare.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Dao <dqminh@cloudflare.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 4, 2022 at 10:40 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> Daniel Dao has reported [1] a regression on workloads that may trigger
> a lot of refaults (anon and file). The underlying issue is that flushing
> rstat is expensive. Although rstat flush are batched with (nr_cpus *
> MEMCG_BATCH) stat updates, it seems like there are workloads which
> genuinely do stat updates larger than batch value within short amount of
> time. Since the rstat flush can happen in the performance critical
> codepaths like page faults, such workload can suffer greatly.
>
> This patch fixes this regression by making the rstat flushing
> conditional in the performance critical codepaths. More specifically,
> the kernel relies on the async periodic rstat flusher to flush the stats
> and only if the periodic flusher is delayed by more than twice the
> amount of its normal time window then the kernel allows rstat flushing
> from the performance critical codepaths.
>
> Now the question: what are the side-effects of this change? The worst
> that can happen is the refault codepath will see 4sec old lruvec stats
> and may cause false (or missed) activations of the refaulted page which
> may under-or-overestimate the workingset size. Though that is not very
> concerning as the kernel can already miss or do false activations.
>
> There are two more codepaths whose flushing behavior is not changed by
> this patch and we may need to come to them in future. One is the
> writeback stats used by dirty throttling and second is the deactivation
> heuristic in the reclaim. For now keeping an eye on them and if there is
> report of regression due to these codepaths, we will reevaluate then.
>
> Link: https://lore.kernel.org/all/CA+wXwBSyO87ZX5PVwdHm-=dBjZYECGmfnydUicUyrQqndgX2MQ@mail.gmail.com [1]
> Fixes: 1f828223b799 ("memcg: flush lruvec stats in the refault")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Reported-by: Daniel Dao <dqminh@cloudflare.com>
> Cc: <stable@vger.kernel.org>
> ---

See my testing results here:
https://lore.kernel.org/linux-mm/CABWYdi2usrWOnOnmKYYvuFpE=yJmgtq4a7u6FiGJGJkskv+eVQ@mail.gmail.com/

Tested-by: Ivan Babrou <ivan@cloudflare.com>
