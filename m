Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340304EFF71
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 09:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238797AbiDBHrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 03:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiDBHra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 03:47:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C3D43485
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 00:45:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7C8160FD6
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 07:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D45C340EC;
        Sat,  2 Apr 2022 07:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648885538;
        bh=MJ7b9c3E+nr51fYg+bLs09xCaDLg+mwoHo8xrQPdmdM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gTe9FQEsGX2DWtwkxFAeywtDpdPuha8W9QpuiHLMEAzbkE7nXyZcMTxrFprvpBSA2
         FOR78HTNENSKY2Z/VXpyFhlkjjZBUKQCXAy3VK8y37uX4OzJCoJ/j0uwfgufnQfDqj
         Xrge3R3OcL5eTLVsbSIBRz1bFyQJGge8/91/Q0438loexWSJTjGJEwutT6IzzZzhe6
         1rdcESLeMrY7Am8/mAZAYBNzBls8XgctDbnoxAPomA2foOShPoue9+1Qx13EWEnobR
         YjcwJAiFnbSaaZ8A9Rw39n6c1adNszVr0ekrD2FVA+pmHYrGd7BGNi23gqMCwV6F/h
         91v8Fh87O0pyg==
From:   Kalle Valo <kvalo@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: page_alloc: simplify pageblock migratetype check in __free_one_page().
References: <20220401135820.1453829-1-zi.yan@sent.com>
        <134f56da-e827-2d29-75ba-1ec88ae2b118@redhat.com>
        <66F9766D-A7D8-4310-9FA9-5EC8B2CC341C@nvidia.com>
        <85520c49-5ef9-25f2-d6fa-f8b26e5dfec2@redhat.com>
        <6696fb21-090c-37c6-77a7-79423cc9c703@redhat.com>
Date:   Sat, 02 Apr 2022 10:45:33 +0300
In-Reply-To: <6696fb21-090c-37c6-77a7-79423cc9c703@redhat.com> (David
        Hildenbrand's message of "Fri, 1 Apr 2022 16:32:58 +0200")
Message-ID: <87sfqwszc2.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 01.04.22 16:22, David Hildenbrand wrote:
>> On 01.04.22 16:19, Zi Yan wrote:
>>> On 1 Apr 2022, at 10:12, David Hildenbrand wrote:
>>>
>>>> On 01.04.22 15:58, Zi Yan wrote:
>>>>
>>>> It's weird, your mails arrive on my end as empty body with attachment. I
>>>> first suspected Thunderbird, but I get the same result on the google
>>>> mail web client.
>>>>
>>>> Not sure why that happens.
>>>
>>> No idea. They look fine (except mangled links by outlook) on my outlook
>>> desk client and web client on my side. lore looks OK too:
>>> https://lore.kernel.org/linux-mm/20220401135820.1453829-1-zi.yan@sent.com/
>> 
>> I can spot in the raw mail I receive
>> 
>> "Content-Type: application/octet-stream; x-default=true"
>> 
>> But that seems to differ to the lore mail:
>> 
>> https://lore.kernel.org/linux-mm/20220401135820.1453829-1-zi.yan@sent.com/raw
>> 
>> 
>> Maybe something in my mail server chain decides to do some nasty
>> conversion (grml, wouldn't be the first time)
>> 
>
> Weird thing is that this only happens with your mails. I opened an
> internal ticket, sorry for the noise.

Zi's patch emails I received didn't have Content-Type, that might have
something to do with this. (But his reply later in the thread did have
one.) Also last week I got one patch email with no Content-Type either
and my Gnus decided to convert it to octet-stream, I guess to be on the
safe side. No idea if something similar is happening to you, but wanted
to mention it anyway.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
