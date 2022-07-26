Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694A75814C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbiGZODy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbiGZODw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:03:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DADB1262F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:03:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCE3D61618
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 14:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954C0C433D6;
        Tue, 26 Jul 2022 14:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658844231;
        bh=nuoaHapxy+kdCtIiY/eWKlFYJB/dZW+a0RR33I/yFmA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fcopf3ICeT8v4NnvPQ9skNVNT4AC6OgccMV3gCJfSaRiQUvlo9sOiLKtu0f4jHjVA
         I6LGGJKizFbC1H5vWJf9kW5bnkHrfPLCOcYUAd885TjyzTfh1jwQKCFpuSuRqRS05k
         oOHaYuyxuXXTRzMBBkO9+4CKw0puGfncKZOjzRbYYOZaNCXH38IqSsgVaYpH3FGVkW
         q0BbKSdAPBgXT78HCnZcl/1qdiUto5BJkQdrDMvPpbUsQdyK66hrRHGyBNfY0Nxibx
         qk8qo+7WBDZqxA9UeqAd/eXKEEB68RE3fP2lmCBL8GcyZA+J7nWGHXYKgI4FauimF4
         eCFQ3SjWp0Mmg==
Message-ID: <ce6f3bcf-fe77-d042-4517-dd09d090b70b@kernel.org>
Date:   Tue, 26 Jul 2022 16:03:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm/page_owner.c: allow page_owner with given
 start_pfn/count
Content-Language: en-US
To:     Kassey Li <quic_yingangl@quicinc.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, minchan@kernel.org,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, quic_guptap@quicinc.com
References: <20220722150810.27740-1-quic_yingangl@quicinc.com>
 <YtrEXB6o+VROImdg@casper.infradead.org>
 <e518246c-4ffa-14af-e568-798572f75bee@quicinc.com>
From:   "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <e518246c-4ffa-14af-e568-798572f75bee@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/22 10:39, Kassey Li wrote:
> hi, Matthew:
>     sorry for the delay, I just started to learn how to upstream patch, and
> setup my Thunderbird with plain text only.
>     you are right, two users will cause problem here.
>     the uses case is dump CMA area to understand the page usage in a given
> cma pool. 2nd, dump whole memory page owner is very time cost, mostly our
> android device has 8G memory now.
>     I will research and check again, if you have more idea on this , please
> kindly to share.

You could try employing lseek() to specify the start pfn, and as for end
pfn, the process can just stop reading and close when it has seen enough?

> BR
> Kassey
> 
> On 7/22/2022 11:38 PM, Matthew Wilcox wrote:
>> On Fri, Jul 22, 2022 at 11:08:10PM +0800, Kassey Li wrote:
>>> by default, page_owner iterates all page from min_low_pfn to
>>> max_pfn, this cost too much time if we want an alternative pfn range.
>>>
>>> with this patch it allows user to set pfn range to dump the page_onwer.
>>
>> This is a really bad UI.  If two users try to do different ranges at the
>> same time, it'll go wrong.  What use cases are you actually trying to
>> solve?
> 

