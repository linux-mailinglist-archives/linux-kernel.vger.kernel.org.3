Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F47C4B7D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 03:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343580AbiBPCNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 21:13:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiBPCN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:13:28 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A617D000
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:13:17 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Jz1bV03xGz1FD0V;
        Wed, 16 Feb 2022 10:08:54 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 10:13:14 +0800
Subject: Re: [PATCH v2] mm: clean up hwpoison page cache page in fault path
To:     Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20220212213740.423efcea@imladris.surriel.com>
 <Yguh5JUGHln/iRJ8@localhost.localdomain>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e6eeb84f-cf1d-493e-ce8e-fea6f3679a9e@huawei.com>
Date:   Wed, 16 Feb 2022 10:13:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Yguh5JUGHln/iRJ8@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/15 20:51, Oscar Salvador wrote:
> On Sat, Feb 12, 2022 at 09:37:40PM -0500, Rik van Riel wrote:
>> Sometimes the page offlining code can leave behind a hwpoisoned clean
>> page cache page. This can lead to programs being killed over and over
>> and over again as they fault in the hwpoisoned page, get killed, and
>> then get re-spawned by whatever wanted to run them.
> 
> Hi Rik,
> 
> Do you know how that exactly happens? We should not be really leaving
> anything behind, and soft-offline (not hard) code works with the premise
> of only poisoning a page in case it was contained, so I am wondering
> what is going on here.
> 
> In-use pagecache pages are migrated away, and the actual page is
> contained, and for clean ones, we already do the invalidate_inode_page()
> and then contain it in case we succeed.
> 

IIUC, this could not happen when soft-offlining a pagecache page. They're either
invalidated or migrated away and then we set PageHWPoison.
I think this may happen on a clean pagecache page when it's isolated. So it's !PageLRU.
And identify_page_state treats it as me_unknown because it's non reserved, slab, swapcache
and so on ...(see error_states for details). Or am I miss anything?

Thanks.

> One scenario I can imagine this can happen is if by the time we call
> page_handle_poison(), someone has taken another refcount on the page,
> and the put_page() does not really free it, but I am not sure that
> can happen.
> 

