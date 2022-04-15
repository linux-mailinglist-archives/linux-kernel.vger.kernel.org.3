Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86681502029
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 03:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348485AbiDOBlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 21:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347526AbiDOBls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 21:41:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757F92E8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 18:39:21 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kff8S4d04zgYb6;
        Fri, 15 Apr 2022 09:37:28 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 09:39:19 +0800
Subject: Re: [PATCH] mm/vmscan: fix comment for current_may_throttle
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220414120202.30082-1-linmiaohe@huawei.com>
 <20220414134335.f58a0e13fb2083180a164c1d@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1e551e7b-be35-94d2-05de-9d49dc538d42@huawei.com>
Date:   Fri, 15 Apr 2022 09:39:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220414134335.f58a0e13fb2083180a164c1d@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/15 4:43, Andrew Morton wrote:
> On Thu, 14 Apr 2022 20:02:02 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> Since commit 6d6435811c19 ("remove bdi_congested() and wb_congested() and
>> related functions"), there is no congested backing device check anymore.
>> Correct the comment accordingly.
>>
>> ...
>>
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -2334,8 +2334,7 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
>>  /*
>>   * If a kernel thread (such as nfsd for loop-back mounts) services
>>   * a backing device by writing to the page cache it sets PF_LOCAL_THROTTLE.
>> - * In that case we should only throttle if the backing device it is
>> - * writing to is congested.  In other cases it is safe to throttle.
>> + * In that case we should not throttle it otherwise it is safe to do so.
>>   */
>>  static int current_may_throttle(void)
>>  {
> 
> That's a bit awkward to read.  I tweaked it, and reflowed the comment
> to 80 cols.
> 
> --- a/mm/vmscan.c~mm-vmscan-fix-comment-for-current_may_throttle-fix
> +++ a/mm/vmscan.c
> @@ -2332,9 +2332,9 @@ static unsigned int move_pages_to_lru(st
>  }
>  
>  /*
> - * If a kernel thread (such as nfsd for loop-back mounts) services
> - * a backing device by writing to the page cache it sets PF_LOCAL_THROTTLE.
> - * In that case we should not throttle it otherwise it is safe to do so.
> + * If a kernel thread (such as nfsd for loop-back mounts) services a backing
> + * device by writing to the page cache it sets PF_LOCAL_THROTTLE. In this case
> + * we should not throttle.  Otherwise it is safe to do so.
>   */
>  static int current_may_throttle(void)
>  {
> _

Looks better. Many thanks for doing this! :)

> 
> .
> 

