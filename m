Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17894F4CDD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580826AbiDEXew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573280AbiDESml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:42:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD8820BE2;
        Tue,  5 Apr 2022 11:40:42 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id k23so25103945ejd.3;
        Tue, 05 Apr 2022 11:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vbMPbp7aUefqeHa6gEgmXUlWTRHZ3oMWVTDKwmVUOh8=;
        b=KJEMIj4e7Nkf5NRQSkeGOdWSQ/71GPeTAtj19TfSQfaw192KiobZULMM0yawIDtQ+1
         kRjZ1hHKMIFz5w9uzoszb/2UfxMFLVuhv1pcx3l2FbrdwFg0o9IdUwBssH6gMmasF+sC
         tAYmb4Zc+PawW5CU655i1OQPBPDNcC4ClfHWIMZ2+DO3B8slsGym7/pz3iqIyZLr1GZ5
         MLbeRvJiT+5mT7bKd/c/7BGNhUV9FRT6Rbo4IITF2Ehl994/2iaeC7VBC13O0Owz00Gp
         EuxD4peu6TSeWZYYpDmgXNCmVOuyQzE+ikHq9qi/Eo1WQKNiWby277cISSVlNRAYEi5t
         uS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vbMPbp7aUefqeHa6gEgmXUlWTRHZ3oMWVTDKwmVUOh8=;
        b=uZesIecNDcIzvRGNc4Ut8tOwqMxFct/6xP//ptwnYFa9EEGNauwgslks77sTiOJ2S0
         OLngnbl8ZNnsKMcJ1cAyGmCLGGkiThM0paJLWlfAcKTmsubhfFuvzWcON0ANGO4R5m8x
         lgrFuPPD//BeWY4RaEoS1Dbj2AeI0J2Ocv1Tcw9K34VG+CaxVJpNQl7MNV2Px749cZJ+
         +vBfmknG+LxviOrurta+GpJbCuAieX95zTnasK32TXt53FzqpTyw0MdSFubmPil/wPkG
         AiSrLE6QPfYbPlEfRkr6q1N0mkHC+gsD4eOchf9JA3tQ6DaSFcZA8qX9LsUtwlYhnKbO
         RrvA==
X-Gm-Message-State: AOAM530XDR3afXN9stxLruiZg5NTvNzsVNVtlEpiHeO5n4nPdRRKUwGO
        uH1zvvcUzJ6ZlW2+yu+X4j0=
X-Google-Smtp-Source: ABdhPJyyOku7BguihhRDVr/2uQVz3QRhlNTGjiETo2Ny1XHm1wtZufdXrCu7Vy7i491eGogKd7Bkqg==
X-Received: by 2002:a17:907:6e14:b0:6e7:f589:b7b4 with SMTP id sd20-20020a1709076e1400b006e7f589b7b4mr4991013ejc.222.1649184040612;
        Tue, 05 Apr 2022 11:40:40 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id dm11-20020a170907948b00b006cf488e72e3sm5795532ejc.25.2022.04.05.11.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 11:40:40 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, nicolas@ndufresne.ca, hverkuil-cisco@xs4all.nl,
        gregkh@linuxfoundation.org, wens@csie.org, samuel@sholland.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [RFC PATCH 0/8] media: hantro: Add 10-bit support
Date:   Tue, 05 Apr 2022 20:40:38 +0200
Message-ID: <4386971.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <b6987a9a-56af-f63f-b60a-37df141d6e89@collabora.com>
References: <20220227144926.3006585-1-jernej.skrabec@gmail.com> <b6987a9a-56af-f63f-b60a-37df141d6e89@collabora.com>
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

Hi Benjamin!

Dne torek, 05. april 2022 ob 18:07:41 CEST je Benjamin Gaignard napisal(a):
> Le 27/02/2022 =E0 15:49, Jernej Skrabec a =E9crit :
> > First two patches add 10-bit formats to UAPI, third extends filtering
> > mechanism, fourth fixes incorrect assumption, fifth moves register
> > configuration code to proper place, sixth and seventh enable 10-bit
> > VP9 decoding on Allwinner H6 and last increases core frequency on
> > Allwinner H6.
> >=20
> > I'm sending this as RFC to get some comments:
> > 1. format definitions - are fourcc's ok? are comments/descriptions ok?
> > 2. is extended filtering mechanism ok?
> >=20
> > I would also like if these patches are tested on some more HW.
> > Additionally, can someone test tiled P010?
> >=20
> > Please take a look.
>=20
> Hi Jernej,
>=20
> I have create a branch to test this series with VP9 and HEVC:
> https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/tree/10bit_=
imx
> 8m Feel free to pick what I may need in it.
>=20
> That doesn't improve fluster scores, I think more dev are still needed in
> GST before getting something fully functional.
> Anyway I able to select P010 pixel format if the input is a 10bit bitstre=
am.

What kind of improvements do you expect? Actually, this series is designed =
to=20
change nothing for platforms, where 10-bit format is not added into the lis=
t=20
of supported formats. I think reasons are quite obvious. First, not every=20
device may support 10-bit output. Second, as you might already figured it o=
ut,=20
registers in this series are set only for legacy cores. I have no idea, wha=
t=20
needs to be done for newer ones, since I don't have them. Anyway, I tested=
=20
this with fluster and only one additional test passes, because it is the on=
ly=20
one for 10-bit YUV420.

Best regards,
Jernej


