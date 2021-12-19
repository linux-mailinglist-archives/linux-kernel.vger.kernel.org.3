Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E9747A120
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 16:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbhLSP2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 10:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbhLSP2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 10:28:21 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A735C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 07:28:21 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id k14so5750431ils.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 07:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ABMuECWKR/9ZUZvCXNqRtaxyxdUxxfmB5wAUrCcXRWw=;
        b=ZRo7631AKE/juZY8w/sQQndQSFwT/lkIs3DvUn/kJvyAjNo9+7VVS67vobF6d3+pzh
         c+30H5wsRa4yVMCEP8tnsV++9FChvSJQZH93H3Tel+5c+9qC9dsf2osCOeQ1zcmPpVf1
         Pmnt7ddXiOmZtmGekjC8tzFGFLCyNTW+1KR9R30ICUJExq+EkpoXr9YJ0X+kVjnEX5yY
         1fpnYNQKJ4RuHUdMxDiVzpiQZUoii2NNsjdsaapXeHzAzPUiuvhqXF2rCcSSeUCQiL0x
         ATflXHfuNpMx9zLJkhkgaRH4b01xrJny+uERu6Nap8nxLhjk0saUfOlgPIt31jg2QCir
         3D6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ABMuECWKR/9ZUZvCXNqRtaxyxdUxxfmB5wAUrCcXRWw=;
        b=s0qkCEJHWFUyTnLz2+7C0dctx9cpdbvloqv5FcxE4eent1wZUU1itXiMaBhiHTrad0
         qcJU5Nz1FxUdJMbeNgRh2zd/Yb91WRgB4h0MBHj6nBFQ/98zUT7UYgda0kY/5KPS2k39
         YLKRMnQG8qF0qw4XqMGnpO/F+AGXhu9lMO/jpQNMCi3a6p+PeEibqUjyd8busDfYhRjr
         PL0c72lRKMoNu3UoLW2gS1zGcBoPdKHJ3h1jWBGjAmUk+CMe0bvJZQsYoKrV4zrA2cXK
         NkWJ+J5y5GWIrS/ZEyH1wVCvOQJDHyGZVhugBiBqBXQterObNMLJBSEP1HEPb+sxP0ym
         rpaA==
X-Gm-Message-State: AOAM532HrVqY4yafLYBbdyaLnXZaLLV/Zt8fqBH0Sl5+PInv/7nbxMoG
        gfeQO4rfgZXdFMvYU8MBvn30erzTY+m7MA==
X-Google-Smtp-Source: ABdhPJylI8VcD9R91zkPQvZPJ5f1ryW8XU+RSLBFP3FzwvxqMY9/eKN5aVoIdEuHHpfakj5yNjLhxw==
X-Received: by 2002:a05:6e02:160d:: with SMTP id t13mr6584467ilu.0.1639927699881;
        Sun, 19 Dec 2021 07:28:19 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id 18sm7097114iln.83.2021.12.19.07.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 07:28:19 -0800 (PST)
Subject: Re: very low IOPS due to "block: reduce kblockd_mod_delayed_work_on()
 CPU consumption"
From:   Jens Axboe <axboe@kernel.dk>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        linux-block@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        ming.lei@redhat.com, hch@lst.de, Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        linux-kernel@vger.kernel.org
References: <1639853092.524jxfaem2.none.ref@localhost>
 <1639853092.524jxfaem2.none@localhost>
 <7d1e4bb8-1a73-9529-3191-66df4ff2d5fe@kernel.dk>
 <12f43a71-713b-a74f-a169-b6ac3d804e50@kernel.dk>
Message-ID: <237bd7d8-9e75-01b5-ebe7-8b1eb747474b@kernel.dk>
Date:   Sun, 19 Dec 2021 08:28:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <12f43a71-713b-a74f-a169-b6ac3d804e50@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/21 7:58 AM, Jens Axboe wrote:
> On 12/18/21 12:02 PM, Jens Axboe wrote:
>> On 12/18/21 11:57 AM, Alex Xu (Hello71) wrote:
>>> Hi,
>>>
>>> I recently noticed that between 6441998e2e and 9eaa88c703, I/O became 
>>> much slower on my machine using ext4 on dm-crypt on NVMe with bfq 
>>> scheduler. Checking iostat during heavy usage (find / -xdev and fstrim 
>>> -v /), maximum IOPS had fallen from ~10000 to ~100. Reverting cb2ac2912a 
>>> ("block: reduce kblockd_mod_delayed_work_on() CPU consumption") resolves 
>>> the issue.
>>
>> Hmm interesting. I'll try and see if I can reproduce this and come up
>> with a fix.
> 
> I can reproduce this. Alex, can you see if this one helps? Trying to see
> if we can hit a happy medium here that avoids hammering on that timer,
> but it really depends on what the mix is here of delay with pending,
> or no delay with no pending.
> 
> Dexuan, can you test this for your test case too? I'm going to queue
> up a revert for -rc6 just in case.

This one should be better...


diff --git a/block/blk-core.c b/block/blk-core.c
index c1833f95cb97..5e9e3c2b7a94 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1481,12 +1481,17 @@ int kblockd_schedule_work(struct work_struct *work)
 }
 EXPORT_SYMBOL(kblockd_schedule_work);
 
-int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork,
-				unsigned long delay)
+void kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork,
+				 unsigned long msecs)
 {
-	if (!delay)
-		return queue_work_on(cpu, kblockd_workqueue, &dwork->work);
-	return mod_delayed_work_on(cpu, kblockd_workqueue, dwork, delay);
+	if (!msecs) {
+		cancel_delayed_work(dwork);
+		queue_work_on(cpu, kblockd_workqueue, &dwork->work);
+	} else {
+		unsigned long delay = msecs_to_jiffies(msecs);
+
+		mod_delayed_work_on(cpu, kblockd_workqueue, dwork, delay);
+	}
 }
 EXPORT_SYMBOL(kblockd_mod_delayed_work_on);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8874a63ae952..95288a98dae1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1155,8 +1155,7 @@ EXPORT_SYMBOL(blk_mq_kick_requeue_list);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q,
 				    unsigned long msecs)
 {
-	kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND, &q->requeue_work,
-				    msecs_to_jiffies(msecs));
+	kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND, &q->requeue_work, msecs);
 }
 EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 
@@ -1868,7 +1867,7 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 	}
 
 	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
-				    msecs_to_jiffies(msecs));
+					msecs);
 }
 
 /**
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bd4370baccca..40748eedddbb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1159,7 +1159,7 @@ static inline unsigned int block_size(struct block_device *bdev)
 }
 
 int kblockd_schedule_work(struct work_struct *work);
-int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned long delay);
+void kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned long msecs);
 
 #define MODULE_ALIAS_BLOCKDEV(major,minor) \
 	MODULE_ALIAS("block-major-" __stringify(major) "-" __stringify(minor))

-- 
Jens Axboe

