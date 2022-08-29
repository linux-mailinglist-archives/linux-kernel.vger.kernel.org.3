Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08055A4BE9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiH2Mbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiH2Mb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:31:27 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EAE83BD5;
        Mon, 29 Aug 2022 05:15:29 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id d1so6123977qvs.0;
        Mon, 29 Aug 2022 05:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=y92MhY7EE4yvAfEj5TsgHetaWbvxk1FPwg51QUNz2vw=;
        b=dQuvCfbN+BqLYM2JPF9Jk0JgSIRFxvFp9l5ekLwOhQD94t2iJ3XipOt4C28q9q3jOU
         oOBbXlAfEnCXBStKk8MQzpdwANPt2An0WRSky8R+nggmsz22HnsvenI2TeydD7zC0Heb
         X0w5KZ7bEweaLkqAkcEuPEg/sErmxPyEfzFfhxXy/eVniwSHstoclJoNt/R+tsbvIi5y
         RH+k+UXL6pNkM14cb5LRvi2w7CflG+AimF44FrcxjiN1cZifa5Qfi8KqPQ4+pILlWXPm
         ySvzLEAfghECl/ZJFS8UDT7kddOlX0Us8JzEI8PsJUfbOL34qeVaph1BxpSgUt+a3QgU
         f/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=y92MhY7EE4yvAfEj5TsgHetaWbvxk1FPwg51QUNz2vw=;
        b=QvEvnEPfb2VRmo4eHjON5Xh85xUVPRulMVFI1yedVvt8pm0+T1GVcM5dSnTqv11ZNJ
         MkarAY8wUSfbHKuqEJR1Za2URpe2JT0ING/9F96fc/VbShFIYZfzzbQs6cz3sYnAr+BV
         XJf4i9M5jdVZREO+Tbo+6paT8ykYi7P9S9OcBeAy8ZjFMhi6NtPUoUpfMfklP1QTGxZF
         cD/kjsvrjZ2L8ZLrcdmlFyq236rq3PYOgymZ6BdJXLbKR7k9blfbUPZIY/+U0F+qH44m
         rk5F5ero5iZOdtHD4NtiiZJVJcNhIII2jVHWfsoqCpLh9k9+FdzkAHyiyqITAZkQZ4L9
         bc4w==
X-Gm-Message-State: ACgBeo3AlJL06ogUBJP6lP3B/LhgriaTvlvJeo1s6woEfsD4HWGkmANJ
        migUuQ6dRyGDiJnQnn48Tuw84DOnkDO81RPY+g4=
X-Google-Smtp-Source: AA6agR4IaCF2wMNBlOtYMYUc4a6oz+UHbC5LMsSt8YcO74NjWYktGgHWVopBsY6Qa9+qBFsRGpDkq/WY8g8Z4coaPkI=
X-Received: by 2002:a05:6214:29c2:b0:497:8b2:442 with SMTP id
 gh2-20020a05621429c200b0049708b20442mr10091445qvb.97.1661775279551; Mon, 29
 Aug 2022 05:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220826144629.11507-1-ilpo.jarvinen@linux.intel.com>
 <20220826144629.11507-4-ilpo.jarvinen@linux.intel.com> <CAHp75Vc4NfZE6DxFnfeAS9fxnZHpxMjacHy1TsG8ib+FiCqFLQ@mail.gmail.com>
 <1712a4c5-638-4e63-af29-32bdcbaab443@linux.intel.com>
In-Reply-To: <1712a4c5-638-4e63-af29-32bdcbaab443@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Aug 2022 15:14:03 +0300
Message-ID: <CAHp75VcozE+AYMoTpjPf0sdPNMqjdO8Z1cpF2wU4FfzhnAaZng@mail.gmail.com>
Subject: Re: [PATCH 3/3] serial: Add kserial_rs485 to avoid wasted space due
 to .padding
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
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

On Mon, Aug 29, 2022 at 3:09 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> On Fri, 26 Aug 2022, Andy Shevchenko wrote:
> > On Fri, Aug 26, 2022 at 5:51 PM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:

...

> > > +       *rs485 =3D *((struct kserial_rs485 *)&rs485_uapi);
> >
> > So with all assets we have we can be sure that on BE64 / BE32 machines
> > this will be flawless. Is this assumption correct?
>
> I think so. At worst it could trigger a build fail assuming the kernel
> would do some really odd struct layout reordering (which, according to
> the build bot, doesn't occur for any currently tested arch).
>
> Now that you highlighted this line though, I started to wonder if it woul=
d
> be just better to use memcpy() instead as it would avoid those casts.

Actually the current version might be better since the compiler will
be aware of the types, but it still requires a proper layout of the
fields. That said, I leave it for you.

--=20
With Best Regards,
Andy Shevchenko
