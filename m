Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6963B5ADD5A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiIFCbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiIFCbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:31:33 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7481C27CFC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 19:31:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id iw17so3308844plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 19:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=lzek8ATB3jHsL3vN/0X4tB8Y5gYzFMJnRQaPyD+5588=;
        b=Pll+tgQokXX3xOc+MdO1F5DEmlX4FUHDP7V+jAz6VEBUO4bXL8pIfwY1Ul7NfMqIIa
         VZNsTA+s+4rAwqpSmXpmh37s/oryLZZne3L9IbWICuUhABDAwmVfX10ws2/HEOWXJyKu
         lTake3EGYEsgGg6kQqi0ENmNmT5v9A2ovZXs1WUkDE31HKWw5jP6AqzphyX8IMUWS/MW
         dJPYedIlWtXMEl6ptkCBiL9hCPz84Td1YcQCjFLklDob7k+KYRPwtfK8fsrQ7qXJD6Gw
         UrGBM5iN+lUNmkRNJPOkGk6czPGsR4hjhIBtxcS9ZNw5g8p7ZJQ/5934WnHPd3OUSY1u
         PYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=lzek8ATB3jHsL3vN/0X4tB8Y5gYzFMJnRQaPyD+5588=;
        b=3DaowqrE36dH2IIckuPoTvlPF15irmO9nrQdjN3AnDJBBOrvr7vHB13BeEkndksh75
         Qjp1vaTku3aND+EIRUoM+SQ/HKzekiNsIXzXrXm4s47UfCQ9KW5r7wozPcf5+R6YmaEG
         X84dBHCsAL3z9H6m1Z184o/gxybkq5PBQTeVfxalVbsstAa9WZ9SaN2P6k55OCmhvAMV
         t47gpCPGWzJ8Q6CKyJjdcTVsP6m2l+fyJv6fy2+z0zWtlZmc9RS1E/JcAWpSL2rglt+2
         6Lr1jkL9ZycKqL5/P4VUjuzKgdN2Q8azNARqALuYBS4XSobWnxzgSa9dZJ8Wu7Hl+OFY
         eGDQ==
X-Gm-Message-State: ACgBeo1WVijvBh/jx5cm3Cws7zcWvtushJJ+Abv3BAdTp2mqCqFmqqjO
        bjRqVHTQIV/mqSk9aMbSa3k=
X-Google-Smtp-Source: AA6agR4JCdWAXQo0iUhRG1v/AOHWCAuOpIIhCfxQagRI59XJ+OrHPlxsiM82Nu/+EG2HraxSH9Wb+Q==
X-Received: by 2002:a17:902:b684:b0:172:d9f4:e511 with SMTP id c4-20020a170902b68400b00172d9f4e511mr52450770pls.107.1662431486047;
        Mon, 05 Sep 2022 19:31:26 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-83.three.co.id. [180.214.233.83])
        by smtp.gmail.com with ESMTPSA id b6-20020a170903228600b00174a4bcefc7sm8380637plh.217.2022.09.05.19.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 19:31:25 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E1883103FA3; Tue,  6 Sep 2022 09:31:22 +0700 (WIB)
Date:   Tue, 6 Sep 2022 09:31:22 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Charles Mirabile <cmirabil@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nicolassaenzj@gmail.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, rh-kdlp@googlegroups.com,
        Miguel Ojeda <ojeda@kernel.org>,
        Joel Savitz <jsavitz@redhat.com>
Subject: Re: [PATCH 2/5] drivers/auxdisplay: sensehat: Raspberry Pi Sense HAT
 display driver
Message-ID: <Yxaw+npNpjyRx0ug@debian.me>
References: <20220823174158.45579-1-cmirabil@redhat.com>
 <20220823174158.45579-3-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AfkVrwEf4k1vmion"
Content-Disposition: inline
In-Reply-To: <20220823174158.45579-3-cmirabil@redhat.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AfkVrwEf4k1vmion
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 23, 2022 at 01:41:55PM -0400, Charles Mirabile wrote:
> This patch adds the driver for the 8x8 RGB LED matrix display
> on the Sense HAT. It appears as a character device named sense-hat
> in /dev/. That special file is 192 bytes large and contains 64
> RGB triplets (3 bytes each) one for each pixel in row major order.
>=20

Better say "Add driver for 8x8 RGB LED matrix display of Sense HAT. The
character device exposed is /dev/sense-hat, which is 192 bytes large and
contains 64 RGB triplets (3 byte each); one for each pixel in row major
order."

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--AfkVrwEf4k1vmion
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYxaw+gAKCRD2uYlJVVFO
o6UEAP9UTwEIVvF4jrRM8U7KWUlW+XpAfJyI5G06OiAzc6TTegD/ZR0jvkuaGfrv
sojir1L+Dw6/Hhz4UbYTWuUC4cuccAA=
=IYEX
-----END PGP SIGNATURE-----

--AfkVrwEf4k1vmion--
