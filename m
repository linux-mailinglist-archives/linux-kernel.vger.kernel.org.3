Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5875F59C02A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiHVNHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbiHVNHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:07:21 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C832E9DD
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:07:19 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id j21so15682953ejs.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=OO/3V/9VOGJvCqjEz1HGxPMCQzQjuOzsv8kdhtCYLqw=;
        b=WKfZw4BbbkDUPDHSI/rvUL2ko1UJNDsiGtR2Rh5cY+gXY86FXqXUlpI3YCUa9Zlr95
         doiBj3WMDGjs5d9/HQhF2bOBYcP49NedwUoBAK6EYdEyPHE7KendVPC6BrVHwbnyfcFx
         K+TNRUSQDBEpAZbQ8LtznwcZXmtdHu37gf0Y5rCMZPXi2aA6DfSlyaTVvJgn8ZQx8fga
         2wOnHBR9ICzQ9My0jtClp2igz/nWW5MJG8Z6aaYBSzs9i858RCTtLmJ5IKhzrKaqimLm
         73w91RWcyTLNjvo9LpSWcYRRwOEjB0IneBYAi+bJ5zDoBzHL2JTVWOgzkGwR/6YxNqIU
         rQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=OO/3V/9VOGJvCqjEz1HGxPMCQzQjuOzsv8kdhtCYLqw=;
        b=lHZVsUwABIM0PvUAVS8vvJ20+nQU0MmZcaHAG/yPmHMwXbgpTG99/0Qpi7rFrfZt7W
         skYVIIVbOr7jehZzivh9q99+/WXfVBTIw+cdPE4WuHuwe3KJKGdO71/neV9qvb7R7NNr
         P6sodEPA5hKO9AuMhdQriPCpO+oh8BqlEObMsgcpVV1qWs/HqfAGw+CMNX3ehogwr1Xz
         0+uVpL4fskA4A6EieTK4vH5JUUPGBdVDrCELMfThY7QZ+Le7Utk6A8jhXZup3FNuwrzL
         0RZgur9A1A0lRdo0yf2yamtzQusTKPMtAFOZiPlmNY+Zt9MA2zQw1m4WmvoFQOhnIdoi
         JZXA==
X-Gm-Message-State: ACgBeo3oQncA1yl+hCKfy2ns5dgBDp4Ha6ERLYl6Y34t2fgmddG8lL0D
        WEvS957LNTAnUZ0pov7Z3JtrxgFbloqu66d1L9TNaQ==
X-Google-Smtp-Source: AA6agR4iJXhbaCc+qVUpwZQJ5IVxTKw3KFZnXaT4HwMAEbWZZxGMshLMCOLe/S61KE7DBVu1Bw9DwjntjPtsy/vPZj0=
X-Received: by 2002:a17:907:2e19:b0:730:acf0:4921 with SMTP id
 ig25-20020a1709072e1900b00730acf04921mr12339007ejc.416.1661173637810; Mon, 22
 Aug 2022 06:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220822001737.4120417-1-shakeelb@google.com> <20220822001737.4120417-3-shakeelb@google.com>
 <CACSApvYU5gfbDv9dyaypu1oOPB58eT1inX9EX6gV5b2q3+qr6Q@mail.gmail.com> <CALvZod4r5_vcL4ZcSpR_DdLc_2sppnPTv1DXmFchCULWLu3Riw@mail.gmail.com>
In-Reply-To: <CALvZod4r5_vcL4ZcSpR_DdLc_2sppnPTv1DXmFchCULWLu3Riw@mail.gmail.com>
From:   Soheil Hassas Yeganeh <soheil@google.com>
Date:   Mon, 22 Aug 2022 09:06:41 -0400
Message-ID: <CACSApvbuKfR8r4OHZ-QHTFaWiSSK8NrHWxmM5TvirFSz7F0GGg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: page_counter: rearrange struct page_counter fields
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Eric Dumazet <edumazet@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Oliver Sang <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, lkp@lists.01.org,
        Cgroups <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 12:55 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Sun, Aug 21, 2022 at 5:24 PM Soheil Hassas Yeganeh <soheil@google.com> wrote:
> >
> > On Sun, Aug 21, 2022 at 8:18 PM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > With memcg v2 enabled, memcg->memory.usage is a very hot member for
> > > the workloads doing memcg charging on multiple CPUs concurrently.
> > > Particularly the network intensive workloads. In addition, there is a
> > > false cache sharing between memory.usage and memory.high on the charge
> > > path. This patch moves the usage into a separate cacheline and move all
> > > the read most fields into separate cacheline.
> > >
> > > To evaluate the impact of this optimization, on a 72 CPUs machine, we
> > > ran the following workload in a three level of cgroup hierarchy with top
> > > level having min and low setup appropriately. More specifically
> > > memory.min equal to size of netperf binary and memory.low double of
> > > that.
> > >
> > >  $ netserver -6
> > >  # 36 instances of netperf with following params
> > >  $ netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K
> > >
> > > Results (average throughput of netperf):
> > > Without (6.0-rc1)       10482.7 Mbps
> > > With patch              12413.7 Mbps (18.4% improvement)
> > >
> > > With the patch, the throughput improved by 18.4%.
> >
> > Shakeel, for my understanding: is this on top of the gains from the
> > previous patch?
> >
>
> No, this is independent of the previous patch. The cover letter has
> the numbers for all three optimizations applied together.

Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
