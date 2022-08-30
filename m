Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5E95A597C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 04:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiH3CmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 22:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiH3CmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 22:42:14 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F7F7A74F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:42:13 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p7so2556186lfu.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=p1rCUVVOx3EtRRRfoxbwmNUBHiId3GOW3+wZvEDaYcY=;
        b=TYlpK7Cdl6vprclxB7keOnBZeV1p1z/gL/XVk9MveYIetBsLqBLhQStTg7EblQLiik
         k1Ml9TiGc0fd3etLqxNriyETRIg5IVd+bS+zXwVnj2aRpIekJX96LwX34HT3RcA4BTuw
         JHdOvwPRA1qnqGoxL1pH7pyqNT3bgG88I5C0zT87Cn86oJKhzdd7XQEsVS4mpZ2vRTRC
         umOYmytqjl91gpEABkiabJkC9Luz8jltpl9ulang/vonNqfxT6kgadCNoj83yTXVj3Tf
         1S3/sUvi2uSKMod9Jw20vtL5I/sj6+Z8LZRf2fpJNFUJwGQqbooK+6bcZscs0IwLXl0s
         5+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=p1rCUVVOx3EtRRRfoxbwmNUBHiId3GOW3+wZvEDaYcY=;
        b=hAlNgjKucyynxgRmCxCaH0bqjGhDhsWF84Y+PXBoymUxnpG4d3mtRLMZ9OcOnQQddz
         GuvAltjqu6yO3fTV3+gnLySYhYeJ20AugC8Mmc3RIrHnAj9gn4LDzQWBKeSrIMQ7jiM2
         6v+t+NORvZ8vbZBGArgHD/0PwAht+ogaGJcjszwtf+GN9JSb6qmcKehCwEVOMF/fXq+g
         f45OZpjVW+Hu28qanUAPuug509fdbVaALgjQwIYYaHCfkkHSRUXDJHbGVFtR03nrG3AY
         Tnp0dyYzu/rG2Ki1B1t0A57x76qaSI+YyPF/765C8NUrfDVoL6wmcUukO91MERbsvMlc
         5sxw==
X-Gm-Message-State: ACgBeo1Uql02SLDIQhYuJSIuDGY+Ct2vAI1vRAa72qKqIxYwCROE200p
        cHAIsfm48em1YqxfUEl0fdmmg0OssIOlnb3+Rfx7DTWJ4fU=
X-Google-Smtp-Source: AA6agR5+jUF2Ty12b+dONg9eCjxYohU7sTVXvt6uHwYeuTt72x4xwGfvu921skeEOOlWO+r8mFb3OmZbYgJamb4j2HI=
X-Received: by 2002:a05:6512:e99:b0:492:db20:efd7 with SMTP id
 bi25-20020a0565120e9900b00492db20efd7mr6675342lfb.468.1661827331338; Mon, 29
 Aug 2022 19:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <1661483530-11308-1-git-send-email-zhaoyang.huang@unisoc.com>
 <CAGWkznH=Gwr_TDF3=fv+_ZH5P4QN6JXEAtH4DAzNus20pHxyeg@mail.gmail.com> <12759ac7-4a6c-89fa-5fd0-914728f6415e@redhat.com>
In-Reply-To: <12759ac7-4a6c-89fa-5fd0-914728f6415e@redhat.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 30 Aug 2022 10:41:43 +0800
Message-ID: <CAGWkznEtFp2+1QLFF-mA0_jhfB48n4oneVXXNvipw3eBYji4kw@mail.gmail.com>
Subject: Re: [PATCH] mm: skip reserved page for kmem leak scanning
To:     David Hildenbrand <david@redhat.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Mon, Aug 29, 2022 at 8:19 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 26.08.22 05:23, Zhaoyang Huang wrote:
> > On Fri, Aug 26, 2022 at 11:13 AM zhaoyang.huang
> > <zhaoyang.huang@unisoc.com> wrote:
> >>
> >> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >>
> >> It is no need to scan reserved page, skip it.
> >>
> >> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >> ---
> >>  mm/kmemleak.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> >> index a182f5d..c546250 100644
> >> --- a/mm/kmemleak.c
> >> +++ b/mm/kmemleak.c
> >> @@ -1471,7 +1471,7 @@ static void kmemleak_scan(void)
> >>                         if (page_zone(page) != zone)
> >>                                 continue;
> >>                         /* only scan if page is in use */
> >> -                       if (page_count(page) == 0)
> >> +                       if (page_count(page) == 0 || PageReserved(page))
> > Sorry for previous stupid code by my faint, correct it here
>
> Did you even test the initial patch?
>
> I wonder why we should consider this change
>
> (a) I doubt it's a performance issue. If it is, please provide numbers
>     before/after.
For Android-like SOC systems where AP(cpu runs linux) are one of the
memory consumers which are composed of other processors such as modem,
isp,wcn etc. The reserved memory occupies a certain number of
memory(could be 30% of MemTotal) which makes scan reserved pages
pointless.
> (b) We'll stop scanning early allocations. As the memmap is usually
>     allocated early during boot ... we'll stop scanning essentially the
>     whole mmap and that whole loop would be dead code? What am i
>     missing?
memmap refers to pages here? If we can surpass these as it exist
permanently during life period. Besides, I wonder if PageLRU should
also be skipped?
-                       if (page_count(page) == 0)
+                       if (page_count(page) == 0 ||
PageReserved(page) || PageLRU(page))
>
> --
> Thanks,
>
> David / dhildenb
>
