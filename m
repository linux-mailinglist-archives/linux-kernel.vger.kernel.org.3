Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C3F567BBE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 04:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiGFCCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 22:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGFCCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 22:02:13 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B04193C6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 19:02:12 -0700 (PDT)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 090663F170
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657072931;
        bh=jnmb0zpL4NW6n76DYnJeaBav9/Yc3ZJVxQW1CIFh74k=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=aAAuVX/kiFDl53SaM81pUxOzhIl7Ri7lAp1oo9MlN1LR9ttmDic/nUZr+mP7/LMRu
         KPCvcAG2C+zYUtizGM/uzE8dld0vnlIbb60grK7jI+xlMTLeyAHhml1r0CBmP58bM8
         plTNuVvHnq94tSOJAMGll7697A+OYFb3nVgUws4y0VyBTMxI9w0wk1nJlhJy7XioIY
         7MelqF+iOeDmoVrKdsCPcKoCzKPJ9KqBUf6zX2KIuIz5N+IJGfMjDBdlgl1yWrjeBd
         9f2rMEPuSVZtkWjV3CAyVrRh2E7yItuBYvLMBe+9l5f0w8OA9WcUABUyROHqpRX75H
         f/HoVZ26nI2Iw==
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-101dcba4a0aso9515352fac.14
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 19:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnmb0zpL4NW6n76DYnJeaBav9/Yc3ZJVxQW1CIFh74k=;
        b=5T/2e1YaD/BhyCgduzzmwsBPMDAN5mZvM+j+1wZQ1mRR2aqezoLSUrLB7BGZbnbUgd
         EzolJJqgfJbAsuVljoeCzPlBnmLXa8OFQ5Xya63I8EtGpTyYBEuNovY8Mu5txo0zZT5L
         gisvRDlc+FOpc0UQhxIKijArIalDP0c7OIFOltQy5wEMqX3lyJa2826maUhGCWLskVnT
         BElhKGc5QmdCPYNA9gv1cr+5MoTI4uvqoL38bC4pnWeL6uy5MSmntji8vqzGnXN39ig7
         oafM7gMeWAB0RgW2OPdWW/sPDXV7UmoJ1jjiGq9LIeU0/9HDHQoDzOIbaj2MjdAKKweu
         mOHw==
X-Gm-Message-State: AJIora/osTsfvyR5zIA7Ex/AcsZLJR/YsjVEkaycnHlPMiDwUITdPl54
        CwzZv6Kw4EJ+gB9+CoxO+pfUMcoD32lq8I7CzzJC695zbYcDXKAYTc5IJQ66ll0ndBah3GOqGGT
        S3okmS8WW827deulmKLc0WHzd+K+K8vmGZTc42FiOslblMavBt5kHowMeXA==
X-Received: by 2002:a05:6808:1805:b0:335:8dcd:5d95 with SMTP id bh5-20020a056808180500b003358dcd5d95mr21886988oib.176.1657072929956;
        Tue, 05 Jul 2022 19:02:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ssxVPF7ft55Orm/Ztsbmk8TBHMuXJEKIQkFhfgSW+oG1zxq6y0ZMqz8t1s3bTZ3S8pKGr4G3kDd4sonpkspH4=
X-Received: by 2002:a05:6808:1805:b0:335:8dcd:5d95 with SMTP id
 bh5-20020a056808180500b003358dcd5d95mr21886969oib.176.1657072929635; Tue, 05
 Jul 2022 19:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220705121756.41660-1-kai.heng.feng@canonical.com> <CAHp75VdnvxhR7yB2sroH4y8VgU3ORnCC3wH4CEKYCX1XSPvMxg@mail.gmail.com>
In-Reply-To: <CAHp75VdnvxhR7yB2sroH4y8VgU3ORnCC3wH4CEKYCX1XSPvMxg@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 6 Jul 2022 10:01:57 +0800
Message-ID: <CAAd53p4ZNna2G7hD4vDfDF-fAtLNJinr+tr9LddMq06yFT26YA@mail.gmail.com>
Subject: Re: [PATCH] iio: light: cm32181: Add PM support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 3:12 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jul 5, 2022 at 2:31 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > The read on in_illuminance_input keeps at 0 after system sleep.
> >
> > So add proper suspend and resume callback to make the sensor keep
> > working after system sleep.
>
> ...
>
> > +static int cm32181_resume(struct device *dev)
> > +{
> > +       struct i2c_client *client = to_i2c_client(dev);
> > +       struct cm32181_chip *cm32181 = iio_priv(i2c_get_clientdata(client));
>
> Simply device_get_drvdata(dev) ?

iio_priv() is still needed to get the struct priv.

Kai-Heng

>
> > +       return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> > +                                        cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
