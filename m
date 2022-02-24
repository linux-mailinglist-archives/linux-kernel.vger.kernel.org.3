Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52244C2C37
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbiBXMzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiBXMzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:55:15 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC594214F89;
        Thu, 24 Feb 2022 04:54:44 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z22so2719966edd.1;
        Thu, 24 Feb 2022 04:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=os8ySsUHGCfn4fSlhWcW0LoCtu+dFeeC1o4LuexdWlg=;
        b=hm0rq7ksIh2akap62WKEH05uGR9TSmZ7MqlrmAX5a72L7/3fsPEduRbJXSubJlErtb
         rIIm3V2IoJacRZsoBc+ZwSNw5CqmnWpp3eUeuthEjiY/sSrhdPkl4W7+vNFmTZxtv8gx
         vw/nLDi6WAlbR3AcgO9deqeahb2xmHpmQSflae5bjVICUtz5ifAehGhOtPEu2fhPds/S
         TmTtx1GLljufg4N6ivv2XqJcaWqR31pLlszavn9Tk6/HrzABAI9jD1PbVLt7wqL+9/Mu
         Ku1aau5xmiYZEXskSUHMhq0CQhrCK+J9KqFIKTmBZOvIoh7k0/2EQeaFyoV5xoYjrzCe
         oN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=os8ySsUHGCfn4fSlhWcW0LoCtu+dFeeC1o4LuexdWlg=;
        b=l8SgCCs4nVQ7yYOw6mza+yX+84TVu9i3D+sEQPzKf730dNtBcmgkGVmon4GlC+SjIH
         UtksLVBX4Gdq542s3u72PyrNgkTT2T4uD66rRZlB989cSDnQz66xi4iZ3/PUJH2f1rnF
         gYl227Jo4j+ArDJuA6uL4Di8oAqRKYusvIAsDgws/y0n4hH1R6EbPNn182Cn645/OUhU
         hOXjlDjd84mjsEpZiATPrgt/IxEUgvKB58VueMH7pYTv9sk1Muztl1DxE3ISN0HwgtOd
         TVMeDqBNhaBC1APHetdWK0AMt97LBCAVwe2c1QYIdUwRt5kKLba2rYqk+g3TLgAOaGrv
         JTBQ==
X-Gm-Message-State: AOAM530aXLlRyoxjbb+Kz9+tu6zfnG0SarsQ7dQ/qrrNYlkEYXoyfOqX
        0NSIBDWOjmATFHmASbU9bvg=
X-Google-Smtp-Source: ABdhPJzQfeK3AEEbh7/kguzo/xuQtlKBLxOyQQ2N+KhzxVRgsqzAxPz1XnXA04R6/H0fgLR2EyU6Fw==
X-Received: by 2002:a05:6402:438e:b0:410:a8bd:fee0 with SMTP id o14-20020a056402438e00b00410a8bdfee0mr2176280edc.426.1645707283299;
        Thu, 24 Feb 2022 04:54:43 -0800 (PST)
Received: from orome (p200300e41f0a6900000000000000043a.dip0.t-ipconnect.de. [2003:e4:1f0a:6900::43a])
        by smtp.gmail.com with ESMTPSA id hp7sm1342998ejc.144.2022.02.24.04.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 04:54:42 -0800 (PST)
Date:   Thu, 24 Feb 2022 13:54:37 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: atmel: remove redundant initialization of variable
 timeout
Message-ID: <YheADZELg0XyEk9j@orome>
References: <20211210002250.639251-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LbvGMTIkSSxx+Jrr"
Content-Disposition: inline
In-Reply-To: <20211210002250.639251-1-colin.i.king@gmail.com>
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


--LbvGMTIkSSxx+Jrr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 10, 2021 at 12:22:50AM +0000, Colin Ian King wrote:
> The variable timeout is being initialized with a value that is never
> read, it is being re-assigned the same value later on. Remove the
> redundant initialization and keep the latter assignment because it's
> closer to the use of the variable.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/pwm/pwm-atmel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--LbvGMTIkSSxx+Jrr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXgAoACgkQ3SOs138+
s6GEChAApw2d+UIzuiHhq4rQmZHAlZMsL5OyuRWo14Kq7CZcPcBQuTf8PYVmtYak
ei6u0+ug6g3LOhG+R7rYvS/x0eV0sO4uydIWlhTJhGEtdxbOuSDWKQxo1odhrvcW
asIHs5gC1kpNzlHUMiIlHjzQ8+d7auwSRS3qO7us8BgtaAV+cKY6XvfSMm6A+/6k
0VU+I0SFPVGy3jncmvip2Oa1kkyG6oWt+sY8a29q0C2DZ69jWLecBgibPrNOwzf2
8T7EzBew6k/qguvpKgu7WitUENSn0WWJ38UW8IHcsJtC64DZv77hc62QZ4ZAgQu1
OQ/Gz5aMXmA9HLQ2rJy7I33DbP81a+OePo2evwFH9XxuBJ4ANLT48vMLb31UHQLu
dGclitZls+dE6YzdQW/Wy80RCCfNTBIVNYi42LgewkZiUUfdPYBPon1VF39PDZ+Q
RhyiaM64czzaM276bqpHOmI6HKOXpFlDte7/LXbNdWWvCSy89/T9BHNfJpVIBzVw
iSHzNCYXntFGu5lY4MnF1mhOwqPSJk4GBgCdyQoQTCIwq2Jp35Tm2rIwrZNbh9vp
qDc11NoTsAOpOmMyZfdArlICNkUWDp9pJpV2iZiYxWiT4XimEHknSuL2cDNmmI1N
Rx1f69kehNDWK2fJJe1SwbfP6E/fn5YT5lflhtsJ6wbhyjjyzXM=
=pYZZ
-----END PGP SIGNATURE-----

--LbvGMTIkSSxx+Jrr--
