Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF2F5ADD45
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbiIFC2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIFC22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:28:28 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F58642DD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 19:28:27 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 123so589469pfy.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 19:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Xy6WkgEFaeEodmkOTP/wZeGwCx12lREAvX9x2pDH+sc=;
        b=SSVih/zlg15TJfUVj4Gque2nzl5RSohnXGjg1I9nNuXKCcL+UeqoJWXS67wwxjcCwR
         zrydbRfCZaq+FmB7smkRm+3SA7VvXSU6Wux/TD8zwlme0S3bi9fATECl8QSPuEHk/Bzb
         Dlw3ck36ZtgmOT3sFyT6Ou0+7axsF0dhj8g7psbnT0KFSmcu1lka/5xYQRxuutfBtaUM
         caqvU+tQvkXl1NuFId5d6RkX25WOxSfXZdDtW7gjE5HUuGyBB6drc7ZsfIlu448E2mEK
         RGd+aZgo/ICv2QXMO/rk9wOB4xKgvHvzFAjluTSsZELcVYweHCLU2aMDyNl8CNyaIidU
         7nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Xy6WkgEFaeEodmkOTP/wZeGwCx12lREAvX9x2pDH+sc=;
        b=XsndxviU3EfYq84ybXfn0RrdTDzvV/caq7ZYVCVhQIv9jSFwKw02Y0a/j1KXtd+fq6
         fo1zZOBTbe6i8wZRSuqz1zehEw4IRyEptqwiQQbBJmuqGWeTc3+E/GBYHYSWKRhq1AFZ
         XMVzD3jcqjcUQYCLcAT0WvLUkBbMsRjIyJOzwhN0wGSxVNfUjKcDFmrDbOVIOLx54d39
         rpywhA1U5Wt18qWNsW7gJl37IzqnP47yAXX2j9zsu7bocDkMXUcLK7oxty9IQ7HH1YUB
         8LCjikM1/7HXH2H8/Fm0IUtAZ2bGjBGUAdUXMnsz4HnSqPCm6pajxjD6Xj1Q6w8r20G5
         f49A==
X-Gm-Message-State: ACgBeo3W+94L+ly0OiXajWnWSJrn3j9zAPemWtwVcCWVkoZOXqDUYsKR
        HC8xumBq9e/dTM9D0np87IU=
X-Google-Smtp-Source: AA6agR7NBDH34Q9KVqZt1AM6M2N7Z01aI0AHZqnC7gyZvkfrSOHG8/kQLPSArybpJ0qWTLmCN69w5Q==
X-Received: by 2002:a05:6a00:88a:b0:53a:b7a0:ea3a with SMTP id q10-20020a056a00088a00b0053ab7a0ea3amr29919286pfj.21.1662431306994;
        Mon, 05 Sep 2022 19:28:26 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-83.three.co.id. [180.214.233.83])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902a38b00b00176677a893bsm4056487pla.82.2022.09.05.19.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 19:28:26 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id B7B5B103CFD; Tue,  6 Sep 2022 09:28:23 +0700 (WIB)
Date:   Tue, 6 Sep 2022 09:28:23 +0700
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
        Lee Jones <lee.jones@linaro.org>,
        Joel Savitz <jsavitz@redhat.com>
Subject: Re: [PATCH 1/5] drivers/mfd: sensehat: Add Raspberry Pi Sense HAT to
 simple_mfd_i2c
Message-ID: <YxawR1ygLhZ49DsR@debian.me>
References: <20220823174158.45579-1-cmirabil@redhat.com>
 <20220823174158.45579-2-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ioEe3Tuii9pgRIJs"
Content-Disposition: inline
In-Reply-To: <20220823174158.45579-2-cmirabil@redhat.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ioEe3Tuii9pgRIJs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 23, 2022 at 01:41:54PM -0400, Charles Mirabile wrote:
> This patch adds the compatible string for the Sense HAT device to
> the list of compatible strings in the simple_mfd_i2c driver so that
> it can match against the device and load its children and their drivers
>=20

Better say "Add compatibe string for Sense HAT device. The device is
compatible with silergy,sy7636a."

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ioEe3Tuii9pgRIJs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYxawRwAKCRD2uYlJVVFO
o4/cAPsEB9c7qBIzYTXr/Nf+mkfNcSkaw7X8J1mNcWcNyaWPrQEA6ScGriT/KWyT
1MY66xRF05EDj5DtuxeeGOs0oxc1CgY=
=aNcd
-----END PGP SIGNATURE-----

--ioEe3Tuii9pgRIJs--
