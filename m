Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7FC4F1457
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbiDDMIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238748AbiDDMIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:08:07 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90531FA6E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 05:06:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id h7so16863423lfl.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 05:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MV4qH4Hhk8OCQ8ozHbvCNo6qYwp9Nh2KxCigjmrKGfM=;
        b=QPG4g01D8+zcutd4ZOtj14dNMDWLfgiCkpvgxVqD5vVG225UdWoO2L00EkZ72yHBw3
         JC/xzN/AO9+iCo3rIB1gnwykIgSa7zAHt7lI3EVNiAaJmV2IbEzoIU8agjY+T0wYfsfo
         ITj/cycIBpDIZ+/PB2IRgFsx4Gv9vXL73KADDZ0ioliLYXFO6B0/sGCffD/OU/qo4Kuh
         FQi2h95JmXDNwLyIp9iAUe26d6bJxwO1YP1I62NRkUQ4abeA9i9Hr7svByWVUXl4ZrCV
         zvVT/7G/Ehm0dDKj4UzR1SwStLyXPM6lgfywOqMcJedfkSWPE2rr2MdBQa+dc6yQuEKo
         8NWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MV4qH4Hhk8OCQ8ozHbvCNo6qYwp9Nh2KxCigjmrKGfM=;
        b=4ACBe/jZ1BVtw0uiwtQqmfPgF/taFH1r5tGEzvwJ0U5v/ac/EIAOprrJpq7T57aKOm
         epKc1aPYl2SvZlx9/PtXmoF8eeTH6xX4xwi3FzT+ouu6i2pP7LIp1KrIuI1+IH9waD+V
         82HSPrmw2klMS/Es8HEvEyonEOOpDbed8cJe/BJvzAhOhU4BoSMI3h8YjQEDftoOHMkk
         XynwsrEOwcxKjiZ6TfETpfg4uDQlmmVT7sadRrQSB7yI+AxGZD9VTRV9tXpddy5f5jDs
         au3EtiRtz3nnYw+nLwK8QxVH7XzYi/QSB2gTn5lG4o9U/VZIa2k+4UHuqY5pjwUiQz3g
         glVg==
X-Gm-Message-State: AOAM532P3gitkLfPfcXZ9/OsxZ29AAlJj2IeswiLvz7OchgMSLnLY1G3
        efGaooDZ9m54y3g7s1rf7EAfkxAlyWhmdAqSnKx+Rw==
X-Google-Smtp-Source: ABdhPJy+nY10ZOd1gX4mC40x2Y0PTtXWJa7ExeMPjT3XD5FYs7YqTmZo9uHZYsABpgJ9+Ub7bV+0fqQPlbahc4+Mqe8=
X-Received: by 2002:ac2:5f0b:0:b0:448:1e32:4531 with SMTP id
 11-20020ac25f0b000000b004481e324531mr23113283lfq.167.1649073968994; Mon, 04
 Apr 2022 05:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220321115059.21803-1-wsa+renesas@sang-engineering.com> <20220321115059.21803-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220321115059.21803-2-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 4 Apr 2022 14:05:32 +0200
Message-ID: <CAPDyKFqt8UUfGVHvpSX5ciP7qJReTYed=sffCGWPP9psS3vC_w@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] mmc: core: improve API to make clear
 mmc_hw_reset is for cards
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022 at 12:51, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> To make it unambiguous that mmc_hw_reset() is for cards and not for
> controllers, we a) add 'card' to the function name and b) make the
> function argument mmc_card instead of mmc_host. A fallback is provided
> until all users are converted.

In my opinion, I think b) is sufficient and would be a nice improvement.

In this regard, I suggest we make one big cross-subsystem patch (the
smallest change as possible) then I can pick it up and send it for the
v5.18-rc2.

Br
Uffe

>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/mmc/core/block.c    |  2 +-
>  drivers/mmc/core/core.c     | 18 +++++++++++++-----
>  drivers/mmc/core/mmc_test.c |  3 +--
>  include/linux/mmc/core.h    |  1 +
>  4 files changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 4e67c1403cc9..74674a4650b0 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -993,7 +993,7 @@ static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
>                 return -EEXIST;
>
>         md->reset_done |= type;
> -       err = mmc_hw_reset(host);
> +       err = mmc_card_hw_reset(host->card);
>         /* Ensure we switch back to the correct partition */
>         if (err) {
>                 struct mmc_blk_data *main_md =
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 368f10405e13..71e75196bc53 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1984,7 +1984,8 @@ int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen)
>  }
>  EXPORT_SYMBOL(mmc_set_blocklen);
>
> -static void mmc_hw_reset_for_init(struct mmc_host *host)
> +/* we can't use mmc_card as a parameter, it is not populated yet */

Please drop this. The function is internal/static and at least to me,
rather self-explanatory.

[...]

Kind regards
Uffe
