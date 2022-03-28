Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD694E8BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 04:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbiC1CEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 22:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiC1CE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:04:29 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F271D2625;
        Sun, 27 Mar 2022 19:02:49 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id h19so10280547pfv.1;
        Sun, 27 Mar 2022 19:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=4BQ57pr5posvuGt0pXZWjHeYu52NS8zeiiTtfiB0iF0=;
        b=L/jsr11LlvVrBEoX7UklyzxTzurXSSXVZyZEkzm+GvVvxzZvMmncUThENEj/LIFWMn
         T9gkBpOw724ajmU1Lur9b4UupGQReOfHuVMb9VW9LF2k8mlRo7fVyjM7Dr9hjEvRAtkT
         pvtSErmj52e4BgmluzUBR8aYY9uJKOQHAVeMx8YRRyJ97N/oTq2Il1rew0VAIT0t9rre
         Cz8g/u4ZFla8SVCifHLXyubrtxRFOJcHcDuEgdDdDLfLPdIMv7SQeMKwfL4hADDcy4A+
         entNL1RcQ7IfLl08ynAYx1kCH+1JS9XQr+e5jsbyOuFrOhbuPhGPvRy48zmKc0qxwTE/
         ik1A==
X-Gm-Message-State: AOAM533lO9tJKjeNTLTgd8UOkpUKZb+47cI+oyWsMRMYewkBQJEhKAqE
        m3tHi6iUgyI545PGnn2Abnk=
X-Google-Smtp-Source: ABdhPJzkW9jFV7Igx6J3Ey0hGZr5VAoPe80hn5IL9BKo/Hyw+PAJb9T3mUq80qnch+wI2BTF+KqHMg==
X-Received: by 2002:a63:d454:0:b0:386:86:6aaa with SMTP id i20-20020a63d454000000b0038600866aaamr8571557pgj.60.1648432969176;
        Sun, 27 Mar 2022 19:02:49 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id mw10-20020a17090b4d0a00b001c7cc82daabsm11233309pjb.1.2022.03.27.19.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 19:02:48 -0700 (PDT)
Message-ID: <49f08642-8878-8574-ce86-d1baf41f1189@acm.org>
Date:   Sun, 27 Mar 2022 19:02:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] block: use dedicated list iterator variable
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20220327214704.2188742-1-jakobkoschel@gmail.com>
Content-Language: en-US
In-Reply-To: <20220327214704.2188742-1-jakobkoschel@gmail.com>
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

On 3/27/22 14:47, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>   block/blk-mq.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8e659dc5fcf3..455fdd488f3c 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4466,12 +4466,14 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
>   static void blk_mq_elv_switch_back(struct list_head *head,
>   		struct request_queue *q)
>   {
> -	struct blk_mq_qe_pair *qe;
> +	struct blk_mq_qe_pair *qe = NULL;
> +	struct blk_mq_qe_pair *iter;
>   	struct elevator_type *t = NULL;
>   
> -	list_for_each_entry(qe, head, node)
> -		if (qe->q == q) {
> -			t = qe->type;
> +	list_for_each_entry(iter, head, node)
> +		if (iter->q == q) {
> +			t = iter->type;
> +			qe = iter;
>   			break;
>   		}

The current code looks much more readable to me than with the above
patch applied. How about replacing the above patch with the patch below?

Thanks,

Bart.


diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9c784262fd6b..c9435be54667 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4451,21 +4451,28 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
  	return true;
  }

-static void blk_mq_elv_switch_back(struct list_head *head,
-		struct request_queue *q)
+static struct blk_mq_qe_pair *blk_lookup_qe_pair(struct list_head *head,
+						 struct request_queue *q)
  {
  	struct blk_mq_qe_pair *qe;
-	struct elevator_type *t = NULL;

  	list_for_each_entry(qe, head, node)
-		if (qe->q == q) {
-			t = qe->type;
-			break;
-		}
+		if (qe->q == q)
+			return qe;
+
+	return NULL;
+}
+
+static void blk_mq_elv_switch_back(struct list_head *head,
+		struct request_queue *q)
+{
+	struct blk_mq_qe_pair *qe = blk_lookup_qe_pair(head, q);
+	struct elevator_type *t;

-	if (!t)
+	if (!qe)
  		return;

+	t = qe->type;
  	list_del(&qe->node);
  	kfree(qe);

