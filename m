Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDA258384E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 07:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbiG1Fzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 01:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiG1Fzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 01:55:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3015E57262;
        Wed, 27 Jul 2022 22:55:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D88FAB821C2;
        Thu, 28 Jul 2022 05:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B09C433D6;
        Thu, 28 Jul 2022 05:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658987733;
        bh=DUDHTcuvIpp71R4euVPZqQUfVOIvukmavIN5Uge2ANY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JrVX0l75QZwJIqKw2c3HzCLLhCABtmRE32QvoSRvYW8sdoRFNkQX9DiE7Q6Z4J0me
         ZrD9YIv2cEugKW8DMcr/xAY7STaxXcc2cIoZXttYlTU2C28btXcHbS0y1ntBxOphHf
         /Cx9bxX0l79vhMevGaWg1Tzy+ZtgyEBUkiqdXW5bpyn6P12PSZRkIizAIICl/pdfIS
         QxwmqSPL5Oz6OltMC0CPYPYj99isDOo0H6vZMFQ0AtsGwhKBYhgbBXQhhEr1lFgnt+
         ucZrIIRm5pvLU+89Tnve2V0bZbo2SxRDj+tnMtcsXxbUdkd7ECzRqkRkqNc6OwqU54
         z8Ylrx96Vq89w==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-31f41584236so8559577b3.5;
        Wed, 27 Jul 2022 22:55:33 -0700 (PDT)
X-Gm-Message-State: AJIora/3JsX+YCPPWXU0hy8cOP0p7appN0oWOyCslU90rRkT0t7fLPvQ
        ejnz1DraCEByrC/LPZq2K2Knk3vi15R8OvSKtj0=
X-Google-Smtp-Source: AGRyM1vgypE0k5aiU3RHkEJf6DMr5nyDHhemQecWGE6d6RPuC/lOaFAXOL7tv5qj1pMK2dto84JYThdJZd0TN+6F33U=
X-Received: by 2002:a81:551:0:b0:322:1cd3:8a35 with SMTP id
 78-20020a810551000000b003221cd38a35mr2686027ywf.148.1658987732528; Wed, 27
 Jul 2022 22:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220728113919.7985-1-Wentao_Liang_g@163.com>
In-Reply-To: <20220728113919.7985-1-Wentao_Liang_g@163.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 27 Jul 2022 22:55:21 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6WEfJeCNu8T5tTu2W7+mHdGqdccRB05+5n=oz=8CgUzg@mail.gmail.com>
Message-ID: <CAPhsuW6WEfJeCNu8T5tTu2W7+mHdGqdccRB05+5n=oz=8CgUzg@mail.gmail.com>
Subject: Re: [PATCH] drivers:md:fix a potential use-after-free bug
To:     Wentao_Liang <Wentao_Liang_g@163.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 8:40 PM Wentao_Liang <Wentao_Liang_g@163.com> wrote:
>
> In line 2884, "raid5_release_stripe(sh);" drops the reference to sh and
> may cause sh to be released. However, sh is subsequently used in lines
> 2886 "if (sh->batch_head && sh != sh->batch_head)". This may result in an
> use-after-free bug.
>
> It can be fixed by moving "raid5_release_stripe(sh);" to the bottom of
> the function.
>
> The bug has been confirmed by Song on 2021-08-14. Now, I resend this
> patch with my real name. I hope the patch can be updated in a near
> future.

I removed this paragraph while applying the patch, as it doesn't belong to
the commit log. In the future you can put it after a "---", so it will
be dropped
automatically by git-am. In other words, use something like:

========================================
...
Signed-off-by: Wentao_Liang <Wentao_Liang_g@163.com>
---
The bug has been confirmed by Song on 2021-08-14. Now, I resend this
patch with my real name. I hope the patch can be updated in a near
future. (This will be dropped.)
---
 drivers/md/raid5.c | 2 +-
...
======================================
>
> Signed-off-by: Wentao_Liang <Wentao_Liang_g@163.com>

Applied to md-next. Thanks for the fix.


> ---
>  drivers/md/raid5.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 5d09256d7f81..93fcbeac5096 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -2881,10 +2881,10 @@ static void raid5_end_write_request(struct bio *bi)
>         if (!test_and_clear_bit(R5_DOUBLE_LOCKED, &sh->dev[i].flags))
>                 clear_bit(R5_LOCKED, &sh->dev[i].flags);
>         set_bit(STRIPE_HANDLE, &sh->state);
> -       raid5_release_stripe(sh);
>
>         if (sh->batch_head && sh != sh->batch_head)
>                 raid5_release_stripe(sh->batch_head);
> +       raid5_release_stripe(sh);
>  }
>
>  static void raid5_error(struct mddev *mddev, struct md_rdev *rdev)
> --
> 2.25.1
>
