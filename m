Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E084B965C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiBQDJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:09:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiBQDJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:09:12 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8C2158E9D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:08:58 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id f8so3806279pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Anr52g04+AVHtEhsIJzL+W2iG28YfG2faiyY/MF3S1Q=;
        b=07TZlRToCc/AdEf2OdPUHwVs6g+ZsE6t5ADSClYQD4YtLyHDVtCXrw0tbUm5v86EPN
         OcyUz4BPpxlWcNwlAG/jJ4TFq8G31s73PHQlBhy433SC8RI/KBQO0Gkws+BdbEE/vCP5
         uunMezkromTerPmrToxjiF43VMZj6JgV+Lp1m+ekN058H3KyHKdIGzREZe7VFg8MQC+a
         WCmwQ3PofM6Oe/FkqsfB2Dx8ro75SLsNUHeoFaNVgJX2gEypTIFOWshmUMn2J51B1eTG
         BcxZbdvjOZptcd3Hm9Hrqlc3/uXKMStobZyt42V3TWV+wy1/3/QJnRUERHVyTeXFFoqz
         YhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Anr52g04+AVHtEhsIJzL+W2iG28YfG2faiyY/MF3S1Q=;
        b=f8O3RaOH1YWG6jVhYVUxGPoKyRQfXjQKoVGisEJ2PYg+RpfaEyUrpQHIXZucEKgBhP
         /2YlxzD5UfzTCbLvP5+Xy5kC4E3NheragDm2Mns+/8Xg8MhlhuctWTfj5Sz+8W32T3Q5
         uoqsZrb7Dn/CLpIkHsIeDP+Sn9IcgYRMScBDOV+iPwskSqgnW6KJa4jxQTGoYzlFv8yK
         9/rhcdijoU0HdwjkhbsGqehvogMs/SzC3xE+I0R3C/zwQFLAtMISmRXzk3vfe64qoTE1
         ZKm2IdJYprPGU8tJ9hTt4V48FXkOOXNJIVBgH+SqvpUiiH8LO2uDwp/tV448huftZ0wI
         Agog==
X-Gm-Message-State: AOAM531YvXjt3K+WUJBC8xC4tyXNa6lkXSEdicF7x59JC2xohnBGGHE4
        ZK4IejlmPbn8pbe2kTbfGaSy/ZM63Yy17w==
X-Google-Smtp-Source: ABdhPJxl3am8omzitpxin/MQKTLxfv3srfGyqtpva7Sci8tI20hniUCP5Uj33Vt824nPP+nacT26Eg==
X-Received: by 2002:a62:1d07:0:b0:4bf:3782:22e3 with SMTP id d7-20020a621d07000000b004bf378222e3mr1145580pfd.52.1645067338250;
        Wed, 16 Feb 2022 19:08:58 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s1sm404329pjr.56.2022.02.16.19.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 19:08:57 -0800 (PST)
Message-ID: <5e633f42-817a-1861-524f-8659e7340351@kernel.dk>
Date:   Wed, 16 Feb 2022 20:08:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH -next] block: update io_ticks when io hang
Content-Language: en-US
To:     "zhangwensheng (E)" <zhangwensheng5@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20220125091938.1799001-1-zhangwensheng5@huawei.com>
 <164506609748.50355.11490091116960287078.b4-ty@kernel.dk>
 <1998c61c-c3d9-8050-be43-16aba2d6e09f@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1998c61c-c3d9-8050-be43-16aba2d6e09f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 8:07 PM, zhangwensheng (E) wrote:
> hi, Jens:
> 
> I am sorry that there are some problems with the patch below:
> 
> 
> @@ -913,12 +913,14 @@ ssize_t part_stat_show(struct device *dev,
>       struct disk_stats stat;
>       unsigned int inflight;
>   -    part_stat_read_all(bdev, &stat);
>       if (queue_is_mq(q))
>           inflight = blk_mq_in_flight(q, bdev);
>       else
>           inflight = part_in_flight(bdev);
>   +    if (inflight)
> +        update_io_ticks(bdev, jiffies, true);
> +    part_stat_read_all(bdev, &stat);
>       return sprintf(buf,
>           "%8lu %8lu %8llu %8u "
>           "%8lu %8lu %8llu %8u "
> 
> It shoule use part_stat_lock() & part_stat_unlock() to protect update_io_ticks(),
> 
> because it operates on per-cpu variables.  And I will fix it in V2.

I'll drop it, please resend a fixed and tested one.

-- 
Jens Axboe

