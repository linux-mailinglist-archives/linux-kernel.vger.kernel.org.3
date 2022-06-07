Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BD553F6B7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 08:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbiFGG7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 02:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiFGG7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:59:20 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AB4E15FE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 23:59:17 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6660C3F1A6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 06:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1654585155;
        bh=IsT8hRw/sNvl8bYDkskbd+oZi1y5enJZxvvxqrYnrr4=;
        h=From:Date:To:Cc:Subject:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=chLaiaBiYJyeJyWb0qyPcnPD2gCuYc3xaRKDY/2W+3oO8OP64l/iQ5XeQvMx9O3RA
         rPCV35JrwCt1hIENBDGjS2BW94T6lwvTB63vvSU2bnqbm3I9VgYo4cQYNWUQilk20Y
         3TxI9Th+6n5X9peHNo1mlimzh4HypZXJGR41PHQ5LZ8BSsspZ70DJHPtEoG8LzP0uS
         nPetqUtnvJBr3dyTNfpxI5/nVJAZmTC+GrLQzMLh+HW2yAAAf6rChpwg06XvXc7hKy
         q+koA2eKbmPF/l3L0cu+5KL2LpOH04iKykvM+XlYwkn1DZqGdStCg4c/4ye05mKHAR
         ox7pd5gtRrxVQ==
Received: by mail-ej1-f70.google.com with SMTP id pv1-20020a170907208100b00710f5f8105cso2598331ejb.17
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 23:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version;
        bh=IsT8hRw/sNvl8bYDkskbd+oZi1y5enJZxvvxqrYnrr4=;
        b=N3yIuFfI5R8eXxf6xLUeiM0ZGQdqg8Xx5zzr+g/85s00WxkL8ZDUZt3xFOUq5uDDGI
         27RpRMTwIfRh15ULFSnG293HbAsq9PIHwPyHM0wQaFRCP7wU9L5yIx3PulNev/SqgGT8
         6H6+FlLQY3S6VPJdrLEoXcSqwqKCgZUp2SeNXGp3S/r8KxFK+N5C1rsd8Sdc//hc8cGK
         BcuftfMaHHNz3dxQWRIPsj7i48EkSFcNlAnoTEg1XtzlvzDOWZA767Y0N+QXqF7bEQgV
         G9zPV3TeW8MBlDiYRNNUGkRJ6DG6q40zYAi3d7TDsaSU0O/k40j0LtNgv+dblUCCVwGy
         3mUw==
X-Gm-Message-State: AOAM531zHzGMARs9d9QDHCgJQRTddE/vZPIFouFtZHdw8QAsFOPUHuFO
        jdlJ4CN9T9+3RzoMdPNn4QVx5hfnYKtquxCXHvZ24vgUDPkkCLucBAoBUtb1EfSli6j0HXKXQ4W
        2YpkDgZOW2x8Gl1k8K6iaT5bMuMM3IgqbmR95uYDD+Q==
X-Received: by 2002:a05:6402:d0a:b0:425:d455:452 with SMTP id eb10-20020a0564020d0a00b00425d4550452mr31270536edb.259.1654585155042;
        Mon, 06 Jun 2022 23:59:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyd9i/9BbSQOIg/c0QLsT8DddOAUdP7JtdSIrybDIOeMXXJCPyjEqk2UpdA6PvWtnllmKbnzg==
X-Received: by 2002:a05:6402:d0a:b0:425:d455:452 with SMTP id eb10-20020a0564020d0a00b00425d4550452mr31270521edb.259.1654585154860;
        Mon, 06 Jun 2022 23:59:14 -0700 (PDT)
