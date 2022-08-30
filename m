Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A8E5A58C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiH3BCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiH3BCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:02:20 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5109CA6C72;
        Mon, 29 Aug 2022 18:01:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MGprC5xP9zKFJb;
        Tue, 30 Aug 2022 09:00:11 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAXj45+YQ1jfxpzAA--.54680S3;
        Tue, 30 Aug 2022 09:01:51 +0800 (CST)
Subject: Re: [PATCH -next 1/3] md/raid10: fix improper BUG_ON() in
 raise_barrier()
To:     John Stoffel <john@stoffel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
 <20220829131502.165356-2-yukuai1@huaweicloud.com>
 <25357.6485.659159.476926@quad.stoffel.home>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d46162b3-cd7c-cbc5-0ded-bb62a8a03ca5@huaweicloud.com>
Date:   Tue, 30 Aug 2022 09:01:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <25357.6485.659159.476926@quad.stoffel.home>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXj45+YQ1jfxpzAA--.54680S3
X-Coremail-Antispam: 1UD129KBjvJXoW7trWftry5tF15XFy8Zw4rAFb_yoW8Xw1rpa
        9Fga1jya1DCwn0yw1DXr4xuFyrKayDKay0y347Ww1kZFyqqFyfGF47Jr95Wr1v9rs3J3W0
        vay5Ka9agF1xtaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, John

ÔÚ 2022/08/30 3:53, John Stoffel Ð´µÀ:
>>>>>> "Yu" == Yu Kuai <yukuai1@huaweicloud.com> writes:
> 
> Yu> From: Yu Kuai <yukuai3@huawei.com>
> Yu> 'conf->barrier' is protected by 'conf->resync_lock', reading
> Yu> 'conf->barrier' without holding the lock is wrong.
> 
> Yu> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Yu> ---
> Yu>  drivers/md/raid10.c | 2 +-
> Yu>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Yu> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> Yu> index 9117fcdee1be..b70c207f7932 100644
> Yu> --- a/drivers/md/raid10.c
> Yu> +++ b/drivers/md/raid10.c
> Yu> @@ -930,8 +930,8 @@ static void flush_pending_writes(struct r10conf *conf)
>   
> Yu>  static void raise_barrier(struct r10conf *conf, int force)
> Yu>  {
> Yu> -	BUG_ON(force && !conf->barrier);
> Yu>  	spin_lock_irq(&conf->resync_lock);
> Yu> +	BUG_ON(force && !conf->barrier);
> 
> I don't like this BUG_ON() at all, why are you crashing the system
> here instead of just doing a simple WARN_ONCE() instead?  Is there
> anything the user can do to get into this situation on their own, or
> does it really signify a logic error in the code?  If so, why are you
> killing the system?

I'm not sure why to use the BUG_ON() here. I just noticed that
'conf->barrier' is read without holding 'resync_lock', and BUG_ON() can
be triggered false positive.

Thanks,
Kuai
> 
> 
>   
> Yu>  	/* Wait until no block IO is waiting (unless 'force') */
> Yu>  	wait_event_lock_irq(conf->wait_barrier, force || !conf->nr_waiting,
> Yu> --
> Yu> 2.31.1
> 
> 
> .
> 

