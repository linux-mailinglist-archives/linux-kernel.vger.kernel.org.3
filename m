Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605F75426A2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442303AbiFHCAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1836899AbiFGX67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:58:59 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2521DE8C1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 16:47:07 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id h192so10546281pgc.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 16:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xTyvpi/CRKA0ZDhB9x52q5aVKrqnKx4HjDRfGU8RMEU=;
        b=RhcM6qukhvT8pJFmYD+0mUKD5iWzoF5VN8gC6Tr64XQE9Mc990RPHwCJQ0Dm1TSHI0
         i1v5/nMeNtJ1sTNx1X7feZVKvVM5xc0KoNGrVgd1zw8v4hbfe/d0GGgnCXp1bs9Y7bAp
         be+uXA+qs+u8UtQA4YdSBnqz0QTFsgOYFdcga1jqfz+kB6kD/rOTYDVi26HQl34C78QT
         Qv69mncqMNaEwY0ZGEKC9iwgAgq183dsWPEvWtReoG8K9jb/DSKXwrHWzZYk0vvl3TLJ
         avoyFNORUPpA1Q+9WfNI8gKy42nVJVfPH8LoaAbm4wZXMGYIWrr0q6q9PhVJkKn894/t
         JW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xTyvpi/CRKA0ZDhB9x52q5aVKrqnKx4HjDRfGU8RMEU=;
        b=7cZ8SjYAI6sEuN4k1KUMwCv2l+a4vLgMtMPOuiMfZsfU7SZoR9bzvg5plOYr0N3fSz
         xHH/n4Gos4eHmr5Nj8K3F4wdwOhZ5XqNVINB4QKll7KUOiTS9eBBN4nnpAvWZsFgvrjw
         demtRKiXV/XPZdFsfcp6TAuznwyyqd/mdqY8eiyFl9Pjjr/nSzH2D6fTywVy7hqkTcU2
         49Ta2MevdpoXq6CJRV21YoZpacfmZBdCnHPYX+6UD/TGGIbAQofFl3vHetuPG2mCB75C
         hskOWlp6GM6NwnKMrMi880Lx4UWlInw2Atd7+qXS5RiUgdofuC6z1VLs2IghuZf4hf3I
         3mlA==
X-Gm-Message-State: AOAM532AHChYudWLO7PjaCdevHS7N1+lnz/IBKmYdutSGd1V9DXUXXee
        OfueCa04Ep4RwXF154kSeUk=
X-Google-Smtp-Source: ABdhPJwXmky3Mb1g3joIbwT3sQR3nWxYKsMw1MQpZUNSfpVt5QUFs23oawRfNxy+Mb0Yfh8FKDB5bA==
X-Received: by 2002:a05:6a00:1513:b0:51c:3ca8:47a4 with SMTP id q19-20020a056a00151300b0051c3ca847a4mr5537879pfu.48.1654645627188;
        Tue, 07 Jun 2022 16:47:07 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:f30f:4d03:66e6:b121])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b0016203a92865sm7365536plb.107.2022.06.07.16.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 16:47:06 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 7 Jun 2022 16:47:04 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "avromanov@sberdevices.ru" <avromanov@sberdevices.ru>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sooyong Suk <s.suk@samsung.com>,
        YongTaek Lee <ytk.lee@samsung.com>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        Chulmin Kim <cmlaika.kim@samsung.com>
Subject: Re: [PATCH] zram_drv: add __GFP_NOMEMALLOC not to use
 ALLOC_NO_WATERMARKS
Message-ID: <Yp/jeBtxIV/nsMiJ@google.com>
References: <Yp5oDD8mfsGtsSaB@google.com>
 <20220603055747.11694-1-jaewon31.kim@samsung.com>
 <Yp5ZnkYEA5xrUksX@google.com>
 <20220606125939.ae37867e43b8b8b07fa06ca7@linux-foundation.org>
 <CGME20220603055341epcas1p2dd357326eea0cd818daf6f0db7c2aae1@epcms1p1>
 <20220607011702epcms1p10100c4e86e2e0334f7fabbfafa3a0698@epcms1p1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607011702epcms1p10100c4e86e2e0334f7fabbfafa3a0698@epcms1p1>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaewon,

