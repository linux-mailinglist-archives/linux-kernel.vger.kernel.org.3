Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958C4520D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 06:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbiEJEro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 00:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiEJErh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 00:47:37 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF7B293B4B
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 21:43:39 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id b81so7901165vkf.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 21:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ti1foShj1iTCmaM6cyCkyOU/54zgXNg0Z+MWa8lGpwE=;
        b=i/lhJAfNJS1T3aWLg3tEmuSGTRIrdIuOhiYgUtbKa7OvB05xOEzz1aidrZX/3Y0oJ0
         jqhN1asTxqUWsB4my07mpcD1/nsr6tjEgP8aF5a8CnG/rqVKBKKGb9Qg5ptTaupM42Gv
         Ha7nTekckik9jppD3d5sCB8pdC3u8cEwJoaIonkZ8VQtZEHMWuJvqn7VuxM3aBnJEWzg
         piLBIbXG/fmLgpGfP0Uet1w7MdjwkPjDKtWqtdBtuzJcuCBpR7O1enFKsiJQcydn5JJN
         DVGb8Oj8ZPBqIPmvm8qV1YvxbK2OcNZyzLl+zmcwBh+Xt3DeL2TYek7iJYOdVT60yHFf
         09Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ti1foShj1iTCmaM6cyCkyOU/54zgXNg0Z+MWa8lGpwE=;
        b=5tDUUxJHeUWm9FiPgwILgEs+0BWsSyfPo20ry/GyCpm9MWpI7+B4wo/PDmaUy+XjVt
         rFFFxzoanr7K02xY1lCl8ac04GCd6UVKb3x2per+JoJC8awAwoH7c5uCoFSYRqFsrXhV
         ZCKRAie57SOtFcZ4OlkZjtNl88IgMaVfBXi5RxLql7+lmbkKhG65zF4mhhQFT9ao50K/
         99GajcyMT7UOUIr46BD1dJzMN4C69Whnf7diEeb4Cs0TZmn8h7XYEmLrglfRO0LAQNL0
         T75xT6TvSx1jxGBiEkcy11XpUiSLEp6+wTieBftGy8GtQbFQzgp7EJLQ+lcekth9HH8X
         3usw==
X-Gm-Message-State: AOAM531K5xjal/iyBtzt4jAt3oSkW8w1l9NeVTKYh9OI8YCezSYpCko0
        3wfsxSo3UxjPxfxcJq/ssB/ufkzo976vb1H/3uOWsA==
X-Google-Smtp-Source: ABdhPJzfgbaBZyzipWD/FN7OG6uaepNf8E6TvE5ShAOCeemGClqd6HGC02rUdA1hA/BcNZcdHcrfI4VtLYULlmzhdnU=
X-Received: by 2002:a1f:9b85:0:b0:32d:4d56:cf64 with SMTP id
 d127-20020a1f9b85000000b0032d4d56cf64mr11173892vke.31.1652157818664; Mon, 09
 May 2022 21:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <20220501175813.tvytoosygtqlh3nn@offworld> <87o80eh65f.fsf@nvdebian.thelocal>
 <e47bf89c-cee7-3006-5c1b-c76f640c3e23@intel.com> <87mtfygoxs.fsf@nvdebian.thelocal>
 <9fb22767-54de-d316-7e6b-5aac375c9c49@intel.com> <CAAPL-u9UkG1WMQm5u1eAe+4-d04aqVAXc9H0gLSegYoHctkCnw@mail.gmail.com>
 <52541497-c097-5a51-4718-feed13660255@intel.com> <CAAPL-u_G8dzXCjx=xcnemgXGQxwnVUFEy_NJzHsJOHapUm-9Ew@mail.gmail.com>
 <ecb2ab76-8b48-13a6-559a-21f73fcf6cea@intel.com>
In-Reply-To: <ecb2ab76-8b48-13a6-559a-21f73fcf6cea@intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Mon, 9 May 2022 21:43:27 -0700
Message-ID: <CAAPL-u-O5nH-7ira3htQ9pUdb3u5oCRpmcxafL9Abo0kWACXaw@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Yang Shi <shy828301@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

On Thu, May 5, 2022 at 7:24 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 5/4/22 23:35, Wei Xu wrote:
> > On Wed, May 4, 2022 at 10:02 AM Dave Hansen <dave.hansen@intel.com> wrote:
> >> That means a lot of page table and EPT walks to map those linear
> >> addresses back to physical.  That adds to the inefficiency.
> >
> > That's true if the tracking is purely based on physical pages.  For
> > hot page tracking from PEBS, we can consider tracking in
> > virtual/linear addresses.  We don't need to maintain the history for
> > all linear page addresses nor for an indefinite amount of time.  After
> > all, we just need to identify pages accessed frequently recently and
> > promote them.
>
> Except that you don't want to promote on *every* access.  That might
> lead to too much churn.

Certainly.  We should use the PMU events to help build the page
heatmap in software and select the hottest pages to promote
accordingly.

> You're also assuming that all accesses to a physical page are via a
> single linear address, which ignores shared memory mapped at different
> linear addresses.  Our (maybe wrong) assumption has been that shared
> memory is important enough to manage that it can't be ignored.

Shared memory is important.  Special handling will be needed to better
support such pages for linear address based hot page tracking.

> >> In the end, you get big PEBS buffers with lots of irrelevant data that
> >> needs significant post-processing to make sense of it.
> >
> > I am curious about what are "lots of irrelevant data" if PEBS data is
> > filtered on data sources (e.g. DRAM vs PMEM) by hardware.  If we need
> > to have different policies for the pages from the same data source,
> > then I agree that the software has to do a lot of filtering work.
>
> Perhaps "irrelevant" was a bad term to use.  I meant that you can't just
> take the PEBS data and act directly on it.  It has to be post-processed
> and you will see things in there like lots of adjacent accesses to a
> page.  Those additional accesses can be interesting but at some point
> you have all the weight you need to promote the page and the _rest_ are
> irrelevant.

That's right. The software has to do the post-processing work to build
the page heatmap with what the existing hardware can provide.

> >> The folks at Intel that tried this really struggled to take this mess and turn it into a successful hot-page tracking.
> >>
> >> Maybe someone else will find a better way to do it, but we tried and
> >> gave up.
> >
> > It might be challenging to use PEBS as the only and universal hot page
> > tracking hardware mechanism. For example, there are challenges to use
> > PEBS to sample KVM guest accesses from the host.
>
> Yep, agreed.  This aspect of the hardware is very painful at the moment.
>
> > On the other hand, PEBS with hardware-based data source filtering can
> > be a useful mechanism to improve hot page tracking in conjunction
> > with other techniques.
>
> Rather than "can", I'd say: "might".  Backing up to what I said originally:
>
> > So, in practice, these events (PEBS) weren't very useful
> > for driving memory tiering.
>
> By "driving" I really meant solely driving.  Like, can PEBS be used as
> the one and only mechanism?  We couldn't make it work.  But, the
> hardware _is_ sitting there mostly unused.  It might be great to augment
> what is there, and nobody should be discouraged from looking at it again.

I think we are on the same page.
