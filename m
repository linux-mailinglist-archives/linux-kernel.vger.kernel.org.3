Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40259598701
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344117AbiHRPKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344108AbiHRPK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0D1BD4EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660835426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XUULX76OiwNqXhgv8GeiwLzhHZ06NzNoZnvqLZsNeCY=;
        b=De8NT+9mTACVr8eiO9Y5fQb6Nh2obi0gHNT1/rwqlbftcB+KQnVKk284LO92VpQa9eYCmD
        4W7m4ztz+80IQqlixp7iCcQm9aDmkPPdydM8TzavyeudZ8qJcyj9aFIM5Yu67LnKW1dHNx
        S0Wc+lESZKcWofpvxcaudlqq4iSX4uA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-56-UmDcstfaOn-GVXgAtFjmtw-1; Thu, 18 Aug 2022 11:10:25 -0400
X-MC-Unique: UmDcstfaOn-GVXgAtFjmtw-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-335cf0fd1a4so31201197b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XUULX76OiwNqXhgv8GeiwLzhHZ06NzNoZnvqLZsNeCY=;
        b=SXCcoOvPX9UAWrmsVN/r0Bum4gPUpEWt8sXsA3XwhC0qtsHpiCH+W4bMwMF6nEhYY1
         MfArA2CvLcu5EpAwN27uVlINV4gXcekMvouf5025fKR8H8hUkwq2HzkNhbnQtn1Pp3uJ
         zfdbEfzAiUSn1sZzrbnQCSVn9XP2R/Ga81DN+pHkAqxgvACZSYI1uL1jjbS52vwE8J7j
         R+haWYUkS1xHGuOvakLseGVzGhWub9jOizCCx+88h1uVCmuhaU5n7qsBTCWO6TU9U4IC
         9dNuavIHsSqZnRNI6WI29ufPPxiIDhHDzLJX0L2eNcoH6y77Mfv1Ex1YasefzxA+GWtt
         JsyQ==
X-Gm-Message-State: ACgBeo3zLBjScsTymo96sE8Ua1tXTBittiXZn+jVGBst/kCK34/Ox+vs
        Cj6l5Y2c0r9erZkIbegUVxDJBNJP36wBRC5xBycS1K6N04R0vmlGHEV3tpWePYxT94FNdE72nuS
        sNHvM0ebbabeOMQimETD5RX++GuDcfBTsBYynMolN
X-Received: by 2002:a81:86c2:0:b0:332:a104:f7e4 with SMTP id w185-20020a8186c2000000b00332a104f7e4mr3238160ywf.505.1660835424786;
        Thu, 18 Aug 2022 08:10:24 -0700 (PDT)
X-Google-Smtp-Source: AA6agR69OHtBUziCmC0IN9+McDoaQN+ei985YjilNjNksbt69AggGTnrOajU0/534Va/bKw++/9Ocx4DaI6fh5BH4gA=
X-Received: by 2002:a81:86c2:0:b0:332:a104:f7e4 with SMTP id
 w185-20020a8186c2000000b00332a104f7e4mr3238114ywf.505.1660835424442; Thu, 18
 Aug 2022 08:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <Yv0A6UhioH3rbi0E@T590> <f633c476-bdc9-40e2-a93f-29601979f833@www.fastmail.com>
 <Yv0KmT8UYos2/4SX@T590> <35f0d608-7448-4276-8922-19a23d8f9049@www.fastmail.com>
 <Yv2P0zyoVvz35w/m@T590> <568465de-5c3b-4d94-a74b-5b83ce2f942f@www.fastmail.com>
 <Yv2w+Tuhw1RAoXI5@T590> <9f2f608a-cd5f-4736-9e6d-07ccc2eca12c@www.fastmail.com>
 <a817431f-276f-4aab-9ff8-c3e397494339@www.fastmail.com> <5426d0f9-6539-477d-8feb-2b49136b960f@www.fastmail.com>
 <Yv3NIQlDL0T3lstU@T590> <aadeb600-4e3a-4b69-bc17-fd2918c5b061@www.fastmail.com>
In-Reply-To: <aadeb600-4e3a-4b69-bc17-fd2918c5b061@www.fastmail.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Thu, 18 Aug 2022 23:10:13 +0800
Message-ID: <CAFj5m9JGGMOc1k71KbiHWu07Vh5FucOtR_yU35eDAfX_2GL0TQ@mail.gmail.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>,
        Paolo Valente <paolo.valente@linaro.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 9:50 PM Chris Murphy <lists@colorremedies.com> wrote:
>
>
>
> On Thu, Aug 18, 2022, at 1:24 AM, Ming Lei wrote:
>
> >
> > Also please test the following one too:
> >
> >
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 5ee62b95f3e5..d01c64be08e2 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1991,7 +1991,8 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx
> > *hctx, struct list_head *list,
> >               if (!needs_restart ||
> >                   (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
> >                       blk_mq_run_hw_queue(hctx, true);
> > -             else if (needs_restart && needs_resource)
> > +             else if (needs_restart && (needs_resource ||
> > +                                     blk_mq_is_shared_tags(hctx->flags)))
> >                       blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
> >
> >               blk_mq_update_dispatch_busy(hctx, true);
> >
>
> Should I test both patches at the same time, or separately? On top of v5.17 clean, or with b6e68ee82585 still reverted?

Please test it separately against v5.17.

thanks,

