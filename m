Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24D05A3EB1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 18:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiH1Q5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 12:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiH1Q5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 12:57:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8E427159;
        Sun, 28 Aug 2022 09:57:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD366B80B08;
        Sun, 28 Aug 2022 16:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F43C433C1;
        Sun, 28 Aug 2022 16:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661705839;
        bh=+gVdxXnMj9/yA6l4eDpVf7DZRA/bONWkROmhqNokrPI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hwQ6Do9fa4SfAFmSSS4Oryvivr4yMmb5xHM+0SOvG5c02e4lV3fGWz0OuAuHXZcUa
         1l4LVcIlUmHJcKIHGPzP8DeiV2uRKHc7P5QBqelF4XnvG7bk3Ojz+QS/xEdgLnxe5G
         +1gK4Zwz5f0ksANH+UfpleElIY2k4vMkTjohN/BYE52GDIjIIP1Zv3PhzxANFlPXYJ
         NkqeT4e0jdV4P7SWGRhCWKMHQ0wrfnSP8522+DsHiJ2wVIaQq1UCVSWBqIiwHaAadH
         1aQpYtvLXvkXxuhYD/1BhlXZUlTUVlFIasHtzTCMyNZMZxdMTF1wLS6skfBgHL4OF5
         d4bgSeSMptYZA==
Date:   Sun, 28 Aug 2022 17:22:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>, lars@metafoo.de,
        krisman@collabora.com, kernel@collabora.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: tsl2583: Fix module unloading
Message-ID: <20220828172258.4a78152f@jic23-huawei>
In-Reply-To: <793d9ca8-47af-2f3d-6079-e0bbb8e7d898@collabora.com>
References: <20220825092048.136973-1-shreeya.patel@collabora.com>
        <793d9ca8-47af-2f3d-6079-e0bbb8e7d898@collabora.com>
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

On Thu, 25 Aug 2022 21:53:09 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> Hi,
> 
> On 8/25/22 12:20, Shreeya Patel wrote:
> > tsl2583 uses devm_iio_device_register() function and
> > calling iio_device_unregister() in remove breaks the
> > module unloading.
> > Fix this by removing call to iio_device_unregister()
> > from tsl2583_remove().
> > 
> > Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>  
> 
> Stable and fixes tags are missing

Stable tags often added by maintainer when applying the patch
rather than at submission: can take into account how they want to
manage stable backports - some maintainers prefer to run a bunch
of tests before asking for patches to be added to stable. I don't
do that, but I don't always tag fixes for stable if I think there
is some risk associated.

Obviously this one is fine for stable material though and I would
have tagged v2 whilst applying ;)
> 
> > ---
> >  drivers/iio/light/tsl2583.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
> > index 82662dab87c0..36c25f79e6a6 100644
> > --- a/drivers/iio/light/tsl2583.c
> > +++ b/drivers/iio/light/tsl2583.c
> > @@ -878,8 +878,6 @@ static int tsl2583_remove(struct i2c_client *client)
> >  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> >  	struct tsl2583_chip *chip = iio_priv(indio_dev);
> >  
> > -	iio_device_unregister(indio_dev);
> > -
> >  	pm_runtime_disable(&client->dev);
> >  	pm_runtime_set_suspended(&client->dev);
> >    
> 
> Driver removal sequence should be opposite to the registration order.
> Could be better not to use the devm in this case

Agreed. Simplest fix is indeed to do what v2 does.

Nicer tidy up after that is perhaps to switch to
devm_pm_runtime_enable()
which tidies up nicely on that and register a
separate callback with devm_add_action_or_reset() to deal with
the power down.  However, I'm struggling to follow how the device
is powered up in the first place (particularly if we disable runtime
pm to make the flow simpler). 

I think the driver may only "work" today by merit of letting it 
autosuspend then resuming. 

Jonathan


> 

