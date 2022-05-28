Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E4B536B1A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 08:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345565AbiE1GYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 02:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiE1GYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 02:24:41 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4514E3616F
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 23:24:39 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L9BS52BdBz1JBYf;
        Sat, 28 May 2022 14:23:01 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 28 May 2022 14:24:35 +0800
Subject: Re: [PATCH] mm/vmscan: don't try to reclaim freed folios
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220527080451.48549-1-linmiaohe@huawei.com>
 <YpDoAZtQtQf6U8D2@casper.infradead.org>
 <e0502c7c-b71d-5356-fcc3-7c048c25d827@huawei.com>
 <YpGTaCf+bZGdEdNj@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <354f9b86-44fe-493b-eac4-07c5eeb573cf@huawei.com>
Date:   Sat, 28 May 2022 14:24:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YpGTaCf+bZGdEdNj@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/28 11:13, Matthew Wilcox wrote:
> On Sat, May 28, 2022 at 10:52:11AM +0800, Miaohe Lin wrote:
>> On 2022/5/27 23:02, Matthew Wilcox wrote:
>>> What?  No.  This can absolutely happen.  We have a refcount on the folio,
>>> which means that any other thread can temporarily raise the refcount,
>>
>> IIUC, the folio is only in the isolated page_list now and it's not in the page cache, swap cache, pagetable or
>> under any use. So there should be no way that any other thread can temporarily raise the refcount when
>> folio_ref_count == 1. Or am I miss something?
> 
> Take a look at something like GUP (fast).  If this page _was_ mapped to
> userspace, something like this can happen:
> 
> Thread A	Thread B
> load PTE
> 		unmap page
> 		refcount goes to 1
> 		vmscan sees the page
> try_get_ref
> 		refcount is now 2.  WARN_ON.
> 
> Thread A will see that the PTE has changed and will now drop its
> reference, but Thread B already spat out the WARN.
> 
> A similar thing can happen with the page cache.

Oh, I see. Many thanks for your patient explanation! :)

> 
> If this is a worthwhile optimisation (does it happen often that we find
> a refcount == 1 page?), we could do something like ...

No, It should be rare.

> 
> 		if (folio_ref_freeze(folio, 1)) {
> 			nr_pages = folio_nr_pages(folio);
> 			goto free_it;
> 		}
> 
> ... or ...
> 
> 		if (folio_ref_count(folio) == 1 &&
> 		    folio_ref_freeze(folio, 1)) {
> 
> ... if we want to test-and-test-and-clear

These proposed code changes look good to me.

> 
> But this function is far too complicated already.  I really want to
> see numbers that proves the extra complexity is worth it.

This optimization can save lots of cpu cycles and avoid possible disk I/O in
that specified case. But that is a somewhat rare case. So there's no numbers
that proves the extra complexity is worth it.

Should I drop this patch or proceed with the proposed code changes above in
next version? :)

Many thanks!

> 
> 
> .
> 

