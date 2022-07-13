Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA95572AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 03:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbiGMBbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 21:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiGMBbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 21:31:09 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E37C9112
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 18:31:07 -0700 (PDT)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 623013FC12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657675866;
        bh=BCcc4GfN+MGP0hj9IK2EKrG4OYSKiM0e7SGOkyqrreo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=quaeGVgyzCiUGTDOirKxtSmbx5VPsnNPoR8kn9bWuWs92ixiryOywCnAJTbymel8u
         If/K9Booud7G/nVEehB3ERLwgsYg9GO+svHGIpfhd5U56BnmoX1fIgx2Zf+hnkAl/v
         Hp5NRMV1u/URl7NjxVxrEUQftkxW4ZaUcARhKwtqhE3zJJn98xxMZkDAwAbOaKQL8f
         ITt01HJ01zpFvD3P08TjZLlATiYCK1TPmpn3t7OyfVMUY30yLe9LVGtU7uC0Ob7jri
         hlAuCprZbloxWq7NCGlt+EI89rkcVwDawKwo/tmwpQwxJkFGNpa8fDtEUfByT8ErJJ
         8AB51BQGfk1fQ==
Received: by mail-oi1-f200.google.com with SMTP id w123-20020acaad81000000b0033a1f7de8e8so1278969oie.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 18:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BCcc4GfN+MGP0hj9IK2EKrG4OYSKiM0e7SGOkyqrreo=;
        b=inv+t/+ONTmL42PsP9MqXJcy/I0Vy6odkq4o9rxUUS+EWdt6f3GhKk8HcaHyqdA6J3
         a7NrLefMFnmNY/Z5KJmDObuOVKlLVanb8LWblUhfUjywCsxUw+cL0XyTf0RfaqeIGazi
         lHxk5Awb3Mcgryn0xYmudUmtS1JFp09vnEHTMHOy+9LgyfqyPTA8p5sp45GAzpzrlgpw
         RrG/7bXJA9GZSOkA46hyjdBtfq6phGW8NrONDuZkwZVHDZmmxErLrDPkANxegY+QRaxl
         pD3ibbB8vuJfpY4JdZJx+geBpKmNG6p/x4SoJcSnnAhKoQM4pOu1Bun2dqfj49DIO5Cd
         rohQ==
X-Gm-Message-State: AJIora+sexqI1eTl7Lj7Pp03SKzJjNoJLsy6LKWc3MtXaScpsU0vg+zT
        BIQvU6nL2QBX9QEm3iIobFE4QVp0b9otHBx6D7RtvkbtnWc7BX4Br3ZN8JX8xk791EJmd5mGwEH
        U5dCxasE6appIPpLkMwsHCXyUmwcPdfgkzLE+2qaivNuKW5Byc6OYoqvmJA==
X-Received: by 2002:a05:6808:1643:b0:335:19ba:b696 with SMTP id az3-20020a056808164300b0033519bab696mr552723oib.42.1657675865301;
        Tue, 12 Jul 2022 18:31:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v6KysfUndZJ6mEviiHlk0zOxcc1iB28C8yGi2owgz5pTmyxq1hkaNLbmASDCQ8QImXIjNRulZ6lU2Cu1DNF5g=
X-Received: by 2002:a05:6808:1643:b0:335:19ba:b696 with SMTP id
 az3-20020a056808164300b0033519bab696mr552714oib.42.1657675865013; Tue, 12 Jul
 2022 18:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220707000151.33381-1-kai.heng.feng@canonical.com> <20220707175037.1352fa6b@jic23-huawei>
In-Reply-To: <20220707175037.1352fa6b@jic23-huawei>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 13 Jul 2022 09:30:52 +0800
Message-ID: <CAAd53p6OS+WH+vP3GUyrExmy_a7KoGyN6-v5hspcFaBoS1S07Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio: light: cm32181: Add PM support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     ktsai@capellamicro.com, lars@metafoo.de, hdegoede@redhat.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 12:40 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu,  7 Jul 2022 08:01:51 +0800
> Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>
> > The read on in_illuminance_input keeps at 0 after system sleep.
> >
> > So add proper suspend and resume callback to make the sensor keep
> > working after system sleep.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to poke at it and see if we missed anything,

This commit doesn't seem to be included in iio/togreg branch.

Kai-Heng

>
> Thanks,
>
> Jonathan
>
> > ---
> > v2:
> >  - Use dev_get_drvdata() instead of i2c_get_clientdata() to avoid extra
> >    dereference.
> >
> >  drivers/iio/light/cm32181.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> > index 97649944f1df6..edbe6a3138d0b 100644
> > --- a/drivers/iio/light/cm32181.c
> > +++ b/drivers/iio/light/cm32181.c
> > @@ -460,6 +460,8 @@ static int cm32181_probe(struct i2c_client *client)
> >                       return PTR_ERR(client);
> >       }
> >
> > +     i2c_set_clientdata(client, indio_dev);
> > +
> >       cm32181 = iio_priv(indio_dev);
> >       cm32181->client = client;
> >       cm32181->dev = dev;
> > @@ -486,6 +488,25 @@ static int cm32181_probe(struct i2c_client *client)
> >       return 0;
> >  }
> >
> > +static int cm32181_suspend(struct device *dev)
> > +{
> > +     struct i2c_client *client = to_i2c_client(dev);
> > +
> > +     return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> > +                                      CM32181_CMD_ALS_DISABLE);
> > +}
> > +
> > +static int cm32181_resume(struct device *dev)
> > +{
> > +     struct i2c_client *client = to_i2c_client(dev);
> > +     struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
> > +
> > +     return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> > +                                      cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
> > +}
> > +
> > +DEFINE_SIMPLE_DEV_PM_OPS(cm32181_pm_ops, cm32181_suspend, cm32181_resume);
> > +
> >  static const struct of_device_id cm32181_of_match[] = {
> >       { .compatible = "capella,cm3218" },
> >       { .compatible = "capella,cm32181" },
> > @@ -506,6 +527,7 @@ static struct i2c_driver cm32181_driver = {
> >               .name   = "cm32181",
> >               .acpi_match_table = ACPI_PTR(cm32181_acpi_match),
> >               .of_match_table = cm32181_of_match,
> > +             .pm = pm_sleep_ptr(&cm32181_pm_ops),
> >       },
> >       .probe_new      = cm32181_probe,
> >  };
>
