Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686DE5B2778
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 22:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiIHUMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 16:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIHUMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 16:12:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BA7FF093;
        Thu,  8 Sep 2022 13:12:34 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n12so4140919wru.6;
        Thu, 08 Sep 2022 13:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=NZgMNXmwX6SnvwK87AGk7VHv1cRLy9ojL7C9GfQltcQ=;
        b=YJ4s58i5EeQ/uWSSo5Qua0Tu9JxeF7gHHmv6fGDm9QWyiqerXu4Ilr2+q5WcCokQpd
         s5ar2mQZ4qckmj8UstMJ1D5NmhDBLq/hZCLkj/1jV6CIx4Lotf4dIr8qxuN18hOdbaRK
         I3q+IFxGDa4L94z8INS+n2AlUJaBDKJ5s6GbSvprWURXKAUiyetY4D5W6f4J+dmAwoN/
         zFtoXWrNsEuFGpQTrpFvl9HvTgJTUPCPd4vSDKzcXyzL2ggoLchBpbC2TNy1CAh1tG2d
         uVX/3Wui6ini3rsil9KvPp43yLaUjvrqRUe3OgNIpv/8dX41fBz3KD8yrbz4cYzcavBj
         jOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NZgMNXmwX6SnvwK87AGk7VHv1cRLy9ojL7C9GfQltcQ=;
        b=iljyor/V267lZRL+3zewqoFIN8A/0UapCc67dUYLsdMCQ+lBbQtGivdpZ/x7DrKgnV
         0e3DlIKEfQNy5pdP+4No35QVhE3BC6HyyDHNffUyQDjrmzmkIOqVQq2JxoKq5eslT76z
         ZWaWCEKOR7JQOQtytaM08Bhx9PQhGR2vKpksmkyRfF9GbPzZAD9MJwP0K0py1XbnyyBT
         8V2i1cBt5tRpfw46ezm5YePZQ+mTwP1I6p+Dhu8koSxog9v9VEgh2rqOKxxYb3sgFdpz
         +74wPnePk58DAtMAdO/0fn/muLBrgIX31SYdXcuCAHNi91V/VhjYcLuO1k+yfNp7Jp5U
         bbLA==
X-Gm-Message-State: ACgBeo1NBcqnPO/9S3DOpoh6ykmARxOqxWGki7n+7wu+d1Hb4NQRb36a
        7vSRNhMxTQL/s/+CVEPc/IMM9rE3A7hRydXQ
X-Google-Smtp-Source: AA6agR7zdskVsvESm8kGX7KqfMmGDv2c4HseHMS5FFGiG85C0bwgWAPGhSMfCb228haUWNp4WODYSw==
X-Received: by 2002:a05:6000:1f9d:b0:228:6446:3d67 with SMTP id bw29-20020a0560001f9d00b0022864463d67mr6210529wrb.575.1662667952965;
        Thu, 08 Sep 2022 13:12:32 -0700 (PDT)
Received: from kista.localnet (82-149-1-172.dynamic.telemach.net. [82.149.1.172])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b003a3561d4f3fsm4852904wms.43.2022.09.08.13.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 13:12:32 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Subject: Re: [PATCH v4 0/5] Allwinner H6 GPU devfreq
Date:   Thu, 08 Sep 2022 22:12:31 +0200
Message-ID: <4086439.1IzOArtZ34@kista>
In-Reply-To: <20220906153034.153321-1-peron.clem@gmail.com>
References: <20220906153034.153321-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 06. september 2022 ob 17:30:29 CEST je Cl=E9ment P=E9ron napisal=
(a):
> Hi,
>=20
> This is a refresh of previous patches sent to enable GPU Devfreq on H6
> Beelink GS1 but that wasn't stable at that time[0].
>=20
> With the recent fix on GPU PLL from Roman Stratiienko I have retested
> and everything seems stable and works as expected[1].
>=20
> Regards,
> Clement

All patches except patch 4 pushed to sunxi tree. Thanks!

Best regards,
Jernej

>=20
> 0:
> https://lore.kernel.org/lkml/CAJiuCce58Gaxf_Qg2cnMwvOgUqYU__eKb3MDX1Fe_+4=
7h
> tg2bA@mail.gmail.com/ 1:
> https://lore.kernel.org/linux-arm-kernel/2562485.k3LOHGUjKi@kista/T/
>=20
> Changes since v3:
>  - Try to be more explicit for panfrost OPP patch
>  - Fix typo
>=20
> Changes since v2:
>  - Fixes device-tree warnings
>  - Add panfrost fix to enable regulator
>  - Remove always-on regulator from device-tree
>  - Update cooling map from vendor kernel
>=20
>=20
> Cl=E9ment P=E9ron (5):
>   arm64: defconfig: Enable devfreq cooling device
>   arm64: dts: allwinner: h6: Add cooling map for GPU
>   arm64: dts: allwinner: h6: Add GPU OPP table
>   drm/panfrost: devfreq: set opp to the recommended one to configure
>     regulator
>   arm64: dts: allwinner: beelink-gs1: Enable GPU OPP
>=20
>  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  1 +
>  .../boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi | 87 +++++++++++++++++++
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 51 ++++++++++-
>  arch/arm64/configs/defconfig                  |  1 +
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c   | 11 +++
>  5 files changed, 149 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
>=20
> --
> 2.34.1


