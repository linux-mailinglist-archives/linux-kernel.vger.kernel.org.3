Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E494E7E56
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 02:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiCZBJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 21:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiCZBJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 21:09:23 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEA914FFF9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 18:07:48 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id c15so12326522ljr.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 18:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NseqcOErFtU1LljXK411YTLgt9GH8dQMTY4dlb6RFSk=;
        b=LNgmEMCn1XnxX/EFBHUQ2zGxHvMCFBgu+ZpE3CiC2daiCLlILuCJLO7tuHRQ4w19+G
         zouO12+LwuYUNeyDQXrfeVBAI4OThT+BsSQLmjTA4r/9D4Ajgbdmr5vbulOZz7lXV5yM
         ZTs47phBmakG6v9VF47l0+hTPTc3c8ssjfmXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NseqcOErFtU1LljXK411YTLgt9GH8dQMTY4dlb6RFSk=;
        b=1XMSJZwm5607TadlIQ0EeW6DofIOh1b8A4xnfq2733x6ojURtQ1Mzu90GT7yh/IMYh
         etC3mpVNW0FvSmY7UZ9BpEJEPJ58eviv6TamzUUlSpqKCpK429LBa58jQ0x1FcDeb2dU
         qAdfUiS+rQaCSqqE56I7QnRBx2v7PU4zD5v4MilacgMR7IaYvDcLZWcgCiDWOs2pZa61
         Ei4y/GmOyvuUVP4Bx4KYq48bimfp0sXCbhVMrcTLIWKykrhKnDEeuuVKZNlJLJknHK7p
         AulTZ28IoyDqYsJPaGuatuPsXdC17JZb2z3j/Zn6K3RG8OzRQTZzBT9gvlTQkYxuP/vT
         dlrA==
X-Gm-Message-State: AOAM531/37ndEXvRGknTXy0bbGtVfX0v6QDateylfqkAJ1bP711poSoG
        RSzNfJjROakZ5xfjZgHEoAgPJE+TCEfMB3f0KH8=
X-Google-Smtp-Source: ABdhPJyv+66JpBoZR4mTrmwOfJEryTrdFEf5Ov2ABjFQQ8RwelTJRi8zqmoTLwnI4ahHDpOp7S70ZQ==
X-Received: by 2002:a05:651c:1725:b0:248:6c4:29d6 with SMTP id be37-20020a05651c172500b0024806c429d6mr10142843ljb.394.1648256866546;
        Fri, 25 Mar 2022 18:07:46 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id k9-20020a192d09000000b004487dfc9d9csm871181lfj.260.2022.03.25.18.07.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 18:07:46 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id w7so16010989lfd.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 18:07:45 -0700 (PDT)
X-Received: by 2002:a2e:9904:0:b0:247:ec95:fdee with SMTP id
 v4-20020a2e9904000000b00247ec95fdeemr10483376lji.291.1648256855004; Fri, 25
 Mar 2022 18:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220326010003.3155137-1-yuzhao@google.com>
In-Reply-To: <20220326010003.3155137-1-yuzhao@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Mar 2022 18:07:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjp=jEhjvD9GPnHfuV5Kc1=rUnf84b_qscLJ8fkY74u3Q@mail.gmail.com>
Message-ID: <CAHk-=wjp=jEhjvD9GPnHfuV5Kc1=rUnf84b_qscLJ8fkY74u3Q@mail.gmail.com>
Subject: Re: [GIT PULL] Multi-gen LRU for 5.18-rc1
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <baohua@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Donald Carr <d@chaos-reins.com>,
        Hillf Danton <hdanton@sina.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Rik van Riel <riel@surriel.com>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
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

On Fri, Mar 25, 2022 at 6:00 PM Yu Zhao <yuzhao@google.com> wrote:
>
> This is more of an option than a request for 5.18. I'm sending it to
> you directly because, in my judgement, it's now as ready as it'll ever
> be.

So I do expect to merge this, but I don't think it has been in
linux-next, has it?

I would really like to see it get that linux-next workout with various
automation bots going after it.

I'd also like to see explicit acks from the usual suspects, or at
least make sure we don't have any explicit NAK's coming in.

Andrew & co?

                   Linus
