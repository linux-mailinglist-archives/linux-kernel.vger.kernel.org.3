Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A4450EBE6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbiDYWZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiDYVYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AEC8BF5D;
        Mon, 25 Apr 2022 14:21:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FCA161422;
        Mon, 25 Apr 2022 21:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B989C385A7;
        Mon, 25 Apr 2022 21:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650921659;
        bh=yeW9+BBUV3mLk/jfmzfFnnmQesZ+9KRuhHEuOliabrk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E/JcjnDmi7uOq5bko2zU6SjHLd+HzINwHPRYwmO9Gp0hKeaMyU1dxx9ZmrEOsf7Zj
         pIEW7sM6WK2FbIV/zrXyRju9itO4v7kfA4YUtVR7YRq0ogeDwPDsZSduI6gyqAynkM
         6+hoAgKuLvu9CXOOLyq/V+VIIs6ASajy7LDcx8lpWHipD89wNms2zwFjMBIeYpahuu
         cnMBtBCYdPAee6EVicQpPLLhoG8TccCTbBG/wetCvdki0dmUZOKfS/pyCP95jBMqkA
         X6ioiWzvNJ2dRltuNo5uLSf+DExXSHn3aZg9HC1nCRXd7GCxkGFURSpczrBLiH8Qxo
         K+k8Ys/6UzJhA==
Received: by mail-yb1-f177.google.com with SMTP id r189so29435566ybr.6;
        Mon, 25 Apr 2022 14:20:59 -0700 (PDT)
X-Gm-Message-State: AOAM532D1L70MPCgiEa466nVhgk3bkILwVvwn1ckPI7QwS0DUNGpkOMK
        90VxGDR8EQS8O2EalmgleKAGU0VajX5sNNFibSo=
X-Google-Smtp-Source: ABdhPJwWKrStNu9Uj5Vqn7auM4uV4Q5j2aLQeQPBqYMe2nRVht9c4yaM2xOWTUMUx+yYi+q7fhM3ZxXsG5XCzei+6us=
X-Received: by 2002:a05:6902:114c:b0:641:87a7:da90 with SMTP id
 p12-20020a056902114c00b0064187a7da90mr18971886ybu.561.1650921658476; Mon, 25
 Apr 2022 14:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220421194558.59667-1-david.sloan@eideticom.com>
In-Reply-To: <20220421194558.59667-1-david.sloan@eideticom.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 25 Apr 2022 14:20:47 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7B=n6HYSCJxfQbumO4-e5TacvUGbOXBMHfB-TvD0M7zA@mail.gmail.com>
Message-ID: <CAPhsuW7B=n6HYSCJxfQbumO4-e5TacvUGbOXBMHfB-TvD0M7zA@mail.gmail.com>
Subject: Re: [PATCH] md: Replace role magic numbers with defined constants
To:     David Sloan <david.sloan@eideticom.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 12:46 PM David Sloan <david.sloan@eideticom.com> wrote:
>
> There are several instances where magic numbers are used in md.c instead
> of the defined constants in md_p.h. This patch set improves code
> readability by replacing all occurrences of 0xffff, 0xfffe, and 0xfffd when
> relating to md roles with their equivalent defined constant.
>
> Signed-off-by: David Sloan <david.sloan@eideticom.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks for the clean up!

> ---
>  drivers/md/md.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 309b3af906ad..b34b72fc5887 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -2645,11 +2645,12 @@ static bool does_sb_need_changing(struct mddev *mddev)
>         rdev_for_each(rdev, mddev) {
>                 role = le16_to_cpu(sb->dev_roles[rdev->desc_nr]);
>                 /* Device activated? */
> -               if (role == 0xffff && rdev->raid_disk >=0 &&
> +               if (role == MD_DISK_ROLE_SPARE && rdev->raid_disk >= 0 &&
>                     !test_bit(Faulty, &rdev->flags))
>                         return true;
>                 /* Device turned faulty? */
> -               if (test_bit(Faulty, &rdev->flags) && (role < 0xfffd))
> +               if (test_bit(Faulty, &rdev->flags) &&
> +                   role < MD_DISK_ROLE_JOURNAL)

I changed this to role < MD_DISK_ROLE_MAX.

Also made some minor style changes, and applied it to md-next.

Thanks,
Song

>                         return true;
>         }

[...]
