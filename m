Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866A94DBA73
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 23:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244273AbiCPWBc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Mar 2022 18:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiCPWBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 18:01:31 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C00C2C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 15:00:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 741E76081104;
        Wed, 16 Mar 2022 23:00:13 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SdOFjOGIOYjO; Wed, 16 Mar 2022 23:00:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8F5366081107;
        Wed, 16 Mar 2022 23:00:12 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Z-NKGvmhIHbB; Wed, 16 Mar 2022 23:00:12 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6C6776081104;
        Wed, 16 Mar 2022 23:00:12 +0100 (CET)
Date:   Wed, 16 Mar 2022 23:00:12 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     libaokun <libaokun1@huawei.com>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        yukuai3 <yukuai3@huawei.com>,
        chengzhihao1 <chengzhihao1@huawei.com>
Message-ID: <157336576.152785.1647468012272.JavaMail.zimbra@nod.at>
In-Reply-To: <dc55e8b3-7d22-6024-374d-4ed126e18c42@huawei.com>
References: <20220215040736.2839939-1-libaokun1@huawei.com> <dc55e8b3-7d22-6024-374d-4ed126e18c42@huawei.com>
Subject: Re: [PATCH -next] ubifs: rename_whiteout: correct old_dir size
 computing
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: rename_whiteout: correct old_dir size computing
Thread-Index: qEsEa6jzfGu0qBp13jytxNkZcU+ggw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "libaokun" <libaokun1@huawei.com>
> An: "richard" <richard@nod.at>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>
> CC: "yukuai3" <yukuai3@huawei.com>, "chengzhihao1" <chengzhihao1@huawei.com>, "libaokun" <libaokun1@huawei.com>
> Gesendet: Donnerstag, 10. März 2022 09:32:57
> Betreff: Re: [PATCH -next] ubifs: rename_whiteout: correct old_dir size computing

> A gentle ping, sorry for the noise.

I have to say sorry for the day.
Thanks for your patience with me.
 
> 
> 在 2022/2/15 12:07, Baokun Li 写道:
>> When renaming the whiteout file, the old whiteout file is not deleted.
>> Therefore, we add the old dentry size to the old dir like XFS.
>> Otherwise, an error may be reported due to `fscki->calc_sz != fscki->size`
>> in check_indes.
>>
>> Fixes: 9e0a1fff8db56ea ("ubifs: Implement RENAME_WHITEOUT")
>> Reported-by: Zhihao Cheng <chengzhihao1@huawei.com>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/ubifs/dir.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
>> index ae082a0be2a3..86151889548e 100644
>> --- a/fs/ubifs/dir.c
>> +++ b/fs/ubifs/dir.c
>> @@ -1402,6 +1402,9 @@ static int do_rename(struct inode *old_dir, struct dentry
>> *old_dentry,
>>   			iput(whiteout);
>>   			goto out_release;
>>   		}
>> +
>> +		/* Add the old_dentry size to the old_dir size. */
>> +		old_sz -= CALC_DENT_SIZE(fname_len(&old_nm));

So you basically reset old_sz back to 0?

Thanks,
//richard
