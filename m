Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EF847A113
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 15:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbhLSO6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 09:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhLSO6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 09:58:35 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA68C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 06:58:35 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id e128so10168029iof.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 06:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qKz+WAr6nEBLsYj+AcL5DWngB8lrLlnoDgVx0fw/U4M=;
        b=HaiOYbTqzxLag60YV9E+lZgvoytr3V9F3lFwlTgtrIhgxyyUbo0h2YaRbtkGKwsaxQ
         BQbtQL4LImkM0wbxCW1vhhA4LMbLb2IZfj5pS2f2sxwqtcLKOK3B31Xa1hNdv+oM+Gjh
         KOYXoeZ0xGNkqv3bDUOeqKVoeHwgX6hkiaFnvQ87nunUyGJ1mczjFTXSa5SbQWe1BTOD
         8RqsPgY8hzJ83fjcgpuBW8EpzdGkD0aMq6gZtbKYcb2BlMLuQ3BCHJ1pgjo5BvJGQQet
         2gqRZElkltBv767sWaUobPB+AlbnsGsEseROo8qSz2cRi3oee5eV0QaoeYQmVOuLbe6l
         PLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qKz+WAr6nEBLsYj+AcL5DWngB8lrLlnoDgVx0fw/U4M=;
        b=S+5gxX7yc2dj1iDlDyp9NLy/m23sPYgsnKoanjJWMlpU7NsZPPTA6YPapHaJGZ0yun
         /VBrDy8ebdFfUEe+ywCAxnb4zjdxbpCMwWCntqq3dVsh4cixjesOJquuTBn/MkGm+tAK
         MS9rp7euJnxV9NFZNwtf4vkTzDqKSjC7fmJEC1nk+1OLNz0XmgOUBuYiYQj9XPxMBrh8
         N5RlyQWXR3AqEih5Z0zxWeDyIpGSMG7GJSVG++NGetubpOrQnPJBcVoqSDo+bsubCKZ/
         q2pvqBOuC90H3jXl9dW36HzCUTOZdXE9SUgLr5HkIDWrJ76DQmlUCgEuitrZahbXaidy
         6ebg==
X-Gm-Message-State: AOAM530+34wn+oWFG1m8SvNEeZgxbfBVtPpZvZYyf1lThgDi99fmEeYx
        10QutWpKtaiCzuE8mpgkjXW/QE21ofPYIQ==
X-Google-Smtp-Source: ABdhPJwXhxG8IxWFGOqQzRmBqSTSLV4aRS0fpka63UV2gZBWhX6DelmsVshPL8ODFP5spTK0ukHfJQ==
X-Received: by 2002:a05:6638:3053:: with SMTP id u19mr7730348jak.220.1639925914462;
        Sun, 19 Dec 2021 06:58:34 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id m14sm2035189iow.54.2021.12.19.06.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 06:58:34 -0800 (PST)
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
Message-ID: <12f43a71-713b-a74f-a169-b6ac3d804e50@kernel.dk>
Date:   Sun, 19 Dec 2021 07:58:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7d1e4bb8-1a73-9529-3191-66df4ff2d5fe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/21 12:02 PM, Jens Axboe wrote:
> On 12/18/21 11:57 AM, Alex Xu (Hello71) wrote:
>> Hi,
>>
>> I recently noticed that between 6441998e2e and 9eaa88c703, I/O became 
>> much slower on my machine using ext4 on dm-crypt on NVMe with bfq 
>> scheduler. Checking iostat during heavy usage (find / -xdev and fstrim 
>> -v /), maximum IOPS had fallen from ~10000 to ~100. Reverting cb2ac2912a 
>> ("block: reduce kblockd_mod_delayed_work_on() CPU consumption") resolves 
>> the issue.
> 
> Hmm interesting. I'll try and see if I can reproduce this and come up
> with a fix.

I can reproduce this. Alex, can you see if this one helps? Trying to see
if we can hit a happy medium here that avoids hammering on that timer,
but it really depends on what the mix is here of delay with pending,
or no delay with no pending.

Dexuan, can you test this for your test case too? I'm going to queue
up a revert for -rc6 just in case.

diff --git a/block/blk-core.c b/block/blk-core.c
index c1833f95cb97..a3fbf4360ee9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1481,12 +1481,15 @@ int kblockd_schedule_work(struct work_struct *work)
 }
 EXPORT_SYMBOL(kblockd_schedule_work);
 
-int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork,
-				unsigned long delay)
-{
-	if (!delay)
-		return queue_work_on(cpu, kblockd_workqueue, &dwork->work);
-	return mod_delayed_work_on(cpu, kblockd_workqueue, dwork, delay);
+void kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork,
+				 unsigned long delay)
+{
+	if (!delay) {
+		cancel_delayed_work(dwork);
+		queue_work_on(cpu, kblockd_workqueue, &dwork->work);
+	} else {
+		mod_delayed_work_on(cpu, kblockd_workqueue, dwork, delay);
+	}
 }
 EXPORT_SYMBOL(kblockd_mod_delayed_work_on);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bd4370baccca..1c7ba45e8463 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1159,7 +1159,7 @@ static inline unsigned int block_size(struct block_device *bdev)
 }
 
 int kblockd_schedule_work(struct work_struct *work);
-int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned long delay);
+void kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned long delay);
 
 #define MODULE_ALIAS_BLOCKDEV(major,minor) \
 	MODULE_ALIAS("block-major-" __stringify(major) "-" __stringify(minor))


-- 
Jens Axboe

