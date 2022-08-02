Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CC5587504
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiHBBUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiHBBUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:20:03 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738B9AE47
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 18:20:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LxcZW2wSvzKJyG;
        Tue,  2 Aug 2022 09:18:43 +0800 (CST)
Received: from [10.174.176.103] (unknown [10.174.176.103])
        by APP1 (Coremail) with SMTP id cCh0CgCX7PC+e+hiFqFeAA--.37387S2;
        Tue, 02 Aug 2022 09:19:59 +0800 (CST)
Message-ID: <2520574c-ea6c-7c0a-2288-9035b5e0cbab@huaweicloud.com>
Date:   Tue, 2 Aug 2022 09:19:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH -next] [RFC] scsi: ses: fix slab-out-of-bounds in
 ses_enclosure_data_process
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
References: <20220713094548.3958915-1-yukuai1@huaweicloud.com>
 <yq1edxz349n.fsf@ca-mkp.ca.oracle.com>
From:   "zhangwensheng (E)" <zhangwensheng@huaweicloud.com>
Reply-To: zhangwensheng@huaweicloud.com
In-Reply-To: <yq1edxz349n.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCX7PC+e+hiFqFeAA--.37387S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4rtryDAF4fAw1rXr1UJrb_yoW5JrW7pr
        18Jr1UJryUJr1rJr1UJr1UJryUJF1UJ34UJr1UJFyUJr1UJr1jqr1UXr1jgr1UJr4rJr1U
        Jr1UJw1UZr1UJrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: x2kd0wpzhq2xhhqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

 From my description, there is still loophole in the previous changes.
can you make a test with the following changes?

diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index 0a1734f34587..06b991e27c84 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -559,11 +559,11 @@ static void ses_enclosure_data_process(struct 
enclosure_device *edev,
                         struct enclosure_component *ecomp;

                         if (desc_ptr) {
-                               if (desc_ptr >= buf + page7_len) {
+                               len = (desc_ptr[2] << 8) + desc_ptr[3];
+                               desc_ptr += 4;
+                               if (desc_ptr + len > buf + page7_len) {
                                         desc_ptr = NULL;
                                 } else {
-                                       len = (desc_ptr[2] << 8) + 
desc_ptr[3];
-                                       desc_ptr += 4;
                                         /* Add trailing zero - pushes into
                                          * reserved space */
                                         desc_ptr[len] = '\0';

thanks！

Wensheng

在 2022/8/2 8:01, Martin K. Petersen 写道:
>> After analysis on vmcore, it was found that the line "desc_ptr[len] =
>> '\0';" has slab-out-of-bounds problem in ses_enclosure_data_process.
>> In ses_enclosure_data_process, "desc_ptr" point to "buf", so it have
>> to be limited in the memory of "buf", however. although there is
>> "desc_ptr >= buf + page7_len" judgment, it does not work because
>> "desc_ptr + 4 + len" may bigger than "buf + page7_len", which will
>> lead to slab-out-of-bounds problem.
>>
>> Fix it by using judging desc_ptr cross the border or not after
>> "desc_ptr += 4".
> FWIW, I tested this change and I am still getting KASAN errors from ses.
>

