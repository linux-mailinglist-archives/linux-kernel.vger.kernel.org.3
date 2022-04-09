Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9429F4FAAF5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 23:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbiDIVf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 17:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiDIVf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 17:35:56 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B2CEB8;
        Sat,  9 Apr 2022 14:33:48 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso12970806pjh.3;
        Sat, 09 Apr 2022 14:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xj9rNlmvCUpgWDGEsXJxpVSrmFrkxrjjtQuyonvd5qc=;
        b=pxgwE7gdypqSf3Nl/KgOQens2ziEPmCPehhJrsikvcaPi541pnOkMOyjrYKMM7OmsG
         JAHBYYZRYMbQ1LtytJAez/zROFN3iYUo7dMoJr/l261ZQ86ZBxrMrTvUCc0HP0hzUL2E
         yDqvj1ShFDj7qRyGo8YiEH80hbZsJe1Ipu9ukCND3xinMfZ9UMpNODbffIKutEim+xQO
         tzbHnwATY5/FNop1iBW5uINgsp0SVaERj4+QvJp1WDB3RAEEK4E9NX4OTW8VrCgf1nt3
         wH02r1pDd7viFS+5AN+uXXk3XIneK9oC0y3GLDSmb1QUqHRx6m06Kh+F30TBEiUqwFTG
         c3tA==
X-Gm-Message-State: AOAM530UHsDWJIHvmh3Rm/pw1WG5EhJ/JXeTC6tAN4ZTiWSoJbr+QHma
        sZoR9ARUkYNMIkkXwQaT+c/rICKaGlo=
X-Google-Smtp-Source: ABdhPJzt4uYVmAOOfTFXUaThJIE6it/aZqeUjTF7jZ4zOK6HeRYQXtZ//XCBsFR/8ewFWu2RG6nRAg==
X-Received: by 2002:a17:902:e791:b0:151:dbbd:aeae with SMTP id cp17-20020a170902e79100b00151dbbdaeaemr25732522plb.171.1649540027613;
        Sat, 09 Apr 2022 14:33:47 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id pf2-20020a17090b1d8200b001c6f65ca66fsm15952799pjb.47.2022.04.09.14.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 14:33:46 -0700 (PDT)
Message-ID: <d41e3238-d7d9-16f8-38bd-2608844d7831@acm.org>
Date:   Sat, 9 Apr 2022 14:33:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] block/compat_ioctl: fix range check in BLKGETSIZE
Content-Language: en-US
To:     Khazhismel Kumykov <khazhy@google.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220408234707.2562835-1-khazhy@google.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220408234707.2562835-1-khazhy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/22 16:47, Khazhismel Kumykov wrote:
> kernel ulong and compat_ulong_t may not be same width. Use type directly
> to eliminate mismatches.
> 
> This would result in truncation rather than EFBIG for 32bit mode for
> large disks.
> 
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> ---
>   block/ioctl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Noticed this one was sitting in my "not landed yet" pile, third time's
> the charm? :)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 4a86340133e4..959e93a90b29 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -629,7 +629,7 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
>   		return compat_put_long(argp,
>   			(bdev->bd_disk->bdi->ra_pages * PAGE_SIZE) / 512);
>   	case BLKGETSIZE:
> -		if (bdev_nr_sectors(bdev) > ~0UL)
> +		if (bdev_nr_sectors(bdev) > ~((compat_ulong_t)0UL))
>   			return -EFBIG;
>   		return compat_put_ulong(argp, bdev_nr_sectors(bdev));

A nit: the "UL" and two parentheses can be left out. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
