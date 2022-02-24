Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CCD4C3235
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiBXQw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiBXQwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:52:24 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709553586B;
        Thu, 24 Feb 2022 08:51:46 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qx21so5603428ejb.13;
        Thu, 24 Feb 2022 08:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0BX8BM017uCOv9ckNj58aZrZbCd/kR/+hefTXMO9tPo=;
        b=kiIocb6M3Uuv4xiRzAdVw033se264t+5e8SmYP5ibq1I4FYRMAbbkXLawlWwzOm54C
         xHb9/0YbSlMUpw2Y6llCywFgYrAx7ZpZqQ+LatVEGnWWdWhVfJOQgo+QQSMiaB0nhH26
         kpkq/SZK9dynlhtQuiHfpLZe9Mhcoq6diD0oyzZr+Eab5VLwELySFw3E0vHze+1GYjcg
         a7cktJzM4p6B4R9ymuUjhoB5MBJsi2ax6GGP6CGvS9MpQvS2yOvXYqUupHSeCx/uSRcg
         PBt4OTHJvYUrvjPylxPIa+CChh3DpYRgOwluNXETDaED4nhajMnp9x/THJUOxJfe+68g
         DzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0BX8BM017uCOv9ckNj58aZrZbCd/kR/+hefTXMO9tPo=;
        b=q0d+qe+miDlHrQtrL3aAVTcYOPTh5r2IqEd5/F6rQOf3TMCfxCfQH1Fl0kLayU1sZk
         6Yer7JpcT6ivvv7mgbek8wi63WwhW16JmZV6TSSaZRd/V9sFGCPu3uEPCkmIhVTghPzB
         H9CP5rtCgfw8pdb70v9zbMqxyDLXVP9o6Czb3oIxHiI1DidN5kufSKxmD0lvjUdDpRve
         LMg2QxfF7RQYOEx+RfS4J0VU+XYV51b0Gaes8Q+HRbsumzD68qmNWGz0YuX6HMyXAXsG
         vMjcgQKxkcO00ukPPaGf1bWpWQIfv6DUUBZzYxbIFZGb1fC+Ea9RtMu/1ANfnwYtWA6p
         UQ7g==
X-Gm-Message-State: AOAM531+xG7c1bJwT1zAPYutuRRcATc/BrDYIbZ+OsSe+Yrx9qzbDRfN
        DpdFEbjSrU443oifsv4aIuA=
X-Google-Smtp-Source: ABdhPJyWV1zkvb8+mEvqp9ZSTYLeQknbMbcIBqw4G7wy2t0xWvm2gOYKTOxfOHmqMh5tXSGKmjzpjg==
X-Received: by 2002:a17:906:af79:b0:6ce:61d3:7e9b with SMTP id os25-20020a170906af7900b006ce61d37e9bmr3085459ejb.191.1645721505223;
        Thu, 24 Feb 2022 08:51:45 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id j3sm1600520ejj.9.2022.02.24.08.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:51:44 -0800 (PST)
Date:   Thu, 24 Feb 2022 17:51:41 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Joey Gouly <joey.gouly@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/5] gpio: Don't fiddle with irqchips marked as immutable
Message-ID: <Yhe3neSJbAxRbt+Z@orome>
References: <20220223154405.54912-1-maz@kernel.org>
 <20220223154405.54912-2-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vbN/cyUZyiD0I2CK"
Content-Disposition: inline
In-Reply-To: <20220223154405.54912-2-maz@kernel.org>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vbN/cyUZyiD0I2CK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 23, 2022 at 03:44:01PM +0000, Marc Zyngier wrote:
> In order to move away from gpiolib messing with the internals of
> unsuspecting irqchips, add a flag by which irqchips advertise
> that they are not to be messed with, and do solemnly swear that
> they correctly call into the gpiolib helpers wueh required.
>=20
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/gpio/gpiolib.c | 7 ++++++-
>  include/linux/irq.h    | 2 ++
>  kernel/irq/debugfs.c   | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)

I kind of like this. The bit where the const cast is essentially guarded
by an "immutable" flag is a bit funky, but it doesn't look like there is
a good way to do it by making all references const without doing a huge
all-at-once conversion.

I've always found it a bit irritating that irq_chip was somewhere
between a container for chip-specific data and an "ops" structure. I
think it'd be even nicer if this was split into an extra struct
irq_chip_ops, which could then always be const and a struct irq_chip
that contained primarily chip-specific data as well as a pointer to
struct irq_chip_ops.

But again, this seems fairly tricky to pull off given all the
interdependencies and we can iterate on this in the future, so this
seems like a good enough compromise:

Acked-by: Thierry Reding <treding@nvidia.com>

--vbN/cyUZyiD0I2CK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXt5oACgkQ3SOs138+
s6Hsmg//ZlvIGlAISsBwoAWBpifpjvE4OPtPa2w5okmTJxjSFYwmu1dcqaGOQbqk
PM58PdveLzwtzZUMy2BFNGtyE1cXPfDvIQlUP2QXjkpmpOH0nZvLbKLtbaOKPe5/
k7ZT1snfCCPyCSkTt3ObyRr/vd09RHkcocvJ3BPX8qgcFs8RP+csLO4LbtPdN4Mp
DTPbjaUqdqG2RvSuEtRrHenTZ6f+g+39LrwgfzRXztvQvFtNEmK+D/sZDENkTVtm
+YIJBgiANbzhXtib+/9FaG3MJECmu6ZBNNSaZat91Ksn+TWDz/RYRdZSsEcposEx
eH5P6Oas2DsQ8P8ny7jplcGV1nOGobRdQBRWnWHXKDGrsDBaVzdFjc4Z/rzoRshO
a5kV7CL+T6Gu+xVWS81PBBcUcwFsIpn5QWe32g3g0cPuNJpsWYpM6lnbH+CrQcQR
LTOMQiTe8hyf6vdhTbdMfb6I/i3JscSm23KJYgZD1Se1bYkzi6DbCf62W2ygqHgT
yakOPdNcZP8KZKp85niKcUdG/ecW9HtTSBGSLDkyMUgBqg4Jr/2uC6C1h/ra3t/D
HlMJDYR4rrx0kR6JDiHl4Be0AJPPo2YksA+YZzVYIOgv0dMLzk9JX0AXeSwo6xBT
Byu+xRCU7+shobZGJlJOJXnRXw7XwLhg3pdOwotfppxKxXcUgzU=
=JQTC
-----END PGP SIGNATURE-----

--vbN/cyUZyiD0I2CK--
