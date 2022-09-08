Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F9B5B191E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiIHJpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiIHJpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:45:17 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9B65B7BB;
        Thu,  8 Sep 2022 02:45:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MNZ1p10kFz6S2Wh;
        Thu,  8 Sep 2022 17:43:26 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgC3VW+nuRlj7qcrAg--.8625S3;
        Thu, 08 Sep 2022 17:45:13 +0800 (CST)
Subject: Re: [PATCH] sbitmap: fix possible io hung due to lost wakeup
To:     Jan Kara <jack@suse.cz>, Keith Busch <kbusch@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20220803121504.212071-1-yukuai1@huaweicloud.com>
 <Yxe7V3yfBcADoYLE@kbusch-mbp.dhcp.thefacebook.com>
 <20220907102318.pdpzpmhah2m3ptbn@quack3>
 <YxinFEYRCU/QuQ5w@kbusch-mbp.dhcp.thefacebook.com>
 <20220907164150.tykjl3jsctjddcnq@quack3>
 <Yxjg2Xsb7WExRv2w@kbusch-mbp.dhcp.thefacebook.com>
 <20220908093330.lzynnuqlnvppj27q@quack3>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <dcb95c47-6e68-6ec0-a74d-317a905d0a1b@huaweicloud.com>
Date:   Thu, 8 Sep 2022 17:45:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220908093330.lzynnuqlnvppj27q@quack3>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgC3VW+nuRlj7qcrAg--.8625S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr4UJFyrWr17Aw45Jr47Jwb_yoWDJrbE9r
        WkAayxCwnxXF4fJFnrKrykArZrKFZIqFZ3Cryqgrn7Za4rWF98Ar4rGrySvwsxGa1kGrnx
        Gws0vF1YvrWYgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUU
        UU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jan

ÔÚ 2022/09/08 17:33, Jan Kara Ð´µÀ:
> On Wed 07-09-22 12:20:09, Keith Busch wrote:
>> On Wed, Sep 07, 2022 at 06:41:50PM +0200, Jan Kara wrote:
>>> On Wed 07-09-22 08:13:40, Keith Busch wrote:
>>>>
>>>> I'm not sure about this part. We've already decremented, so the freed bit is
>>>> accounted for against the batch. Returning true here may double-count the freed
>>>> bit, right?
>>>
>>> Yes, we may wake up waiters unnecessarily frequently. But that's a
>>> performance issue at worst and only if it happens frequently. So I don't
>>> think it matters in practice (famous last words ;).
>>
>> Ok, let's go with that. Do you want to send the patch? I have a follow-up fix
>> for batched tagging that depends on this.
> 
> I think Kuai will do that. But if not, I can certainly take his patch and
> resubmit it with the fixup.

Sorry that I'm too busy with work stuff recently, I can do that in a few
weeks. In the meantime, feel free go on without me.

Thanks,
Kuai
> 
> 								Honza
> 

