Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF7A53D4EF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 04:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350285AbiFDCtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 22:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350184AbiFDCte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 22:49:34 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229352ED4D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 19:49:33 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id g4so16722300ybf.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 19:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dFgPJ0EvCireqTk1NG3fa4MqyQXhNKCWoxAx0OX5uXM=;
        b=8Up1FSkJCiVMlo1FEPFESU3WDGO72wv6qWRe11rdwvRC9vTdo1Gk3pDAk4rFZ9okjl
         22j5WkGOCNktK7zB9SPGsugkZ3cvgu4b4Il+LNMSSe1zDG/qBA/9v8tmudSHtL//OgiN
         8FgjtJAqux1NWUVE1V1HG7iSqts6cqhwFS5fggSqa+cgv8VKziRbTufEJW7PXUUfmplZ
         92GS54lBjo10Q6a+WPKWjuMMiHepsO0mjFalEFxWg9f/8IeKptyRqv30MynWJkd8unqe
         zGF/QbRrNQx+GvB/gQDIiA7zPS2m9B9lrn/FrF5hDBGANdfdmBGsn2wz5ZiQN49xnAPj
         gREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dFgPJ0EvCireqTk1NG3fa4MqyQXhNKCWoxAx0OX5uXM=;
        b=y1fMcUWlZWtnBRgmLa27qqQMcSO6bbHYBeDF6xkjjV7MeQUezSH8U/frRZruU8ZXwZ
         mOt2HwDzkZ0UBw60zmmDAWwDOXvUrA38kJqpfZDOAFuMrS38q1vTSvA6r91ZpBEFDiL3
         ZvWoJuJd394uOh+cqI90FEc5V2aCRxmIcbSec46dNVAjj4Yh5qNo5oYkisM/35pFo2Jv
         NMaIiQKqcXkJxH4nRyF3Ig6XDW5JtyqqIyF/hki/0sZaBLil/AvpK6Ye7Dh35vl5VsVb
         6qOTf9brgqG0JvgNocsh0X4QOO5S0nb86HYvgEGU6FYsje2XWsSzQeTCVPwNrrGFd+EX
         eN8w==
X-Gm-Message-State: AOAM533p/m9DBIU6S9m6u0+i84SyveUQLKtXytMjLFNcg8Ngfalx0f5H
        HL8XvPiHIR+yxAgU1Hc0K34dMIngEi9OC05YV1tkMg==
X-Google-Smtp-Source: ABdhPJzlLpBQmq1Y4Obciqm0T5t6gUS5s0GUXNsC0U2JhwJt5+dKNnXEmlY34Se+DMgyRJe/dsDi8WR22+ZOVYCER8s=
X-Received: by 2002:a25:cc53:0:b0:65c:b19c:fac1 with SMTP id
 l80-20020a25cc53000000b0065cb19cfac1mr13512196ybf.89.1654310972408; Fri, 03
 Jun 2022 19:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220603070423.10025-1-zhengqi.arch@bytedance.com>
In-Reply-To: <20220603070423.10025-1-zhengqi.arch@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 4 Jun 2022 10:48:56 +0800
Message-ID: <CAMZfGtUV6ifKcxyUKHuzTpFt_-4jWXgUwuJhdt8fS8B8wjh1Lg@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: separate {pgscan,pgsteal}_{kswapd,direct}
 items in memory.stat of cgroup v2
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 3, 2022 at 3:06 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>
> There are already statistics of {pgscan,pgsteal}_kswapd and
> {pgscan,pgsteal}_direct of memcg event here, but now the sum
> of the two is displayed in memory.stat of cgroup v2.
>
> In order to obtain more accurate information during monitoring
> and debugging, and to align with the display in /proc/vmstat,
> it better to display {pgscan,pgsteal}_kswapd and
> {pgscan,pgsteal}_direct separately.
>
> Moreover, after this modification, all memcg events can be
> printed with a combination of vm_event_name() and memcg_events().
> This allows us to create an array to traverse and print, which
> reduces redundant seq_buf_printf() codes.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

With Shakeel's changes.

Acked-by: Muchun Song <songmuchun@bytedance.com>
