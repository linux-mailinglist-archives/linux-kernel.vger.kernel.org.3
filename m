Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DACC4E889B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 17:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbiC0QA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 12:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbiC0QA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 12:00:27 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8913B3F9;
        Sun, 27 Mar 2022 08:58:48 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2e5757b57caso125671917b3.4;
        Sun, 27 Mar 2022 08:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yiDYEA/EuZ+ylmTzvXJZbTs7+i6Gl3H4EBEZ/YkodTM=;
        b=ec71uLssCGrn6hKc+khmHDKyHdSeIsdcn1G7EC20neYwK+kXNcaT+ZSWNz/796NPZ8
         606j4km0dFBmVv6Y6jd8VXmo8uKEUbnCfcRVcBE4TPBuYkHuAePW1erpYzf312JLtnad
         v7EVt+F+GVVYknpClMQze45V38I7dZMXqwiNZ4IJA4XyBtLS9VcecrvqoLD8jvCr98tN
         UNReUNJuufEeSk/kJS6GA+TyiEKpAhIjl2vDFzn4DSePDHFuTLGReZFxTlSQ1BkcdiTa
         W4TeMCdx6Bf0tE5vRE6OxqHKzZYvT58L76kLVpYsGoHdcw/5g0D0cyNf24Jg53T3T99R
         i4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yiDYEA/EuZ+ylmTzvXJZbTs7+i6Gl3H4EBEZ/YkodTM=;
        b=ywBJftaVyROByUPqQWEGQ/a6aLZKNiAWTexVbfncNZ8pzOTn40nlGOKjgL3OgxVZZG
         QIBGxr8m+j/WVm8TkKx4jm93fIKCVgTaisapDbwwOaOkAhkoekDyV890O10AFySNzEBL
         GZhAw8s5A5E/73vnrijcXTt7hLP/yNQNQlt2Q9hj6ynIqM6wPcTrmyDecjucM5NHTDIA
         +RIX9r58tR6IAF800o5m54ybdCHk92yNGEA+xuW+5kxshFbWVh9VrQh3c9QlLIz5UDwC
         /xL14yQiTy77obhmnWPf8pZWUXwoO+2EEtc1Y+Ua2QWfpqT3BUH/ExhCbBHEHNJm6LLf
         UuCQ==
X-Gm-Message-State: AOAM530dFev257GMpA5t/HclGA2WU4vonrpcAte0E/25PaQ3C+7kgGXU
        yoxdbjZ9SO2UxNB7w7gasLlpeTxe3LKaCPwz1BM=
X-Google-Smtp-Source: ABdhPJzZE/1EQn+FgKqPkuKSnTMKiiX7gg6lyFOpthCBpTFayS0d/FcsFaMSkQk3SkJDZqUZQXzP2KtXzBjXY9ryK7M=
X-Received: by 2002:a81:1697:0:b0:2e9:d8ed:278 with SMTP id
 145-20020a811697000000b002e9d8ed0278mr9912709yww.452.1648396727404; Sun, 27
 Mar 2022 08:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220318070900.2499370-1-ztong0001@gmail.com> <20220327154005.806049-1-ztong0001@gmail.com>
 <20220327165336.799db3ac@jic23-huawei>
In-Reply-To: <20220327165336.799db3ac@jic23-huawei>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Sun, 27 Mar 2022 08:58:36 -0700
Message-ID: <CAA5qM4AGvTrcGu=RRi-fDrAC8aE2FN-Y+79-24LV0MerEN-5CQ@mail.gmail.com>
Subject: Re: [PATCH v3] iio:imu:bmi160: disable regulator in error path
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Sun, Mar 27, 2022 at 8:46 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 27 Mar 2022 08:40:05 -0700
> Tong Zhang <ztong0001@gmail.com> wrote:
>
> > Regulator should be disabled in error path as mentioned in _regulator_put().
> > Also disable accel if gyro cannot be enabled.
> >
> > [   16.233604] WARNING: CPU: 0 PID: 2177 at drivers/regulator/core.c:2257 _regulator_put
> > [   16.240453] Call Trace:
> > [   16.240572]  <TASK>
> > [   16.240676]  regulator_put+0x26/0x40
> > [   16.240853]  regulator_bulk_free+0x26/0x50
> > [   16.241050]  release_nodes+0x3f/0x70
> > [   16.241225]  devres_release_group+0x147/0x1c0
> > [   16.241441]  ? bmi160_core_probe+0x175/0x3a0 [bmi160_core]
> >
> > Fixes: 5dea3fb066f0 ("iio: imu: bmi160: added regulator support")
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> oops. Raced with you ;)
>
> Anyhow, I added the tag, so no problem.
>
> Jonathan

No problem. Have a nice weekend!:-)
- Tong

>
> > ---
> > v2: also disable accel when gyro fail to enable
> > v3: add tag
> >  drivers/iio/imu/bmi160/bmi160_core.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> > index 824b5124a5f5..01336105792e 100644
> > --- a/drivers/iio/imu/bmi160/bmi160_core.c
> > +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> > @@ -730,7 +730,7 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
> >
> >       ret = regmap_write(data->regmap, BMI160_REG_CMD, BMI160_CMD_SOFTRESET);
> >       if (ret)
> > -             return ret;
> > +             goto disable_regulator;
> >
> >       usleep_range(BMI160_SOFTRESET_USLEEP, BMI160_SOFTRESET_USLEEP + 1);
> >
> > @@ -741,29 +741,37 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
> >       if (use_spi) {
> >               ret = regmap_read(data->regmap, BMI160_REG_DUMMY, &val);
> >               if (ret)
> > -                     return ret;
> > +                     goto disable_regulator;
> >       }
> >
> >       ret = regmap_read(data->regmap, BMI160_REG_CHIP_ID, &val);
> >       if (ret) {
> >               dev_err(dev, "Error reading chip id\n");
> > -             return ret;
> > +             goto disable_regulator;
> >       }
> >       if (val != BMI160_CHIP_ID_VAL) {
> >               dev_err(dev, "Wrong chip id, got %x expected %x\n",
> >                       val, BMI160_CHIP_ID_VAL);
> > -             return -ENODEV;
> > +             ret = -ENODEV;
> > +             goto disable_regulator;
> >       }
> >
> >       ret = bmi160_set_mode(data, BMI160_ACCEL, true);
> >       if (ret)
> > -             return ret;
> > +             goto disable_regulator;
> >
> >       ret = bmi160_set_mode(data, BMI160_GYRO, true);
> >       if (ret)
> > -             return ret;
> > +             goto disable_accel;
> >
> >       return 0;
> > +
> > +disable_accel:
> > +     bmi160_set_mode(data, BMI160_ACCEL, false);
> > +
> > +disable_regulator:
> > +     regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
> > +     return ret;
> >  }
> >
> >  static int bmi160_data_rdy_trigger_set_state(struct iio_trigger *trig,
>
