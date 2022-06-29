Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D2D5608FA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiF2SXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiF2SXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:23:38 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6F7255AB;
        Wed, 29 Jun 2022 11:23:36 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d5so14832172plo.12;
        Wed, 29 Jun 2022 11:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PZ7JUKiuVG800mwXq+md9lqBB2yZefg/Lo7AxgMd90w=;
        b=kBKHF9JhHlIaow3V2mR0POOGYhAUQya2KMaoksU/eDmAi6on/pE4GT4ZWytexJ9mBA
         tP1jwfbYWlcWIN/LRS720SnQsjIKaKJC9JuHHq9hJup7rB5wJsBRx7e+xLGrrX3X1D2b
         LMHzRqXJmGAPp/Liez2t8UkCDmyC41DENIGGRlBSo9xe+1nH/cBTiMnB2/vhYJ8EjjI3
         RkaUsJIefSKAbJttMblMK7Gd2wD/Dp9FTqsn7qp0+oQtp8hyD1nfKY6XB9Xd9wUabyjW
         bQnoFIOMxSWfOYmvl93mZG6BaZs2Af1JEr4b2ZhpGxfEALbnM030vbnbf/oMHu6OojXZ
         EL5w==
X-Gm-Message-State: AJIora9GbMD/E2JABcjHqKa2wEsVstNWQjL+AeNZ2d17XYUQi9B/ORGr
        +A3EokifN+CJDbzxFFZJqek=
X-Google-Smtp-Source: AGRyM1tSqbps2Q68p3GwM75jHEAbwvy4y5MYIXhYDE8wt/zgPNVVJJpl3DuGUj9f/8lpcsibsysXog==
X-Received: by 2002:a17:902:f708:b0:153:839f:bf2c with SMTP id h8-20020a170902f70800b00153839fbf2cmr11488760plo.113.1656527015458;
        Wed, 29 Jun 2022 11:23:35 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:e57f:78b4:1672:b207? ([2620:15c:211:201:e57f:78b4:1672:b207])
        by smtp.gmail.com with ESMTPSA id h6-20020aa796c6000000b00522c8fb04adsm12363086pfq.176.2022.06.29.11.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 11:23:34 -0700 (PDT)
Message-ID: <28db81c5-27d3-7b83-5021-4507b4dd118a@acm.org>
Date:   Wed, 29 Jun 2022 11:23:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] blk-mq: set BLK_MQ_S_STOPPED first to avoid unexpected
 queue work
Content-Language: en-US
To:     Liu Song <liusong@linux.alibaba.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1656479900-58719-1-git-send-email-liusong@linux.alibaba.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1656479900-58719-1-git-send-email-liusong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/22 22:18, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> In "__blk_mq_delay_run_hw_queue", BLK_MQ_S_STOPPED is checked first,
> and then queue work, but in "blk_mq_stop_hw_queue", execute cancel
> work first and then set BLK_MQ_S_STOPPED, so there is a risk of
> queue work after setting BLK_MQ_S_STOPPED, which can be solved by
> adjusting the order.
> 
> Signed-off-by: Liu Song <liusong@linux.alibaba.com>
> ---
>   block/blk-mq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 93d9d60..865915e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2258,9 +2258,9 @@ bool blk_mq_queue_stopped(struct request_queue *q)
>    */
>   void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
>   {
> -	cancel_delayed_work(&hctx->run_work);
> -
>   	set_bit(BLK_MQ_S_STOPPED, &hctx->state);
> +
> +	cancel_delayed_work(&hctx->run_work);
>   }
>   EXPORT_SYMBOL(blk_mq_stop_hw_queue);

What made you come up with this patch? Source code reading or something
else? Please mention this in the patch description.

Regarding the above patch, I don't think this patch fixes the existing
race between blk_mq_stop_hw_queue() and __blk_mq_delay_run_hw_queue(),
not even if cancel_delayed_work_sync() would be used.

The comment block above blk_mq_stop_hw_queue() clearly mentions that it
is not guaranteed that this function stops dispatching of requests
immediately. So why bother about fixing the existing race conditions that
do not affect what is guaranteed by blk_mq_stop_hw_queue()?

Thanks,

Bart.
