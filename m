Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA67E597EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243723AbiHRG7k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 18 Aug 2022 02:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239022AbiHRG7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 02:59:33 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B01B6EF0E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 23:59:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id AB65D61F1132;
        Thu, 18 Aug 2022 08:59:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id B7xKpa3dEKri; Thu, 18 Aug 2022 08:59:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 45B1F61F113A;
        Thu, 18 Aug 2022 08:59:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id I6RGV6UGPG4Y; Thu, 18 Aug 2022 08:59:28 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 23A6A61F1132;
        Thu, 18 Aug 2022 08:59:28 +0200 (CEST)
Date:   Thu, 18 Aug 2022 08:59:27 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     cuigaosheng <cuigaosheng1@huawei.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        gongruiqi1@huawei.com, wangweiyang2@huawei.com
Message-ID: <1160016027.119085.1660805967979.JavaMail.zimbra@nod.at>
In-Reply-To: <6733eee6-bfb6-7ee9-1331-2a739520fcd5@huawei.com>
References: <20220715071105.2321311-1-cuigaosheng1@huawei.com> <6733eee6-bfb6-7ee9-1331-2a739520fcd5@huawei.com>
Subject: Re: [PATCH -next] mtd/ftl: Fix memleak in ftl_add_mtd()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: mtd/ftl: Fix memleak in ftl_add_mtd()
Thread-Index: V5oJKIljgIpBvfWjk+sGiwgnVw0TaA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "cuigaosheng" <cuigaosheng1@huawei.com>
>
> PING

There seems to be a problem with your caps lock key. ;-)
 
> 在 2022/7/15 15:11, Gaosheng Cui 写道:
>> When add_mtd_blktrans_dev failed, partition's memory will be freed
>> by kfree, but there are some structure members that are allocated
>> for memory independently, such as partition->VirtualBlockMap,
>> partition->EUNInfo, partition->ZferInfo, and partition->bam_cache,
>> so kfree(partition) may cause memory leaks, using ftl_freepart(partition)
>> will fix it.

Is this leak observable via kmemleak or such?
I always thought ->remove_dev() unconditionally do a cleanup later.

>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>> ---
>>   drivers/mtd/ftl.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mtd/ftl.c b/drivers/mtd/ftl.c
>> index f655d2905270..200271bdc7aa 100644
>> --- a/drivers/mtd/ftl.c
>> +++ b/drivers/mtd/ftl.c
>> @@ -1031,6 +1031,7 @@ static void ftl_add_mtd(struct mtd_blktrans_ops *tr,
>> struct mtd_info *mtd)
>>   		partition->mbd.devnum = -1;
>>   		if (!add_mtd_blktrans_dev(&partition->mbd))
>>   			return;
>> +		ftl_freepart(partition);
>>   	}
>>   
> >   	kfree(partition);
