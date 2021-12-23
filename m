Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF5A47DDDF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 03:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346074AbhLWCyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 21:54:10 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:56404 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346039AbhLWCyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 21:54:08 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowAD3_S275MNhYnheBA--.17047S2;
        Thu, 23 Dec 2021 10:53:47 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] driver core: platform: Fix wrong comment
Date:   Thu, 23 Dec 2021 10:53:46 +0800
Message-Id: <20211223025346.1236195-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAD3_S275MNhYnheBA--.17047S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4fWF43CryrAr45Gw1xZrb_yoW5ZFWxpr
        4kK3yIkr18WF42g34xJ3W8ZF43Cr12qFWUWryagwsru3s8XrnxG345Ka4avrn7J3yDGa15
        JF12vFs5uFs8uF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
        0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYc_-DUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I notice that there is a 'WARN(ret == 0, "0 is an invalid IRQ
number\n");' before 'return ret;', which means that it is possible to
return 0 if fails.
Therefore, it might be better to correct the wrong comment.
And also there is reply sent by Damien Le Moal because I submitted a
patch to remove the non-zero check of the platform_get_irq() previously.
Damien Le Moal said that the comment for platform_get_irq() is wrond
because it can actually return 0.
Moreover, platform_get_irq() returns platform_get_irq_optional().
As a conclusion, the comments of the platform_get_irq() and
platform_get_irq_optional() should be fixed.
Not only that, the comments of platform_get_irq_byname() and
platform_get_irq_byname_optional() have the same error.
This time I only submit one as an example.
If the patch is right, I will submit another version to fix all.
But, I also notice that the 'return 0' is removed intentionally in the
fixed tag.
I am not sure which one is right.
Anyway, the success IRQ number should be 'postive' other than
'non-zero'.
So the comment should be corrected.
Here is the mail from Damien Le Moal.

Link:
https://lore.kernel.org/lkml/dd6e6054-3d7e-b43a-0386-71323c49ab27@opensource.wdc.com/
On Thu, Dec 23, 2021 at 08:41:54AM +0800, Damien Le Moal wrote:
>> It can be found that platform_get_irq() returns nagative code but not
>> null when fails.
>> The comment of the platform_get_irq clearly shows that.
>> Therefore it should be better to remove the useless check.
>
> Nope, platform_get_irq() can actually return 0 (the comment for that
> function is wrong). So testing for !irq is valid and must be kept.
>
>>
>> Fixes: fd990556f0fa ("ata: move library code from ahci_platform.c to
libahci_platform.c")
>> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
>> ---
>>  drivers/ata/libahci_platform.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/ata/libahci_platform.c
b/drivers/ata/libahci_platform.c
>> index b2f552088291..5ec68f138c28 100644
>> --- a/drivers/ata/libahci_platform.c
>> +++ b/drivers/ata/libahci_platform.c
>> @@ -587,8 +587,6 @@ int ahci_platform_init_host(struct
platform_device *pdev,
>>  			dev_err(dev, "no irq\n");
>>  		return irq;
>>  	}
>> -	if (!irq)
>> -		return -EINVAL;
>>
>>  	hpriv->irq = irq;
>>

Fixes: c2f3f755f5c7 ("Revert "driver core: platform: Make platform_get_irq_optional() optional"")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/base/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 9cd34def2237..fcba2559cc90 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -181,10 +181,10 @@ EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
  * For example::
  *
  *		int irq = platform_get_irq_optional(pdev, 0);
- *		if (irq < 0)
+ *		if (irq <= 0)
  *			return irq;
  *
- * Return: non-zero IRQ number on success, negative error number on failure.
+ * Return: positive IRQ number on success, negative error number and zero on failure.
  */
 int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 {
-- 
2.25.1

