Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57724E88C9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbiC0QRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 12:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiC0QRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 12:17:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238B136B48;
        Sun, 27 Mar 2022 09:15:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B64766106D;
        Sun, 27 Mar 2022 16:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB24C340EC;
        Sun, 27 Mar 2022 16:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648397732;
        bh=nsHF7/lCAErDCtCYXXbx66rNfi9PbiN9g5HgcBT+RqQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tr/82D5aMQfcQypRkmTPFGOf6CwP9yeBo+qVpfjjHaM6HjTqd79AMDxNS5owmhbV2
         Ay1hZAp80QOD1XK6qQD0mYSkiKxhTrpsHX+gLue+eCQrRdkkKzCXuBpOIY46koTc40
         WIRBkeUalOfhGSGNr3DOESAanxTUKzVfRO9jVAABuo0GnTw9R5ZdMXM5UUXJ3qhaga
         IkRQghfcd2xI7sSCL51WNj3wI9SlGIMPVE+jAfF8Z6wuHDl5iKlNtVkxBVtqWhP7EJ
         Q/ZYitHObfvQvJpvWBJFNoXtkqCCX+r9PDwKtZ77Mwt12TatBRIBNAHF09f+F2K5yd
         DJT4cW//X35BA==
Date:   Sun, 27 Mar 2022 17:23:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        "=?UTF-8?B?5pyx546J?= =?UTF-8?B?5piO?= (Yuming Zhu/11457)" 
        <yuming.zhu1@unisoc.com>, linux-iio@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 2/7] iio: adc: sc27xx: fix read big scale voltage not
 right
Message-ID: <20220327172302.142ee9bd@jic23-huawei>
In-Reply-To: <CAF12kFvPp4eVJtWD7zd=Kvx2mHQGWiy_dDOD1bvMLQgeNgBvzQ@mail.gmail.com>
References: <20220311164628.378849-1-gengcixi@gmail.com>
        <20220311164628.378849-3-gengcixi@gmail.com>
        <20220320133229.6026f51a@jic23-huawei>
        <CAF12kFvPp4eVJtWD7zd=Kvx2mHQGWiy_dDOD1bvMLQgeNgBvzQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2022 15:36:56 +0800
Cixi Geng <gengcixi@gmail.com> wrote:

> Jonathan Cameron <jic23@kernel.org> =E4=BA=8E2022=E5=B9=B43=E6=9C=8820=E6=
=97=A5=E5=91=A8=E6=97=A5 21:25=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Sat, 12 Mar 2022 00:46:23 +0800
> > Cixi Geng <gengcixi@gmail.com> wrote:
> > =20
> > > From: Cixi Geng <cixi.geng1@unisoc.com>
> > >
> > > Fix wrong configuration value of SC27XX_ADC_SCALE_MASK and
> > > SC27XX_ADC_SCALE_SHIFT by spec documetation.
> > >
> > > Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> > > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > > =20
> > No blank lines in a tag block (they break people's scripts)
> > Also, if this is a fix, I'd expect a fixes tag. =20
> I will add in next version
> > =20
> > > Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>
> > > ---
> > >  drivers/iio/adc/sc27xx_adc.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_ad=
c.c
> > > index 00098caf6d9e..aee076c8e2b1 100644
> > > --- a/drivers/iio/adc/sc27xx_adc.c
> > > +++ b/drivers/iio/adc/sc27xx_adc.c
> > > @@ -36,8 +36,8 @@
> > >
> > >  /* Bits and mask definition for SC27XX_ADC_CH_CFG register */
> > >  #define SC27XX_ADC_CHN_ID_MASK               GENMASK(4, 0)
> > > -#define SC27XX_ADC_SCALE_MASK                GENMASK(10, 8)
> > > -#define SC27XX_ADC_SCALE_SHIFT               8
> > > +#define SC27XX_ADC_SCALE_MASK                GENMASK(10, 9)
> > > +#define SC27XX_ADC_SCALE_SHIFT               9 =20
> >
> > This driver would benefit from use of FIELD_GET() / FIELD_PREP()
> > but that is obviously unrelated to this particular series.
> > =20
> the next patch in this set need to use the fixed define value

Understood.  I was suggesting a future cleanup on top of this series
to avoid the need for both MASK and SHIFT being defined for
each field.  FIELD_GET/FIELD_PREP() are used to do that.

What you have in this series is fine without that change.

Jonathan

> >
> > Jonathan
> > =20
> > >
> > >  /* Bits definitions for SC27XX_ADC_INT_EN registers */
> > >  #define SC27XX_ADC_IRQ_EN            BIT(0) =20
> > =20

