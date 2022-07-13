Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACA35734FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbiGMLMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGMLMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:12:01 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA2E1005E2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:11:59 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id y3so10503171iof.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vkJzBdhAPnus30vWZUDhoGlIesPZU6wdK/9XY54AqKE=;
        b=TOq7MiGSZplMJVVxX6sSCfGXliPlSBpORzBi2qG0kb0/gQ7gaf3GGlhXJbZLxqrTCT
         88Byuok1DNIGL3vxFqELvbzon5A9CqzpMhoxaeqN3I30ettFKzpwkX8Spp9rkYUJezWU
         dby5KGaqS3c03aIODh/gibnfYebZmCcDYJeBCD/rGt/5irgCMEqOIaP2Huv0s4PgQzsM
         3FL/QCLUX0f0im/Df81FdFJdX6FccYl52OOQ0DJz1gDf4JfVZfbPu3QJaU9MpfwypLwp
         aaaNYuoTXEix8NPYANEPtTQmLYtMhnxp7fcAqqhTmpr98+NB4JsIDLo6FcEfyJ2lkdyG
         pF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vkJzBdhAPnus30vWZUDhoGlIesPZU6wdK/9XY54AqKE=;
        b=sQIZ5xTCOKQZWXZkaLaV0A8VqArgYs+gzsLviwRs2U6ZqSj3KMpjkrrzDOAMRrd4De
         w58tJfkba7UuuHrZIrp72LFECOJ6VQ9645JS+3aOl2wHupQA9Zqt+YkFdQlFz1sD8jLh
         2cOgXtjE4QfxdTLDRJBhlaALFWKCKuYG15uw8xvdh452dOxI4THSjjjTswpZWBWjzE0i
         aCxVnK/4+s+U3lnRXH44CakL4R6IoBwQmYzDL72fxRThee3CpRcTDHwU6b/fHihdnSH5
         pX+vFZxv0SxpQyB2IL8XctIoG6g1fOFiaorF2NOBBh5j53W9zpqo7XLVCQxXDqIjZR1P
         ET7A==
X-Gm-Message-State: AJIora+0CHJ9m6bhtJ9nG5kQPRPoTZYLTD22dDqW4jiwUvQd3V3Uhvgd
        JRXW0k4ukdahinY2wnNp8OVWcf6wuKEzaU3dgJJ4eA==
X-Google-Smtp-Source: AGRyM1vrldNjTJ0dhHIKZVP9o1actTfcyIS2tt0HbtwtGtmNgSMucO+V5JWjve1ZGR5q+4OsxT+cKnGfz1s4t0Tq++g=
X-Received: by 2002:a05:6638:2410:b0:33f:8518:659b with SMTP id
 z16-20020a056638241000b0033f8518659bmr968365jat.253.1657710719238; Wed, 13
 Jul 2022 04:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <cf4f316274c5474586d0d99b17db4a4c@hyperstone.com>
