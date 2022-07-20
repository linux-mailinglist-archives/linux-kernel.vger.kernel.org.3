Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D349957C04C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 00:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiGTWu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 18:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiGTWu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 18:50:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754E92E9FA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:50:25 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x91so185484ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xgi1z1ae5ziBlcC49Co3XBDsqsxEKGU7GKGo/g6/OU4=;
        b=ZEQZLa2dXunPpmjgStLAYenZf/8aoYz0Q3PUsLtPT8Wo3LfAR+Glg+kc2wyM4v8axn
         0X7fmWOLBu1LTE89OcO4bOsx98vxYmJdU3/ofl442ahCtlMuRoQzPdO072v/oUiXjTii
         XvEVNhH5AWbk5CWbwAqjNZZya+t8495tCoplk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xgi1z1ae5ziBlcC49Co3XBDsqsxEKGU7GKGo/g6/OU4=;
        b=oL8+r/mRFUhZdH09Fp4BvHOl5mrGHieYQyJB5U66kt6Ekrg8bIHnIXjqsZWXUq5G5z
         9LS29+v01BH9GEAfEu//gMpYJAVWzeKhzE0OpQJ/YHf/fzHtGky0yCnR8SzVX7T8i9ue
         Uvx5mi2Z8M0h8597rzPwqycTkd79S27ddq3QEZAdb2d2hFb2WGQ2UP9FMfFLLyV88kft
         b8OncKnI4YlNDM23LDvaGjIjDYz1nu4Zr0YrB1j6znIUALra489IUhIIrqxCU/ZuE5nA
         tYSYNMgORIXAbAhw2AumfysQp5/cobaiuXJi2LESPFkfUFfSp0uo2bOz0T5k8DvMN92g
         9Y3w==
X-Gm-Message-State: AJIora+HANSEV/ufdeSxrcsB4VFguBLT5Br/2Jt/5QTPjZ3QroXO1ZOg
        mQ/wwUmnh4PVQ7Yp3nXrHb2M34wsJMg2d4HD
X-Google-Smtp-Source: AGRyM1vNDJNKSZvX3LdavLo30i+DekAhePlH+tr9PDcC2qzpHdeUjzoSjz7ZtnEKF7WW7iSxY27sYg==
X-Received: by 2002:a05:6402:4028:b0:43a:8d67:faeb with SMTP id d40-20020a056402402800b0043a8d67faebmr53760411eda.90.1658357423817;
        Wed, 20 Jul 2022 15:50:23 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id s25-20020a056402165900b0043bc19efc15sm132566edx.28.2022.07.20.15.50.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 15:50:22 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id z13so8512000wro.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:50:21 -0700 (PDT)
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr32646726wrr.617.1658357421541; Wed, 20
 Jul 2022 15:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220719203857.1488831-1-nfraprado@collabora.com>
 <20220719203857.1488831-2-nfraprado@collabora.com> <CAD=FV=XgWAMXGAfBw9dBoKB6Y6_AAT6ccAtLg=jy3qLa2HOxBA@mail.gmail.com>
 <194631de-2e3f-6e1f-65f6-76dbef04483e@collabora.com> <20220720185226.tf4y2ofmuz3ifejr@notapiano>
In-Reply-To: <20220720185226.tf4y2ofmuz3ifejr@notapiano>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 20 Jul 2022 15:50:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WNOrV4XJdBzUiU31Cu7yCcRJfScUrYLhzbJwMzDFHb1w@mail.gmail.com>
Message-ID: <CAD=FV=WNOrV4XJdBzUiU31Cu7yCcRJfScUrYLhzbJwMzDFHb1w@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/panel-edp: Add panel entry for R140NWF5 RH
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 20, 2022 at 11:52 AM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Wed, Jul 20, 2022 at 09:49:35AM +0200, AngeloGioacchino Del Regno wrot=
e:
> > Il 20/07/22 00:40, Doug Anderson ha scritto:
> > > Hi,
> > >
> > > On Tue, Jul 19, 2022 at 1:39 PM N=C3=ADcolas F. R. A. Prado
> > > <nfraprado@collabora.com> wrote:
> > > >
> > > > Add panel identification entry for the IVO R140NWF5 RH (product ID:
> > > > 0x057d) panel.
> > > >
> > > > Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com=
>
> > > >
> > > > ---
> > > > The comments on the driver indicate that the T3 timing should be se=
t on
> > > > hpd_absent, while hpd_reliable would have a shorter time just while=
 the
