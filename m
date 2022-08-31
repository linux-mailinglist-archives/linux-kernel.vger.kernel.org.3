Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520F55A7A8B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiHaJss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiHaJsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:48:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254F9CEB13;
        Wed, 31 Aug 2022 02:48:39 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MHfRF6VD9zkWm8;
        Wed, 31 Aug 2022 17:44:57 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 31 Aug 2022 17:48:37 +0800
Received: from [127.0.0.1] (10.174.177.249) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 17:48:36 +0800
Subject: Re: [PATCH] xfs: donot need to check return value of xlog_kvmalloc()
To:     Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     linfeilong <linfeilong@huawei.com>,
        wuguanghao <wuguanghao3@huawei.com>
References: <514e5e4b-e7c8-365f-8459-75974c067993@huawei.com>
 <0ba12a13-6cc4-5f44-fa06-ead350f819d5@sandeen.net>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <b83283b2-39b3-c659-1b9f-f774af47d3f8@huawei.com>
Date:   Wed, 31 Aug 2022 17:48:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0ba12a13-6cc4-5f44-fa06-ead350f819d5@sandeen.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.249]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/30 0:06, Eric Sandeen wrote:
> On 8/22/22 6:46 AM, Zhiqiang Liu wrote:
>> In xfs_attri_log_nameval_alloc(), xlog_kvmalloc() is called
>> to alloc memory, which will always return
>> successfully, so we donot need to check return value.
>>
>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> I think this is fine. xlog_kvmalloc loops until success, and its other
> caller does not check the return value.
>
> This isn't really strictly a fix (it's harmless) but it "fixes"
>
> Fixes: commit 4183e4f27f402 ("xfs: share xattr name and value buffers when logging xattr updates")
>
> Reviewed-by: Eric Sandeen <sandeen@redhat.com>

Thanks for your reply.

Before xlog_kvmalloc was changed to "loops until success", the sanity check was necessary.

As you said, this isn't really strictly a fix, so I think we should not add the Fix tag.

> That said, I think that xfs_attri_log_nameval_alloc() also cannot fail, so
> perhaps its callers don't need checks either?
Yes, you are right. I will clean it up in the V2 patch.

>> ---
>>  fs/xfs/xfs_attr_item.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
>> index 5077a7ad5646..667e151a2bca 100644
>> --- a/fs/xfs/xfs_attr_item.c
>> +++ b/fs/xfs/xfs_attr_item.c
>> @@ -86,8 +86,6 @@ xfs_attri_log_nameval_alloc(
>>  	 */
>>  	nv = xlog_kvmalloc(sizeof(struct xfs_attri_log_nameval) +
>>  					name_len + value_len);
>> -	if (!nv)
>> -		return nv;
>>
>>  	nv->name.i_addr = nv + 1;
>>  	nv->name.i_len = name_len;
> .

