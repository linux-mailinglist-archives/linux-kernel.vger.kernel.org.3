Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6274B07FA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbiBJISV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:18:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237266AbiBJISS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:18:18 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8683A10B2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:18:19 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id y9so4508328pjf.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H574A7XQqJ2i5NOk/wD0S3rN53fezDZ1/ELWgryWgFE=;
        b=Oa+Tp3QxHuRcJB/aSgRGxHd8UwAsGvC3gacfclP4+/ahWcAWX74FK03OqlzxB3iBsg
         GQRhf9gVxyecKNxaNPkl1qjXL2lnsB8O83NCkNiO/A7Jt+oknUlyF0fO37yQ/2ImHDLT
         1n+YJWq+QEdb6y8b/PIqwgTS7NuBURzoo8L/D0jG0zeyp7Vn5wjBeGWHOadk8R8G2+lm
         8pmbuy1OZkrXQTwZKvvmerXrEQW3k0QX/rOcQfJcxMfYFY4+vupO18VqImPsRvMRs5Ax
         xCEHrzMO1kEVBFtwoU91hXPH+o4EQZBQkKmyt23OQQ5uZoJRI2lYAA5N0QVsSmI6mN+4
         mC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H574A7XQqJ2i5NOk/wD0S3rN53fezDZ1/ELWgryWgFE=;
        b=4QxVBgvxXFzRK67xc5cueb7dA9/PjF1U7oXaB0+YQhXg6LGyYS+ATW37N0IvrfbeP4
         JQdFlkxJOnmqBQCtF3FBCFF5bruLj2JcRKFGrmYHNA1uJYhMetJ9Uh83zQ4OMBOJsWbv
         gMWYmHGgX2UkNUiluWKNLCY8Gl6X6mPLjvFlOsDHxelwDfeBtDvG3LzkgIxo4K9TOSug
         WkUf1SjeUHfMMhpIIvah4oiffiYyagqCMMzSQzyUqofFjT1NuvNOib5n+dtVBVQGyD47
         rQBgygxbikcw9x2m9Iiz1uVZFXPHXuzTixTho2AMF8djVVbQDyGbc19MRUvL7JVub9Gq
         dUrg==
X-Gm-Message-State: AOAM532owCqHLTHix4CWILX5PbAOMS+5ZRLZr45N1Womf0ygpXPrxkuP
        ASkO5QJtw4GV9pdZ2yptbFBN5s+6cNNDq+kNEx4w6A==
X-Google-Smtp-Source: ABdhPJwrKcbOYPJEbU39Gd2dmmbqdwqqtinc327Thc2Xjkz4zVZ//YkeDIVkAuLI2XRNsUtZ+htTSuFHX/0/KqwX34Q=
X-Received: by 2002:a17:902:6b4a:: with SMTP id g10mr6467923plt.57.1644481099048;
 Thu, 10 Feb 2022 00:18:19 -0800 (PST)
MIME-Version: 1.0
References: <20220208141218.2049591-1-jsd@semihalf.com> <20220208141218.2049591-3-jsd@semihalf.com>
 <YgPdYw6hDoN198Hf@smile.fi.intel.com>
In-Reply-To: <YgPdYw6hDoN198Hf@smile.fi.intel.com>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Thu, 10 Feb 2022 09:18:08 +0100
Message-ID: <CAOtMz3OJNopHKgKDvGNfVWwvvo57=LyiRcnT+x6TxwLb+hgkyw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] i2c: designware: Add AMD PSP I2C bus support
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa@kernel.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>, upstream@semihalf.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Easow, Nimesh" <Nimesh.Easow@amd.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 9 lut 2022 o 16:28 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Tue, Feb 08, 2022 at 03:12:18PM +0100, Jan Dabros wrote:
>
> ...
>
> I have noticed code duplication.
>
> > +     status =3D psp_send_i2c_req(PSP_I2C_REQ_ACQUIRE);
> > +     if (status) {
> > +             if (status =3D=3D -ETIMEDOUT)
> > +                     dev_err(psp_i2c_dev, "Timed out waiting for PSP t=
o release I2C bus\n");
> > +             else
> > +                     dev_err(psp_i2c_dev, "PSP communication error\n")=
;
> > +
> > +             dev_err(psp_i2c_dev, "Assume i2c bus is for exclusive hos=
t usage\n");
> > +             psp_i2c_mbox_fail =3D true;
> > +             goto cleanup;
> > +     }
>
> > +     /* Send a release command to PSP */
> > +     status =3D psp_send_i2c_req(PSP_I2C_REQ_RELEASE);
> > +     if (status) {
> > +             if (status =3D=3D -ETIMEDOUT)
> > +                     dev_err(psp_i2c_dev, "Timed out waiting for PSP t=
o acquire I2C bus\n");
> > +             else
> > +                     dev_err(psp_i2c_dev, "PSP communication error\n")=
;
> > +
> > +             dev_err(psp_i2c_dev, "Assume i2c bus is for exclusive hos=
t usage\n");
> > +             psp_i2c_mbox_fail =3D true;
> > +             goto cleanup;
> > +     }
>
> If you are going to update the series, consider to introduce a common hel=
per.
> Otherwise, consider a follow up.

Thanks for your comment. Since Jarkko is running some long-lasting
tests with v4 patchset, I would like to keep this as is for now (and
make a follow up commit). If there will be some additional comments
for v4 from him and will spin v5 - I will introduce a common helper
function then.

Best Regards,
Jan
