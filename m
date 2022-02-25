Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20794C4259
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239523AbiBYKbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiBYKbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:31:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B352A1DFDEE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:31:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6CECD1F383;
        Fri, 25 Feb 2022 10:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645785070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8kSziZZrqJ3nLAuA7rj14nn/xJ0IVe+nf3bzOwN4ymI=;
        b=DuS6UudmWm4sbbGXhniuF82BrNVH2WbxHPDRwFTASY/twC2hrVyDC+bwglZqbE5mj9crUp
        xSxaiCJjxQz3XW0XAmFiKXllq1evx0zEo47J6FpA1JI1c06I0vwRkc0bYw8iezvYSJkqap
        RT+51SmpBd4k4WgmZ28oicDmj6APqt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645785070;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8kSziZZrqJ3nLAuA7rj14nn/xJ0IVe+nf3bzOwN4ymI=;
        b=IIVQHfcHKwywRhtLNnXt+/yVYtW06ooXWxUc2tLF7FzHWzi/yIXhsZnsk87je9zwWmxYQO
        2q2CfpR42SQU1+AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3267A13ACB;
        Fri, 25 Feb 2022 10:31:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jx2iC+6vGGK4dAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 25 Feb 2022 10:31:10 +0000
Message-ID: <cf1f5f29-2be3-f9c9-f4d6-78a1bccf6e31@suse.cz>
Date:   Fri, 25 Feb 2022 11:31:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        =?UTF-8?Q?Jakub_Mat=c4=9bna?= <matenajakub@gmail.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "willy@infradead.org" <willy@infradead.org>,
        "hughd@google.com" <hughd@google.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "riel@surriel.com" <riel@surriel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org" <peterz@infradead.org>
References: <20220218122019.130274-1-matenajakub@gmail.com>
 <20220218192143.jdqcf4igcjpezmrz@revolver>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH 0/4] Removing limitations of merging anonymous VMAs
In-Reply-To: <20220218192143.jdqcf4igcjpezmrz@revolver>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/22 20:21, Liam Howlett wrote:
> * Jakub Matěna <matenajakub@gmail.com> [220218 07:21]:
>> Motivation
>> In the current kernel it is impossible to merge two anonymous VMAs
>> if one of them was moved. That is because VMA's page offset is
>> set according to the virtual address where it was created and in
>> order to merge two VMA's page offsets need to follow up.
>> Another problem when merging two VMA's is their anon_vma. In
>> current kernel these anon_vmas have to be the one and the same.
>> Otherwise merge is again not allowed.
>> Missed merge opportunities increase the number of VMAs of a process
>> and in some cases can cause problems when a max count is reached.
> 
> Does this really happen that much?  Is it worth trying even harder to

Let me perhaps clarify. Maybe not in general, but some mremap() heavy
workloads fragment VMA space a lot, have to increase the vma limits etc.
While the original motivation was a proprietary workload, there are e.g.
allocators such as jemalloc that rely on mremap().

But yes, it might turn out that the benefit is not universal and we might
consider some ways to make more aggressive merging opt-in.

> merge VMAs?  I am not really sure the VMA merging today is worth it - we
> are under a lock known to be a bottleneck while examining if it's

I'd be afraid that by scaling back existing merging would break some
userspace expectations inspecting e.g. /proc/pid/maps

> possible to merge.  Hard data about how often and the cost of merging
> would be a good argument to try harder or give up earlier.
> 
>> 
>> Solution
>> Following series of these patches solves the first problem with
>> page offsets by updating them when the VMA is moved to a
>> different virtual address (patch 2). As for the second
>> problem merging of VMAs with different anon_vma is allowed
>> (patch 3). Patch 1 refactors function vma_merge and
>> makes it easier to understand and also allows relatively
>> seamless tracing of successful merges introduced by the patch 4.
>> 
>> Limitations
>> For both problems solution works only for VMAs that do not share
>> physical pages with other processes (usually child or parent
>> processes). This is checked by looking at anon_vma of the respective
>> VMA. The reason why it is not possible or at least not easy to
>> accomplish is that each physical page has a pointer to anon_vma and
>> page offset. And when this physical page is shared we cannot simply
>> change these parameters without affecting all of the VMAs mapping
>> this physical page. Good thing is that this case amounts only for
>> about 1-3% of all merges (measured for internet browsing and
>> compilation use cases) that fail to merge in the current kernel.
> 
> It sounds like you have data for some use cases on the mergers already.
> Do you have any results on this change?
> 
>> 
>> This series of patches and documentation of the related code will
>> be part of my master's thesis.
>> This patch series is based on tag v5.17-rc4.
>> 
>> Jakub Matěna (4):
>>   mm: refactor of vma_merge()
>>   mm: adjust page offset in mremap
>>   mm: enable merging of VMAs with different anon_vmas
>>   mm: add tracing for VMA merges
>> 
>>  include/linux/rmap.h        |  17 ++-
>>  include/trace/events/mmap.h |  55 +++++++++
>>  mm/internal.h               |  11 ++
>>  mm/mmap.c                   | 232 ++++++++++++++++++++++++++----------
>>  mm/rmap.c                   |  40 +++++++
>>  5 files changed, 290 insertions(+), 65 deletions(-)
>> 
>> -- 
>> 2.34.1
>> 

