Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346F74FC5E3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345576AbiDKUhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240336AbiDKUhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:37:04 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE313DEB9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:34:48 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id t11so6283256eju.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ie+QkOmFE8UTE3hyBEH9mlG+n6irl6CyrcT3wa6CMKg=;
        b=Qm7oC3V8HC75KdBBaoCL5RO3B/cBlxpzT1hPeg1/mFEaIgkVS9QXpw8bzHXsZ/xL2c
         wSYJp/J6Ic7hrhfKhLc8JA0Rb/tNtq/AyOVkRML6tWsW8DhXG6QoZGueu13LtGJTP8TZ
         p5EHssQPpzS8XTe2C5v7j40cJoBREMDp1y7undUYImVQTN/Znli+fhaKabPafpdcCSfC
         wMxVqoRuSFvXhCw+0IYrNyc00w0NV7BQd7iwTmhkHmL1ScDdGzjqMkbungHg2TgBu0CL
         Djp8Bq7JDSGVeXCQ20FOjPWep8787Bd2ivEK7Vi+2kaHKK8fp/7pN8QRCiLtgjB3ZL1Q
         WxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ie+QkOmFE8UTE3hyBEH9mlG+n6irl6CyrcT3wa6CMKg=;
        b=Rlfxbq32l3cJSinS/BrKtefl03LOviYfSeplZcEm/+/M8a4JS1I99UWINiMb8i0rym
         xa0LjWN/LlWzD7rs3oWDkBkoD9WcgWQwGUegOt5VNSIPy2C9UTXSY19cEvIlfxpywdRN
         g6Q88yVQA+X6TjgiScY7vx2KafhiFNKzK1jXM2k1/doHfgNrj3hVv3J7swm0NRRFvyBa
         g8muStGzAFYaCp8NfuaN6INgYJFU+doQL9wGEa7jlbK3d/bp7C+mJaepLVF9bSlD+zVF
         UkcMmqc93ix6YEYRTMe5dJlgqGfiGZ1UDKjyw4yK0yR/WTUv0o6mZ4ZpeFZ0iABOqBfV
         2ryA==
X-Gm-Message-State: AOAM532SzUbWzk+DrKyCxT0nkYOufwk2fShlKShcD08G6oFYTGCYoo/L
        vLQ5nqA+MDEQLrti3M5L3Xo=
X-Google-Smtp-Source: ABdhPJzkd1u1sG/qXxzNgb47n0qmUolgQV4HEdfpa+StYJ95FHkUBW96eBipbqQD4S+vJvLvYfqm2w==
X-Received: by 2002:a17:906:c282:b0:6ce:369d:3d5 with SMTP id r2-20020a170906c28200b006ce369d03d5mr31454727ejz.425.1649709287367;
        Mon, 11 Apr 2022 13:34:47 -0700 (PDT)
Received: from leap.localnet (host-82-60-208-254.retail.telecomitalia.it. [82.60.208.254])
        by smtp.gmail.com with ESMTPSA id o5-20020a50c905000000b0041d828d0c58sm1582226edh.53.2022.04.11.13.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 13:34:46 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: Re: [PATCH v2 0/7] drop some unnecessary wrappers
Date:   Mon, 11 Apr 2022 22:34:44 +0200
Message-ID: <37499399.10thIPus4b@leap>
In-Reply-To: <20220411102136.14937-1-makvihas@gmail.com>
References: <20220411102136.14937-1-makvihas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=EC 11 aprile 2022 12:21:29 CEST Vihas Makwana wrote:
> Drop some unnecessary wrappers and update all the references
> accordingly.
> Tested on Comfast CF-WU810N RTL8188EUS wireless adapter.
>=20
> v1 -> v2:
> Drop the wrapper functions with underscores prefixed.
>=20
> Vihas Makwana (7):
>   staging: r8188eu: drop unnecessary wrapper _rtw_free_cmd_priv
>   staging: r8188eu: drop unnecessary wrapper _rtw_init_cmd_priv
>   staging: r8188eu: drop unnecessary wrapper _rtw_init_evt_priv
>   staging: r8188eu: drop unnecessary wrapper _rtw_init_mlme_priv
>   staging: r8188eu: drop unnecessary wrapper _rtw_free_mlme_priv
>   staging: r8188eu: drop unnecessary wrapper _rtw_alloc_network
>   staging: r8188eu: drop unnecessary wrapper _rtw_dequeue_cmd
>=20
>  drivers/staging/r8188eu/core/rtw_cmd.c     | 145 +++++++----------
>  drivers/staging/r8188eu/core/rtw_mlme.c    | 179 +++++++++------------
>  drivers/staging/r8188eu/include/rtw_mlme.h |   4 +-
>  3 files changed, 135 insertions(+), 193 deletions(-)
>=20
> --=20
> 2.30.2
>=20
=46ormally, you are removing the wrapped functions (or helpers, if you=20
prefer) by moving their code into the wrappers. To say that you are=20
removing the wrappers is not correct.

However, I'm sure this kind of formal mistake won't prevent your patches
to be accepted. I wanted to point this out to you in case you decide to=20
submit similar patches in the future and perhaps want to describe your=20
changes a little more accurately.

Thanks,

=46abio M. De Francesco=20



