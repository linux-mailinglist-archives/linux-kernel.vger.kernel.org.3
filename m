Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D065ADD8C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbiIFCrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbiIFCrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:47:17 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306EA6B8FC;
        Mon,  5 Sep 2022 19:47:17 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r69so9430126pgr.2;
        Mon, 05 Sep 2022 19:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=JY3Cjdj/SseTgL8ad0a+0T3JmVyh8QzCUfb+7GEodNI=;
        b=CHFKoZJdk0f90v6SGSNTXBKOpAy6EitSKkqWktK/Atfw4Q1A8aiLY2c8dmWelMwvvD
         WG4WpO1KkBRn0JvCdgCyTCwfnApkv4TqYW8keb794uusshRoxtiTzJOLEKFKpnKp/0LJ
         S0JJ33C/dSOwqfcAvUngNfElY0TVldgE1FBANjnydge49a3iJ4ySkZDJMS3TTYB23QJX
         CYRsFw5WMxWzpxwHxgUxYveKERDrtUbtR/SyJSbROjP2KydGaoGMoZrwiZBz1CoY9AYd
         6lO9b40gFfIAPXjujqr/6wCrqOOjxAwe6yMieZMpAM1tz7GvlL70i3BS/KuCsvXBFvRD
         pMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JY3Cjdj/SseTgL8ad0a+0T3JmVyh8QzCUfb+7GEodNI=;
        b=Dbv3S+bUsOCJMVHcQp6XBeUCVM4j7x4FBWSuiWtBLBFOkfA0bNMt38JEkuAAFNMfH3
         dORqrhsOpD2RYxMILQsyBPxLg7TdvZIjFJTyOPbHkfSBj+EBGgqhG0SHDqrtNHJpvGqe
         5GFWuH0gN6glr+j3He6lCtrLAE+OdduX08a8rIcYpXWF4I30urUSn9ZJkMbvhG25scBj
         D8zgACvwI3s4xhZhTJ2pYiKStdvxjnlPcRLeEWXyjKhaTMZ7+Ox840dsBD4mCHs1vX+R
         vFrK2nyRZpXKPU/XIqS+0ydeB1Urz7izvsulTthqywLecQcXPiN9Q4MQR5egqAdkpaU0
         gJKg==
X-Gm-Message-State: ACgBeo3LQS468kixnqeeBButDSgux0LT8LIFZlYmvccAA0sqMliqq94M
        84YT28dqJHRVVqwRzv/dcBo=
X-Google-Smtp-Source: AA6agR503+JVAoZ/vBSv59I0rwVLTrI+qAsBhq9qZ7hEtMiVP9mhu2biTRcMkWcNNNzLvQGJfzkapg==
X-Received: by 2002:a05:6a02:115:b0:41c:4d5f:876 with SMTP id bg21-20020a056a02011500b0041c4d5f0876mr45542972pgb.419.1662432436687;
        Mon, 05 Sep 2022 19:47:16 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-83.three.co.id. [180.214.233.83])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902680300b0017305e99f00sm8332932plk.107.2022.09.05.19.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 19:47:16 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 28B0B103FA3; Tue,  6 Sep 2022 09:47:13 +0700 (WIB)
Date:   Tue, 6 Sep 2022 09:47:13 +0700
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
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, Joel Savitz <jsavitz@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 3/5] dt-bindings: mfd: sensehat: Add Raspberry Pi Sense
 HAT schema
Message-ID: <Yxa0sfqzeb9QGabA@debian.me>
References: <20220823174158.45579-1-cmirabil@redhat.com>
 <20220823174158.45579-4-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cOieIu35pyV/w2q6"
Content-Disposition: inline
In-Reply-To: <20220823174158.45579-4-cmirabil@redhat.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cOieIu35pyV/w2q6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 23, 2022 at 01:41:56PM -0400, Charles Mirabile wrote:
> This patch adds the device tree bindings for the Sense HAT
> and each of its children devices in yaml form.

Better say "Add DT bindings for Sense HAT and its subdrivers."

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--cOieIu35pyV/w2q6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYxa0rAAKCRD2uYlJVVFO
oxkeAQDEnxMEF2YwBsN9NPPuih/zm/f70QOpCFiy+V3Ep0zFlAD+JW4PFTzxVTW7
gzzg702nNBBBVh7dJCz+jgm1Wfc+pA4=
=bifi
-----END PGP SIGNATURE-----

--cOieIu35pyV/w2q6--
