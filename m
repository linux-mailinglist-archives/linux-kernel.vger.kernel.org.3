Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95E45AE119
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiIFHa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIFHaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:30:24 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEABB183A4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 00:30:22 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id x10so11335402ljq.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 00:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=DiSpmFkHopXEMzzo8GEVfCCu3wvcb3PHuqr/MihPiik=;
        b=Suy9xaG0hDq6pQIqD17PejsNfIIVQ1gI46mV663jKAw1v93lFaPhwY9IXY8ghDVxKy
         d9DJginmJWkDWy7YLyofcSmFzx5yNI46hnqeFDJ0ZiYHX8g4Z3syWLNSsEvIYTl5svws
         5eUaITyEljNt+AdQViAPPPIbkgxUeWRQ6pZtP7XE/tDfRMaflkFeMvCuiu4pbMtgh6tz
         mOLeTB3S/UIWTFRvxPjR16iKNah2ZXHtbHPzx5w7kssmGwGre5C4qQXwhXE9UgwPiSOz
         4yHIe9K45Ytj9KeRxBMRtLnYaIw8vhxVdMSWHLKkhZgZQoh9qOSQN65BUQXgvNMNLWcB
         HdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DiSpmFkHopXEMzzo8GEVfCCu3wvcb3PHuqr/MihPiik=;
        b=6D8AOkbinjjghML58nQrOiYtit8S3lbRUODSijK0cNlJ7nzsDqwCY4GQ663ubx5RtL
         5qn27AEGG6EB4IIk7zRoK6gVsp/F+x4XGRpBRhDhYem9IXFs3d4XGzkTFyH6fFhjrGyJ
         1CqFE5/ByL4yW3/8RrYhwk98RdNZamW7qZelyYw6wJq/XFqLhPzz4TO2kjrxG3+jmJOD
         kLhIBNvVEp2B/hsM1ksjZZmhBTIj7b5A6Esi4aWiSNpDOGO9lf7OiwVjZjHFTdlzxvzk
         leLMYLbet7FDkT87oWjDKBYjwaFfHOnPLWO9ss2Ev28Djp9K6MobWGd0FBaU5EDkVzib
         P/0A==
X-Gm-Message-State: ACgBeo2hoEjAWiuNBSxN3JpZchuFzpZFaGC1aGzQFC4kQO/VKcWPpStp
        RLyqkZy1AaeqWLGQqcioMlNvSBXmKuLo0kLxcg153G48ecQ=
X-Google-Smtp-Source: AA6agR4t+tu3ZAd8IIAOVS0YvuOjTmZsbQrd1ilWJTHuJQPtGKs9Z7gCq7sk1u98aeMMci/idTKSyrQKZwEnHC+WP8I=
X-Received: by 2002:a05:651c:2203:b0:26a:44ad:706c with SMTP id
 y3-20020a05651c220300b0026a44ad706cmr3414950ljq.359.1662449421133; Tue, 06
 Sep 2022 00:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <1662116347-17649-1-git-send-email-zhaoyang.huang@unisoc.com>
 <20220902115839.1e3fafd159e42d4e7dae90af@linux-foundation.org> <YxJUxDn5v2MqmjKM@casper.infradead.org>
In-Reply-To: <YxJUxDn5v2MqmjKM@casper.infradead.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 6 Sep 2022 15:29:52 +0800
Message-ID: <CAGWkznHzCnjUUjceAvj_E_WCSwGP5_SoGYDeKaHL9dTeUinEBQ@mail.gmail.com>
Subject: Re: [Resend RFC PATCH] mm: introduce __GFP_TRACKLEAK to track
 in-kernel allocation
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 3, 2022 at 3:08 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Sep 02, 2022 at 11:58:39AM -0700, Andrew Morton wrote:
> > Cc willy for page-flags changes.
>
> Thanks.  This is probably OK.  The biggest problem is that it won't
> work for drivers which allocate memory and then map it to userspace.
> If they try, they'll get a nice splat, but it may limit the usefulness
> of this option.  We should probably document that limitation in this
> patch.
>
> > On Fri, 2 Sep 2022 18:59:07 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:
> > > +++ b/mm/page_alloc.c
> > > @@ -1361,6 +1361,8 @@ static __always_inline bool free_pages_prepare(struct page *page,
> > >             page->mapping = NULL;
> > >     if (memcg_kmem_enabled() && PageMemcgKmem(page))
> > >             __memcg_kmem_uncharge_page(page, order);
> > > +   if (PageTrackleak(page))
> > > +           kmemleak_free(page);
>
> Don't we also need to __ClearPageTrackleak()?
ok
>
> > > +   if (gfp & __GFP_TRACKLEAK) {
> >
> > And we'd want __GFP_TRACKLEAK to evaluate to zero at compile time if
> > CONFIG_HAVE_DEBUG_KMEMLEAK=n.
> >
> > > +           kmemleak_alloc(page_address(page), PAGE_SIZE << order, 1, gfp & ~__GFP_TRACKLEAK);
> > > +           __SetPageTrackleak(page);
> > > +   }
>
> We only set this on the first page we allocate.  I think there's a
> problem for multi-page, non-compound allocations, no?  Particularly
> when you consider the problem fixed in e320d3012d25.
Please correct me if I am wrong. AFAICT, the leak_object is created
for tracking from page_address(page) to page_address(page) + PAGE_SIZE
<< order via checksum of the whole area while not referring to
page->cnt. Non-compound high order tail pages will not be checked
anymore since the leak_object has been freed together with head page
by put_page, whereas, it would not be a problem as the tail pages
should NOT be accessed also as they should be considered as buddy
pages, no?
>
> I'm not opposed to this tracking, it just needs a bit more thought and
> awareness of some of the corner cases of the VM.  A few test cases would
> be nice; they could demonstrate that this works for both compound and
> non-compound high-order allocations.
