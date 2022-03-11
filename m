Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CD24D565B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 01:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344695AbiCKAKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 19:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiCKAKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:10:37 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C73E33B8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 16:09:35 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id b37so3025400uad.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 16:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KKinXJt7hCI4YpcWmOz6K5DlvGxO13aibVS8plGZoac=;
        b=HqX+58LeRiyJ+PCpXDzYP5OEeCLu5dtyp+co5T4+ZSilbM/f/SuTyjR/SP5bq59Qje
         NYcX25WKgHXZ7PNbCD+j6iamM/KYFiq87pv9laSQydiTUaVkWdWBOL8O7VL5I/iQtT9r
         FDGvPa/3t0WOBLSafpitmkfSrZB3/mW3aphHPPlHNz05DljBZ3DuozCDGJSsvgRkA/W3
         AzU1i1dkD4LVMUUI/BLlEVswagAzDBwpK+fmYbh1jYiRkTc7uCVBegSKSNnUzZploBMO
         wgdVfKk4l0YBvSpGa3nXIddYza4tfmO3p7JqdnzggMQgnms0/2cZUvYp3RRkMrj241nk
         C7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKinXJt7hCI4YpcWmOz6K5DlvGxO13aibVS8plGZoac=;
        b=4uWrrbvGCS7EvwZ3yIctI0pL7Iw+moplldtYhsEf1XUOZwq5L8SgNHB3nA7x55hz9S
         LavEWMJ6QzQz3CJyjptDh2E/QPUaVtTXH7an0S4KHtpW17CFhBuXedB15Cc+FWBd+k5j
         7McLUjAALRSDIGUVnveubCPI7Rtiqs5uba1pceBXDWGP1XSDCS5ESkOPIl1ls+lE5W2y
         0D2Rf1OjJCQ2iD9k7bkAJnyg/kvk/yrObARDf5dag36IsZyg3c6zM6TXfMhUdvPrXxn+
         N07hFpWPVUBqzMSa8Vot9gzlfG9jm1YS9OqirA7os/puixrXIUpvwGVVq2U8Ow8nlQb5
         t/Wg==
X-Gm-Message-State: AOAM531G8w8RSu3jXSErX2NdJELOxpIKP3aCS9Jm//fs3BHcTvoCaS7u
        fh8rY46fEBeOuFSt02CdzIv2KuitCJmkBqj6ag6fGA==
X-Google-Smtp-Source: ABdhPJyb6rTtf+blMbaJtCSG6M567B8/H8bDzy2b/FCzeVtcsifwkglVog4fG17ucBsnOxmlRf+HGHL/HFVCdu14FhY=
X-Received: by 2002:ab0:4d52:0:b0:34c:41ce:275b with SMTP id
 k18-20020ab04d52000000b0034c41ce275bmr3638164uag.19.1646957374015; Thu, 10
 Mar 2022 16:09:34 -0800 (PST)
MIME-Version: 1.0
References: <dd620dbd-6d71-7553-d1e9-95676ff12c82@nutanix.com>
 <YiKsUr1FQwmDP7V0@google.com> <CAOUHufZyrLrkEvFay+FddN5Ve3v_-JvNROHo9hEhsoVuCpwh0Q@mail.gmail.com>
 <YiX2HcF5o2IjfX1H@dhcp22.suse.cz> <Yim+aOCyfwLrqYWi@dhcp22.suse.cz>
In-Reply-To: <Yim+aOCyfwLrqYWi@dhcp22.suse.cz>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 10 Mar 2022 17:09:22 -0700
Message-ID: <CAOUHufZ3MfDSuN4x_2wqGpc5aaKGm840KUKX6KPfvp3OcJbjTg@mail.gmail.com>
Subject: Re: Regression of madvise(MADV_COLD) on shmem?
To:     Michal Hocko <mhocko@suse.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>, dancol@google.com,
        Shakeel Butt <shakeelb@google.com>, sonnyrao@google.com,
        oleksandr@redhat.com, Hillf Danton <hdanton@sina.com>,
        Benoit Lize <lizeb@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
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

On Thu, Mar 10, 2022 at 2:01 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 07-03-22 13:10:08, Michal Hocko wrote:
> > On Sat 05-03-22 02:17:37, Yu Zhao wrote:
> > [...]
> > > diff --git a/mm/swap.c b/mm/swap.c
> > > index bcf3ac288b56..7fd99f037ca7 100644
> > > --- a/mm/swap.c
> > > +++ b/mm/swap.c
> > > @@ -563,7 +559,7 @@ static void lru_deactivate_file_fn(struct page
> > > *page, struct lruvec *lruvec)
> > >
> > >  static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
> > >  {
> > > -       if (PageActive(page) && !PageUnevictable(page)) {
> > > +       if (!PageUnevictable(page)) {
> > >                 int nr_pages = thp_nr_pages(page);
> > >
> > >                 del_page_from_lru_list(page, lruvec);
> > > @@ -677,7 +673,7 @@ void deactivate_file_page(struct page *page)
> > >   */
> > >  void deactivate_page(struct page *page)
> > >  {
> > > -       if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
> > > +       if (PageLRU(page) && !PageUnevictable(page)) {
> > >                 struct pagevec *pvec;
> > >
> > >                 local_lock(&lru_pvecs.lock);
> > >
> > > I'll leave it to Minchan to decide whether this is worth fixing,
> > > together with this one:
> >
> > There doesn't seem to be any dependency on the PageActive anymore. I do
> > remember we have relied on the PageActive to move from the active list
> > to the inactive. This is not the case anymore but I am wondering whether
> > above is really sufficient. If you are deactivating an inactive page
> > then I would expect you want to move that page in the LRU as well. In
> > other words don't you want
> >       if (page_active)
> >               add_page_to_lru_list
> >       else
> >               add_page_to_lru_list_tail

Yes, this is better.

> Do you plan to send an official patch?

One thing I still haven't thought through is why the A-bit couldn't
protect the blob in the test. In theory it should be enough even
though deactivate_page() is a NOP.

1. all pages are initially inactive and have the A-bit set
2. madvise(COLD) clears the A-bit for zero-filled pages (but fails to
change their LRU positions)
3. the memcg hits the limit
4. pages in the blob are moved to the active LRU because those pages
still have the A-bit (zero-filled pages remain inactive)
5. inactive_is_low() tests true and the blob gets deactivated???

The last step doesn't make sense, since the inactive list is still very large.

Thanks.
