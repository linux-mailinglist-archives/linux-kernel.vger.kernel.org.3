Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65095A570F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiH2WXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiH2WXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:23:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695968276A;
        Mon, 29 Aug 2022 15:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04E9B612EE;
        Mon, 29 Aug 2022 22:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6317BC433B5;
        Mon, 29 Aug 2022 22:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661811826;
        bh=2ngJC3O39kPRPMioYMTDLmYI3pojOfPaE67eugc3YTA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uVzIJsFVejbF0ji2G2ZS+ClcNFicRXvUKBMgcETzO0C8MUpFf0YPCrVc5jXQe8uke
         C039MfGScOmsjUqhizIbXZX1jH1NVSqXDA7eSLjOsnEiYVmy/gbMvGjRZ03Ir3wx66
         IYhYkzlT791FN+ZHPysYm2FrTL38XUWvzpuwdB0ucBxADL+zh1tdqSpP4xN5YA5loG
         kA4APiDCL4AfuE+ZfRH5NZ5Mr0UbXlipB4hiVTZBhbc0Pw0RcdKcr5So1lLwJEpYX1
         PHiLhpF92+B2LTdc/yXaVSGztt3LhLPhm+36AnG5ArjAPctIYPE0tBmwbn3Ihi5d4i
         MP2h5xKYQFWQQ==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-334dc616f86so230897167b3.8;
        Mon, 29 Aug 2022 15:23:46 -0700 (PDT)
X-Gm-Message-State: ACgBeo1jAvBoLB78M/kIvtjCaPKbmBHUH4FsrhC3g/4WuDex0d5uBGpy
        9O6Ll6wga0h/CQdC+/h6fb5VD9/zF5NAQ/cMMHA=
X-Google-Smtp-Source: AA6agR5U4Uzz8rYMXw2KnNoFv48bfkckDUw6S3y8fqqklfQ7G7REWuoo9KTXTTKEKKI8F3wScitBzfrlxX7sdFWmYi8=
X-Received: by 2002:a05:6902:1501:b0:697:c614:2079 with SMTP id
 q1-20020a056902150100b00697c6142079mr9813353ybu.389.1661811825340; Mon, 29
 Aug 2022 15:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220811171417.147697-1-logang@deltatee.com> <20220811171417.147697-3-logang@deltatee.com>
In-Reply-To: <20220811171417.147697-3-logang@deltatee.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 29 Aug 2022 15:23:34 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7p4e6PNUo8dwMi8+2WLkUUo3mb6ctDD+jjquNqoqAcOw@mail.gmail.com>
Message-ID: <CAPhsuW7p4e6PNUo8dwMi8+2WLkUUo3mb6ctDD+jjquNqoqAcOw@mail.gmail.com>
Subject: Re: [PATCH 2/5] md/raid5: Refactor raid5_get_active_stripe()
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 10:14 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> Refactor raid5_get_active_stripe() without the gotos with an
> explicit infinite loop and some additional nesting.
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Applied to md-next.

Thanks!
Song

> ---
>  drivers/md/raid5.c | 82 +++++++++++++++++++++++-----------------------
>  1 file changed, 41 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 4456ac51f7c5..1288ef9e1571 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -811,54 +811,54 @@ static struct stripe_head *__raid5_get_active_stripe(struct r5conf *conf,
>
>         spin_lock_irq(conf->hash_locks + hash);
>
> -retry:
> -       if (!noquiesce && conf->quiesce) {
> -               /*
> -                * Must release the reference to batch_last before waiting,
> -                * on quiesce, otherwise the batch_last will hold a reference
> -                * to a stripe and raid5_quiesce() will deadlock waiting for
> -                * active_stripes to go to zero.
> -                */
> -               if (ctx && ctx->batch_last) {
> -                       raid5_release_stripe(ctx->batch_last);
> -                       ctx->batch_last = NULL;
> -               }
> -
> -               wait_event_lock_irq(conf->wait_for_quiescent, !conf->quiesce,
> -                                   *(conf->hash_locks + hash));
> -       }
> +       for (;;) {
> +               if (!noquiesce && conf->quiesce) {
> +                       /*
> +                        * Must release the reference to batch_last before
> +                        * waiting, on quiesce, otherwise the batch_last will
> +                        * hold a reference to a stripe and raid5_quiesce()
> +                        * will deadlock waiting for active_stripes to go to
> +                        * zero.
> +                        */
> +                       if (ctx && ctx->batch_last) {
> +                               raid5_release_stripe(ctx->batch_last);
> +                               ctx->batch_last = NULL;
> +                       }
>
> -       sh = find_get_stripe(conf, sector, conf->generation - previous, hash);
> -       if (sh)
> -               goto out;
> +                       wait_event_lock_irq(conf->wait_for_quiescent,
> +                                           !conf->quiesce,
> +                                           *(conf->hash_locks + hash));
> +               }
>
> -       if (test_bit(R5_INACTIVE_BLOCKED, &conf->cache_state))
> -               goto wait_for_stripe;
> +               sh = find_get_stripe(conf, sector, conf->generation - previous,
> +                                    hash);
> +               if (sh)
> +                       break;
>
> -       sh = get_free_stripe(conf, hash);
> -       if (sh) {
> -               r5c_check_stripe_cache_usage(conf);
> -               init_stripe(sh, sector, previous);
> -               atomic_inc(&sh->count);
> -               goto out;
> -       }
> +               if (!test_bit(R5_INACTIVE_BLOCKED, &conf->cache_state)) {
> +                       sh = get_free_stripe(conf, hash);
> +                       if (sh) {
> +                               r5c_check_stripe_cache_usage(conf);
> +                               init_stripe(sh, sector, previous);
> +                               atomic_inc(&sh->count);
> +                               break;
> +                       }
>
> -       if (!test_bit(R5_DID_ALLOC, &conf->cache_state))
> -               set_bit(R5_ALLOC_MORE, &conf->cache_state);
> +                       if (!test_bit(R5_DID_ALLOC, &conf->cache_state))
> +                               set_bit(R5_ALLOC_MORE, &conf->cache_state);
> +               }
>
> -wait_for_stripe:
> -       if (noblock)
> -               goto out;
> +               if (noblock)
> +                       break;
>
> -       set_bit(R5_INACTIVE_BLOCKED, &conf->cache_state);
> -       r5l_wake_reclaim(conf->log, 0);
> -       wait_event_lock_irq(conf->wait_for_stripe,
> -                           is_inactive_blocked(conf, hash),
> -                           *(conf->hash_locks + hash));
> -       clear_bit(R5_INACTIVE_BLOCKED, &conf->cache_state);
> -       goto retry;
> +               set_bit(R5_INACTIVE_BLOCKED, &conf->cache_state);
> +               r5l_wake_reclaim(conf->log, 0);
> +               wait_event_lock_irq(conf->wait_for_stripe,
> +                                   is_inactive_blocked(conf, hash),
> +                                   *(conf->hash_locks + hash));
> +               clear_bit(R5_INACTIVE_BLOCKED, &conf->cache_state);
> +       }
>
> -out:
>         spin_unlock_irq(conf->hash_locks + hash);
>         return sh;
>  }
> --
> 2.30.2
>
