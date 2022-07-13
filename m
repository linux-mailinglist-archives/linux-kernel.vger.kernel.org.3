Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BD5573B43
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbiGMQa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbiGMQaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:30:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F7B22BCE;
        Wed, 13 Jul 2022 09:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8F36B820DD;
        Wed, 13 Jul 2022 16:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FB8C34114;
        Wed, 13 Jul 2022 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657729820;
        bh=Nj/cSJ3aiSlsXlRKjR7iKliBWLuG3wKJK9ksDyvn6io=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DPKw5nM6na4V+WSXIfHBo87+clWTGud4RrmpEoVeEvTyxa4kOp9gcuX8tAureCJNQ
         9/b9QdaH5Rj5AeESy6rXdy2L/MB7lNyib71IUWDEM+Xd1SJxvvblKShKMjICuyIsNC
         kveTRv77DcOFQIh1xX9CDIb8oAhnl5389/aQlqVFIhdZBkNsYe/P8bbDK17PxCY77L
         D/fJ73mBAW24fSdNDS7FDuoAoS+PHPhANQOhAbV4CiKtxKb3u3PgFrbiI8dRAxmK94
         zrgKcq7NCuqJUhuhX4Q10OUCAgE0X6GvCrHv8BaHyCrkyyA67KPdV6Ts2Zibp7B+zp
         7zwpa4IUkWwCA==
Date:   Wed, 13 Jul 2022 17:40:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     ktsai@capellamicro.com, lars@metafoo.de, hdegoede@redhat.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: cm32181: Add PM support
Message-ID: <20220713174009.2f18b0e4@jic23-huawei>
In-Reply-To: <CAAd53p6OS+WH+vP3GUyrExmy_a7KoGyN6-v5hspcFaBoS1S07Q@mail.gmail.com>
References: <20220707000151.33381-1-kai.heng.feng@canonical.com>
        <20220707175037.1352fa6b@jic23-huawei>
        <CAAd53p6OS+WH+vP3GUyrExmy_a7KoGyN6-v5hspcFaBoS1S07Q@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 09:30:52 +0800
Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> On Fri, Jul 8, 2022 at 12:40 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Thu,  7 Jul 2022 08:01:51 +0800
> > Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> >  
> > > The read on in_illuminance_input keeps at 0 after system sleep.
> > >
> > > So add proper suspend and resume callback to make the sensor keep
> > > working after system sleep.
> > >
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>  
> > Applied to the togreg branch of iio.git and pushed out as testing for
> > the autobuilders to poke at it and see if we missed anything,  
> 
> This commit doesn't seem to be included in iio/togreg branch.

Seems I got distracted and didn't push out.
Should be there now,

Jonathan

> Kai-Heng
> 
> >
> > Thanks,
> >
> > Jonathan
> >  
> > > ---
> > > v2:
> > >  - Use dev_get_drvdata() instead of i2c_get_clientdata() to avoid extra
> > >    dereference.
> > >
> > >  drivers/iio/light/cm32181.c | 22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > >
> > > diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> > > index 97649944f1df6..edbe6a3138d0b 100644
> > > --- a/drivers/iio/light/cm32181.c
> > > +++ b/drivers/iio/light/cm32181.c
> > > @@ -460,6 +460,8 @@ static int cm32181_probe(struct i2c_client *client)
> > >                       return PTR_ERR(client);
> > >       }
> > >
> > > +     i2c_set_clientdata(client, indio_dev);
> > > +
> > >       cm32181 = iio_priv(indio_dev);
> > >       cm32181->client = client;
> > >       cm32181->dev = dev;
> > > @@ -486,6 +488,25 @@ static int cm32181_probe(struct i2c_client *client)
> > >       return 0;
> > >  }
> > >
> > > +static int cm32181_suspend(struct device *dev)
> > > +{
> > > +     struct i2c_client *client = to_i2c_client(dev);
> > > +
> > > +     return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> > > +                                      CM32181_CMD_ALS_DISABLE);
> > > +}
> > > +
> > > +static int cm32181_resume(struct device *dev)
> > > +{
> > > +     struct i2c_client *client = to_i2c_client(dev);
> > > +     struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
> > > +
> > > +     return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> > > +                                      cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
> > > +}
> > > +
> > > +DEFINE_SIMPLE_DEV_PM_OPS(cm32181_pm_ops, cm32181_suspend, cm32181_resume);
> > > +
> > >  static const struct of_device_id cm32181_of_match[] = {
> > >       { .compatible = "capella,cm3218" },
> > >       { .compatible = "capella,cm32181" },
> > > @@ -506,6 +527,7 @@ static struct i2c_driver cm32181_driver = {
> > >               .name   = "cm32181",
> > >               .acpi_match_table = ACPI_PTR(cm32181_acpi_match),
> > >               .of_match_table = cm32181_of_match,
> > > +             .pm = pm_sleep_ptr(&cm32181_pm_ops),
> > >       },
> > >       .probe_new      = cm32181_probe,
> > >  };  
> >  

