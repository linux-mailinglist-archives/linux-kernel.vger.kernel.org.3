Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDA85134AD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346821AbiD1NTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345315AbiD1NTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:19:36 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08F93B57C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:16:21 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q76so909786pgq.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4sHacRRY30Pjz/1yDqzEFZEb5sFvQXJuqEwbOI0bTMM=;
        b=bdhoqQobFR7Phoi4FdBadzAsDFxVlRJzRLUqNtYQwslvK1G8+kBQQgNoOz9V5grhPR
         aGMqon/MnMfFMmpDc3V+0vBHACYIbRK1xZ1VYNAZuI2JqpDQO2EJ4E0ekZ+6nkaYyV3X
         nC9u/olRR5bZsK1ZleyXfqoveSn5AqFxim3h6t3gPWNGENorYvAWVfzCf2H0vQowNCDj
         4OAZVRpDwZ35BMezaBw0STRq7T9iBz0wVTGanHPROIK6shX7tTyuPos6tA07e4sOqUEU
         cqzhNDjqU6JR5aVRJINiEfZek5MaN/m+PGJUWiXKE1rxiXtP0Yn9OU+8goHRNYMwQ2Rt
         WBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4sHacRRY30Pjz/1yDqzEFZEb5sFvQXJuqEwbOI0bTMM=;
        b=aGGfiiXklemWLgKEw5ZKT+++6DTJ6Xfjifo//LyEpQMfPNK/uYtCAcAjQRtsIp2XA8
         Aca3h1TleD4sCOcoNa+lvRfBah1in0278ogAJQBJ9WtI/yZBM8qNH3RdPFlikyf3uF/D
         xUtHYaeFNbOuaJU5O7OIS4Fv3LZpPvGk++rj2BIE7mHqMrtBgTPWUSQEUPSXQMPxcO0K
         xvfYitccLALZcvmUo96l9B9wMhIt0o+pYIQclsgVfr448T7sqUce4AE+5ZnyYZO+TjlR
         jwaD/fUXSkb0J5MM7yxJYmNjL0ZJJhgRTDXTp0IFQ455d0PooSJ20F+WkOGDkowiqUJy
         e0lQ==
X-Gm-Message-State: AOAM531f+v5S8wiPOREEZ4SGS73bJoeQk6pOF5QBv1QqKFLE7VK5/w0Q
        q2u417MBL0Mg4lB/rRRafP4WXvYI7i9NQxT9t1Ugag==
X-Google-Smtp-Source: ABdhPJwjGR25+7u/Dco2xuOKBKMlJ5UrMQI9ZdCH+mKtqLXMapz0HoQlfYvjco5ruv3cBRoR7nlwSdkWyIqMxhAmszk=
X-Received: by 2002:a63:9502:0:b0:386:3916:ca8e with SMTP id
 p2-20020a639502000000b003863916ca8emr27650809pgd.357.1651151780839; Thu, 28
 Apr 2022 06:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220420055807.GA16310@xsang-OptiPlex-9020> <43598597-72e1-6750-9bee-031fd463fc3b@intel.com>
 <CALvZod4_vNWYxzGR3BksZYgoti-9hOioMGwF2UVRnwcAGpFqXA@mail.gmail.com> <54bcab1b-2c39-9052-2bc4-4a779fe7b27a@intel.com>
In-Reply-To: <54bcab1b-2c39-9052-2bc4-4a779fe7b27a@intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 28 Apr 2022 06:16:09 -0700
Message-ID: <CALvZod6neFJVCs+qwL5CLmaux3iPjRZY6vdvCt-aNsENnObe-w@mail.gmail.com>
Subject: Re: [memcg] a8c49af3be: hackbench.throughput -13.7% regression
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Apr 27, 2022 at 10:12 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>
> Hi Shakeel,
>
> On 4/27/2022 1:02 PM, Shakeel Butt wrote:
> > Can you to comment out the following block instead of the above line
> > and see if there is any impact?
>
> Changed the code as following:
>
> +static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
> +{
> +       mod_memcg_state(memcg, MEMCG_KMEM, nr_pages);
> +
> +#if    0
> +       if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
> +               if (nr_pages > 0)
> +                       page_counter_charge(&memcg->kmem, nr_pages);
> +               else
> +                       page_counter_uncharge(&memcg->kmem, -nr_pages);
> +       }
> +#endif
> +}
> +
>
> The hackbench test result is 147% better:
>
> 086f694a75e1a283 cee08cab8eefaaffdec62343e8d
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>        8691:15      -52942%         750:6     dmesg.timestamp:last
>            :15          13%           2:6     last_state.booting
>            :15          13%           2:6     last_state.is_incomplete_ru=
n
>           1:15          -7%            :6     kmsg.common_interrupt:#No_i=
rq_handler_for_vector
>           2:15         -18%            :6     kmsg.timestamp:common_inter=
rupt:#No_irq_handler_for_vector
>        4656:15      -26039%         750:6     kmsg.timestamp:last
>          %stddev     %change         %stddev
>              \          |                \
>     143619 =C2=B1  4%    +147.0%     354807 =C2=B1  2%  hackbench.through=
put   <------
>     475.91 =C2=B1  4%     -58.8%     196.09 =C2=B1  2%  hackbench.time.el=
apsed_time
>
>

Thanks for testing. We should spend time to deprecate memcg->kmem page
counter instead of optimizing MEMCG_KMEM.

Actually we can deprecate kmem page_counter usage, limit and failcnt
easily by replacing them with memcg_page_state(MEMCG_KMEM),
PAGE_COUNTER_MAX and 0. The kmem.max_usage_in_bytes would be a bit
tricky.
