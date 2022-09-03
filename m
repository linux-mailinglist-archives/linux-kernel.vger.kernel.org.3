Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5B75ABD62
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 08:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiICGIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 02:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiICGI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 02:08:29 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAE0DC09A;
        Fri,  2 Sep 2022 23:08:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MKPRz2ZMnz6R22m;
        Sat,  3 Sep 2022 14:06:39 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgBH53BV7xJjNiU3AQ--.13373S3;
        Sat, 03 Sep 2022 14:08:22 +0800 (CST)
Subject: Re: [PATCH -next 0/3] md/raid10: reduce lock contention for io
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
 <CAPhsuW6pKMeaULJajDGSjDRVmBUDEd=QQdGftK_Oo0vgsEuKVg@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3e9385af-b02c-e886-bc4b-d85cb4f447af@huaweicloud.com>
Date:   Sat, 3 Sep 2022 14:08:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6pKMeaULJajDGSjDRVmBUDEd=QQdGftK_Oo0vgsEuKVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH53BV7xJjNiU3AQ--.13373S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr47uw4fJr1rKr1xGr4rZrb_yoWDZrbE9F
        ZrCr9xC3W8tr4Yga98Gr1rXF9FyF45WayxX3yUXFn2v348ZFWjqF4UC393CwnxAas5t3WS
        yr10gFWxZryagjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
        r21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUU
        U==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Song

在 2022/09/01 2:00, Song Liu 写道:
> On Mon, Aug 29, 2022 at 6:03 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> patch 1 is a small problem found by code review.
>> patch 2 avoid holding resync_lock in fast path.
>> patch 3 avoid holding lock in wake_up() in fast path.
>>
>> Test environment:
>>
>> Architecture: aarch64
>> Cpu: Huawei KUNPENG 920, there are four numa nodes
>>
>> Raid10 initialize:
>> mdadm --create /dev/md0 --level 10 --bitmap none --raid-devices 4 /dev/nvme0n1 /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1
>>
>> Test cmd:
>> fio -name=0 -ioengine=libaio -direct=1 -group_reporting=1 -randseed=2022 -rwmixread=70 -refill_buffers -filename=/dev/md0 -numjobs=16 -runtime=60s -bs=4k -iodepth=256 -rw=randread
>>
>> Test result:
>> before this patchset:   2.9 GiB/s
>> after this patchset:    6.6 Gib/s
> 
> Nice work! Applied to md-next.

Can you drop this version? There are something to improve. I can send a
new version.

Thanks,
Kuai
> 
> Thanks,
> Song
> .
> 

