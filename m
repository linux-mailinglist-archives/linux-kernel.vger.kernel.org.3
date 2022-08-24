Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9660E59F128
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiHXBzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiHXBzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:55:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AD274358
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:54:59 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MC8FC3r2LzXdvf;
        Wed, 24 Aug 2022 09:50:39 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 09:54:42 +0800
Message-ID: <fef11350-48c6-a73f-1004-b93c3c1263c8@huawei.com>
Date:   Wed, 24 Aug 2022 09:54:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH -next] xfs: remove "%Lu" which doesn't meet C standard
To:     "Darrick J. Wong" <djwong@kernel.org>
References: <20220823015517.4160583-1-zengheng4@huawei.com>
 <YwTjv0bpf3Ed0JjS@magnolia>
From:   Zeng Heng <zengheng4@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
In-Reply-To: <YwTjv0bpf3Ed0JjS@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I'm pleasure send more similar patches if they were a bit helpful 
for xfs.

Besides, I'm just a rookie in XFS, and have read about your edition of

<XFS Algorithms & Data Structures>.

Just let you know, it's a good job.


Best Regards,

Zeng Heng


在 2022/8/23 22:27, Darrick J. Wong 写道:
> On Tue, Aug 23, 2022 at 09:55:17AM +0800, Zeng Heng wrote:
>> The "%Lu" specifier, which represents long long unsigned,
>> doesn't meet C language standard, and even more,
>> it makes people easily mistake with "%lu", which represent
>> long unsigned. So replace "%Lu" with "llu".
>>
>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> Yesss finally fixing this
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>
> --D
>
>> ---
>>   fs/xfs/xfs_inode.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
>> index 28493c8e9bb2..b3eeeae3afe1 100644
>> --- a/fs/xfs/xfs_inode.c
>> +++ b/fs/xfs/xfs_inode.c
>> @@ -3119,7 +3119,7 @@ xfs_iflush(
>>   	if (XFS_TEST_ERROR(dip->di_magic != cpu_to_be16(XFS_DINODE_MAGIC),
>>   			       mp, XFS_ERRTAG_IFLUSH_1)) {
>>   		xfs_alert_tag(mp, XFS_PTAG_IFLUSH,
>> -			"%s: Bad inode %Lu magic number 0x%x, ptr "PTR_FMT,
>> +			"%s: Bad inode %llu magic number 0x%x, ptr "PTR_FMT,
>>   			__func__, ip->i_ino, be16_to_cpu(dip->di_magic), dip);
>>   		goto flush_out;
>>   	}
>> @@ -3129,7 +3129,7 @@ xfs_iflush(
>>   		    ip->i_df.if_format != XFS_DINODE_FMT_BTREE,
>>   		    mp, XFS_ERRTAG_IFLUSH_3)) {
>>   			xfs_alert_tag(mp, XFS_PTAG_IFLUSH,
>> -				"%s: Bad regular inode %Lu, ptr "PTR_FMT,
>> +				"%s: Bad regular inode %llu, ptr "PTR_FMT,
>>   				__func__, ip->i_ino, ip);
>>   			goto flush_out;
>>   		}
>> @@ -3140,7 +3140,7 @@ xfs_iflush(
>>   		    ip->i_df.if_format != XFS_DINODE_FMT_LOCAL,
>>   		    mp, XFS_ERRTAG_IFLUSH_4)) {
>>   			xfs_alert_tag(mp, XFS_PTAG_IFLUSH,
>> -				"%s: Bad directory inode %Lu, ptr "PTR_FMT,
>> +				"%s: Bad directory inode %llu, ptr "PTR_FMT,
>>   				__func__, ip->i_ino, ip);
>>   			goto flush_out;
>>   		}
>> @@ -3158,7 +3158,7 @@ xfs_iflush(
>>   	if (XFS_TEST_ERROR(ip->i_forkoff > mp->m_sb.sb_inodesize,
>>   				mp, XFS_ERRTAG_IFLUSH_6)) {
>>   		xfs_alert_tag(mp, XFS_PTAG_IFLUSH,
>> -			"%s: bad inode %Lu, forkoff 0x%x, ptr "PTR_FMT,
>> +			"%s: bad inode %llu, forkoff 0x%x, ptr "PTR_FMT,
>>   			__func__, ip->i_ino, ip->i_forkoff, ip);
>>   		goto flush_out;
>>   	}
>> -- 
>> 2.25.1
>>
