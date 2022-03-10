Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16814D4295
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240380AbiCJIeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240370AbiCJIeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:34:15 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CEF5D5F7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:33:13 -0800 (PST)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KDj0T2C8mz9sYG;
        Thu, 10 Mar 2022 16:29:29 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 16:33:11 +0800
Subject: Re: [PATCH -next] ubifs: rename_whiteout: correct old_dir size
 computing
To:     <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yukuai3@huawei.com>, Zhihao Cheng <chengzhihao1@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20220215040736.2839939-1-libaokun1@huawei.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <dc55e8b3-7d22-6024-374d-4ed126e18c42@huawei.com>
Date:   Thu, 10 Mar 2022 16:32:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20220215040736.2839939-1-libaokun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500020.china.huawei.com (7.185.36.88)
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

A gentle ping, sorry for the noise.


在 2022/2/15 12:07, Baokun Li 写道:
> When renaming the whiteout file, the old whiteout file is not deleted.
> Therefore, we add the old dentry size to the old dir like XFS.
> Otherwise, an error may be reported due to `fscki->calc_sz != fscki->size`
> in check_indes.
>
> Fixes: 9e0a1fff8db56ea ("ubifs: Implement RENAME_WHITEOUT")
> Reported-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/ubifs/dir.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
> index ae082a0be2a3..86151889548e 100644
> --- a/fs/ubifs/dir.c
> +++ b/fs/ubifs/dir.c
> @@ -1402,6 +1402,9 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
>   			iput(whiteout);
>   			goto out_release;
>   		}
> +
> +		/* Add the old_dentry size to the old_dir size. */
> +		old_sz -= CALC_DENT_SIZE(fname_len(&old_nm));
>   	}
>   
>   	lock_4_inodes(old_dir, new_dir, new_inode, whiteout);

-- 
With Best Regards,
Baokun Li

