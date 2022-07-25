Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4483B57FCC1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbiGYJyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiGYJyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:54:20 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71C48167FF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:54:19 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id DA5D01E80D8E;
        Mon, 25 Jul 2022 17:49:17 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ConPBFkEGh_z; Mon, 25 Jul 2022 17:49:15 +0800 (CST)
Received: from [172.30.24.122] (unknown [180.167.10.98])
        (Authenticated sender: renyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id D30971E80D0F;
        Mon, 25 Jul 2022 17:49:14 +0800 (CST)
Subject: Re: [PATCH 2/3] lkdtm/perms: Check possible NULL pointer returned by
 kmalloc(),vmalloc()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     keescook@chromium.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, yuzhe@nfschina.com
References: <20220725081153.20228-1-renyu@nfschina.com>
 <Yt5XZN3CdTprfjwk@kroah.com>
From:   tury <renyu@nfschina.com>
Message-ID: <bd13881e-6a78-8831-18a8-5b022e8648ce@nfschina.com>
Date:   Mon, 25 Jul 2022 17:54:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <Yt5XZN3CdTprfjwk@kroah.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is insufficient memory, the allocation will fail.

the return value is void,so i think it is ok .

should i have changed comment to something like this ?

As the possible alloc failure of the kmalloc() and vmalloc(),
the return pointer could be NULL.therefore it should be better to check it.


在 2022年07月25日 16:42, Greg KH 写道:
> On Mon, Jul 25, 2022 at 04:11:53PM +0800, Ren Yu wrote:
>> As the possible alloc failure of the kmalloc() and vmalloc(),the
>> return pointer could be NULL.therefore it should be better to check it.
>>
>> Signed-off-by: Ren Yu <renyu@nfschina.com>
>> ---
>>   drivers/misc/lkdtm/perms.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
>> index b93404d65650..34b43b9ea1f1 100644
>> --- a/drivers/misc/lkdtm/perms.c
>> +++ b/drivers/misc/lkdtm/perms.c
>> @@ -180,6 +180,9 @@ static void lkdtm_EXEC_STACK(void)
>>   static void lkdtm_EXEC_KMALLOC(void)
>>   {
>>   	u32 *kmalloc_area = kmalloc(EXEC_SIZE, GFP_KERNEL);
>> +	if (!kmalloc_area)
>> +		return;
>> +
> Always run checkpatch on your patches so that grumpy maintainers do not
> have to tell you to run checkpatch on your patches...
>
> Also, shouldn't this return an error?
>
> But most importantly, how can this ever fail?
>
> thanks,
>
> greg k-h
>
