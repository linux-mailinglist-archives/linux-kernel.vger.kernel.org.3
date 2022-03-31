Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579214ED651
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiCaI66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbiCaI65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:58:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2511EF5C7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:57:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BAB291FD03;
        Thu, 31 Mar 2022 08:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648717028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o+QZvD8swjFnMSJcmeUxxDnjqZ670h4F9PHw1e2uO6Y=;
        b=DmVMe88X3xPisr03GZBMxO5DXXi9/CkJGwJrW1Oco73dhNHYTLOIcv4psO68j1x4APyjGD
        h/fDXEYsHFkjziCZpf/ZsZ2OfEUSR94mZr0A9qZB4Drtc35nGHRJB5XQ9xm3sifmA9thWb
        HR8pPbJnKdDkNashwvh2t5bqB+HTz8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648717028;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o+QZvD8swjFnMSJcmeUxxDnjqZ670h4F9PHw1e2uO6Y=;
        b=KwH0swrJbUSJFqGbJXITNAgtw3SAxx4MzaJ9KGYutSuFtaD5X+/We2vRP2DeYlLGRUMV6m
        lwTVRIEMjMyxJnDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8CE10133D4;
        Thu, 31 Mar 2022 08:57:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MxO9IeRsRWIlKwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 31 Mar 2022 08:57:08 +0000
Message-ID: <3c30c5e9-c2fb-9f24-1207-8c342045996b@suse.cz>
Date:   Thu, 31 Mar 2022 10:57:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] mm: page_alloc: validate buddy before check its
 migratetype.
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220330221238.396357-1-zi.yan@sent.com>
 <CAHk-=whZ7d8Z4rv5oV9+FLEEk_1A1X=JsJaeAmFZzhDxLqDLFg@mail.gmail.com>
 <63234E12-AF64-4D85-A2BF-8A4EF5359F91@nvidia.com>
 <7586AEB3-FE81-4D51-ADAE-737E74625444@nvidia.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <7586AEB3-FE81-4D51-ADAE-737E74625444@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 02:10, Zi Yan wrote:
> On 30 Mar 2022, at 19:48, Zi Yan wrote:
> 
>> On 30 Mar 2022, at 19:03, Linus Torvalds wrote:
>>
>>> On Wed, Mar 30, 2022 at 3:12 PM Zi Yan <zi.yan@sent.com> wrote:
>>>>
>>>> Fixes: 1dd214b8f21c ("mm: page_alloc: avoid merging non-fallbackable pageblocks with others")
>>>
>>> Oh, btw - should this perhaps be backported further back than that
>>> alleged "fixes" commit?
>>>
>>> It does look like maybe the problem potentially existed before too,
>>> and was just much harder to trigger.
>>>
>>> That said, google doesn't find any other reports that look like
>>> Steven's oops, so maybe it really never happened and backporting isn't
>>> called for.
>>>
>>> Or possibly my google-fu is just bad.
>>>
>>
>> There might not be any issue with the original code because this bug
>> could only be triggered when CONFIG_FLATMEM and CONFIG_MEMORY_ISOLATION
>> are both set, which never happens, since CONFIG_MEMORY_ISOLATION
>> depends on CONFIG_SPARSEMEM.

Good point. Which means unset_migratetype_isolate() that Linus pointed
out, is currently also safe as it's a CONFIG_MEMORY_ISOLATION code.
We could still implement the suggested page_find_buddy() wrapper using
page_is_buddy() internally, as well as the cleanup of __free_one_page(),
but it's not urgent.

>> By checking Steven's boot log, it should be PFN 0x21ee00 that triggers
>> the bug, since the physical memory range ends at PFN 0x21edff.
>> PFN 0x21ee00 is 2MB aligned instead of MAX_ORDER-1 (4MB) aligned.
>> The original code assumes all physical memory ranges are at least
>> MAX_ORDER-1 aligned, which is true when CONFIG_SPARSEMEM is set
>> (CONFIG_MEMORY_ISOLATION depends on it), since CONFIG_SPARSEMEM
>> allocates pageblock_flags array (the NULL-deferenced bitmap points
>> to) at section size granularity (128MB > 4MB). However, CONFIG_FLATMEM
>> does not do this. It allocates pageblock_flags array at the exact size
>> of the physical memory. So checking 0x21ee00 will not cause NULL
>> dereferencing when CONFIG_MEMORY_ISOLATION is set and the original
>> if statement can be true.
>>
>> Now I am wondering if the page_is_buddy() check is correct for
>> CONFIG_FLATMEM. Is mem_map allocation aligned to MAX_ORDER-1
>> or just the present physical memory range? Is PageBuddy(0x21ee00)
>> accessing some random memory location?
> 
> OK. mem_map seems to be MAX_ORDER-1 aligned, so there is no
> problem with PageBuddy(0x21ee00).

Yeah mem_map has to be in all config variants, otherwise buddy merging
would have been blowing up in page_is_buddy() even prior to all the
"sometimes avoid merging pageblock" changes.
> 
> --
> Best Regards,
> Yan, Zi

