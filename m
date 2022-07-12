Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42EA5713C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiGLIAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiGLH76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:59:58 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437439B54B;
        Tue, 12 Jul 2022 00:59:57 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id o7so12584481lfq.9;
        Tue, 12 Jul 2022 00:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+qr/rB1qp3jjME/ZnJzZQtFse2L01G1JMoWBlVLSGU=;
        b=D9uRYKokFim4JLJO9gvLlORuIh6vcIUQJfDCoZKNyWB35esEUVUh/49prmxrSVqZwV
         3KQ1TeNXyy/4v9rfTGx1At0tvDe26KiAp4lF+NNjE0yzw2mg2iHXSmNUVLtGn/ZiOTs9
         ROTw/puBgp1n1TEeFXFQWpIUSiW/kG7hjZjmTHNq7uU8AuMMyDsB5wclUERNySepNxP/
         +xEhyP0MKwMwQLBTEIjajP4XfENyyWToPSpmEMm19FCMtste/xtaECL+wPeUbUu/sFXt
         Z3h+62Qa9RN2XgHk2DQ6ceN8TshvjagwtjpSHeauWhdI3v4m9FW6jPd3dqs4vCMo3csa
         hBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+qr/rB1qp3jjME/ZnJzZQtFse2L01G1JMoWBlVLSGU=;
        b=RHQ8zf5hpMbq0HALb447qwQkVi36Z3F5eDK0RQJSzszR2A6y698BFR9uMFU3Qreykh
         nDUjw+aFbdP916cOBqiFP4Rwu35O+KSCQQEIGvIz7WD8T5fhVXIVOmOE91im95EyJQd2
         WP2twYfuq0MF/ofAbcznCvh1SysaSiXW+/MmC7et1UAIGB+KRLeRwuXTBwAMhScGQCWh
         p7zJ1WY5BPvITBcYUC2pK8djw+pzXfJPcG79vGZKzaORoH4Fnob+8Zwe08SN8rU7FVIK
         l3Ayu9VELvEKog5X9b1/pRLt1hIufkmdRqlyXGEA1PcwmoPmugAokm2OM43qn1Voo54L
         ZbEg==
X-Gm-Message-State: AJIora+5F42WyGH3/j4TeAbdIcgla3Rnqdy2GaNWWsjkiqM1ErTFVue8
        fJY/G6PfcsojpamWn7jI9WrXb0wys7aNNYkg4tg=
X-Google-Smtp-Source: AGRyM1shi6v9DXsk4lwIdb0yjkJzIJOV8Bqm/mWXus8sJ5A9abScTn9/Us6KGjW2cBxKfXtDm7lOkhAKt2bBzLjAPho=
X-Received: by 2002:a05:6512:324a:b0:486:a915:7b70 with SMTP id
 c10-20020a056512324a00b00486a9157b70mr12988761lfr.265.1657612795528; Tue, 12
 Jul 2022 00:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220711134312.234268-1-tmaimon77@gmail.com> <20220711134312.234268-3-tmaimon77@gmail.com>
 <CAHp75VdXsiH9ityqopznRpjxvwOboS_Zbi9iO6nRZ03TuKxTtg@mail.gmail.com> <CAHp75VeCPRVUMHYdNWgPja2eWeStokRDSogW-7ALz10_yEaDMA@mail.gmail.com>
In-Reply-To: <CAHp75VeCPRVUMHYdNWgPja2eWeStokRDSogW-7ALz10_yEaDMA@mail.gmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 12 Jul 2022 10:59:44 +0300
Message-ID: <CAP6Zq1j_-w0n9WTUG99UVTJwsyqY0Zcs294wmA7LuWdiF4KYMA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iio: adc: npcm: Add NPCM8XX support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        zhengbin13@huawei.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for your comments, they will be addressed next version.

On Mon, 11 Jul 2022 at 17:16, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jul 11, 2022 at 4:14 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Jul 11, 2022 at 3:59 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> ...
>
> > >         struct device *dev = &pdev->dev;
> > > +       const struct of_device_id *match;
>
> > > +       match = of_match_node(npcm_adc_match, pdev->dev.of_node);
> > > +       if (!match || !match->data) {
> > > +               dev_err(dev, "Failed getting npcm_adc_data\n");
> > > +               return -ENODEV;
> > > +       }
> > >
> > > +       info->data = (struct npcm_adc_info *)match->data;
> >
> > Instead of above
> >
> >   info->data = device_get_match_data(dev);
> >   if (!info->data)
>
>
> >     return -ENODEV;
>
> Or
>
>   return dev_err_probe(dev, -EINVAL, "...\n");
>
> if you want that message to be issued.
>
>
> --
> With Best Regards,
> Andy Shevchenko

Best regards,

Tomer
