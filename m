Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D57055CD14
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbiF0Qhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239545AbiF0Qh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:37:28 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829671114B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:37:26 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id p136so11487539ybg.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M2vRONC13amhSE1W+iisI+raE+PvPU52ESA4pnszZg8=;
        b=UEcpkmCqZthqdDmCcJb/GHcW0WYvQnSCthVpaKsdmJhtGXLqN7CSupnYP/T9EPiFCT
         dpWNdyhfR++Q5OkhmkqsGWC8xP+zsLjqe1hZEPiTRDPwzXUixzZdYN+OrQiKxHD6+YND
         syqoKAJUsXT0A6UFFYH6qKrCaYiRvAEakeCdLDH8ogsyCp24jeLat9pAf8A3f5Kaa916
         Ne+P4JzkAkzuD8jViCtMZRJ9dzBpqQSf0OwuZA8SljXz57Vy4S+6COF26L6Jk7HDX7m7
         cflaOdwbvTx9eRoOi8K6EYa7WK7WZCXi9s387y7i3owFFtCUK9XdXU/EVohHplY0b3pr
         tt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M2vRONC13amhSE1W+iisI+raE+PvPU52ESA4pnszZg8=;
        b=brSwXHfmoXrb5XM3KBziBYyPN4+4NlRTMWbtHUYfzrLK1uSeQJz4RHoE7lRAJ8JT6C
         WqWOP4w6zAx6rgAg1AevzgOLScfewI5GS93c7ZBb9QnOvodJZm4I9W+Jf/Iq1wE13DQf
         +pIjXnkgfJOik1l/rmDcHvSYhsjhsU5+wOdhD4x1AT+fx1hSi472FXYG60G9H0UZREWx
         Wc9xQER9AIXcbMS613jxV8Ozo/LoJxmbicvTtW3IZu75/U+fkjeypxDDbnpeaD2Eo/u0
         vZorigfI08kRpGrMAhNXgJU8B9APKrxYo86m9uDygnMo3k+r2YP2bv2hoWN8H770HlGc
         /Seg==
X-Gm-Message-State: AJIora9rtBmsqR/Kwrxwxuxh2ymHfVQCFF4ZcCXeizTRjTKwOjXat4Jh
        RgHwg212Tj7rDsrKrA9+XX8LletmG1uXUMdGjVinmg==
X-Google-Smtp-Source: AGRyM1sTPM7jj4zDy93zPEKtxPXKrzDkCiWDP4UO0S1kmWgyzlhK983F6Y8r4ItcgcZqCrhSji4lQVe3yDiErQ+njmI=
X-Received: by 2002:a25:83cf:0:b0:66b:c7e5:faf with SMTP id
 v15-20020a2583cf000000b0066bc7e50fafmr14517036ybm.288.1656347845647; Mon, 27
 Jun 2022 09:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <4e685057-b07d-745d-fdaa-1a6a5a681060@openvz.org>
 <0fe836b4-5c0f-0e32-d511-db816d359748@openvz.org> <c516033f-a9e4-3485-26d9-a68afa694c1d@openvz.org>
 <YrSP25ebDmXE+kPS@dhcp22.suse.cz> <CALvZod4WsmrpfZtfnP4AmvtnkvBRngXXGyhM6+aQzkdfjsinAQ@mail.gmail.com>
 <YrXDV7uPpmDigh3G@dhcp22.suse.cz>
In-Reply-To: <YrXDV7uPpmDigh3G@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 27 Jun 2022 09:37:14 -0700
Message-ID: <CALvZod6U8DvMUcuUNfpQRwfkevQB7=nP4ZLA2gWGNf_JGdyARQ@mail.gmail.com>
Subject: Re: [PATCH mm v5 0/9] memcg: accounting for objects allocated by
 mkdir, cgroup
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vasily Averin <vvs@openvz.org>, kernel@openvz.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>
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

On Fri, Jun 24, 2022 at 6:59 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 23-06-22 09:55:33, Shakeel Butt wrote:
> > On Thu, Jun 23, 2022 at 9:07 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 23-06-22 18:03:31, Vasily Averin wrote:
> > > > Dear Michal,
> > > > do you still have any concerns about this patch set?
> > >
> > > Yes, I do not think we have concluded this to be really necessary. IIRC
> > > Roman would like to see lingering cgroups addressed in not-so-distant
> > > future (http://lkml.kernel.org/r/Ypd2DW7id4M3KJJW@carbon) and we already
> > > have a limit for the number of cgroups in the tree. So why should we
> > > chase after allocations that correspond the cgroups and somehow try to
> > > cap their number via the memory consumption. This looks like something
> > > that will get out of sync eventually and it also doesn't seem like the
> > > best control to me (comparing to an explicit limit to prevent runaways).
> > > --
> >
> > Let me give a counter argument to that. On a system running multiple
> > workloads, how can the admin come up with a sensible limit for the
> > number of cgroups?
>
> How is that any easier through memory consumption? Something that might
> change between kernel versions?

In v2, we do provide a way for admins to right size the containers
without killing them. Actually we are trying to use memory.high for
right sizing the jobs. (It is not the best but workable and there are
opportunities to improve it).

Similar mechanisms for other types of limits are lacking. Usually the
application would be getting the error for which it can not do
anything most of the time.

> Is it even possible to prevent from id
> depletion by the memory consumption? Any medium sized memcg can easily
> consume all the ids AFAICS.

Though the patch series is pitched as protection against OOMs, I think
it is beneficial irrespective. Protection against an adversarial actor
should not be the aim here. IMO this patch series improves the memory
association to the actual user which is better than unattributed
memory treated as system overhead.
