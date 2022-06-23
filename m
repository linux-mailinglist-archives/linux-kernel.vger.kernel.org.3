Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0DC557599
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiFWIgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiFWIgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:36:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D4548E74
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:36:37 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m1so19099262wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbuXZOwI9mYKfaVBHWeOR5IHXlwgx/Q9JGU1SB5W8ho=;
        b=rNE4ypE3Anl7UmSPNciHy5jRgpfNrZqmYhgejf+DhJ21ZTqNYFcI6EHFDTvszTPsPu
         tvXKKnnbMrBtWUBtJI0ZV1ropXJG24/JCKtURLIUSv5dTdE+fC99+azrU0ATqe4hw6cC
         Av386JXtJcDseifMm7xtDk0WYys7VJBM4VJA0AsRkfLmp6s9dw9UCs1CfgJkysPe5ftV
         VNLaBo0jf8JSSH4u+fogIby/mhkfgSvcP9two9vHX60hNA6Bk+uCP+W684ICmKZP8JcO
         vGEqH4BrgYaPbOPEw4B9Q3kIu2CZUopKZa+h9hSv7plPRP/AIK/1KJu+2fAXIOdk+JGK
         Z6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbuXZOwI9mYKfaVBHWeOR5IHXlwgx/Q9JGU1SB5W8ho=;
        b=oIAiPr6Rs4jbWe+rGZ8b9szlthN/3e9M6yCbCOpsgnjnm1RRZ0HsJrOZbtLv5OjetX
         6duj+00CKLrIJ+PtS3UJUTI+9NpIfDsZMeTg6yr6jzsFLUt1VhsyK8rCJrqJ74WGL0ot
         mtYSYRwMOvl4qDLeZQcJWgAPxguvODDdRRK2TQswLMwfvisJe2Be5DwYuZtP1mxUk+Ng
         hv7Sfh2yyPwQborkGEhZl5XdEqrDmhzd2OUp5lywxjn+MaYQGSq5bDrwqP2mBksYs1TW
         zVawndOlhsoqKQ7w/bzWEnRE/EMAYc60xwq3sRMCJoAWTnDulusQPZ/8Hx2IikSIfLaT
         aBdQ==
X-Gm-Message-State: AJIora/W0SXgAFq8+z6/vBjG+l5NqmSQ7x+0XYJxHKRwyCuAjybQjMNO
        t0rkenRY5U7TGm0PykvO978nKUB2pBT7n4Xl2c4ooA==
X-Google-Smtp-Source: AGRyM1uAzkp1Y+NAMZvl5CJxWEOHWfRu/K19SJEsnNSsL8wB4qh8iZ1NWiHdyoBswX/VqG8W+ew/8+Z1cOmNFpAXC24=
X-Received: by 2002:a5d:4308:0:b0:219:e5a4:5729 with SMTP id
 h8-20020a5d4308000000b00219e5a45729mr6988759wrq.210.1655973395694; Thu, 23
 Jun 2022 01:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220623000530.1194226-1-yosryahmed@google.com> <YrQe5A+FXnbgOR1f@dhcp22.suse.cz>
In-Reply-To: <YrQe5A+FXnbgOR1f@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 23 Jun 2022 01:35:59 -0700
Message-ID: <CAJD7tkanavKpKrQr8-jA8pukgD7OY4eOwJRZufJ2NoThD12G+Q@mail.gmail.com>
Subject: Re: [PATCH] mm: vmpressure: don't count userspace-induced reclaim as
 memory pressure
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
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

On Thu, Jun 23, 2022 at 1:05 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 23-06-22 00:05:30, Yosry Ahmed wrote:
> > Commit e22c6ed90aa9 ("mm: memcontrol: don't count limit-setting reclaim
> > as memory pressure") made sure that memory reclaim that is induced by
> > userspace (limit-setting, proactive reclaim, ..) is not counted as
> > memory pressure for the purposes of psi.
> >
> > Instead of counting psi inside try_to_free_mem_cgroup_pages(), callers
> > from try_charge() and reclaim_high() wrap the call to
> > try_to_free_mem_cgroup_pages() with psi handlers.
> >
> > However, vmpressure is still counted in these cases where reclaim is
> > directly induced by userspace. This patch makes sure vmpressure is not
> > counted in those operations, in the same way as psi. Since vmpressure
> > calls need to happen deeper within the reclaim path, the same approach
> > could not be followed. Hence, a new "controlled" flag is added to struct
> > scan_control to flag a reclaim operation that is controlled by
> > userspace. This flag is set by limit-setting and proactive reclaim
> > operations, and is used to count vmpressure correctly.
> >
> > To prevent future divergence of psi and vmpressure, commit e22c6ed90aa9
> > ("mm: memcontrol: don't count limit-setting reclaim as memory pressure")
> > is effectively reverted and the same flag is used to control psi as
> > well.
>
> Why do we need to add this is a legacy interface now? Are there any
> pre-existing users who realized this is bugging them? Please be more
> specific about the usecase.

Sorry if I wasn't clear enough. Unfortunately we still have userspace
workloads at Google that use vmpressure notifications.

In our internal version of memory.reclaim that we recently upstreamed,
we do not account vmpressure during proactive reclaim (similar to how
psi is handled upstream). We want to make sure this behavior also
exists in the upstream version so that consolidating them does not
break our users who rely on vmpressure and will start seeing increased
pressure due to proactive reclaim.

>
> --
> Michal Hocko
> SUSE Labs