Received: from smeagol ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id ex1-20020a170907954100b007052b183d51sm7090557ejc.132.2022.06.06.23.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 23:59:13 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
Date:   Tue, 7 Jun 2022 08:59:11 +0200
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        linux@armlinux.org.uk, alim.akhtar@samsung.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ARM: s3c: Kconfig: Style cleanups
Message-ID: <20220607085911.4b0f7f10@smeagol>
In-Reply-To: <63eabd40-761e-3b4e-c1be-43a12516e1b0@linaro.org>
References: <20220523064252.11938-1-juergh@canonical.com>
        <165450679893.60702.4773704114108524411.b4-ty@linaro.org>
        <63eabd40-761e-3b4e-c1be-43a12516e1b0@linaro.org>
Organization: Canonical Ltd
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dzSs=0VGa2QCNMu0FW4QcUo";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dzSs=0VGa2QCNMu0FW4QcUo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Jun 2022 11:14:28 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 06/06/2022 11:13, Krzysztof Kozlowski wrote:
> > On Mon, 23 May 2022 08:42:49 +0200, Juerg Haefliger wrote: =20
> >> The majority of the Kconfig files use a single tab for basic indentati=
on
> >> and a single tab followed by two whitespaces for help text indentation.
> >> Fix the lines that don't follow this convention.
> >>
> >> While at it, add missing trailing comments to endif statements and rep=
lace
> >> tabs before comments with whitespaces (which seems to be more common).
> >>
> >> [...] =20
> >=20
> > Applied, thanks!
> >=20
> > [1/3] ARM: s3c: Kconfig: Fix indentation
> >       https://git.kernel.org/krzk/linux/c/076702da7e8a2472f8ac86f1179dd=
cc5e90febae
> > [3/3] ARM: s3c: Kconfig.s3c64xx: Fix indentation
> >       (no commit info) =20
>=20
> ...And dropped. This does not pass checkpatch. Please be sure you run
> scripts/checkpatch on your contributions.

I did and the check passed but email aliases don't work well in this scenar=
io.
Will fix and resubmit.

...Juerg


> WARNING: From:/Signed-off-by: email address mismatch: 'From: Juerg
> Haefliger <juerg.haefliger@canonical.com>' !=3D 'Signed-off-by: Juerg
> Haefliger <juergh@canonical.com>'
>=20
>=20
> Best regards,
> Krzysztof


--Sig_/dzSs=0VGa2QCNMu0FW4QcUo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmKe9z8ACgkQD9OLCQum
QrekSxAAr7orCH7rJvXteTM/jHkBdQCnPsvWgUeCXlACg24BKoLr05vB8yy4RUNG
PMg5pSZd9xhqJ2eOn8wjzMAKhEL/BRvgUmqKmip+4BLtl0MVwZcykQBD2wqCYS3i
lALzu45t9X+WV0dDRx2D96Xqp1ycUT1YSIpZ5fVsoZtJz9v0F0F5gJUlwooP8QHX
SwW83+HQFwjSv5WtaNZaE/+VW4rV5wS0sF0OQ9AfbD3KrZ4w8TcSbLwe3zbAJDK+
Duso7rtqlmGfSDwBwHz4RjLYwxTvOG4OVjeTfjhaUpHmcumA8FDrH9CAYcEeBk3R
cX3SxOS1yJn0bkMMDcNQd8m5XjGzX1ZZAZFc/XQ4MCK8jTBdpqjDbemL4qVvKD3X
7s2BiQzvs75A+rcI4jrItEr4ecIP4HEQDxGmo7VbpJzX0G8dsvywOVmBgwaSBcAW
iQ176Fa2lqrE+KiMWJVBvnJJ01KmbrsAWzxNBUijjq+OKONfs9oP+3HjjogS3Vts
3gaVLqr3T9eFA3hWOPtK+WCYG61X8BX0E8KRUSc02BYYynfSPiMMK+pO1nShdcev
oY9k2TeSr/r/zNfuGPgDPS32AR3xeODGWyYtMuMEnws4rf5eBpdjVYGMB31WRQtM
s4czehkmQOcqGX/TdbjkRNvMr6jGC+c2KUKvK4hCRpMPcZ9yUUY=
=stuX
-----END PGP SIGNATURE-----

--Sig_/dzSs=0VGa2QCNMu0FW4QcUo--
