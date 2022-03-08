Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973774D2697
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiCIBRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiCIBRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:17:01 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8221C125
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:07:03 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id h11so1001964ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 17:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BVNrGCcOfvHiAcGFTY5YLY7Z1HHPIFngZYQsO1KxKDY=;
        b=SG8/miPNs2SqQ8nycTJeRar97B4Q7FMFusbGeyij2z7w6RORJwBq1pHwdtxhXCkrRP
         31vF6vX9uuDq2YbmdD68fWT0Gox8vxJsIr/Xdf2NdLBT+tW3RUdzKm+1mBy81yu0fuoT
         DDi5tUBGsrtwdVz6rvkrIvBZrf5rTovzb5E7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BVNrGCcOfvHiAcGFTY5YLY7Z1HHPIFngZYQsO1KxKDY=;
        b=HULZkjVdYtQBbxTlaOD5zDuQ5TaqWaJ2N5TtFIkjolAFfC6GlBZBamA1Gq14327IfM
         oKHGpHorjA+ecPwcmkiyAfzqFBCwCVcgG75RServbnf6ij4509ixcKPsCKteY56bX2Nn
         KK9xnYvX6ZE0IFr1I/2I1bTvxJfbVTILvGtDRV71WwLyQx0Wsa66cF/JLf4heLq4Y2aN
         4aLdCRpw9E8A1MmWLFv0EJXyybpZoomhiV0B0AGNgC9X9GNCzfh0wErDeFqmnjBdSMuD
         aYdul+inArKBV/rrVVkUumr2USz0KJBEMRx6TY6wBVeRsDe8h/Vuu7RJ5WsRFUvTlN3G
         bkjg==
X-Gm-Message-State: AOAM533DgkIxdSUrTCNkQ5Imu+wMiJTH7uvc5rE/jQi2q+tq+7+gmq6K
        /wUP9Egkx6HfjdgdNqPVmfNJzV5l/4hk2Z8yKK0=
X-Google-Smtp-Source: ABdhPJx6AWqrHOVly8fQhiPxze4QcU+7vA0PYzffwjLDU90qzRXd1euF1Z2zesQMKoDRH45N1MgEQQ==
X-Received: by 2002:a17:906:7745:b0:6b5:fe2b:4827 with SMTP id o5-20020a170906774500b006b5fe2b4827mr15214443ejn.628.1646783951712;
        Tue, 08 Mar 2022 15:59:11 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709066d8700b006d4b4d137fbsm86756ejt.50.2022.03.08.15.59.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 15:59:11 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id p15so1351947ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 15:59:11 -0800 (PST)
X-Received: by 2002:a2e:924d:0:b0:246:370c:5618 with SMTP id
 v13-20020a2e924d000000b00246370c5618mr12145935ljg.358.1646783940635; Tue, 08
 Mar 2022 15:59:00 -0800 (PST)
MIME-Version: 1.0
References: <20220308234723.3834941-1-yuzhao@google.com> <20220308234723.3834941-6-yuzhao@google.com>
In-Reply-To: <20220308234723.3834941-6-yuzhao@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Mar 2022 15:58:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wggLcQSk3i2h8RWR2GYnCDQW_t5sWOExh2Oojmxvz0hcA@mail.gmail.com>
Message-ID: <CAHk-=wggLcQSk3i2h8RWR2GYnCDQW_t5sWOExh2Oojmxvz0hcA@mail.gmail.com>
Subject: Re: [PATCH v8 05/14] mm: multi-gen LRU: groundwork
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, page-reclaim@google.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
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

I still think this part is fundamentally wrong:

On Tue, Mar 8, 2022 at 3:48 PM Yu Zhao <yuzhao@google.com> wrote:
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 3326ee3903f3..4ef67f157374 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -892,6 +892,28 @@ config ANON_VMA_NAME
>           area from being merged with adjacent virtual memory areas due to the
>           difference in their name.
>
> +# the multi-gen LRU {
> +config LRU_GEN
> +       bool "Multi-Gen LRU"
> +       depends on MMU
> +       # the following options can use up the spare bits in page flags
> +       depends on !MAXSMP && (64BIT || !SPARSEMEM || SPARSEMEM_VMEMMAP)
> +       help
> +         A high performance LRU implementation for memory overcommit.
> +
> +config NR_LRU_GENS
> +       int "Max number of generations"
> +       depends on LRU_GEN
> +       range 4 31
> +       default 4
> +       help
> +         Do not increase this value unless you plan to use working set
> +         estimation and proactive reclaim. These features are usually for job
> +         scheduling optimizations in data centers.
> +
> +         This option uses order_base_2(N+1) bits in page flags.
> +# }

Pick a value. Don't ask a user for a value.

If you don't know what the value should be, the user sure as hell doesn't.

And if you don't pick a value for people to test, then people will
test random values and dilute and make the testing less valid in the
process.

There is absolutely no upside to asking people a question like this,
and only downsides.

If the quoted "schedulign optimizations" are real, then maybe bigger
values should be the default? Or maybe it should be a run-time
tunable, so that people can actually _test_ them?

Or - more likely - that config variable just shouldn't exist, at least
in some initial series, and you just should say "we use four
generations, we can tweak this if people have hard numbers later".

                 Linus