> > > > HPD line stabilizes on low after power is supplied.
> > >
> > > Right. Ideally hpd_reliable is 0 unless you've got a badly-designed p=
anel.
> > >
> > >
> > > > But can we really assume that the HPD line will be reliable at all
> > > > before the DDIC is done booting up, at which point the HPD line is
> > > > brought up? IOW, shouldn't we always delay T3 (by setting hpd_relia=
ble =3D
> > > > T3), since only then we're really sure that the DDIC is done settin=
g up
> > > > and the HPD line is reliable?
> > >
> > > If the panel is hooked up properly, then the HPD pin should be pulled
> > > low at the start and then should only go high after the panel is read=
y
> > > for us to talk to it, right? So it's not like the DDIC has to boot up
> > > and actively init the state. I would assume that the initial state of
> > > the "HPD output" from the panel's IC would be one of the following:
> > > * A floating input.
> > > * A pulled down input.
> > > * An output driven low.
> > >
> > > In any of those cases just adding a pull down on the line would be
> > > enough to ensure that the HPD line is reliable until the panel comes
> > > around and actively drives the line high.
> > >
> > > Remember, this is eDP and it's not something that's hot-plugged, so
> > > there's no debouncing involved and in a properly designed system ther=
e
> > > should be no time needed for the signal to stabilize. I would also
> > > point out that on the oficial eDP docs the eDP timing diagram doesn't
> > > show the initial state of "HPD" as "unknown". It shows it as low.
> > >
> > > Now, that all being said, I have seen at least one panel that glitche=
d
> > > itself at bootup. After you powered it on it would blip its HPD line
> > > high before it had actually finished booting. Then the HPD would go
> > > low again before finally going high after the panel finished booting.
> > > This is the reason for "hpd_reliable".
> > >
> > > If you've got a board with a well-designed panel but the hookup
> > > between the panel and the board is wrong (maybe the board is missing =
a
> > > pulldown on the HPD line?) then you can just set the "no-hpd" propert=
y
> > > for your board. That will tell the kernel to just always delay the
> > > "hpd-absent" delay.
> > >
>
> Thank you for the detailed explanation, this does clear all doubts from w=
hat me
> and Angelo were discussing.
>
> >
> > We were concerned exactly about glitchy HPD during DDIC init, as I didn=
't
> > want to trust it because the only testing we could do was on just two u=
nits...
> >
> > ...but if you're sure that I was too much paranoid about that, that's g=
ood,
> > as it means I will be a bit more "relaxed" on this topic next time :-)
> >
> > > > I've set the T3 delay to hpd_absent in this series, following what'=
s
> > > > instructed in the comments, but I'd like to discuss whether we shou=
ldn't
> > > > be setting T3 on hpd_reliable instead, for all panels, to be on the
> > > > safer side.
> > >
> > > The way it's specified right now is more flexible, though, isn't it?
> > > This way if you're on a board where the HPD truly _isn't_ stable then
> > > you can just set the "no-hpd" and it will automatically use the
> > > "hpd_absent" delay, right?
> > >
>
> Yes, indeed. I just wasn't sure that flexibility brought us anything, but=
 after
> your explanation above it makes much more sense now, thanks!
>
> >
> > For Chromebooks, that's totally doable, thanks to the bootloader seekin=
g for
> > proper machine compatibles, so yes I agree with that.
> >
> > >
> > > >   drivers/gpu/drm/panel/panel-edp.c | 8 ++++++++
> > > >   1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/pa=
nel/panel-edp.c
> > > > index 3626469c4cc2..675d793d925e 100644
> > > > --- a/drivers/gpu/drm/panel/panel-edp.c
> > > > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > > > @@ -1854,6 +1854,12 @@ static const struct panel_delay delay_100_50=
0_e200 =3D {
> > > >          .enable =3D 200,
> > > >   };
> > > >
> > > > +static const struct panel_delay delay_200_500_e200 =3D {
> > > > +       .hpd_absent =3D 200,
> > > > +       .unprepare =3D 500,
> > > > +       .enable =3D 200,
> > > > +};
> > > > +
> > > >   #define EDP_PANEL_ENTRY(vend_chr_0, vend_chr_1, vend_chr_2, produ=
ct_id, _delay, _name) \
> > > >   { \
> > > >          .name =3D _name, \
> > > > @@ -1882,6 +1888,8 @@ static const struct edp_panel_entry edp_panel=
s[] =3D {
> > > >
> > > >          EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea=
1.delay, "N116BCA-EA1"),
> > > >
> > > > +       EDP_PANEL_ENTRY('I', 'V', 'O', 0x057d, &delay_200_500_e200,=
 "R140NWF5 RH"),
> > > > +
> > >
> > > This looks fine to me:
> > >
> > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > >
> > > I'm happy to apply this in a day or two assuming you're OK with my
> > > explanation above.
> >
> > Thank you for the long mail, your explanation was truly helpful!
> > (especially for me being paranoid :-P)
> >
> > So, I agree to go with that one, for which:
> >
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> >
> > Nic, green light?
>
> Yep.
>
> I haven't seen any issues with keeping the hpd_reliable as 0 in the machi=
ne I
> have access to, and Douglas' explanation cleared up all the doubts of how=
 this
> all works, so, Douglas, please feel free to merge this as is.
>
> In that case, since patch 3 was also merged already I'll send a v2 just f=
or
> patch 2 separately.

Great! I went ahead and applied to drm-misc-next then.

f6ff4570e567 drm/panel-edp: Add panel entry for R140NWF5 RH
