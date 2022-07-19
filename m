Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8641257AA66
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 01:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbiGSXWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 19:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiGSXWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 19:22:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7047947B84
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 16:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658272940; x=1689808940;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DNYh3WvqLRfUXzaq47t9zdMeNxzavxqzs6FOlkMSOks=;
  b=Zkzn2vo0LRx+Z507IMw/Cn7A7uX0XMFdv2Hl1b/5lRSaK58SUh1plOkH
   xIuGkCFl1kGrMV/zV9SI5FV3AbU+E8Ax2sSrFHsb+xNgmtzPmr+PHR36R
   xcsLNcgJzj60Vf+EbWeCftQEscGNsZAV6HGAjf7dE4+N3HWqnzxV6P5Cg
   VnwjwzOV48LNZfBPjzI5ufcmTvMsGhdu471cNYCNmZYO1ocHgXTYdnsET
   q7PWNPdTGS7P29dLUz6VkHqThATldoZfKOgFNaZogYrCz519eUZ17GdGT
   I9kmNg8IC6jNbkUnT47iM3m+BODHwkKcsY0ALXBqWTgnbJZbqaJchnmH3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="287786756"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="287786756"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 16:22:13 -0700
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="687299824"
Received: from twliston-mobl1.amr.corp.intel.com (HELO [10.212.132.190]) ([10.212.132.190])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 16:22:12 -0700
Message-ID: <dc7800c0-43f3-6453-ef5f-1ceb659062de@intel.com>
Date:   Tue, 19 Jul 2022 16:22:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/1] mm: kfence: apply kmemleak_ignore_phys on early
 allocated pool
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>, yee.lee@mediatek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:KFENCE" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20220628113714.7792-1-yee.lee@mediatek.com>
 <20220628113714.7792-2-yee.lee@mediatek.com>
 <CAMuHMdX=MTsmo5ZVa8ya3xmr4Mx7f0PB3gvFF42pdaTYB6-u5A@mail.gmail.com>
 <20220715163305.e70c8542d5e7d96c5fd87185@linux-foundation.org>
 <CAMuHMdWSsibmL=LauLm+OTn0SByLA4tGsbhbMsnvSRdb381RTQ@mail.gmail.com>
 <CANpmjNPhhPUZFSZaLbwyJfACWMOqFchvm-Sx+iwGSM3sxkky8Q@mail.gmail.com>
 <20220719161356.df8d7f6fc5414cc9cc7f8302@linux-foundation.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220719161356.df8d7f6fc5414cc9cc7f8302@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/22 16:13, Andrew Morton wrote:
> On Mon, 18 Jul 2022 16:26:25 +0200 Marco Elver <elver@google.com> wrote:
> 
>> On Sat, 16 Jul 2022 at 20:43, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> [...]
>>>> - This patch has been accused of crashing the kernel:
>>>>
>>>>         https://lkml.kernel.org/r/YsFeUHkrFTQ7T51Q@xsang-OptiPlex-9020
>>>>
>>>>   Do we think that report is bogus?
>>> I think all of this is highly architecture-specific...
>> The report can be reproduced on i386 with CONFIG_X86_PAE=y. But e.g.
>> mm/memblock.c:memblock_free() is also guilty of using __pa() on
>> previously memblock_alloc()'d addresses. Looking at the phys addr
>> before memblock_alloc() does virt_to_phys(), the result of __pa()
>> looks correct even on PAE, at least for the purpose of passing it on
>> to kmemleak(). So I don't know what that BUG_ON(slow_virt_to_phys() !=
>> phys_addr) is supposed to tell us here.
>>
> It's only been nine years, so I'm sure Dave can remember why he added
> it ;)
> 
> 		BUG_ON(slow_virt_to_phys((void *)x) != phys_addr);
> 
> in arch/x86/mm/physaddr.c:__phys_addr().

I think I intended it to double check that the linear map is *actually*
a linear map for 'x'.  Sure, we can use the "x - PAGE_OFFSET" shortcut,
but did it turn out to be actually accurate for the address it was handed?

I'd be curious what the page tables actually say for the address that's
causing problems.
