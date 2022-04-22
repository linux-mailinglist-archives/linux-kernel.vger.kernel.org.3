Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6775E50BD29
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449722AbiDVQfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389617AbiDVQfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:35:19 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90F65EDF6;
        Fri, 22 Apr 2022 09:32:25 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id br15so809767lfb.9;
        Fri, 22 Apr 2022 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YewSinPcGEIeTbpWSFNv/QaYp2GFPGAdYjpjIS4ZQuY=;
        b=QpUHz1vVPZYl1ycw382VVPxZtDcCpYg9jeqLetG000tFyQ18XJS015+5bAQqA6dx89
         9gVQ7zIAWH2KzxKxl4dDiA2funO+ozgnPI+NfDVhW32i9F1MGVa5BrYD2IYn3CVBALwB
         l3QnapdrQeSLGmk1G/CHAw+DfkmqfZl242vs5phnP9pALQvmO2gGDRxmYRxjPBUqnDB8
         u4nSgB31wclp1Yt4qn43kcUu2YM4RNBMssrvyNDF+5wejwWhnmlTyAhLTrRyEv8+CXr9
         7rsIZSTTWEGvoY9QahEIVFY/qfySR/ooP9pbigZxOBpAyJwWejd9g+OP34C+hNqlGMyp
         Q8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YewSinPcGEIeTbpWSFNv/QaYp2GFPGAdYjpjIS4ZQuY=;
        b=XS8fUAwK7Xcexho8eeMrqkbohTz4ib7Pdu/WHfMQ0TtaKQKJaTktlqxql3zPXb4ijL
         eJF/KAW5DTQ6n6x2l8i7r2vKZeehcziN9OaKDWDfEOcfEsrPQdbeJ8Ii5kIaUOZk9aqZ
         cUPSBplzV5tLSsuc2bQE1558eyWflzG+9vFMMrgVqsOQybdK2vojt1qHvCuCmgUqQTJ2
         zT8HFiSh4GSJdnbyxZyTrJ1yQqmQ79By0Ru9MPiNb3P83c1I+/SHaUx4k1Y5ff0vndwr
         kEX4U0f3GSL2J7r6AIxD9OmT7EijFbNrW66WpaYHyEj65i8ZkoT15EY0Cm7OI9WZrsw4
         Up6g==
X-Gm-Message-State: AOAM532BCmX6FhSSYQxiwxTVQImyam6rQfyMfG8qv407f9K8TmIX3tLc
        4uPZPXWbkPQsI7Dv6/dqdFE=
X-Google-Smtp-Source: ABdhPJxsRAU0DiEyPLHTIbsCE9CV7Ihho1WvyGZYkNK20zcsObdi8pplNFmCWlfpI6F5gVdvdEgaSw==
X-Received: by 2002:a05:6512:16a9:b0:44a:2f67:3b29 with SMTP id bu41-20020a05651216a900b0044a2f673b29mr3859596lfb.153.1650645143913;
        Fri, 22 Apr 2022 09:32:23 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id j7-20020a056512028700b00471bab03deesm277168lfp.38.2022.04.22.09.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:32:22 -0700 (PDT)
Date:   Fri, 22 Apr 2022 18:32:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sergiu Moga <sergiu.moga@microchip.com>
Cc:     claudiu.beznea@microchip.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] dt-bindings: pwm: convert atmel pwm to json-schema
Message-ID: <YmLYlFEFA0eGqEco@orome>
References: <20220307153656.177589-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BMMd2rJA7OnOnIT7"
Content-Disposition: inline
In-Reply-To: <20220307153656.177589-1-sergiu.moga@microchip.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BMMd2rJA7OnOnIT7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2022 at 05:36:54PM +0200, Sergiu Moga wrote:
> This patch series addresses the conversion of the Atmel PWM DT
> binding to the DT Schema format and adds the SAMA7G5 compatible to
> the respective converted binding.
>=20
> Changes since v2:
> - Moved `allOf` between `maintainers and `properties`
> - Replaced `additionalProperties: true` with
>  `unevaluatedProperties: false`
> - Used 4 spaces indentation for `examples`
> - Modified file path in `MAINTAINERS`
>=20
> Sergiu Moga (2):
>   dt-bindings: pwm: convert atmel pwm to json-schema
>   dt-bindings: pwm: at91: Add SAMA7G5 compatible strings list
>=20
>  .../bindings/pwm/atmel,at91sam-pwm.yaml       | 47 +++++++++++++++++++
>  .../devicetree/bindings/pwm/atmel-pwm.txt     | 35 --------------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 48 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/atmel,at91sam-p=
wm.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-pwm.txt

Applied, thanks.

Thierry

--BMMd2rJA7OnOnIT7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJi2JQACgkQ3SOs138+
s6FSvA//Y0U6CmqV/ssGT2v/ciRSryyP2fXgj3fWC/WgDBV4NkwMV+WFO1UpyP93
KfUO1IQTwAOBxaI33vdqKzkYzRdN3xt1/oEEV2pFz+uDiw30xecwslpJQvsHLKid
BpRvwjaZuzurIaxYEbRwV6CWGyxtGrLXt7DoQ1aQl9X4x5M2nZZaPIFJYC7kirpl
tctAwP8FKc/spZ4NFktKuDGvQnIHUGxYI6/6GWhx67ILJ2zJnR9AowxxNs6ID+2o
vr3zW/AIhSoLA04xoWdNDqyv3cuT3lod0DedaHRzucHv3kGyeoF8Vfhi+QyUxKVs
NGXMJjrfqnqVwlvVtQt99EEug8NTX+R9a6viuTEQKLX9L34l2A1jt65dMXPS7POy
kk1OrV4v9s3BJsY4tEUH0aFRTHhj1NCs7VJeJjxi9lH7bCAbq/IlwFLSO1ojWcuC
YxXcJ2VdUQrGKvp93CThbdhwrly2xXrOpck2FWz7xCc3yBcHOHm+wOmtbq06oMFW
wCJHt6bp/eC0XLsPlIGMg9q63vL5PlkYkKT4cMKE6vhhuNKmC3I4iUBiPICO5n/b
klGE8BrjdsvAPqeQmdMPCuxYP7MZGnrczzcItjVlkOsSlyMbppRNL721S2Baid0G
WPfO7j5gD+jeYobA9icC78f3pr5XhwSOpM8mtSdskdtpYiLQdks=
=vpYA
-----END PGP SIGNATURE-----

--BMMd2rJA7OnOnIT7--