In-Reply-To: <cf4f316274c5474586d0d99b17db4a4c@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jul 2022 13:11:23 +0200
Message-ID: <CAPDyKFqfx07ePLLwn-w_c4WB6rbM43aio7xDh=h3V914QB-3GQ@mail.gmail.com>
Subject: Re: [PATCHv4] mmc: block: Add single read for 4k sector cards
To:     Christian Loehle <CLoehle@hyperstone.com>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2022 at 14:43, Christian Loehle <CLoehle@hyperstone.com> wrote:
>
> Cards with 4k native sector size may only be read 4k-aligned,
> accommodate for this in the single read recovery and use it.
>
> Fixes: 81196976ed946 (mmc: block: Add blk-mq support)
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Applied for next (please tell if you prefer this to be queued for
v5.19rc and/or stable), thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index f4a1281658db..912a398a9a76 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -176,7 +176,7 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
>                                       unsigned int part_type);
>  static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>                                struct mmc_card *card,
> -                              int disable_multi,
> +                              int recovery_mode,
>                                struct mmc_queue *mq);
>  static void mmc_blk_hsq_req_done(struct mmc_request *mrq);
>
> @@ -1302,7 +1302,7 @@ static void mmc_blk_eval_resp_error(struct mmc_blk_request *brq)
>  }
>
>  static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
> -                             int disable_multi, bool *do_rel_wr_p,
> +                             int recovery_mode, bool *do_rel_wr_p,
>                               bool *do_data_tag_p)
>  {
>         struct mmc_blk_data *md = mq->blkdata;
> @@ -1368,12 +1368,12 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
>                         brq->data.blocks--;
>
>                 /*
> -                * After a read error, we redo the request one sector
> +                * After a read error, we redo the request one (native) sector
>                  * at a time in order to accurately determine which
>                  * sectors can be read successfully.
>                  */
> -               if (disable_multi)
> -                       brq->data.blocks = 1;
> +               if (recovery_mode)
> +                       brq->data.blocks = queue_physical_block_size(mq->queue) >> 9;
>
>                 /*
>                  * Some controllers have HW issues while operating
> @@ -1590,7 +1590,7 @@ static int mmc_blk_cqe_issue_rw_rq(struct mmc_queue *mq, struct request *req)
>
>  static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>                                struct mmc_card *card,
> -                              int disable_multi,
> +                              int recovery_mode,
>                                struct mmc_queue *mq)
>  {
>         u32 readcmd, writecmd;
> @@ -1599,7 +1599,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>         struct mmc_blk_data *md = mq->blkdata;
>         bool do_rel_wr, do_data_tag;
>
> -       mmc_blk_data_prep(mq, mqrq, disable_multi, &do_rel_wr, &do_data_tag);
> +       mmc_blk_data_prep(mq, mqrq, recovery_mode, &do_rel_wr, &do_data_tag);
>
>         brq->mrq.cmd = &brq->cmd;
>
> @@ -1690,7 +1690,7 @@ static int mmc_blk_fix_state(struct mmc_card *card, struct request *req)
>
>  #define MMC_READ_SINGLE_RETRIES        2
>
> -/* Single sector read during recovery */
> +/* Single (native) sector read during recovery */
>  static void mmc_blk_read_single(struct mmc_queue *mq, struct request *req)
>  {
>         struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
> @@ -1698,6 +1698,7 @@ static void mmc_blk_read_single(struct mmc_queue *mq, struct request *req)
>         struct mmc_card *card = mq->card;
>         struct mmc_host *host = card->host;
>         blk_status_t error = BLK_STS_OK;
> +       size_t bytes_per_read = queue_physical_block_size(mq->queue);
>
>         do {
>                 u32 status;
> @@ -1732,13 +1733,13 @@ static void mmc_blk_read_single(struct mmc_queue *mq, struct request *req)
>                 else
>                         error = BLK_STS_OK;
>
> -       } while (blk_update_request(req, error, 512));
> +       } while (blk_update_request(req, error, bytes_per_read));
>
>         return;
>
>  error_exit:
>         mrq->data->bytes_xfered = 0;
> -       blk_update_request(req, BLK_STS_IOERR, 512);
> +       blk_update_request(req, BLK_STS_IOERR, bytes_per_read);
>         /* Let it try the remaining request again */
>         if (mqrq->retries > MMC_MAX_RETRIES - 1)
>                 mqrq->retries = MMC_MAX_RETRIES - 1;
> @@ -1879,10 +1880,9 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
>                 return;
>         }
>
> -       /* FIXME: Missing single sector read for large sector size */
> -       if (!mmc_large_sector(card) && rq_data_dir(req) == READ &&
> -           brq->data.blocks > 1) {
> -               /* Read one sector at a time */
> +       if (rq_data_dir(req) == READ && brq->data.blocks >
> +                       queue_physical_block_size(mq->queue) >> 9) {
> +               /* Read one (native) sector at a time */
>                 mmc_blk_read_single(mq, req);
>                 return;
>         }
> --
> 2.36.1
>
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
