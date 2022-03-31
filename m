Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45D54ED2E7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiCaEPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiCaEO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:14:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B1529E4ED
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 20:49:11 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KTTkl5BWJzCqvT;
        Thu, 31 Mar 2022 11:46:55 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 31 Mar 2022 11:49:09 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 31 Mar 2022 11:49:09 +0800
Subject: Re: [PATCH -next] fs: sysv: check sbi->s_firstdatazone in
 complete_read_super
To:     Christoph Hellwig <hch@infradead.org>
References: <20220330104215.530223-1-liushixin2@huawei.com>
 <YkR6WdjLJyF0PMcd@infradead.org>
CC:     <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <a8d491c5-5af5-a9ee-441e-27fdf233eb93@huawei.com>
Date:   Thu, 31 Mar 2022 11:49:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YkR6WdjLJyF0PMcd@infradead.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The type I used is sysv v7.

I discovered this problem through a syzkaller use case. The use case first create a file
via memfd and bind it to loop0. Then mount it to a folder with type v7. No error is
reported for preceding operations. Finally when create a file, the warning in inc_nlink
is triggered. I want to look the filesystem information, so I execute 'df' command and
find this problem.

Btw, I think the warning may be a follow-up problem caused by the filesystem being
created or mounted incorrectly.

Thanks,

On 2022/3/30 23:42, Christoph Hellwig wrote:
> On Wed, Mar 30, 2022 at 06:42:15PM +0800, Liu Shixin wrote:
>> sbi->s_firstinodezone is initialized to 2 and sbi->s_firstdatazone is read
>> from sbd. There's no guarantee that sbi->s_firstdatazone must bigger than
>> sbi->s_firstinodezone. If sbi->s_firstdatazone less than 2, the filesystem
>> can still be mounted unexpetly. At this point, sbi->s_ninodes flip to very
>> large value and this filesystem is broken. We can observe this by
>> executing 'df' command. When we execute, we will get an error message:
>> 	"sysv_count_free_inodes: unable to read inode table"
> This looks fine.  Just curious: which variant of the sysv fs do you
> use and what is the use case?
> .
>

