Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE0C494A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359487AbiATIvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:51:45 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:41322 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1359476AbiATIvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:51:40 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowAA3P5+GIulh4OCnBg--.5508S2;
        Thu, 20 Jan 2022 16:51:19 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     gregkh@linuxfoundation.org
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: Re: [PATCH] usb: typec: Check error number after calling ida_simple_get
Date:   Thu, 20 Jan 2022 16:51:13 +0800
Message-Id: <20220120085113.1854945-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAA3P5+GIulh4OCnBg--.5508S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr48JrykWF1xJFyxKr17ZFb_yoW5XFWUpr
        W7KFWjkrs5tFW2g3Z7Xw4rXFZ8Gw4kA3y5JrZag3s2vwsIvF1xtrW8tw4F9rWkCw4kW3Wj
        vrWUA3W3G3yDAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r43
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU04E_DUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 04:39:13PM +0800, Greg KH wrote:
>> If allocation fails, the ida_simple_get() will return error number.
>
> How can allocation fail?  Have you been able to trigger this?

Thanks for your advice.
I have already tested the altmode_id_get() by kunit and qemu-system-x86_64.
Firstly I used qemu to create a virtual machine with only 32M memory.
And then I wrote a kunit test that trying to make altmode_id_get() fail.
The test continually allocates memory until the memory doesn't have
enough space allocated for 8 bytes at first.
Then it will call the altmode_id_get() and use KUNIT_EXPECT_EQ() to
test whether the return value is -ENOMEM.
Because it is tested under extremely harsh conditions, I close the OOM
killer, in order to prevent the automatically killing for the process
which will make the memory deadlock.
To be convenient, I used '__GFP_NORETRY' when allocation instead of
the above setting, as it can achieve the same goal that the allocation
will not retry that causing the OOM killer.
As a result, the test passed which means that altmode_id_get()
really returned -ENOMEM.

>> So altmode_id_get() may return error number.
>> And then id will be used in altmode_id_remove, causing the BUG_ON().
>> Or it will be assigned to alt->id.
>> Therefore, it should be better to check it and return error if fails,
>> like the ida_simple_get() in typec_register_port().
>> 
>> Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
>> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
>> ---
>>  drivers/usb/typec/class.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
>> index aeef453aa658..67b3670ede99 100644
>> --- a/drivers/usb/typec/class.c
>> +++ b/drivers/usb/typec/class.c
>> @@ -516,6 +516,9 @@ typec_register_altmode(struct device *parent,
>>  	struct altmode *alt;
>>  	int ret;
>>  
>> +	if (id < 0)
>> +		return ERR_PTR(id);
>> +
>>  	alt = kzalloc(sizeof(*alt), GFP_KERNEL);
>>  	if (!alt) {
>>  		altmode_id_remove(parent, id);
>> -- 
>> 2.25.1
>> 
>
> How did you test that this change will work properly?

And this time I also use the kunit to test the patch.
I added the check 'if (id < 0) return;' between the altmode_id_get()
and KUNIT_FAIL().
As a result the kunit test passed, which means that the patch works properly.

Therefore, I think it is true that the allocation can fail and
altmode_id_get() will return -ENOMEM under the conditions that
the freed memory is lower that 8 bytes and OOM killer is closed.

Moreover, there is a check for the allocation of 'alt' in the
same function.
To maintain the code consistency, it should be better to add the
check for 'id' too.

Sincerely thanks,
Jiang

