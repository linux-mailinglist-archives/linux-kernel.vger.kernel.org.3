Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717F65858EE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 09:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiG3HIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 03:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiG3HIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 03:08:22 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560D256BB6;
        Sat, 30 Jul 2022 00:08:20 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s14so7266189ljh.0;
        Sat, 30 Jul 2022 00:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=tIBM3YfgmPp7U8f9ccRVjiScdQ5ht2L/cW+n6qhI3xc=;
        b=V6cWGzy9vo9bC1mYKdvD6nyEL8as9poBhoSM6xL/F42GmNlOiLQuW6o8GgVi6AavBn
         q7RmkSALlud/LxIWHogkH73pdjhkuoboeuobzy8FIIPoUQxJW4T73SlAYEx4A/iqt1SI
         TZ78tTt4SAMW0hKHS9hSb3vBuPJ+lJVAp4iZRqFPwV6TzciXfY1zZGKcysuHL5ap2ptM
         9gctWFxVpfZAN1SO5iqN75vaNh+xJx+YnQiTAIzI3G4MCyJoYIXeVM2xsm88hIHT0QMl
         IldU/hBUWbW71UWjx9ZXimOJw7LWx38Opz7Clb37jHTy19ysbaiEAi6LMppeh/afE/2Z
         7+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=tIBM3YfgmPp7U8f9ccRVjiScdQ5ht2L/cW+n6qhI3xc=;
        b=NSlN7640J6J1AipgPrrEZ+LjiQNrzp0xNHaR6sUzJPmKo/4+VJsmv848Pk8KVWxOqY
         W+M9mDIX8/CPEmQxJgLcHssNwfOCRVqZRzylWpyu1/4/auxaUH5HW9oOUO5fo8B1mgHn
         ANEmrtXPrFI8EAMMoq9pmKOSGs12Ac9WhKyIDm0bYym3FiuOhLTR7N0sJ6xXR8pQtdfs
         nU3bLSosAHf+sJTg5OtC+DmPWhj/A6HbWuZN7/cTEfn8Klyadts+HHFE5uVmigbJQUep
         YzuWBU7a1X9mCXwqCPwmnI+spp5WhxXqIfVQ4FnLPpNcZyfIJC2fdpcNOZYqDsZWF8hE
         ghrA==
X-Gm-Message-State: AJIora9TXH4ht3/lLFOIq4C4Nu4IVE+BHkYygfX5/fjYAump6zK4Z+T0
        bdwVKklLi2DVrILk6hK5oMa0uIBj19aDAVTB3Q==
X-Google-Smtp-Source: AGRyM1uMbpWyeRPaYBKWgwfiN9eWE6DT9CoW3l+aLTwC6kJww0K6oQ9sU7MvSHntmxMdWn4Yb/6vYz0HC6Fa1qoqbMs=
X-Received: by 2002:a05:651c:1796:b0:25d:7288:ed0b with SMTP id
 bn22-20020a05651c179600b0025d7288ed0bmr2142081ljb.228.1659164898266; Sat, 30
 Jul 2022 00:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220729075519.4665-1-stanley.chu@mediatek.com> <7e8c58cf-64c1-8426-bf22-97d3df85ed38@acm.org>
In-Reply-To: <7e8c58cf-64c1-8426-bf22-97d3df85ed38@acm.org>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Sat, 30 Jul 2022 15:08:05 +0800
Message-ID: <CAGaU9a_G1kH8VezozhZ3-S6-GvMr=EUVc4btU8Dwdo+cCJDxUg@mail.gmail.com>
Subject: Re: [PATCH v1] scsi: ufs: Fix ufshcd_scale_clks decision in recovery flow
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>, alim.akhtar@samsung.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        peter.wang@mediatek.com, Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        alice.chao@mediatek.com, powen.kao@mediatek.com,
        mason.zhang@mediatek.com, qilin.tan@mediatek.com,
        lin.gui@mediatek.com, eddie.huang@mediatek.com,
        tun-yu.yu@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On Sat, Jul 30, 2022 at 4:12 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 7/29/22 00:55, Stanley Chu wrote:
> > diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> > index 581d88af07ab..dc57a7988023 100644
> > --- a/drivers/ufs/core/ufshcd.c
> > +++ b/drivers/ufs/core/ufshcd.c
> > @@ -1574,8 +1574,6 @@ static ssize_t ufshcd_clkscale_enable_store(struc=
t device *dev,
> >       ufshcd_rpm_get_sync(hba);
> >       ufshcd_hold(hba, false);
> >
> > -     hba->clk_scaling.is_enabled =3D value;
> > -
> >       if (value) {
> >               ufshcd_resume_clkscaling(hba);
> >       } else {
> > @@ -1586,6 +1584,8 @@ static ssize_t ufshcd_clkscale_enable_store(struc=
t device *dev,
> >                                       __func__, err);
> >       }
> >
> > +     hba->clk_scaling.is_enabled =3D value;
> > +
> >       ufshcd_release(hba);
> >       ufshcd_rpm_put_sync(hba);
> >   out:
> > @@ -7259,7 +7259,8 @@ static int ufshcd_host_reset_and_restore(struct u=
fs_hba *hba)
> >       hba->silence_err_logs =3D false;
> >
> >       /* scale up clocks to max frequency before full reinitialization =
*/
> > -     ufshcd_scale_clks(hba, true);
> > +     if (ufshcd_is_clkscaling_supported(hba) && hba->clk_scaling.is_en=
abled)
> > +             ufshcd_scale_clks(hba, true);
> >
> >       err =3D ufshcd_hba_enable(hba);
>
> I see a race condition between the hba->clk_scaling.is_enabled check in
> ufshcd_host_reset_and_restore() and the code that sets
> ufshcd_clkscale_enable_store(). Shouldn't the code in
> ufshcd_host_reset_and_restore() that scales up the clocks be serialized
> against ufshcd_clkscale_enable_store()?

Both check and set paths are serialized by hba->host_sem currently.

Would I miss any other unserialized paths?

Thanks,
Stanley


>
> Thanks,
>
> Bart.



--=20
Yours truly,

=E6=9C=B1=E5=8E=9F=E9=99=9E (Stanley Chu)
