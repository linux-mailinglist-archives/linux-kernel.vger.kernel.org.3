Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A7E50200C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 03:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239881AbiDOBSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 21:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiDOBR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 21:17:58 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F7B7CDD2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 18:15:32 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id r130so1758321vkr.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 18:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sqQ5iSXHRChMtfKt3RIiTUV6la+/DUpLnLLVZuKBh7Q=;
        b=oviqlwgsbsf/uMOiFPTaRFR184BPOabtCsqvs6xHtrlZpVbO4wKVB0eo7OE3eF6N/f
         WoaWM5yeZZLbX4bTnkrRStEi99QdeKS6Z3yPjXlEJ8thMjBN2y6vtiXz9+r5waIlarMi
         PEuJDrqRxDNGWEvZtqcjJ6wDZjHCrtXjyW8RCewvZZTM8b8ewk2aMLxst08o3jkmgvHj
         dBaMIEPKx2pirgP/PA/oNB8wvUGcKYkBWFZi8QlKZ5MZdK/U1NzAv8EWY+L7ieWQPXio
         KQeZRRy2WP6HjteGasYoS9ndZF9Muc0bdCZWEfz9K4vzCapbUgbZygSvSEc1A6iW2EBz
         SL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sqQ5iSXHRChMtfKt3RIiTUV6la+/DUpLnLLVZuKBh7Q=;
        b=4omK45oFptnD9PnunLjFVjeCrF99ZqKX6btY80EaS2Dtx10Lm4Qeh3IiaYtmel4gQ0
         BaDkdlLPeIsArkJ972HpLQwDU6iAJMabsJNesIfSNe0N1lKlpAO/kt0YNZ2W9YHxH7Li
         GCy+hL8QAQWjZ/f4EIzQvx4PHhME++gHeYn7Gxl6en+Owd41sFAkiPo582q5pUCd+DvF
         AMjPvJHorrn1UIBMWSOtsFwrgWjQibigsGGSLisXW0fl7EtBsR+KgvcNJgszKEzAIHpC
         WKTxLOQjFp1dcO8o9Dv8CE5DAGy/iN7iXRwU76uE5UnpKnuqHQixMDOPC3avX2Wsz93p
         kW7Q==
X-Gm-Message-State: AOAM5306zh7EmptQh4XohnzdhfzG8teNBted4Y7Mc1FYuV/Sn+WeZmoU
        gJ+VWekmVTWNzctpykljErHNka+AjrFkZm8M3iMX+Q==
X-Google-Smtp-Source: ABdhPJwvGDjSCKwPleIWn79rkQzoHHhv5ROws7qejBtcO8EAQjqcBUMU+Hjaa8vtashbeHOejWBcqwTJDS8z7VZov/8=
X-Received: by 2002:a1f:314b:0:b0:331:fff6:a89e with SMTP id
 x72-20020a1f314b000000b00331fff6a89emr2454874vkx.26.1649985331160; Thu, 14
 Apr 2022 18:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-9-yuzhao@google.com>
 <20220411191621.0378467ad99ebc822d5ad005@linux-foundation.org>
In-Reply-To: <20220411191621.0378467ad99ebc822d5ad005@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 14 Apr 2022 19:14:54 -0600
Message-ID: <CAOUHufYeC=Kuu59BPL_48sM67CqACxH2wWy-SYGXpadgMDmY3w@mail.gmail.com>
Subject: Re: [PATCH v10 08/14] mm: multi-gen LRU: support page table walks
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
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

On Mon, Apr 11, 2022 at 8:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed,  6 Apr 2022 21:15:20 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > +static void update_batch_size(struct lru_gen_mm_walk *walk, struct folio *folio,
> > +                           int old_gen, int new_gen)
> > +{
> > +     int type = folio_is_file_lru(folio);
> > +     int zone = folio_zonenum(folio);
> > +     int delta = folio_nr_pages(folio);
> > +
> > +     VM_BUG_ON(old_gen >= MAX_NR_GENS);
> > +     VM_BUG_ON(new_gen >= MAX_NR_GENS);
>
> General rule: don't add new BUG_ONs, because they crash the kenrel.
> It's better to use WARN_ON or WARN_ON_ONCE then try to figure out a way
> to keep the kernel limping along.  At least so the poor user can gather logs.

These are VM_BUG_ONs, which are BUILD_BUG_ONs except for (mostly MM) developers.
