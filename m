Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD024879EB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 16:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348139AbiAGPuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 10:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239713AbiAGPuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 10:50:20 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48F3C061574;
        Fri,  7 Jan 2022 07:50:19 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id p5so10590697ybd.13;
        Fri, 07 Jan 2022 07:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1OhZbkZC6Q/vRS5LzzFYge2UROcV5To4d6Z9LDg9hRU=;
        b=Z6PACJQR+qBcCqi/W3s8z/EJl6kS8xU6PePoWWLLjSPyPhxMSB+KOjeqSwoWQhqBtb
         yBHM+bgRC5CC4p0Z7beU5C4nXVWZMNB075KIx6vqqp96AJadNK5xTMX7GUeco5Y1SRu2
         iBoeohvkMHgJfdpKajo4mTuIHzPG+wg2XUKgurhV2kzpaSuvxp8DuxXvFRnjt5rYg2R/
         NU5TLgw5HLeCPimsUpra46NVDXq3hdk2SgJ9TSX3AXqrShLkhj7BqtxfAsOkIBX3BRy2
         evJMxCCq0+mV28ObTtkWe1gr2403Qwm2GSdD/fhiANwjbVwGJrfU7Y7sARijdOfH4qR+
         7txA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1OhZbkZC6Q/vRS5LzzFYge2UROcV5To4d6Z9LDg9hRU=;
        b=NhCqRrSe1eIGz/nu93ydzsM9u4I8AW18WUB5n73NwlKEiGfudAnTfHo/9YyK7+bawe
         d3XFyYBk9G+N47WHK8ERczf+/87UnkgEoPso6/N1VNn11f6vavq5NXjsIzZEvluVTfNk
         5h2xwd0bwFsGtQG4mN5zmoMLmFkGPLquFXZB92e2P10zUEHW1pf+ZmNN1RE96VFwTwmh
         d3M3lnbjM5VwdqwS6j8h28Zt+0vccsc9Vylb1P17THE1r3rTE5PLw/PtqvEr8nG/hSPw
         B7SdrJNKBQh+CohHHBjw6LW6nzRihjBgf5kWrfG16cwFeW8BkozPaKdBScMV9nReJ6l6
         VBbw==
X-Gm-Message-State: AOAM533i18GT08MXyRxy5n8VeipPAY/jpN5Q64db5qR7jAXXZhw7F2nw
        /O3ggEpXDvfSiFNZ8xMDf1Ih60B4RSfAI8MbHWw=
X-Google-Smtp-Source: ABdhPJx5FnRmyjoFHwgvfNs7zgSpqJ1ZbFZcA3E/g23QncWcbtpUDOtPHnSWcm8psKTtAJnD+Y4SUfY9LmrdU43vrGc=
X-Received: by 2002:a25:c794:: with SMTP id w142mr51978239ybe.690.1641570618829;
 Fri, 07 Jan 2022 07:50:18 -0800 (PST)
MIME-Version: 1.0
References: <20200904201835.5958-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200904201835.5958-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8b5d4928-2921-b876-7d1e-04bb42eff4fa@st.com> <3b54ab9b-4ffd-ab32-d495-fad6132ea504@microchip.com>
 <5c56c87d-ca48-5573-0606-da1441fab7ff@microchip.com> <CA+V-a8uk3h95aL7n7cDjYdXJBbE6GWF_LkiAVMOFtVzv-83ZpQ@mail.gmail.com>
 <450850f6-9296-e505-4b92-c71ed190b95f@microchip.com> <CA+V-a8vsX9Ei8dS+fJQe9jqcFXmvfeVb==-HhDkXFnajQYT6tg@mail.gmail.com>
 <e6cfb1fd-7132-0b5c-9e85-dd9c8dfd6d79@microchip.com> <CA+V-a8vOOk4WunS-27d5hrvhLbs3YqAUoGX+Mcan7e6kuHkajQ@mail.gmail.com>
In-Reply-To: <CA+V-a8vOOk4WunS-27d5hrvhLbs3YqAUoGX+Mcan7e6kuHkajQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 7 Jan 2022 15:49:52 +0000
Message-ID: <CA+V-a8u51keKGMaVg=E5vZsoL2ntFg=q-UrNw=4JY4ykPXdm0g@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] media: i2c: ov5640: Remain in power down for DVP
 mode unless streaming
To:     Eugen Hristev <Eugen.Hristev@microchip.com>
Cc:     Hugues Fruchet <hugues.fruchet@st.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Paul <paul.kocialkowski@bootlin.com>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 9:57 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Eugen,
>
> On Mon, Jan 3, 2022 at 11:29 AM <Eugen.Hristev@microchip.com> wrote:
> >
> > On 12/21/21 5:11 PM, Lad, Prabhakar wrote:
> > > Hi Eugen,
> > >
<snip>
> > > could you give it a shot with yavta please.
> >
> > Hello Lad,
> >
> > I debugged this further, and I have some news:
> >
> > It looks like the 'write 0x2 to SYS_CLTR0' does not fail itself, rather
> > the sensor refuses to accept a power up.
> >
> > I tried to read the register before the write, and it reads 0x42.
> > Then, I tried to write 0x42 back, and it works fine.
> > So, I do not think there is a problem with i2c communication.
> > The only problem is that the sensor refuses to power up (accept the 0x2
> > into the SYS_CTRL_0 ), due to an unknown (to me) reason.
> >
> That's strange.
>
> > If the power up is performed at the initialization phase, it works.
> >
> > I also tried to capture with v4l2-ctl, and the result is the same.
> >
> you mean yavta ?
>
> > Which of the init configuration set of registers your test is using?
> I have been testing 320x240 and 640x480. Could you give that a try please=
?
>
> > It may be that it does not work in a specific config .
> >
> > The datasheet which I have does not claim that the 'power up' might fai=
l
> > in some circumstances.
> >
> Let me check if I can ping OmniVision FAE.
>
Fyi.. I got the below feedback from OmniVision FAE.

SW standby bit is working as expected from my side.


As far as the sensor initialization is concerned  we use HW power up
sequence defined in the datasheet followed by SW initialization.

SW initialization consist of the following :-

78 3103  11    ;  I2C timing ( do not modify)
78 3008  82  ;   SW reset
78 3008  42  ;   Stop streaming
78 =E2=80=A6=E2=80=A6.            Sensor settings for required mode

78 3008  02  ;   Start  streaming

Note:-  0x3008[7]  SW reset bit is volatile, as soon as a reset is
applied the  all the bits  are  cleared  and  0x3008[7:0] set to
default value hence  should read  0x2

Cheers,
Prabhakar