On Tue, Jun 07, 2022 at 10:17:02AM +0900, Jaewon Kim wrote:
> > 
> > 
> >--------- Original Message ---------
> >Sender : Minchan Kim <minchan@kernel.org>
> >Date : 2022-06-07 05:48 (GMT+9)
> >Title : Re: [PATCH] zram_drv: add __GFP_NOMEMALLOC not to use ALLOC_NO_WATERMARKS
> > 
> >On Mon, Jun 06, 2022 at 12:59:39PM -0700, Andrew Morton wrote:
> >> On Mon, 6 Jun 2022 12:46:38 -0700 Minchan Kim <minchan@kernel.org> wrote:
> >> 
> >> > On Fri, Jun 03, 2022 at 02:57:47PM +0900, Jaewon Kim wrote:
> >> > > The atomic page allocation failure sometimes happened, and most of them
> >> > > seem to occur during boot time.
> >> > > 
> >> > > <4>[   59.707645] system_server: page allocation failure: order:0, mode:0xa20(GFP_ATOMIC), nodemask=(null),cpuset=foreground-boost,mems_allowed=0
> >> >
> >> > ...
> >> >
> >> > > 
> >> > > The kswapd or other reclaim contexts may not prepare enough free pages
> >> > > for too many atomic allocations occurred in short time. But zram may not
> >> > > be helpful for this atomic allocation even though zram is used to
> >> > > reclaim.
> >> > > 
> >> > > To get one zs object for a specific size, zram may allocate serveral
> >> > > pages. And this can be happened on different class sizes at the same
> >> > > time. It means zram may consume more pages to reclaim only one page.
> >> > > This inefficiency may consume all free pages below watmerk min by a
> >> > > process having PF_MEMALLOC like kswapd.
> >> > 
> >> > However, that's how zram has worked for a long time(allocate memory
> >> > under memory pressure) and many folks already have raised min_free_kbytes
> >> > when they use zram as swap. If we don't allow the allocation, swap out
> >> > fails easier than old, which would break existing tunes.
> 
> 
> Hello.
> 
> Yes correct. We may need to tune again to swap out as much as we did.
> 
> But on my experiment, there were quite many zram allocations which might
> be failed unless it has the ALLOC_NO_WATERMARKS. I thought the zram
> allocations seem to be easy to affect atomic allocation failure.

I understand your concern but solution here would affect to existing common
users too much.

> 
> >> 
> >> So is there a better way of preventing this warning?  Just suppress it
> >> with __GFP_NOWARN?
> > 
> >For me, I usually tries to remove GFP_ATOMIC alllocation since the
> >atomic allocation can be failed easily(zram is not only source for
> >it). Otherwise, increase min_free_kbytes?
> > 
> 
> I also hope driver developers to handle this atomic allocation failure.
> However this selinux stuff, context_struct_to_string, is out of their domain.
> Do I need to report this to selinux community? Actualy I got several
> different callpaths to reach this context_struct_to_string.

I am not famliar with selinux stuff but if it's common to see the
GFP_ATOMIC failures in the path, I think it should have __GFP_NOWARN
or other solution to allocate memory in advance.
(BTW, I had similar problem before and fixed it with adding __GFP_NOWARN
648f2c6100cf, selinux: use __GFP_NOWARN with GFP_NOWAIT in the AVC)

> 
> Yes we may need to increase min_free_kbytes. But I have an experience where
> changing wmark_min from 4MB to 8MB did not work last year. Could you share 
> some advice about size?

I don't think we could have universal golden value for it since every
workload and configuration are different in their system. Maybe,
your zram size is rather big compared to system memory and swappiness
is rather high for boot.
