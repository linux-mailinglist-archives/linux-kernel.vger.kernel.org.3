Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC884526720
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382408AbiEMQdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382401AbiEMQct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:32:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCE227159
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:32:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h16so11447493wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImbON6V8wU257CZMiPPax7JLE068/EVToU8GSEhgawc=;
        b=O243YbdfW0Jg4H1gGwYCZGx0z3CmKLaaqmC5kZpdtydkh22CmMPPj1txC9sqebmXog
         cin6gCGiXkChH/iixFvUb0MCNs47y3VonDbYdhc19L/LntVohrthJLNcZ0TYAoN57Ckp
         o09thapGF2/jCB66jv+7j9EjLuOdvTPXyqhvdNYpuEQoQIOpAVzXI5jdfIDLyIia7+mf
         KGFzzvxHXd0K8fe9u3C4Wtx+1ldskL/AflYjdoxlOOPV6XFg+IHV+9M+FESsy3HQACha
         +/nR7lhC1a1BcaJO0Ot7JnHtIKzLg38WUO9rf3syo03P2e6aM9DRo3489EJEJmtRYzCf
         affw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImbON6V8wU257CZMiPPax7JLE068/EVToU8GSEhgawc=;
        b=KL0BwFZ+xHnjS+bR+CSEpf5nmHidw91v4EStmlVOPJBQLGwe2p1+dTnEPK8JFV7Pog
         2s0eDcuglRzmwXZIYAgrrr8wExoY+WAlUtkudIjXKtYr/amuxxBamBlBVa4ZMqojil4u
         cyvQO+i6DZYq2jLWaiHr/mJjn8abNL2AjQFIR/zlKlv880pOXSpJ+nYWkK8+PEW7mfAQ
         O8BjotGgu2hq0KUZnMj6Hwep0qPWjn2B/O0Ytl3wyZ3WSJqu5czl4blUy8sdkdwXvQD9
         1M9eOKiaO87wDEWndCwAsdUs1H8U4n8pptzaCDQ2KXYZAY7g/Lt/nvZ6c3fGVlnhnzX3
         7wfQ==
X-Gm-Message-State: AOAM5323x7o+Ufkeycord3fX2lQuFPPKmBWCCmXyjuGyJc40Tki4uji5
        13TvuHtNgRnqoPz5AvQSys7uuewaaambfd+UC/F1+A==
X-Google-Smtp-Source: ABdhPJzaSBuvg9v5enW5ednG0dsVQhfVdaVjCnZHVnrTU3q3IBGQB458BwmYH6gtv6/MhFwKY5nnfuzEH7IIezYWqZI=
X-Received: by 2002:a05:6000:1f1b:b0:20c:9ea8:b650 with SMTP id
 bv27-20020a0560001f1b00b0020c9ea8b650mr4752087wrb.300.1652459566460; Fri, 13
 May 2022 09:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220513151554.1054452-1-kan.liang@linux.intel.com> <20220513151554.1054452-3-kan.liang@linux.intel.com>
In-Reply-To: <20220513151554.1054452-3-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 13 May 2022 09:32:33 -0700
Message-ID: <CAP-5=fVv-f2JpWxOrHUFa73P-6z8JAR-+dcmL8MfYgLhpxe4zA@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf stat: Always keep perf metrics topdown events in
 a group
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        zhengjun.xing@linux.intel.com, adrian.hunter@intel.com,
        ak@linux.intel.com, eranian@google.com
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

On Fri, May 13, 2022 at 8:16 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> If any member in a group has a different cpu mask than the other
> members, the current perf stat disables group. when the perf metrics
> topdown events are part of the group, the below <not supported> error
> will be triggered.
>
> $ perf stat -e "{slots,topdown-retiring,uncore_imc_free_running_0/dclk/}" -a sleep 1
> WARNING: grouped events cpus do not match, disabling group:
>   anon group { slots, topdown-retiring, uncore_imc_free_running_0/dclk/ }
>
>  Performance counter stats for 'system wide':
>
>        141,465,174      slots
>    <not supported>      topdown-retiring
>      1,605,330,334      uncore_imc_free_running_0/dclk/
>
> The perf metrics topdown events must always be grouped with a slots
> event as leader.
>
> With the patch, the topdown events aren't broken from the group for the
> splitting.
>
> $ perf stat -e "{slots,topdown-retiring,uncore_imc_free_running_0/dclk/}" -a sleep 1
> WARNING: grouped events cpus do not match, disabling group:
>   anon group { slots, topdown-retiring, uncore_imc_free_running_0/dclk/ }
>
>  Performance counter stats for 'system wide':
>
>        346,110,588      slots
>        124,608,256      topdown-retiring
>      1,606,869,976      uncore_imc_free_running_0/dclk/
>
>        1.003877592 seconds time elapsed

Nice! This is based on:
https://lore.kernel.org/lkml/20220512061308.1152233-2-irogers@google.com/
You may end up with a group with the leader having a group count of 1
(itself). I explicitly zeroed that in the change above, but this may
be unnecessary. Maybe we should move this code to helper functions for
sharing and consistency on what the leader count should be.

Thanks,
Ian

> Fixes: a9a1790247bd ("perf stat: Ensure group is defined on top of the same cpu mask")
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/builtin-stat.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index a96f106dc93a..af2248868a4f 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -272,8 +272,11 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
>                 }
>
>                 for_each_group_evsel(pos, leader) {
> -                       evsel__set_leader(pos, pos);
> -                       pos->core.nr_members = 0;
> +                       if (!evsel__must_be_in_group(pos) && pos != leader) {
> +                               evsel__set_leader(pos, pos);
> +                               pos->core.nr_members = 0;
> +                               leader->core.nr_members--;
> +                       }
>                 }
>                 evsel->core.leader->nr_members = 0;
>         }
> --
> 2.35.1
>
