Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1974EF855
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348960AbiDAQry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349897AbiDAQrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:47:15 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D241017DCB5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 09:32:19 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id h7so5933889lfl.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jSn+1DlBmjF9liCFAObVEDkZuTzAiSQphLAr9mc3iek=;
        b=EMrbF6/FUCzz/mA9FTkStMXcBiPNQ3kZ6MlkbNvu29QIQOMkngWpkkZSDjJgw+o1Wn
         L39n6IqZYh2upzJE1VQ4bvuZj1k/YuRpwkL1xpensQ19FI//uyAsOog8d1vF1s+0Fy/7
         c+Z3RRCNMyi3MKUUNQaDjDcza+QULvzb70HA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSn+1DlBmjF9liCFAObVEDkZuTzAiSQphLAr9mc3iek=;
        b=F/kH4n8DH4ZSS3UwHCRq5dbRrk5va42b8ReEFLSkSWYMB8Vx7HeZ4xCnXTSNFbK7cK
         pDJKMUPMI/MVCU3FKKU5GdITbNiGqiB27SorGbpuPVqDIG2Kv1jkAHex8mpm+UM3FRlP
         gX1bM+Y+WLTRy6HWG7GhtiWw6Nw6IJfXOaWfMw4fuhRE4YyNK0LGJ03+AJNUXKiOLilF
         msxElkc8IEP12NuelYom861D65WQRsonaKrBksOYds+6Y7dY1Weze0gN8QPzXK6BleSc
         p9M8HeHLGmatQuuM/gx0Rp43etvG4DEabpy3YG/k0mQpHo8qepqR6tJsf1wOazrEjyiJ
         V7UQ==
X-Gm-Message-State: AOAM530DoJjqjHG4DnKVAsb0dmv0HHlbvv6vIzJUWDGXQPyzMJnN56Qx
        B+iLV3tp4pSSltbCt6p1jnFhyufg1Q+S88jiQ20=
X-Google-Smtp-Source: ABdhPJwPkTr/iXa/AE5+WbA6er1ANlSWqu3PO7rplltcOi1s1fO5QjN+xf9nbC1gqKrwaIwUV5YrFw==
X-Received: by 2002:a05:6512:1594:b0:44a:2d71:f14d with SMTP id bp20-20020a056512159400b0044a2d71f14dmr14695200lfb.446.1648830737246;
        Fri, 01 Apr 2022 09:32:17 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id l5-20020a056512110500b0044a1061f722sm278812lfg.200.2022.04.01.09.32.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 09:32:15 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id z12so5863494lfu.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 09:32:15 -0700 (PDT)
X-Received: by 2002:a05:6512:3ca1:b0:44a:93f1:45cf with SMTP id
 h33-20020a0565123ca100b0044a93f145cfmr14626698lfv.542.1648830735595; Fri, 01
 Apr 2022 09:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220401135820.1453829-1-zi.yan@sent.com> <20220401135820.1453829-2-zi.yan@sent.com>
In-Reply-To: <20220401135820.1453829-2-zi.yan@sent.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Apr 2022 09:31:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjToETfvzxkz_Y=QPt0JQRHF3VZ51xjhbPNAneHFvZofw@mail.gmail.com>
Message-ID: <CAHk-=wjToETfvzxkz_Y=QPt0JQRHF3VZ51xjhbPNAneHFvZofw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: wrap __find_buddy_pfn() with a necessary buddy
 page validation.
To:     Zi Yan <ziy@nvidia.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 6:58 AM Zi Yan <zi.yan@sent.com> wrote:
>
> +extern bool find_buddy_page_pfn(struct page *page, unsigned int order,
> +                               struct page **buddy, unsigned long *buddy_pfn);

Wouldn't it make more sense to just return the 'struct page *buddy'
here, instead of the 'bool'?

So a NULL buddy means the obvious "no buddy found".

I dislike those "pass return value by reference" in general, and the
above has _two_ of them.

We can get rid of at least one very obviously.

           Linus
