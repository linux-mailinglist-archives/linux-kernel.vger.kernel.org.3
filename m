Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96D4521305
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbiEJLEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240100AbiEJLEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:04:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77842245C5A
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:00:43 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id b18so28594880lfv.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvqbIjZaqqz8v9VA2vUEgbSJLXck1rk/XGndPKUI8M4=;
        b=As6px3bRkV/WYceyt6eqCbvizxSd854/raXBKyf31lxnaAJmSn49+dvMLMVXwO39NQ
         k7h+5f6UaivYfJHAvl3V09m3PE74R0z6M6z75QkKfR5qLZZzXN0ZTJ6tJhbEiaZmgK0R
         AKKA7uM1YVN9EUnaSVoLGJHEh1H23U+QcIXJP8/VbRU5M/I/Sjch4cbTFIf0trkAajla
         RopZhRJKDcazJG111TrByaXgvTMNj1oUL/BrFhyFoiAl3FTHQw7GqiOWVqUUCa3KKmFD
         RC9+TYqeedTnNg6KQ/Lr31abjBy5LXXGJvVtNM76Zd6tZ78FvThB1ou90Ufkuy2cABnn
         /RJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvqbIjZaqqz8v9VA2vUEgbSJLXck1rk/XGndPKUI8M4=;
        b=o9dsmWlRhXasP8VPD69pcyAexum1RPLlDDKV9kRakJiliZ6ddUHQsftFhLx2DaJkiC
         4cxqVMhe8yj4unQdQWg67Bv+jtmtQzKGtD4/5lsquBKPrz9jVxfmvhzhJAfWLpSNzrY8
         Q7B+SKxE0o4Cn98tr4jgSGi8kOtPRgIAPpnh9LfBP/xr/OdE3k3x0QZdt+Akd7n2oxHn
         h2FLcgVckMWccBFHts+f7AfnFdL84QD6hR/Y2N9Z0U23fT0nPmR+09hpV/0thZf8uVD/
         0KsZutBOL0zs6PfF6r2O3js7q2yg/Yl2MdGkJItItCeCSS4IzGW0m4VKs7eSPxWJOjGZ
         DCyA==
X-Gm-Message-State: AOAM530YZP2tEcpG1IbWnNBoiejzen/UHuG6gncIgxeWnl4tnOWP5agX
        4e/gl1ehYv4csgOTgVP9AgDEidDTXp7qc9Qf38jifg==
X-Google-Smtp-Source: ABdhPJzs6FKfad9LRIJMUJG5aJGzOXpIrCTsPgsKEEQS+bty+cdf9FmnJFJ34reO05TPlj13fA/XDyp+df5E6xA3FW0=
X-Received: by 2002:a05:6512:e84:b0:474:12f3:cb53 with SMTP id
 bi4-20020a0565120e8400b0047412f3cb53mr11556679lfb.254.1652180441697; Tue, 10
 May 2022 04:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220429152118.3617303-1-vincent.whitchurch@axis.com>
In-Reply-To: <20220429152118.3617303-1-vincent.whitchurch@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 May 2022 13:00:04 +0200
Message-ID: <CAPDyKFqV5V7dyOZw98tp8vDdFFb6pVmQwFxdeUMD=Ls4tQhO8A@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: support zeroout using TRIM
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     kernel@axis.com, linux-block@vger.kernel.org, tytso@mit.edu,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Avri

On Fri, 29 Apr 2022 at 17:22, Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> If the device supports TRIM and indicates that it erases to zeros, we
> can use it to support hardware offloading of REQ_OP_WRITE_ZEROES.
>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Thanks for the patch, this certainly makes sense to me too.

So, applied for next (with a slightly updated commit message) and by
adding Avri's reviewed-by tag, thanks!

Kind regards
Uffe


