Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6DB4FF998
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbiDMPBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbiDMPBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:01:48 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7761CFE7;
        Wed, 13 Apr 2022 07:59:26 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id l127so512489pfl.6;
        Wed, 13 Apr 2022 07:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a8xsNVPTPkZiDBpwZg9umRn5flhAKtFDM+YN563Ytlc=;
        b=N7vl7cbDOzSVVa2xQmrn/gJ4JjGaNIH7Uy2Hp1J/Z7eo4go1K9K99CH5vmVXXCcp/D
         ZdzoZXrfloDxwMfgqmMdw/IbGzrMcDO/Liqk7cYPJ3k9m+5dxsfPErJP4zFFnVqZB9ux
         KaX/1tc437YSTr7AmE0cdBud+YQaZKwQTpOFaZnlQyBN/6nLz64er0SnnBxFkqW+dT6w
         TZpR1tO/smdhSAZD+rV8XastTs5nKaFgjGsGphLVptMqBBoRZu58RpqDIirV0zSkEaMW
         7hd0TVy0Csl+M1F5f4kQdNXAEjiiC4w4Ps8hDdU5eeay1HwfLEXUxIA9wucfSgISAT2/
         cUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a8xsNVPTPkZiDBpwZg9umRn5flhAKtFDM+YN563Ytlc=;
        b=aX/Ecd9RwjhUlsbJ/HlmzAfsTSzC3dvPi/CEcXMVl4+s5TI+KUbWWlQgRnAzNw+D6b
         Ja2aekkrjtJeQ3hZN7XWyrkuDlllea5xpmQxAwgGhnLiJSx5qud5RpEim0UOALTpr5gB
         SE9xsXCKfvbtQiZ7te1KTTLsdlrzQBZCwCKmBA4jPYyivtDgZTmD4Aar5eP11cFEYmy1
         hirw8UJAdrsBd8goPpPLU+iMw4u4y3DbYtsJw+HMSwXmzncEXRBxqy4SnLJPpFKByPNa
         DnNrcCVbPrKyKTmmU06JCZbSUI26+Ni5QOiV/OFSQL60dw0tn+/4hu5rSG9S/Hbd7uN/
         LWWg==
X-Gm-Message-State: AOAM533L/XNqcJD6m7lOSN/X66OUpc5jSf4Lh3Mt3P3RTeTajV0q63Jd
        82f/w07nvXh659XueVAg/DrtbbtfHSz7N4oAON0=
X-Google-Smtp-Source: ABdhPJx04qs+59GafrTWKGAXEemW01VTdHxraux+oseAqe884eVHqiSzTTISYamv21b5tNDYcB74bfloqxGx5r2MQP8=
X-Received: by 2002:a63:770c:0:b0:39d:adf2:ba83 with SMTP id
 s12-20020a63770c000000b0039dadf2ba83mr3859010pgc.184.1649861965867; Wed, 13
 Apr 2022 07:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220407115406.115112-1-hadess@hadess.net> <nycvar.YFH.7.76.2204111708230.30217@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2204111708230.30217@cbobk.fhfr.pm>
From:   Jason Gerecke <killertofu@gmail.com>
Date:   Wed, 13 Apr 2022 07:59:14 -0700
Message-ID: <CANRwn3SVcqFtv0BTTtqpM7M4WRN4sMKVo7_-9t5M8itt-rEttQ@mail.gmail.com>
Subject: Re: [PATCH] HID: wacom: Correct power_supply type
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Linux Input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ping Cheng <ping.cheng@wacom.com>,
        Jason Gerecke <jason.gerecke@wacom.com>
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

Following up on my previous comment. I've been able to test this patch
with both flavors of wireless interface. Both Bluetooth (Intuos Pro)
and dongle-based (Intuos5) appear to have mostly-correct behavior
while charging and discharging, even when the battery level gradually
drops to zero. The misbehaviors I see appear to be limited to upower
mis-categorizing the devices as an e.g. keyboard or generic battery
rather than as a tablet. This leads to some slightly confusing UI
issues (e.g. GNOME and KDE referring to the device incorrectly), but
nothing too annoying. If upower is taught to recognize tablets under
more circumstances those issues should disappear.

Ping tells me you may have an Intuos4 Wireless, Bastien? Any
additional testing you can do with that device would be appreciated,
though even without it I'm personally comfortable enough to provide an
ack:

Acked-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

On Tue, Apr 12, 2022 at 1:53 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Thu, 7 Apr 2022, Bastien Nocera wrote:
>
> > POWER_SUPPLY_TYPE_USB seems to only ever be used by USB ports that are
> > used to charge the machine itself (so a "system" scope), like the
> > single USB port on a phone, rather than devices.
> >
> > The wacom_sys driver is the only driver that sets its device battery as
> > being a USB type, which doesn't seem correct based on its usage, so
> > switch it to be a battery type like all the other USB-connected devices=
.
> >
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > ---
> >  drivers/hid/wacom_sys.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> > index 066c567dbaa2..620fe74f5676 100644
> > --- a/drivers/hid/wacom_sys.c
> > +++ b/drivers/hid/wacom_sys.c
> > @@ -1777,7 +1777,7 @@ static int __wacom_initialize_battery(struct waco=
m *wacom,
> >       bat_desc->get_property =3D wacom_battery_get_property;
> >       sprintf(battery->bat_name, "wacom_battery_%ld", n);
> >       bat_desc->name =3D battery->bat_name;
> > -     bat_desc->type =3D POWER_SUPPLY_TYPE_USB;
> > +     bat_desc->type =3D POWER_SUPPLY_TYPE_BATTERY;
> >       bat_desc->use_for_apm =3D 0;
> >
> >       ps_bat =3D devm_power_supply_register(dev, bat_desc, &psy_cfg);
>
> Thanks Bastien, makes sense. CCing Jason and Ping (the Wacom driver
> maintainers) to get their Ack.
>
> --
> Jiri Kosina
> SUSE Labs
>
