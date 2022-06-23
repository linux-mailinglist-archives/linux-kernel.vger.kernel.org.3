Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471D0558594
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 19:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbiFWR7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 13:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbiFWR5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:57:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E836F4B5;
        Thu, 23 Jun 2022 10:15:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B63861E1D;
        Thu, 23 Jun 2022 17:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672EEC341C6;
        Thu, 23 Jun 2022 17:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656004550;
        bh=8R+RW0DB9EQ2uVvtR45zq4/JAUy2m7hPxnil1cTbtlk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mtxeAVFNaaUOJEFUJk7ElG9DH1UpHpB/WNY7S4GrmCBJ31fzAmELxc5zbtlTNydIx
         FYkxzZ/oqMyAIiOJB9C42FooAnuW7HA2I2atqBgZ59duf9XuPRV+Zwny2acXTiTueu
         HG/G5bsTK5vZPQmSthSNalyuORED+RwbABSp254wcTd2GoZtGtYlBQHlnPOmCWzLtt
         vZIRaRd4RzSZaL7plFY0pX3htWj8+YcJJpTQvDKkDCYF7D5I6VdCUs8SES1J27w1cW
         IRESsHWyRF/hVr21wXjpueLL8Q05Xy9iHqA5UcGqf400nTnWxSqsXbmlmxsgulGt/+
         vYpp/sE/CXecw==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-3178acf2a92so870667b3.6;
        Thu, 23 Jun 2022 10:15:50 -0700 (PDT)
X-Gm-Message-State: AJIora/hmev4rmtUmLQWZ7oc9DYvh68wHJvaN5cYi6PwC80TqEUfKR7W
        SvZCDPGwdvky0zSxG6UT4mx4iPyIZWn6sO2ibZo=
X-Google-Smtp-Source: AGRyM1t1olztSDrteGXYMB7kj+MmjwKdDzfi/VVXgAWzrN71mL+qoji3GFIBqR9bTs5XYPv9Msej5AWqsmKYH2U9il8=
X-Received: by 2002:a81:2f45:0:b0:317:71c7:fcdc with SMTP id
 v66-20020a812f45000000b0031771c7fcdcmr11702449ywv.73.1656004549455; Thu, 23
 Jun 2022 10:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220623165552.38645-1-logang@deltatee.com>
In-Reply-To: <20220623165552.38645-1-logang@deltatee.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 23 Jun 2022 10:15:38 -0700
X-Gmail-Original-Message-ID: <CAPhsuW50vG=M6JhBEe3qwef10GQt84cg9p_ji5tqyRnMA1-xRQ@mail.gmail.com>
Message-ID: <CAPhsuW50vG=M6JhBEe3qwef10GQt84cg9p_ji5tqyRnMA1-xRQ@mail.gmail.com>
Subject: Re: [PATCH] md/raid5: Fix divide type in raid5_make_request()
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 9:56 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> 0day reports a build failure on the hexagon architecture:
>
>   ld.lld: error: undefined symbol: __hexagon_udivdi3
>      referenced by raid5.c
>         md/raid5.o:(raid5_make_request) in archive drivers/built-in.a
>      referenced by raid5.c
>         md/raid5.o:(raid5_make_request) in archive drivers/built-in.a
>      did you mean: __hexagon_udivsi3
>         defined in: arch/hexagon/built-in.a(lib/udivsi3.o)
>
> This is caused by using DIV_ROUND_UP on a sector_t type.
>
> The actual value is known to be less than 256 so a wide 64bit divide
> here is not desirable. Thus cast the argument to an int to ensure it
> uses a 32bit divide.

I force pushed an update that uses DIV_ROUND_UP_SECTOR_T instead.
I guess that should also work?

Thanks,
Song

>
> Fixes: 681fb14a7100 ("md/raid5: Pivot raid5_make_request()")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/md/raid5.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 5723a497108a..9d25696b793d 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -6091,7 +6091,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
>         bi->bi_next = NULL;
>
>         bitmap_set(ctx.sectors_to_do, 0,
> -                  DIV_ROUND_UP(ctx.last_sector - logical_sector,
> +                  DIV_ROUND_UP((int)(ctx.last_sector - logical_sector),
>                                 RAID5_STRIPE_SECTORS(conf)));
>
>         pr_debug("raid456: %s, logical %llu to %llu\n", __func__,
>
> base-commit: 57c19f921f8081c1a9444dc7f3f6b3ea43fe612e
> --
> 2.30.2
>
