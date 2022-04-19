Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E34F507907
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347251AbiDSSkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352706AbiDSSkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:40:03 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4153B3DDF5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:36:58 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d14so4999659qtw.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z6rZlfac8Ye6saOGMPLmjkY9uCNpacxOF3e5qKVDCFs=;
        b=pUNRUP0C2APS8UkYdqD1g38qMZXlHCHTzwxIFeyub/nFDk5LOeX274rsdd11wSgmN8
         uCHYhlPiAtBIqTpVWa4vJ2mVMAnikZbGWhzTnsCiwuM6ycLkGAAbHe7tn+xhM6UnN3er
         z34qjnv+F9EnA9SU4Nz/CgToz/lCawKurVMefsW1qHE5jgzj7HPdDDF3kK+jrBKy4Bka
         8gWfH2cjfiP7xm584wjQnehiYrUiUyLdyG8ZZbokhBgOPVSigkVAWz9dse6bUbQFjAiT
         xOpXk0GwBwzihyqVDblqSEEnu7oLfrE3mVizFu0MAQddiKmMNN+joRWvdpfrZ1wmJwQ/
         Kwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z6rZlfac8Ye6saOGMPLmjkY9uCNpacxOF3e5qKVDCFs=;
        b=5qTfZKPbSvFftjUb55SxWvdi2L9jfJzj2EfFR8HKf4i3Wig6S2mvKvaXNBJQpncHYX
         wQeuvwGFlWuHgpyZ91MSFblS0FzKDEGlX1+n/lOnTv0KV5qs+dWKfc9wAZS3IyfhWlfz
         2tv73anSJZcGpaGiaP4zzLSoDttqkrPOJiQs8xbmUTOoiGZWgkWMMW9yxoQU0GQRYOhR
         ZtsAhHw8vuLxgZA6inUswvqgyO8doDVSiahCkjnafpfXLNeSFfu7nL1Rm9OTQp16Ak3P
         BmgwGmXz5c8aDaXrHiUswja31zwkJ/qW/3Ep1glgv7al5PI7fASThQvgQbV+pU9Ohcwl
         Hcfg==
X-Gm-Message-State: AOAM5329QZCOey54hGM9tGJ+8xQ55hQxGIAYinRUrEhTfUHg5JUkMYbA
        cqsxgIXFvtg0w5nnu3IdPA==
X-Google-Smtp-Source: ABdhPJzVl/QPKAmlpf46Xz5ohDwz/HUO0fPboNx6NNJqvpchra2rA+XyEIU2blLLyStCUGcBXkJKQA==
X-Received: by 2002:a05:622a:130a:b0:2f3:3f25:b00 with SMTP id v10-20020a05622a130a00b002f33f250b00mr591679qtk.494.1650393417270;
        Tue, 19 Apr 2022 11:36:57 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id m139-20020a37a391000000b0069e88edfdacsm375265qke.105.2022.04.19.11.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:36:56 -0700 (PDT)
Date:   Tue, 19 Apr 2022 14:36:54 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH rfc 0/5] mm: introduce shrinker sysfs interface
Message-ID: <20220419183654.axbxcjehs6fpqg4z@moria.home.lan>
References: <20220416002756.4087977-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416002756.4087977-1-roman.gushchin@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 05:27:51PM -0700, Roman Gushchin wrote:
> 7) Don't display cgroups with less than 500 attached objects
>   $ echo 500 > count_memcg
>   $ cat count_memcg
>     53 817
>     1868 886
>     2396 799
>     2462 861
> 
> 8) Don't display cgroups with less than 500 attached objects (sum over all nodes)
>   $ echo "500" > count_memcg_node
>   $ cat count_memcg_node
>     53 810 7
>     1868 886 0
>     2396 799 0
>     2462 861 0
> 
> 9) Scan system/root shrinker
>   $ cat count
>     212
>   $ echo 100 > scan
>   $ cat scan
>     97
>   $ cat count
>     115

This part seems entirely overengineered though and a really bad idea - can we
please _not_ store query state in the kernel? It's not thread safe, and it seems
like overengineering before we've done the basics (just getting this stuff in
sysfs is a major improvement!).

I know kmemleak does something kinda sorta like this, but that's a special
purpose debugging tool and this looks to be something more general purpose
that'll get used in production.
