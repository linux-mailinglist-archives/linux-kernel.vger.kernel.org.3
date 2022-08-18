Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2A059815E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244018AbiHRKQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 06:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbiHRKQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:16:18 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D725EDF5;
        Thu, 18 Aug 2022 03:16:17 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x21so1284299edd.3;
        Thu, 18 Aug 2022 03:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=wsN7iozfhyXZXHJvriSV4ZPgggxzR3PisBDWWDPZOQM=;
        b=LXbFWrHXyFVAGMmqfKC0M++LKU5M1VSxesW12PjzaxHY+OnubhbBsITVQbUZBG1pxz
         P8ArFm0kkzhpxgk+0PsEIFzR95i/ZMVp0kye8YGw5NEUXPL5c38RniOH6FHLGpJn/cC6
         hupJqfhVoAyEitYYNf7BvsgWcGPyZ4Q6JAWY0tGCCEanUH1RKroPwDrlGfbuF8EtaJAX
         sGO2GQFvfs/5KTlptZ6ZLyFnrv4eM2ZBXYfLDBzPnZrZx6Ic23ldsNGKmGJ/7F8kvFoE
         58NmHZwIW/8rKRXENpdzAPf8gKCCEtJxMgjHesgxvhcIgnqU92sHKzUrqPSTakuE3JqY
         +mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=wsN7iozfhyXZXHJvriSV4ZPgggxzR3PisBDWWDPZOQM=;
        b=xgAsVl7QOiPoXGuzg8Tuz5xYXRhU7OVMCErt4id1hlHiKH+Gs8ujldJyAQ48xt+4EK
         d50TTRXu6W49fiqR2r26MF9diuv7PQSpPO5hRvW4iN5mgioLEXKfgDNZFi6Wfjbox0u9
         okXsIqjcNfEzSlGBqP2k5eZdgvAEg+b6qOCy3GghRNScexfhPTAPek30hXhdMS/1Fp4X
         beJatyhjYsJX2jsV0TvnxSvoC72SYeREBLeFyKJo8OhdlOzhRocei4vhmmV6KO4TkBpa
         FSE8ldHD7OHx97NutAvi9KvMlpG2SkXBA7c2gn4OTueH358DDOD0ziKb4hR60Ui6B/ia
         3Uyg==
X-Gm-Message-State: ACgBeo3V9upHv4sZtWb/zLkLcgMJW8Aoa5ZvkHsJXkE227l6AbEqP6ph
        1stObV7cnIT0OD92w4UDt9rkJqQ7omeCQhu6Q5TzdK7LEm4=
X-Google-Smtp-Source: AA6agR58funaKXG5pSH22PfDkM0MZ7V1qoe2s5pa9w7uOzefy/5KJ4YZUMTwxaNfsEWYYmx8oA6X23E0SGPK8ZGT8Kg=
X-Received: by 2002:a05:6402:d05:b0:425:b7ab:776e with SMTP id
 eb5-20020a0564020d0500b00425b7ab776emr1805765edb.142.1660817775670; Thu, 18
 Aug 2022 03:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <1660785696-9010-1-git-send-email-u0084500@gmail.com>
 <1660785696-9010-3-git-send-email-u0084500@gmail.com> <85193de5-244c-2cda-e442-656769b97b14@linaro.org>
In-Reply-To: <85193de5-244c-2cda-e442-656769b97b14@linaro.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Thu, 18 Aug 2022 18:16:04 +0800
Message-ID: <CADiBU3_RUTiG0T5vEKe0qHmHHQDXyMQL2BxFA+YgL_u-VGUNkA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] power: supply: rt9471: Add Richtek RT9471 charger driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        =?UTF-8?B?5ri45a2Q6aao?= <alina_yu@richtek.com>,
        cy_huang <cy_huang@richtek.com>, alinayu829@gmail.com,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=B9=
=B48=E6=9C=8818=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:09=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 18/08/2022 04:21, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add support for the RT9471 3A 1-Cell Li+ battery charger.
> >
> > The RT9471 is a highly-integrated 3A switch mode battery charger with
> > low impedance power path to better optimize the charging efficiency.
> >
> > Co-developed-by: Alina Yu <alina_yu@richtek.com>
> > Signed-off-by: Alina Yu <alina_yu@richtek.com>
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> > Since v2:
> > - Fix checkpatch error about 'foo * bar' to 'foo *bar' in psy_device_to=
_chip function.
> > - Specify the member name directly for the use of linear range.
> >
> > ---
>
> (...)
>
> > +
> > +static DEVICE_ATTR_RW(sysoff_enable);
> > +static DEVICE_ATTR_RW(charge_term_enable);
> > +static DEVICE_ATTR_RW(port_detect_enable);
> > +
> > +static struct attribute *rt9471_sysfs_entries[] =3D {
> > +     &dev_attr_sysoff_enable.attr,
> > +     &dev_attr_charge_term_enable.attr,
> > +     &dev_attr_port_detect_enable.attr,
> > +     NULL
>
> You need to document the sysfs ABI in Documentation.
Can it be define in 'sysfs-class-power' or a dedicated file called
'sysfs-class-power-rt9471'?
Not sure which one is better.

>
> > +};
> > +
> > +static const struct attribute_group rt9471_attr_group =3D {
> > +     .attrs  =3D rt9471_sysfs_entries,
> > +};
> > +
> > +static const struct attribute_group *rt9471_attr_groups[] =3D {
> > +     &rt9471_attr_group,
> > +     NULL
> > +};
>
> (...)
>
> > +
> > +static const struct of_device_id rt9471_of_device_id[] =3D {
> > +     { .compatible =3D "richtek,rt9471" },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, rt9471_of_device_id);
> > +
> > +static struct i2c_driver rt9471_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "rt9471",
> > +             .owner =3D THIS_MODULE,
>
> You should not need this. Run coccinelle/coccicheck on your driver.
Yes, I found it. 'module_i2c_driver' already include this owner setting.
Just remove it. Thanks.
>
>
> Best regards,
> Krzysztof
