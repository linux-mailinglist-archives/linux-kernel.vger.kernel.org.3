Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F45582510
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiG0K7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiG0K7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:59:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75695491F0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:59:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13015B82016
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46036C433B5;
        Wed, 27 Jul 2022 10:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658919579;
        bh=rt7aES8/Hzlk/Y+2Fqy8g4ajbN0y3PoWZvROhgiQ80Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K2N/H6wkNiaX4mYYBDNVTGiXimHHrMudSzduFYV+r5tPZHn1Sow+uzDaT5lCDcyrX
         yrFVEdsusIks/GBsnYpUHtfe0yaLJnBecf0+7RFnqzO2bYHcR0XtlpmIoUBQVBWco+
         hU119b/JJHrCOXGq0GEh/gw2RRrRcgwe88MVBGlXcc7rBXuabdbDA4uPTIygdKDq2V
         v2KR90Y84e0DaavIxxnVMhhcL35Q/eUQ2QOjvXf0cNgMIO8GGtigD6KFhi9AQ9Vejg
         xhonZJMveI9/jsjRfBKJKp6NfW14roNbmO7HxRCA6tpn9UhvZxejD2WuHwzVHbDYgp
         uRrbKrZhoCwZg==
Message-ID: <ef94e33b-a006-ab3c-b6f9-e567220eb94c@kernel.org>
Date:   Wed, 27 Jul 2022 12:59:36 +0200
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
 <ce6f3bcf-fe77-d042-4517-dd09d090b70b@kernel.org>
 <b2814a36-4021-b2a4-52db-6ac707d32835@quicinc.com>
From:   "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <b2814a36-4021-b2a4-52db-6ac707d32835@quicinc.com>
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

On 7/27/22 09:44, Kassey Li wrote:
> 
> 
> On 7/26/2022 10:03 PM, Vlastimil Babka (SUSE) wrote:
>> On 7/25/22 10:39, Kassey Li wrote:
>>> hi, Matthew:
>>>      sorry for the delay, I just started to learn how to upstream patch, and
>>> setup my Thunderbird with plain text only.
>>>      you are right, two users will cause problem here.
>>>      the uses case is dump CMA area to understand the page usage in a given
>>> cma pool. 2nd, dump whole memory page owner is very time cost, mostly our
>>> android device has 8G memory now.
>>>      I will research and check again, if you have more idea on this , please
>>> kindly to share.
>>
>> You could try employing lseek() to specify the start pfn, and as for end
>> pfn, the process can just stop reading and close when it has seen enough?
> 
> lseek is a good idea.
> read_page_owner start with below
>     pfn = min_low_pfn + *ppos;
> so we need to export the min_low_pfn to user then decide the ppos to seek.
> (my_cma.base_pfn - min_low_pfn) is the ppos we want to set.

Hm could we just pfn = *ppos and then anything below min_low_pfn is skipped
internally? So we don't need to teach userspace min_low_pfn.

> is there concern to export min_low_pfn  ?
> or use a mutex lock for my previous debugfs version patch ?
> 
>>
>>> BR
>>> Kassey
>>>
>>> On 7/22/2022 11:38 PM, Matthew Wilcox wrote:
>>>> On Fri, Jul 22, 2022 at 11:08:10PM +0800, Kassey Li wrote:
>>>>> by default, page_owner iterates all page from min_low_pfn to
>>>>> max_pfn, this cost too much time if we want an alternative pfn range.
>>>>>
>>>>> with this patch it allows user to set pfn range to dump the page_onwer.
>>>>
>>>> This is a really bad UI.  If two users try to do different ranges at the
>>>> same time, it'll go wrong.  What use cases are you actually trying to
>>>> solve?
>>>
>>