> ---
>
> Notes:
>     https://lore.kernel.org/lkml/20160303182146.GG9772@thunk.org/ seems to agree
>     that BLKZEROOUT can use TRIM on eMMC.
>
>     BLKDISCARD uses DISCARD when available so it can't be used to send TRIM.
>
>     If TRIM should not be used for BLKZEROOUT for some reason I guess the only way
>     is to use MMC_IOC_MULTI_CMD like in this commit in mmc-utils but that's a
>     rather low-level interface:
>
>      https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git/commit/?id=43282e80e174cc73b09b81a4d17cb3a7b4dc5cfc
>
>  drivers/mmc/core/block.c | 26 ++++++++++++++++++++++----
>  drivers/mmc/core/queue.c |  2 ++
>  2 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 506dc900f5c7..0398b205a285 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -126,6 +126,7 @@ struct mmc_blk_data {
>  #define MMC_BLK_DISCARD                BIT(2)
>  #define MMC_BLK_SECDISCARD     BIT(3)
>  #define MMC_BLK_CQE_RECOVERY   BIT(4)
> +#define MMC_BLK_TRIM           BIT(5)
>
>         /*
>          * Only set in main mmc_blk_data associated
> @@ -1090,12 +1091,13 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
>         blk_mq_end_request(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
>  }
>
> -static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
> +static void mmc_blk_issue_erase_rq(struct mmc_queue *mq, struct request *req,
> +                                  int type, unsigned int erase_arg)
>  {
>         struct mmc_blk_data *md = mq->blkdata;
>         struct mmc_card *card = md->queue.card;
>         unsigned int from, nr;
> -       int err = 0, type = MMC_BLK_DISCARD;
> +       int err = 0;
>         blk_status_t status = BLK_STS_OK;
>
>         if (!mmc_can_erase(card)) {
> @@ -1111,13 +1113,13 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>                 if (card->quirks & MMC_QUIRK_INAND_CMD38) {
>                         err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                                          INAND_CMD38_ARG_EXT_CSD,
> -                                        card->erase_arg == MMC_TRIM_ARG ?
> +                                        erase_arg == MMC_TRIM_ARG ?
>                                          INAND_CMD38_ARG_TRIM :
>                                          INAND_CMD38_ARG_ERASE,
>                                          card->ext_csd.generic_cmd6_time);
>                 }
>                 if (!err)
> -                       err = mmc_erase(card, from, nr, card->erase_arg);
> +                       err = mmc_erase(card, from, nr, erase_arg);
>         } while (err == -EIO && !mmc_blk_reset(md, card->host, type));
>         if (err)
>                 status = BLK_STS_IOERR;
> @@ -1127,6 +1129,19 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>         blk_mq_end_request(req, status);
>  }
>
> +static void mmc_blk_issue_trim_rq(struct mmc_queue *mq, struct request *req)
> +{
> +       mmc_blk_issue_erase_rq(mq, req, MMC_BLK_TRIM, MMC_TRIM_ARG);
> +}
> +
> +static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
> +{
> +       struct mmc_blk_data *md = mq->blkdata;
> +       struct mmc_card *card = md->queue.card;
> +
> +       mmc_blk_issue_erase_rq(mq, req, MMC_BLK_DISCARD, card->erase_arg);
> +}
> +
>  static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
>                                        struct request *req)
>  {
> @@ -2327,6 +2342,9 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
>                 case REQ_OP_SECURE_ERASE:
>                         mmc_blk_issue_secdiscard_rq(mq, req);
>                         break;
> +               case REQ_OP_WRITE_ZEROES:
> +                       mmc_blk_issue_trim_rq(mq, req);
> +                       break;
>                 case REQ_OP_FLUSH:
>                         mmc_blk_issue_flush(mq, req);
>                         break;
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index c69b2d9df6f1..bbe2ea829ea7 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -191,6 +191,8 @@ static void mmc_queue_setup_discard(struct request_queue *q,
>                 q->limits.discard_granularity = SECTOR_SIZE;
>         if (mmc_can_secure_erase_trim(card))
>                 blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
> +       if (mmc_can_trim(card) && card->erased_byte == 0)
> +               blk_queue_max_write_zeroes_sectors(q, max_discard);
>  }
>
>  static unsigned short mmc_get_max_segments(struct mmc_host *host)
> --
> 2.34.1
>
