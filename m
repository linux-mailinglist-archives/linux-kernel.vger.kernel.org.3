Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F0B5AC56F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 18:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbiIDQar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 12:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbiIDQap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 12:30:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED362B27F;
        Sun,  4 Sep 2022 09:30:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 525D1B80D70;
        Sun,  4 Sep 2022 16:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B97C433C1;
        Sun,  4 Sep 2022 16:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662309041;
        bh=mdq9aBpeeejzTVkU2nNEaKiUz49Bwldf5MKVl3rvX/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k5itcawlyRhCLB0n3UVKz/qVPjFOUb7lQlkG0KVIeMRD2TCdHkLcvzqMZFNVaMZXH
         5l/looaKOtiIPuQlAGIfFNB2UOiDJHRpUcg5zppw7oW9mlS8EH04HKir+G2Bdvb8Ay
         fSsd4w20witVcY6BxO5lTU+eYleBQasC5yN6Gx9zYSqJ//qvpKSdSBU+3wyEvOoDZd
         Ee/7k0AyT4MrXKy3IHvghekciIT+ef8Lo+yEsX6Z8ogNcucy5FjZOU4aMA7Hk8A3gb
         selX/HwTmiV9mZOEJvFdGALUgaPt3qCVDNlWs72myjedK8LeXfpfBYALu8x6m+CVbE
         NQCvb45fnbsvA==
Date:   Sun, 4 Sep 2022 16:56:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Crt Mori <cmo@melexis.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 3/3] iio: temperature: mlx90632 Change return value
 of sensor measurement channel
Message-ID: <20220904165634.5cde87fd@jic23-huawei>
In-Reply-To: <CAKv63uviUbiAy6tYjkqFP-Qgs7dwAV5BPrr2aTTxQyjPBeA+Og@mail.gmail.com>
References: <20220903222422.3426156-1-cmo@melexis.com>
        <20220904154923.33b79d83@jic23-huawei>
        <CAKv63uviUbiAy6tYjkqFP-Qgs7dwAV5BPrr2aTTxQyjPBeA+Og@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Sep 2022 17:27:28 +0200
Crt Mori <cmo@melexis.com> wrote:

> On Sun, 4 Sept 2022 at 17:23, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Sun,  4 Sep 2022 00:24:22 +0200
> > cmo@melexis.com wrote:
> >  
> > > From: Crt Mori <cmo@melexis.com>
> > >
> > > The current EINVAL value is more applicable to embedded library, where
> > > user can actually put the fixed value to the sensor. In case of the
> > > driver if the value of the channel is invalid it is better in inform
> > > userspace that Channel was out of range as that implies more to internal
> > > driver error than invalid input. It also makes for easier debugging of
> > > where the error comes from during the development.
> > >
> > > Signed-off-by: Crt Mori <cmo@melexis.com>  
> > Hmm. That's an obscure return value - I think it's mostly going to confuse
> > anyone who ever gets it.  So not sure this change is wise even though the
> > descriptive text for that one does seem very much suited to this usecase.
> >  
> I did get it few times during the development due to read when sensor
> is not busy, but the measurement data not yet updated correctly due to
> powermode switch. I think I added enough delays all around to avoid
> hitting it and with proper power mode switching, but there might be a
> case, so it will be easier to spot in the source code in future. I
> would not remove it, if that is what you are proposing.

I meant leave it as EINVAL. The users of ECHRNG are very very
few in number, so I don't have a good understanding of it's expected
uses.. 
> 
> > > ---
> > >  drivers/iio/temperature/mlx90632.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> > > index 37edd324d6a1..d511d36942d3 100644
> > > --- a/drivers/iio/temperature/mlx90632.c
> > > +++ b/drivers/iio/temperature/mlx90632.c
> > > @@ -435,7 +435,7 @@ static int mlx90632_channel_new_select(int perform_ret, uint8_t *channel_new,
> > >               *channel_old = 1;
> > >               break;
> > >       default:
> > > -             return -EINVAL;
> > > +             return -ECHRNG;
> > >       }
> > >
> > >       return 0;  
> >  

