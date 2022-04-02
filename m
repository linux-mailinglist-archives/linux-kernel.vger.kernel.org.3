Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E3C4EFF82
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 09:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbiDBHy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 03:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236552AbiDBHyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 03:54:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CED41AC418
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 00:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4EB06106D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 07:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358E6C340EE;
        Sat,  2 Apr 2022 07:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648885953;
        bh=YIMugAx6SP0UDoekYs2akzusEyckH9HLDYh5AdeaFY4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Zq8CHYF4q6TCoaJj1RLtHjmm9eKoGFkckU54LCpjZrpq1iTjgFPpoTm9KGgMTxLDn
         s53givX6Rsw3o4cW+mPLC+hOwPGurmOqUs2SGpg0Db6fOTUIkUd3TjYp5Wi1rg83O0
         WvQIAZmgerkPR2H1SYSFaJOChde6BJ3Onz0cU2vDazmYyPAw1Etb52N9wjd/5wnlCM
         RDB9O7nRpUj6+RATkXq8zloTFnSLVgGkMXK92X1YB5soXdcnYwcYuyMaQUpQq6A670
         SlpidCSKQrWC9EVOerpQGl9JI85szZoqT4hZNLyxosfgZfdol3dRgeCXinRlN2oWoe
         9GDaZnYAmmoaQ==
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
        <87sfqwszc2.fsf@tynnyri.adurom.net>
Date:   Sat, 02 Apr 2022 10:52:25 +0300
In-Reply-To: <87sfqwszc2.fsf@tynnyri.adurom.net> (Kalle Valo's message of
        "Sat, 02 Apr 2022 10:45:33 +0300")
Message-ID: <87mth3udl2.fsf@tynnyri.adurom.net>
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

Kalle Valo <kvalo@kernel.org> writes:

> David Hildenbrand <david@redhat.com> writes:
>
>> On 01.04.22 16:22, David Hildenbrand wrote:
>>> On 01.04.22 16:19, Zi Yan wrote:
>>>> On 1 Apr 2022, at 10:12, David Hildenbrand wrote:
>>>>
>>>>> On 01.04.22 15:58, Zi Yan wrote:
>>>>>
>>>>> It's weird, your mails arrive on my end as empty body with attachment. I
>>>>> first suspected Thunderbird, but I get the same result on the google
>>>>> mail web client.
>>>>>
>>>>> Not sure why that happens.
>>>>
>>>> No idea. They look fine (except mangled links by outlook) on my outlook
>>>> desk client and web client on my side. lore looks OK too:
>>>> https://lore.kernel.org/linux-mm/20220401135820.1453829-1-zi.yan@sent.com/
>>> 
>>> I can spot in the raw mail I receive
>>> 
>>> "Content-Type: application/octet-stream; x-default=true"
>>> 
>>> But that seems to differ to the lore mail:
>>> 
>>> https://lore.kernel.org/linux-mm/20220401135820.1453829-1-zi.yan@sent.com/raw
>>> 
>>> 
>>> Maybe something in my mail server chain decides to do some nasty
>>> conversion (grml, wouldn't be the first time)
>>> 
>>
>> Weird thing is that this only happens with your mails. I opened an
>> internal ticket, sorry for the noise.
>
> Zi's patch emails I received didn't have Content-Type, that might have
> something to do with this. (But his reply later in the thread did have
> one.) Also last week I got one patch email with no Content-Type either
> and my Gnus decided to convert it to octet-stream, I guess to be on the
> safe side. No idea if something similar is happening to you, but wanted
> to mention it anyway.

Just to clarify, I assumed Gnus was doing the conversion to octet-stream
but I never verified that.

Heh, interestingly enough that patch was sent from redhat.com:

https://lore.kernel.org/all/877d8eyz61.fsf@kernel.org/

Is that just a coincidence or are Redhat servers doing something
strange? If you find out, do let me know. I'm very curious :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
