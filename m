Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1871654AEEE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243241AbiFNK7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbiFNK7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:59:01 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36139286C1;
        Tue, 14 Jun 2022 03:59:00 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u12so16370712eja.8;
        Tue, 14 Jun 2022 03:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pIl3ve2qWNEUoL+rbrKIn4jxMygDkC3EHjty1+HINlM=;
        b=kasr6ciKYU3aBbGLQ4cwq8w8ZCkS9QclEp3UGTJv9aWFhfeH63Jg5ksFBP6v/z7ODZ
         8I8GLstOsKRPgLEdR6nqRTmmZ6+r6cxP14bnQM/fAjWdecUQD1jkIRF2hLq7+Qid7dn0
         R5vl18NeVxyFIFQUxMz+KC6RcogcaOIOBx+vsCfV7wRcxpOAs23M0OoGXet2l9ttYeFv
         TVMxTLQRtnEU6DXjzxUgPffb8F2riiAGo++fA7Qgj5hz+VaXpEBcNpGfAgP+p5nSMwTI
         VIsWZog4iHy8NVOpkIYwgLV/3uD51HeAL//2tu2hHhBVA+Kup5+NxDZIsocLR+DN6w+J
         tWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pIl3ve2qWNEUoL+rbrKIn4jxMygDkC3EHjty1+HINlM=;
        b=60JKJwM/huQ/ECeL6ov3HJXIRqrlFK3JBtvLPxdYNVL2EYpU2cZocZZE2reL/YIXLg
         9kUKBpZozSv2/BnwQ45lXgwS4E15SEKVEBUEDsEK2tjp1koZwziLI5pevH+rEqSS/Iz4
         bzDhZna/pO3Zy6guJo38JcmwM3GQZshgH/FaVe9mE33mhHLm8IDoPWyQ4YnIy9KlwEG8
         rGwRwGG8HFJ0PlUU/y7zCwwE+lLawtaJIn2W7ga4dtfftWkHrVglcDlT7yEVH1My7wfB
         TPeqj9+9C0i5wUQebMcqxX5y+nQAFaA3BqcleZrWNXfHJ0NzVcmsRiJWT9VyhCaJE4A+
         p3eQ==
X-Gm-Message-State: AOAM533X8VHEWEXFF4VW47o/j36427meWV1l2ALWYq6hEPaV60HTbbsR
        1if/3694SxCg9xZLCPK7XgdXRJ7U+rcytMJvIE4=
X-Google-Smtp-Source: ABdhPJyrQBhiI0HqIsQgPdH3NL5HHlDRcXK8aanoiPins9/RAWDYVugKpOEtTl8I4lVA6480iiOiM40AjuQf94G21GY=
X-Received: by 2002:a17:906:149:b0:711:fca6:bc2f with SMTP id
 9-20020a170906014900b00711fca6bc2fmr3774376ejh.497.1655204338631; Tue, 14 Jun
 2022 03:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220613120534.36991-1-andrea.merello@iit.it> <20220613120534.36991-9-andrea.merello@iit.it>
 <CAHp75Vdh8kAH6540xCwzFh5uf=QMVTHC42a8pOgvkpObzjfD+w@mail.gmail.com> <164f663acbba481a8ea8f45f185aaf83@iit.it>
In-Reply-To: <164f663acbba481a8ea8f45f185aaf83@iit.it>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Jun 2022 12:58:21 +0200
Message-ID: <CAHp75VeYK=oCbbBVp01_b5LK_FqAo4F_bic9Me4Y6PpfFnDU6g@mail.gmail.com>
Subject: Re: [v6 08/14] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Andrea Merello <Andrea.Merello@iit.it>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 11:11 AM Andrea Merello <Andrea.Merello@iit.it> wro=
te:

...

> >> +                                /* G:   2,    4,    8,    16 */
> >
> >Indentation of this comment is a bit off.
> >
> >> +static int bno055_acc_range_vals[] =3D {1962, 3924, 7848, 15696};
> >
> >Perhaps split this to 4 lines and put the comment on top of the third li=
ne?
>
> Not sure what you mean here, sorry. May you elaborate or provide an examp=
le, please?

static int ... [] =3D {
    /* Comment goes here */
   value1, value2, ..., valueN,
};

...

> >> +static void bno055_debugfs_init(struct iio_dev *iio_dev)
> >> +{
> >> +       struct bno055_priv *priv =3D iio_priv(iio_dev);
> >> +
> >> +       priv->debugfs =3D debugfs_create_file("firmware_version", 0400=
,
> >> +                                           iio_get_debugfs_dentry(iio=
_dev),
> >> +                                           priv, &bno055_fw_version_o=
ps);
> >
> >> +       devm_add_action_or_reset(priv->dev, bno055_debugfs_remove, pri=
v->debugfs);
> >
> >Shouldn't we report the potential error here? It's not directly
> >related to debugfs, but something which is not directly related.
>
> The error eventually comes out from something that has nothing to do with=
 debugs per se (i.e. the devm stuff), but it will only affect debugfs indee=
d.
>
> Assuming that we don't want to make the whole driver fail in case debugfs=
 stuff fails (see last part of the comment above debugfs_create_file() impl=
ementation), and given that the devm_add_action_or_reset(), should indeed "=
reset" in case of failure (i.e. we should be in a clean situation anyway), =
I would say it should be OK not to propagate the error and let things go on=
.

As I said, it's not directly related to debugfs. Here is the resource
leak possible or bad things happen if you probe the driver, that fails
to add this call for removal, remove it, and try to insert again, in
such case the debugfs will be stale.

> However we can add a dev_warn() to report what happened.

Not sure if it would suffice, I leave it to Jonathan.

--=20
With Best Regards,
Andy Shevchenko
