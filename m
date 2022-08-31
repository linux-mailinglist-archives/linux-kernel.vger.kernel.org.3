Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD0E5A88EA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 00:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiHaWTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 18:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiHaWTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 18:19:31 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A40EA89D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:19:30 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id k66so10366847vsc.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AWZYQnfan1bJ9GVCNBmyZROKJBcbdAllrd1bujLULUY=;
        b=dIvdefwaZbVNNqxh58j/aN2+eJRZ99cdEUmZC1J0cvPnn8cQuWt1+PInXHWHuD86Ro
         kUUwpAt8eLCA1sOqsb23HOTSSSoFU8FV9mURgEs1ycFph/6ImAZMOpyQGA2HHzU/WQj6
         qbvtJIAFvKWzXCkus1+g/Ks1t9ag0iaV+KhvBBU/KEtVQ1oxAITPF8No6eMViA8oktNL
         fj+WxeXrs49XTdF0UWkU474Bg5OYUt/4xAyqLxWNwsHFVm9wECowDjpI1a6GFj+otplu
         VlhUILHGh6hu65+zZSjlpg2G2QL32OR+YKzids3xS0QPdZFGBnezavGjEnHtulocVp+C
         BmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AWZYQnfan1bJ9GVCNBmyZROKJBcbdAllrd1bujLULUY=;
        b=4jr5xFyACUc/OTVsXa/mXoPBkn6fSRl0z9tmTng9EyMjsL8a0kQAtnqpnsrIlG01KA
         iRqhTwG4P5sA0IHWPdoldB8Uk/J3vDjzeHHaxcqd5SNpCgRaFbyzOMTh88+vmbA5Nwyq
         Z4ruW7Tc2CuplHJmDUNePa+FO5fBZSvgU+JQ9In4Hx4mRNmA9wSLi26AVWKrdlwI3s4g
         EGAYLzQ2zkiLbz6VgVok+7K6t0rD9NT1+UMdEeYzgKUVKjrtd3r7HV8DHSMj8K0+QZ/w
         tiWQoyY1Hm7GCCtnYxh3IEIPwKyG23QZGAS7YZo9wOo8NtoHWcBbX30mSVriK5sMVQqr
         DQvg==
X-Gm-Message-State: ACgBeo2P8h8n1ewyAEGMLVoly38cChZN/9g3PBkAaHAFf+opGe12T0sM
        GK/XRkySyY16Fb5BR2bdNL2oIRmZjNJuYUj3JwBGVQ==
X-Google-Smtp-Source: AA6agR6qB/hK2H0DqIQnLfQXxQ5YBcusYTQ4Uhij460P3WvW0T5tBjs9Eu81k8/3Y7BrMETRjUoukeCZSc+ZR44TKS0=
X-Received: by 2002:a67:f909:0:b0:390:e960:7f5a with SMTP id
 t9-20020a67f909000000b00390e9607f5amr4984075vsq.50.1661984369049; Wed, 31 Aug
 2022 15:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220815071332.627393-1-yuzhao@google.com> <20220831041731.3836322-1-yuzhao@google.com>
In-Reply-To: <20220831041731.3836322-1-yuzhao@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 31 Aug 2022 16:18:50 -0600
Message-ID: <CAOUHufamkHsCTckj5hBCTZoM-W-awdoQMVOP5_KswDW_VLJEoA@mail.gmail.com>
Subject: Re: OpenWrt / MIPS benchmark with MGLRU
To:     Arnd Bergmann <arnd@arndb.de>, Dave Hansen <dave.hansen@intel.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>
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

On Tue, Aug 30, 2022 at 10:17 PM Yu Zhao <yuzhao@google.com> wrote:
>
> TLDR
> ====
> RAM utilization  Throughput (95% CI)  P99 Latency (95% CI)
> ----------------------------------------------------------
> ~90%             NS                   NS
> ~110%            +[12, 16]%           -[20, 22]%
>
> Abbreviations
> =============
> CI:   confidence interval
> NS:   no statistically significant difference
> DUT:  device under test
> ATE:  automatic test equipment
>
> Rational
> ========
> 1. OpenWrt is the most popular distro for WiFi routers; many of its
>    targets use big endianness [1].
> 2. 4 out of the top 5 bestselling WiFi routers in the US use MIPS [2];
>    MIPS uses software-managed TLB.
> 3. Memcached is the best available memory benchmark on OpenWrt;
>    admittedly such a use case is very limited in the real world.

Thanks.

My goal is to encourage MM people to extend their test coverage to
some commonly used but less tested configurations. I carefully
constructed this benchmark with the balance between its
representativeness and the effort to reproduce.

When I wear my MM hat, I see ER-8 as the ideal choice because it comes
with a serial port, a replaceable memory DIMM and one of the two cores
that can be disabled. The same SoC is also what the Debian MIPS port
mainly uses for their testing [1]. So if I need help, I might be able
to get it from them.

From OpenWrt's / MIPS OEMs' POVs, I do see ER-8 as an uninteresting
platform. Currently the best selling WiFi router on Amazon US is
Archer A7, a knockoff of Archer C7. The latter comes with not only the
serial port header but also the JTAG header, and that's what I use.
But I seriously doubt showing how I work on C7 would encourage MM
people to try it. I snapped a pictures of it during lunch:
https://drive.google.com/file/d/1rYBwLOyMqBSr6WKUZd7Gbf9RfwA641X5/
And other boards I routinely test the MM performance on:
https://drive.google.com/file/d/1yBMx9OPWw-5czvz3maNUy6WBFwPvAqG5/
All the way dates back to this vintage:
https://drive.google.com/file/d/12N21qiWSoyJgZwVkwAhY8_5Fj4dKftqD/

[1] https://wiki.debian.org/MIPSPort
