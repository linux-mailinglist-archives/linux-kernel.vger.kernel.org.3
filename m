Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C6B5856EE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 00:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239496AbiG2WtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 18:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiG2WtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 18:49:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84661054E;
        Fri, 29 Jul 2022 15:49:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F9E36069C;
        Fri, 29 Jul 2022 22:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2029C433C1;
        Fri, 29 Jul 2022 22:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659134940;
        bh=LkvPfzYtfb9EjP1LAFWhigdFg66QIUbWSN0sx4uuD5U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rIhE8QZHqZkY2dVBmpIWzaOfDZb672NNgWXlQNsS69rJ8P3KUjxsDZxTUIxKDm9+u
         G4NSbiizBSRcct7TwS6e2ZIInUXS/CxOnm4gIPY87wW7Jtw24BjnrqhoCQyFUmIrM8
         pIgD8bPiju7uEAovlI/r7oc284DMDdcRyJpth8jltcEUr+3DGZJ0MkJnx/coSs1KXa
         Tkmi8UxohvDSfh35guDxJ6pj5UvcoM06b0xoeWKrosAHmk7GoShC/efILj+LlrUep8
         mO02f5HHBLOHTxHDhtmstuIe1keiTRFI7jkDANOxSr1wpb0r7q9NQz6r25kQVQA+7w
         wjUHd6ZUu4ljQ==
Received: by mail-yb1-f180.google.com with SMTP id e127so9757059yba.12;
        Fri, 29 Jul 2022 15:49:00 -0700 (PDT)
X-Gm-Message-State: ACgBeo3/JwWBDBqMmq+8EQMAMtM9wVPsYeOHOK7ha75oKVsCOBaRR/R1
        OgWlr6sjd9gXUWBObQ49NNauLQsdbxhp+KkcJcM=
X-Google-Smtp-Source: AA6agR42WT30UcPMWcAnSW+BY9IARYILzVHBkx7ZY7ZWL7bp4J+x4UkZWsqyY/BK+Ob3MBki6HHkRAC0sguKu/PL3pw=
X-Received: by 2002:a25:9d8c:0:b0:676:cd19:b236 with SMTP id
 v12-20020a259d8c000000b00676cd19b236mr2019179ybp.257.1659134939828; Fri, 29
 Jul 2022 15:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220727210600.120221-1-logang@deltatee.com> <20220727210600.120221-2-logang@deltatee.com>
 <YuKZmloAcZWY5of8@infradead.org>
In-Reply-To: <YuKZmloAcZWY5of8@infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 29 Jul 2022 15:48:48 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4jtiuNPzC2aK-Jo80X15AWdYi7HQ2n7YWqVP6Uux3hYg@mail.gmail.com>
Message-ID: <CAPhsuW4jtiuNPzC2aK-Jo80X15AWdYi7HQ2n7YWqVP6Uux3hYg@mail.gmail.com>
Subject: Re: [PATCH 1/5] md/raid5: Refactor raid5_get_active_stripe()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 7:13 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Jul 27, 2022 at 03:05:56PM -0600, Logan Gunthorpe wrote:
> > Refactor the raid5_get_active_stripe() to read more linearly in
> > the order it's typically executed.
> >
> > The init_stripe() call is called if a free stripe is found and the
> > function is exited early which removes a lot of if (sh) checks and
> > unindents the following code.
> >
> > Remove the while loop in favour of the 'goto retry' pattern, which
> > reduces indentation further. And use a 'goto wait_for_stripe' instead
> > of an additional indent seeing it is the unusual path and this makes
> > the code easier to read.
> >
> > No functional changes intended. Will make subsequent changes
> > in patches easier to understand.
>
> I find the new loop even more confusing than the old one.  I'd go
> with something like the version below (on top of the whol md-next tree
> that pulled this in way too fast..)

This looks good to me. Christoph, would you mind send official patch
for this?

Thanks,
Song

>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 4456ac51f7c53..cd8ec4995a49b 100644
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
> +                        * waiting on quiesce, otherwise the batch_last will
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
