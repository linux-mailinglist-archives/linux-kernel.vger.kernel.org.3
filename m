Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A095053F144
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbiFFU7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbiFFU7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:59:09 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A506C56C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:48:14 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so13568822pjq.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AlPPNyvR7lWFI2X/TgyXlnC9vx00TL5Vm+xNvpSSNoA=;
        b=onq/TWloM+5cXdpjwh/6inxOthaxTkEiG/j5wDpdk6g/TQkcp9a0A+cafRzZH35+AM
         ZM78epWv+TGXUvh1aF99og/sdEOHYj9PPDmcP6q+Sk3A/vtzuJ9yJfhssR6P7u1CpRLp
         cUMJsu8Kp0AoqeSUW1gKx0cD5FcaEVuyLAm6U2EV5DuEcbJkMPMIzCpDBo0/uw2TqMlB
         NkFVawwE6H/O7ifHQ4ahzFWZIubIh2RrBNturvuIQ/95QzXagP5JXv3trzWsVWnGBsPi
         AlrkyUFxg8++9C9cXcLpL4GS5GodMQGQeODET7T6YwVNABW4h9qluL7f9ni/DSuPrJzq
         uO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AlPPNyvR7lWFI2X/TgyXlnC9vx00TL5Vm+xNvpSSNoA=;
        b=qTMBjs+ZAcu6md3tqYCTAC1o9qk13KplzDm0Mv+/0rKB/sSgLCOXJvETrO9XG0wMwk
         V1dhj1e36gyQ2vL4tYQL+Tkm0WQVsCSr1u27KGkOHz6lWR1a+UltJnPOhb9kddB3W98H
         X29aU1+4km2b2zBzXD50NkZNFx3/9vnpkgIprh76bUamGu7xxHILPuzUJ3re7zRwjaRi
         S79zxxx1YfPAnHZB6ewcPHdDPY8FKsWNN1AhA4YtRioP3Q8Zjr9TRRzLE9g1zio/KS6l
         7b9N1FtMCTM7IAPMU0BzpRMLwxjWs6ayPJdNme8nzAV73kX+haVhwK+/sRjLMkMg/GFi
         pkUg==
X-Gm-Message-State: AOAM532d3YdG1dwfBo6VJ4kBMyEAabvxzlwU94zXRWK+X5l6j+WuNpiO
        v/s7f9Zi3k+Rl/Zjl8LKf1k=
X-Google-Smtp-Source: ABdhPJxgji6mfqhBbxL3JBchT6aASnEZ9yodH/o/YTvmACsIhcerFsRvM1Xm+fzxjamxFo0x3EBZ+w==
X-Received: by 2002:a17:90b:1b05:b0:1e2:a053:2fad with SMTP id nu5-20020a17090b1b0500b001e2a0532fadmr52776954pjb.209.1654548494401;
        Mon, 06 Jun 2022 13:48:14 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:e75e:2c04:7854:d454])
        by smtp.gmail.com with ESMTPSA id q3-20020a056a0002a300b0051be16492basm7119485pfs.195.2022.06.06.13.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:48:14 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 6 Jun 2022 13:48:12 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>, ngupta@vflare.org,
        senozhatsky@chromium.org, avromanov@sberdevices.ru,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        s.suk@samsung.com, ytk.lee@samsung.com, jaewon31.kim@gmail.com
Subject: Re: [PATCH] zram_drv: add __GFP_NOMEMALLOC not to use
 ALLOC_NO_WATERMARKS
Message-ID: <Yp5oDD8mfsGtsSaB@google.com>
References: <CGME20220603055341epcas1p2dd357326eea0cd818daf6f0db7c2aae1@epcas1p2.samsung.com>
 <20220603055747.11694-1-jaewon31.kim@samsung.com>
 <Yp5ZnkYEA5xrUksX@google.com>
 <20220606125939.ae37867e43b8b8b07fa06ca7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606125939.ae37867e43b8b8b07fa06ca7@linux-foundation.org>
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

On Mon, Jun 06, 2022 at 12:59:39PM -0700, Andrew Morton wrote:
> On Mon, 6 Jun 2022 12:46:38 -0700 Minchan Kim <minchan@kernel.org> wrote:
> 
> > On Fri, Jun 03, 2022 at 02:57:47PM +0900, Jaewon Kim wrote:
> > > The atomic page allocation failure sometimes happened, and most of them
> > > seem to occur during boot time.
> > > 
> > > <4>[   59.707645] system_server: page allocation failure: order:0, mode:0xa20(GFP_ATOMIC), nodemask=(null),cpuset=foreground-boost,mems_allowed=0
> >
> > ...
> >
> > > 
> > > The kswapd or other reclaim contexts may not prepare enough free pages
> > > for too many atomic allocations occurred in short time. But zram may not
> > > be helpful for this atomic allocation even though zram is used to
> > > reclaim.
> > > 
> > > To get one zs object for a specific size, zram may allocate serveral
> > > pages. And this can be happened on different class sizes at the same
> > > time. It means zram may consume more pages to reclaim only one page.
> > > This inefficiency may consume all free pages below watmerk min by a
> > > process having PF_MEMALLOC like kswapd.
> > 
> > However, that's how zram has worked for a long time(allocate memory
> > under memory pressure) and many folks already have raised min_free_kbytes
> > when they use zram as swap. If we don't allow the allocation, swap out
> > fails easier than old, which would break existing tunes.
> 
> So is there a better way of preventing this warning?  Just suppress it
> with __GFP_NOWARN?

For me, I usually tries to remove GFP_ATOMIC alllocation since the
atomic allocation can be failed easily(zram is not only source for
it). Otherwise, increase min_free_kbytes?
