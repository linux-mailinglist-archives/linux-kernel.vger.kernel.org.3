Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E473F599E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 17:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349708AbiHSPY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 11:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349694AbiHSPYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 11:24:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C52D876AE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:24:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w19so9427369ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=QcjuSMkjgvmcMVSZtEnP4HKDq1IJJzuLOO5WZsbK0+U=;
        b=agmJAUC8jfOsl/gS4hT8lv5H6fTz01qf2pe3Iv5R9j9Ate9ewR22RfAhjEhwJ6X7ah
         6i2gUSjqWAQUwG7vDL22TL3OJ2DhWyK4iGyCxaZDkZBo8C5fdnjLhkpYDW7Sa1kKJ0m9
         nTTLPu80zYWs5VKFI/soqsQZ2m3SZwMJLkyAN+lFaM/+QA0zpsdobhOAVHSxJY09NVpJ
         unBTEPM3BaQo8lZAI/3LxHBqdI4Xtjfj+l91HslXfgpBHq8BMYj8CpA31LlMMIn6dSW8
         vv42Aj7Ht2909aymuONX4UFmgeVzYDTPM0HNunn/RXfrH17hgsFeGl4AuF4WAgPFBbnL
         B9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QcjuSMkjgvmcMVSZtEnP4HKDq1IJJzuLOO5WZsbK0+U=;
        b=vmVOWZafMjrGB4vLfGgT7nacH6YRQeavyPEh63+m6Fr1A6aM3gruu5pXWPBUKioRKo
         lbz8PRhKAtMsDA8s2NEgUpPIbNqE01tmHFrC1Ya8bdx1n+nfoOFtKJq+PzyALqr7PgyZ
         1gK0ZNI6UK0Xh7MKtL0qAKkxKdqMftT2y4nL0S3/t1U35fBbOEXfvkSu3eVS74BqPgqx
         A6W0IdS6HUiorxnvFtsE6935YTercuJ73INxIM5XldDnE663GzCfVWLd+47/haBP/SlT
         erhelZngd83WkYrwg5VU2SwYFV1hsz75RIG7zDGMerawj6RI6h56HqEwDqWrsowm+93q
         mGUw==
X-Gm-Message-State: ACgBeo1WubusIeimlt4uqY9eTSTLjqaIqox1/9a+WX03Cc0ePlp8xKAT
        0fGIiSNlpEP/9SzD+5yvdXrGdg==
X-Google-Smtp-Source: AA6agR5mq+T7k3AHmZCAgqpwHVwskje+A0igISLSMji1ANW7KLAUFwidL9UZ9jQ29SXqclEdOTfxgg==
X-Received: by 2002:a17:907:7fa5:b0:730:5d54:4c24 with SMTP id qk37-20020a1709077fa500b007305d544c24mr5248538ejc.641.1660922691995;
        Fri, 19 Aug 2022 08:24:51 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id h10-20020aa7c60a000000b0043cc2c9f5adsm3270313edq.40.2022.08.19.08.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 08:24:51 -0700 (PDT)
Message-ID: <a6d3e3a8-f0a6-dffc-c3b6-45d81efc7664@linbit.com>
Date:   Fri, 19 Aug 2022 17:24:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] block: move from strlcpy with unused retval to strscpy
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Geoff Levand <geoff@infradead.org>, Jim Paris <jim@jtan.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220818205958.6552-1-wsa+renesas@sang-engineering.com>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220818205958.6552-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 18.08.22 um 22:59 schrieb Wolfram Sang:
> Follow the advice of the below link and prefer 'strscpy' in this
> subsystem. Conversion is 1:1 because the return value is not used.
> Generated by a coccinelle script.
> 
> Link: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/block/brd.c               |  2 +-
>  drivers/block/drbd/drbd_nl.c      |  2 +-

For the drbd part:

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

>  drivers/block/mtip32xx/mtip32xx.c | 12 ++++++------
>  drivers/block/ps3vram.c           |  2 +-
>  drivers/block/zram/zram_drv.c     |  6 +++---
>  5 files changed, 12 insertions(+), 12 deletions(-)
...
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index 013d355a2033..864c98e74875 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -4752,7 +4752,7 @@ void notify_helper(enum drbd_notification_type type,
>  	struct drbd_genlmsghdr *dh;
>  	int err;
>  
> -	strlcpy(helper_info.helper_name, name, sizeof(helper_info.helper_name));
> +	strscpy(helper_info.helper_name, name, sizeof(helper_info.helper_name));
>  	helper_info.helper_name_len = min(strlen(name), sizeof(helper_info.helper_name));
>  	helper_info.helper_status = status;
>
-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
