Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B121753A5A6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353067AbiFANIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245269AbiFANIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:08:13 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E32912099;
        Wed,  1 Jun 2022 06:08:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o9so960550wmd.0;
        Wed, 01 Jun 2022 06:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=G8G1wDJSbB2ex2GaSeSsf8H1z5vD3B/zuqms9eCbXDI=;
        b=Rec1skFoe2Rnj1FvtON2aLb3K4CIsT8BEcZdVJciC9lMrkkAD9yjW91g3a8LwEr78R
         ctPcLgH22B5UuiQTQP1Pet8EhLnRpe4Llor7YrUVzC9tWAxaC1oPQhXTB7v3l79zmesn
         o9CPRSFeb778AWAmTB4rEDaxhX9qtCm0x5+djjtyDIOBlS5XKZLCyIRbLO6fAm29aQN3
         zVpIArImbvG52GAOq/IzBFbM+vM/IzJa+gaezxSKUqzp6ImNPVjOgLh4aTO5KaQMU8SY
         Hcy0JPc5eyF0jOShXLizAfmOewdm8EuoLqDORNEOvaQ45lnUTYc5YR0N+GBmvLwkFHVE
         6UQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=G8G1wDJSbB2ex2GaSeSsf8H1z5vD3B/zuqms9eCbXDI=;
        b=Sv8yIm4P3vH5W2nUBoE0ZkgnO2W/hF5xoVFjxkMIYL8ruS9joe0YS/PafF5yx7VVNE
         S7y2/60D8hyc8ZdpPkzGdrjJRF6dwx6tXNjDAUK/66hg/hsk22mHMXJI+iLkMC00L5Bz
         1oPyMpVwil3rDGal1pTSYw7MzOHNtXSv3kyZbRX51XUWDHiaeWFi5PVBjfng4aSsyuBZ
         56x0kl0NX+fcoisGpQ3eJwe2YaYZb1hFvuMrNbCY9FLNJPdRpnYWx02r3c1KcMpHR2GX
         7YRxRpHma1kZfwqnMlKBraMz2kJMRWWGoCaUU7rtYXXqG06eeUpM2ZN7uB3bKc1iPlBb
         7RGg==
X-Gm-Message-State: AOAM533VslC7eHCZolXjQNZ5GUi3YGrjeQZlf1/zacxJ0RQNH0bDmylt
        DhD2O5jGpZHE4w7JgN/rVkE=
X-Google-Smtp-Source: ABdhPJwBuo/cKqq5pTiqjdVyhYMtSikGql1eGwHT2tWUqpu5BKFX8Hu1lO0l9SjqKVfNPECVMj5HLQ==
X-Received: by 2002:a05:600c:a41:b0:39c:1512:98bd with SMTP id c1-20020a05600c0a4100b0039c151298bdmr11764958wmq.88.1654088889650;
        Wed, 01 Jun 2022 06:08:09 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef02:1900:8f43:42cb:e8c8:c65c? (p200300f6ef0219008f4342cbe8c8c65c.dip0.t-ipconnect.de. [2003:f6:ef02:1900:8f43:42cb:e8c8:c65c])
        by smtp.gmail.com with ESMTPSA id 63-20020a1c1942000000b003974cb37a94sm5251307wmz.22.2022.06.01.06.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 06:08:09 -0700 (PDT)
Message-ID: <5b808f06ba7532bbfd9c2745420aedfa9464a297.camel@gmail.com>
Subject: Re: [PATCH v1] iio: trigger: warn about non-registered iio trigger
 getting attempt
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 01 Jun 2022 15:09:03 +0200
In-Reply-To: <20220601103356.xlimabcihaay5jky@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220531181457.26034-1-ddrokosov@sberdevices.ru>
         <20220531185729.z6246gexteyo4xmd@CAB-WSD-L081021.sigma.sbrf.ru>
         <786db9cf74473caef10dcea79975716b5516f47e.camel@gmail.com>
         <20220601103356.xlimabcihaay5jky@CAB-WSD-L081021.sigma.sbrf.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-01 at 10:33 +0000, Dmitry Rokosov wrote:
> Hi Nuno,
>=20
> Thank you for comments!
>=20
> On Wed, Jun 01, 2022 at 10:47:54AM +0200, Nuno S=C3=A1 wrote:
> > On Tue, 2022-05-31 at 18:57 +0000, Dmitry Rokosov wrote:
> > > Hi Jonathan,
> > >=20
> > > I have one question about a cases when trigger owner is builtin
> > > module.
> > > In the such cases trig->owner =3D=3D null, because THIS_MODULE equals
> > > to
> > > null. How do you think, should we take into account such
> > > situations?
> > >=20
> > > IMHO we have to take in and save this information to trig_info
> > > during
> > > trigger allocation call. For example we can check THIS_MODULE
> > > from
> > > the
> >=20
> > Hmmm, If we were to do something during iio_trigger_alloc(), we
> > would
> > rather assign already THIS_MODULE to owner and we would not need
> > this
> > WARN(). I mean, if someone calls iio_trigger_get() before
> > allocating
> > it, it will have bigger problems :).
> >=20
>=20
> You are right, non-allocated pointer dereference is much bigger
> problem :)
>=20
> > I think this could actually be something reasonable...
>=20
> I think it could be a good solution, but it's required a lot of
> changes
> in the IIO drivers code, because if we assign trig->owner from
> iio_trigger_alloc(), we do not need this_mod parameter in the
> iio_trigger_register() iface and its wrappers.
> So it means to make it workable we must:
> =C2=A0=C2=A0=C2=A0 - rework iio_trigger_alloc()
> =C2=A0=C2=A0=C2=A0 - redesign iio_trigger_register() iface and its wrappe=
rs
> =C2=A0=C2=A0=C2=A0 - correct iio_trigger_register() call from all IIO dri=
vers
>=20
> I suppose we need to wait for Jonathan's comments here...
>=20

I think we could actually get this done without having to change all
the drivers. Note on how iio_trigger_register() passes THIS_MODULE to
the internal API. We could also use macros in the alloc function in a
way that only internal functions would need to be changed. But it all
depends on whether or not Jonathan wants this moved...

- Nuno S=C3=A1
