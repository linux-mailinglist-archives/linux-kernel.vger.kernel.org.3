Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDC457DA67
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 08:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbiGVGiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 02:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVGiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 02:38:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137BF15A3B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 23:38:16 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Lq073327nz1M8KS;
        Fri, 22 Jul 2022 14:35:27 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 14:38:13 +0800
Subject: Re: [PATCH 5/5] hugetlbfs: fix confusing hugetlbfs stat
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <akpm@linux-foundation.org>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220721131637.6306-1-linmiaohe@huawei.com>
 <20220721131637.6306-6-linmiaohe@huawei.com> <YtnvFBn8tSm7y/mV@monkey>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f277d8ac-8091-78b4-e168-5dfd87314889@huawei.com>
Date:   Fri, 22 Jul 2022 14:38:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YtnvFBn8tSm7y/mV@monkey>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/22 8:28, Mike Kravetz wrote:
> On 07/21/22 21:16, Miaohe Lin wrote:
>> When size option is not specified, f_blocks, f_bavail and f_bfree will be
>> set to -1 instead of 0. Likewise, when nr_inodes is not specified, f_files
>> and f_ffree will be set to -1 too. Check max_hpages and max_inodes against
>> -1 first to make sure 0 is reported for max/free/used when no limit is set
>> as the comment states.
> 
> Just curious, where are you seeing values reported as -1?  The check

From the standard statvfs() function.

> for sbinfo->spool was supposed to handle these cases.  Seems like it

sbinfo->spool could be created when ctx->max_hpages == -1 while
ctx->min_hpages != -1 in hugetlbfs_fill_super.

> should handle the max_hpages == -1 case.  But, it doesn't look like it
> considers the max_inodes == -1 case.
> 
> If I create/mount a hugetlb filesystem without specifying size or nr_inodes,
> df seems to report zero instead of -1.
> 
> Just want to understand the reasoning behind the change.

I wrote a test program:

#include <sys/statvfs.h>
#include <stdio.h>

int main(void)
{
	struct statvfs buf;

	if (statvfs("/root/huge/", &buf) == -1) {
 		printf("statvfs() error\n");
		return -1;
	}
	printf("f_blocks %lld, f_bavail %lld, f_bfree %lld, f_files %lld, f_ffree %lld\n",
		buf.f_blocks, buf.f_bavail, buf.f_bfree, buf.f_files, buf.f_ffree);
	return 0;
}

And test it in my env:
[root@localhost ~]# mount -t hugetlbfs none /root/huge/
[root@localhost ~]# ./stat
f_blocks 0, f_bavail 0, f_bfree 0, f_files 0, f_ffree 0
[root@localhost ~]# umount /root/huge/
[root@localhost ~]# mount -t hugetlbfs -o min_size=32M none /root/huge/
[root@localhost ~]# ./stat
f_blocks -1, f_bavail -1, f_bfree -1, f_files -1, f_ffree -1
[root@localhost ~]# umount /root/huge/
[root@localhost ~]# mount -t hugetlbfs -o min_size=32M,size=64M none /root/huge/
[root@localhost ~]# ./stat
f_blocks 32, f_bavail 32, f_bfree 32, f_files -1, f_ffree -1
[root@localhost ~]# umount /root/huge/
[root@localhost ~]# mount -t hugetlbfs -o min_size=32M,size=64M,nr_inodes=1024 none /root/huge/
[root@localhost ~]# ./stat
f_blocks 32, f_bavail 32, f_bfree 32, f_files 1024, f_ffree 1023
[root@localhost ~]# umount /root/huge/

Or am I miss something?

> 

Thanks.
