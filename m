Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3D1559369
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 08:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiFXG1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 02:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiFXG1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 02:27:34 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F82506FD;
        Thu, 23 Jun 2022 23:27:34 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x3so2806460lfd.2;
        Thu, 23 Jun 2022 23:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/sedk71D7R4whH0Mv3CPlpRx99+rEAt+wQi/LXeqlJs=;
        b=HavAjAmztdTX8MaSJjnLsWrw7E2g13xom9bIrP01fLE66JN0frGA+6h/aAr9xNItoC
         cYKfDVanr4buHuTF6YUA/qHPPBxVjWh7GkcwLM6tYp5qzfZVS9+EVMgqTaD262Ur9Osb
         Ga/tJHLPd5S82CnSXcYsMU12nyZBkxZH/yN2B0LoNw/Bn/AnfRHPGfJoP42dCXABNOIe
         MbUrDDBEZ/8U2VwQAYqdqn9IpDbCPR9wLMcYc6kl7ImUtXJdG8zhaIsJkAPEyKdKQyot
         T/FNIg25FJaKy7r+gTimOzEkCIcaEZ8d5P5kCF8N5us40ImcfYC0XQjfk9Wqbu4dwDYk
         yQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/sedk71D7R4whH0Mv3CPlpRx99+rEAt+wQi/LXeqlJs=;
        b=QHn00uUqUh/DQHz3mJOt2p4qgVceGBJ4CqNOu5MMFFhVpz3l9SYnQ7X203WfD9lR0G
         qJGdedka5hmnWphWvdAYbRizRKUkSAdSw6YnXm3Eq0KQYdegegM54Nbnjsp01catlWAu
         4F19M1Am89iYEWXRvDBkMzw5EljAg1KmtZpVceKwi3MjmNWoJdQDjsl1hU2m6evSTNmk
         pW85os/jxDrId53JyY+ST3HBxLWTow9d9RqscQYXfvG0e7eVcOTvtKidwouy6gkIx/lM
         HfuAYnjUkQC/An+vH+KkXGtAsvkNwgbsEHIUfgxWtzBp7DvS2gcl2G6aZ0dmq8Iq4tPv
         ezFA==
X-Gm-Message-State: AJIora+RezNQCn6roKdMo7jV3pGjeMoFyPIHISAGWnZHu+NDq21x+Six
        5Mm+mP4l72QQvqx+v7T7W/3W3Oc5QQAcVQ==
X-Google-Smtp-Source: AGRyM1t2xOfIH1PjMFYNiUJToLBqF+8bYFknvT3QPsb6KmxgwD0YC4nF5oNJ6hT9Tzj0wy38yr/ieA==
X-Received: by 2002:a05:6512:32c2:b0:47f:9c32:645 with SMTP id f2-20020a05651232c200b0047f9c320645mr7144875lfg.312.1656052052353;
        Thu, 23 Jun 2022 23:27:32 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id q14-20020ac24a6e000000b0047255d2117bsm214407lfp.170.2022.06.23.23.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 23:27:30 -0700 (PDT)
Date:   Fri, 24 Jun 2022 08:29:20 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/10] iio: adc: mcp3911: use resource-managed version of
 iio_device_register
Message-ID: <YrVZwAqmE0QmibQY@gmail.com>
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
 <20220623170844.2189814-2-marcus.folkesson@gmail.com>
 <CAHp75VcYk9PjQ=3ZPB1f=uQ-1GYKnvV-wsu+-z1z81W_ZHCqrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Z3FU30Rz5qR/KF9m"
Content-Disposition: inline
In-Reply-To: <CAHp75VcYk9PjQ=3ZPB1f=uQ-1GYKnvV-wsu+-z1z81W_ZHCqrw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Z3FU30Rz5qR/KF9m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thank you for your comments (all of them) Andy!

On Thu, Jun 23, 2022 at 09:01:59PM +0200, Andy Shevchenko wrote:
> On Thu, Jun 23, 2022 at 7:40 PM Marcus Folkesson
> <marcus.folkesson@gmail.com> wrote:
> >
> > Keep using managed resources as much as possible.
>=20
> You may not mix devm_ and non-devm_ API calls like this.
> So, you rule of thumb that goto is most of the time wrong after devm_ cal=
l.

Can you please confirm that clocks and regulators are disabled when the
resources are handed back?
I cannot see where when I'm trying to follow the code.

Best regards
Marcus Folkesson

--Z3FU30Rz5qR/KF9m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmK1WbsACgkQiIBOb1ld
UjLgrQ/+N2Ug71ripAScd5r6c8hrLl5oQLFSqMGBgQd4+61MWRNFDHnCVhRp1RyQ
k3huY0OLvBiwfcM+0FAdRRRz2QzZKQv+D+/XzMzU0LES/QjQN2pAA0nP4Wz46w0g
u/io/Pb2wdWRKfWKG1Qqh4GsZHmSIrbbZ9Dw1cVUEnSrEVpoZd26ODbwBgll6SGn
HmWYYM5XuC6vYwR8FhnR2pjFiAvULwPUhCRz7ixZMHhd5BiC9RvbjwDevpnhvmc4
tkk93qdiWAKYewQbbx8KQg+HrjZbQNyWNYAW1SQ1nXq1KJ9iVmYGnfK72xZfTp+9
DPG7Q073Au9+CoIAkZBj0qTDMQarsxsLllu8Hc5xgkTLLfNgEQVndHLXmq1968Qa
KJhOxHDLmthoB46UqSIyV8xE40LHba3djdSZYH9fUEmTd/7gput9G+DMuhPhkwC3
uMMBohd2rCcwBNLjkhTNY7J7P962JMHCvCLlED3NV4LZJJ58qk21nwHuv34Jgy7W
ufnu0Skw8pmn6sCwhsfhDB8uPj55Vo9EPZwbw7XyVeRxALmmtMJhGVw49fXv63iy
i8bYrdnDyNPySs4NQc0m/yyoQMZaxQ0hJEgoUZClzuYjbSb9iKwrLbIix+sF6BYY
/QLeKN33RNIbcmAJSEplPpJwksm+Nc/I9Q/xdMAx0YlSmLuS0Rg=
=3Jth
-----END PGP SIGNATURE-----

--Z3FU30Rz5qR/KF9m--
