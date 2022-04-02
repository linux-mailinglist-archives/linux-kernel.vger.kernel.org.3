Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00EC4F045A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 17:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357250AbiDBPUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 11:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354802AbiDBPUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 11:20:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6493211C20;
        Sat,  2 Apr 2022 08:18:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1866EB80883;
        Sat,  2 Apr 2022 15:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F582C340F0;
        Sat,  2 Apr 2022 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648912731;
        bh=rx3+JliMGIpaZApdgMUkzyOqNL+m0ef+I2pUyVfu2+U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HvL+FHkqpZDJifWDwb32vEGkreVa/vjqyXMbqo5MIFfX3ZvTW+lUGJMUJRyJO7Aav
         QBv6D0QkUOFhIucwsLeFb/L8RK6ywPKPNyJKEe/xIxT39Cf9LjUUrWfUvYpeJqkIqy
         /adz/syA7EU0IUWo9xGaADeFyN5o0S3z+n4p3RwBMBaKmEQpC/UlwhUu2fELqHeLz3
         fTdxAQDZ4Nj05OmqZdCe+EO6AkE0Ok4946es8UwhJKz+KZV7n+x4RnO+EGTMS44Qs5
         scYrzXg+4eVj7wesjsnzhfJms0voI25hmuFjl21IwhSKrvUs54a69Oe76MYcybmDxx
         eXmithQccLKaA==
Date:   Sat, 2 Apr 2022 16:26:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:proximity:sx_common: Fix device property parsing on
 DT systems
Message-ID: <20220402162633.0050d289@jic23-huawei>
In-Reply-To: <CAPUE2uvpBaE+YLkg6RXq4CCEFBr5ZFhjS1dXkbse9nyH8C=2Jg@mail.gmail.com>
References: <20220331210425.3908278-1-swboyd@chromium.org>
        <CAPUE2uvpBaE+YLkg6RXq4CCEFBr5ZFhjS1dXkbse9nyH8C=2Jg@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Fri, 1 Apr 2022 13:54:51 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> On Thu, Mar 31, 2022 at 2:04 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > After commit 7a3605bef878 ("iio: sx9310: Support ACPI property") we
> > started using the 'indio_dev->dev' to extract device properties for
> > various register settings in sx9310_get_default_reg(). This broke DT
> > based systems because dev_fwnode() used in the device_property*() APIs
> > can't find an 'of_node'. That's because the 'indio_dev->dev.of_node'
> > pointer isn't set until iio_device_register() is called. Set the pointer
> > earlier, next to where the ACPI companion is set, so that the device
> > property APIs work on DT systems.
> >
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > Fixes: 7a3605bef878 ("iio: sx9310: Support ACPI property")
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>  
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>

Applied to the fixes-togreg branch of iio.git though I'll not push
that out until rc1 is out in a few days time and I can rebase appropriately.

Thinking on the cause of this problem it seems like we should really be setting
the indio_dev->dev.of_node in iio_device_alloc() and then let a driver
override it if desired rather than this approach of fill it in if not set.
Such a change only affects a few drivers based on a dumb bit of grepping.
I'd treat such a change as a cleanup though, so having this fix in place
makes sense anyway. 

Jonathan

> > ---
> >  drivers/iio/proximity/sx_common.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
> > index a7c07316a0a9..8ad814d96b7e 100644
> > --- a/drivers/iio/proximity/sx_common.c
> > +++ b/drivers/iio/proximity/sx_common.c
> > @@ -521,6 +521,7 @@ int sx_common_probe(struct i2c_client *client,
> >                 return dev_err_probe(dev, ret, "error reading WHOAMI\n");
> >
> >         ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(dev));
> > +       indio_dev->dev.of_node = client->dev.of_node;
> >         indio_dev->modes = INDIO_DIRECT_MODE;
> >
> >         indio_dev->channels =  data->chip_info->iio_channels;
> > --
> > https://chromeos.dev
> >  

