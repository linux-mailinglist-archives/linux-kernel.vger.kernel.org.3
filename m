Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C42520B0A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 04:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbiEJCOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 22:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiEJCOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 22:14:46 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D6FF27
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 19:10:50 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ky1h2208nz1JBmt;
        Tue, 10 May 2022 10:09:38 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 10:10:48 +0800
Subject: Re: [PATCH 10/15] mm/swap: break the loop if matching device is found
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-11-linmiaohe@huawei.com>
 <20220509141602.b6be120b80d0ab3218fe619a@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e8f23593-1ff7-7204-2b17-2e9901b65098@huawei.com>
Date:   Tue, 10 May 2022 10:10:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220509141602.b6be120b80d0ab3218fe619a@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/10 5:16, Andrew Morton wrote:
> On Mon, 9 May 2022 21:14:11 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> We can break the loop if matching device is found to save some possible
>> cpu cycles because there should be only one matching device and there is
>> no need to continue if the matching one is already found.
>>
>> ...
>>
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -1692,6 +1692,8 @@ int swap_type_of(dev_t device, sector_t offset)
>>  				spin_unlock(&swap_lock);
>>  				return type;
>>  			}
>> +
>> +			break;
>>  		}
>>  	}
>>  	spin_unlock(&swap_lock);
> 
> Are you sure?  If we have two S_ISREG swapfiles on the same device,
> don't they have the same sis->bdev?

Oh, I missed this use case. Sorry about it! :(

> 
> If not, why bother passing `offset' into this function at all?

Yes, you're right. 'offset' indicates the swap header location. Will drop this patch.

Thanks!

> .
> 

