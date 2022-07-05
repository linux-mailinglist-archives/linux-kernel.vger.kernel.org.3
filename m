Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F060B56781B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiGETyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGETyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:54:00 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5B265AB;
        Tue,  5 Jul 2022 12:53:58 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id n8so16704953eda.0;
        Tue, 05 Jul 2022 12:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oXMuNwTXUvJo0+POZWc/5imaFRdw3zoRSiX+En9QOVw=;
        b=aCAO7obABtqBdXKJyThLKOxRy3Gkos3sCS85KBPppcd5OtU6W0mAv8wa3910L4g+wv
         fVzmu9c7Lx8j8FyLigZXQNdR2GQHgxpkhaEKzuYcF0X4V3PODju071tD4JP/R8cA5Rzx
         1w1//jejTVMZPH0Tj8JKWbCQ79VtMdgFKuWY86K7kkCZC6/DZMdfPlz1/b8wzw+9I6gi
         Wy8c9PFMCRb3qBkqpLtc/qt87+Sdz+eRCVxRqrDay6SUsCmLAPmMBtKGiMzFdl7COXLj
         cFeEZpcOIyfO4THHHDc2kD1wA0y2IGoVRMAuFGiD2bTw9Evr8M9iSafyZJ4IDAimmgME
         PAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oXMuNwTXUvJo0+POZWc/5imaFRdw3zoRSiX+En9QOVw=;
        b=dFtGNWj4XAlXsFFyG08KlZp93KBXq3czoxM9fvTdzuF2tr2OLu6smawB45FQt+Xglq
         H4ktEZEJeg8HHP0q5Q6klw3QS69xWeE2vjSCQzQvVs8qwMPjkDYxoZPKfSMG5rIXpcJi
         R1q0+t2iSu3Z5rM+BTxploUze2aNLpJ/dE0G4HnT6qPgFSsPu0MyGMP31pJ5QawChRYQ
         fku6kVV0OIZBq/ugCfvEIeHQf8QYHQ/L3foM9+2/1GYP3GTy3baAAmJZIZ2DnI2Hmi95
         qDULC7Z2GvHLc94aVjRupD3QUchfv6FjTTq/0GokQeZQB659mZmHV2YLP5TvFkt2SlLF
         VXZQ==
X-Gm-Message-State: AJIora91QiMy4tm7wWcbs1H+pdR515YGleNe28Q1ARF/AC890Vnhq2wX
        +SYn2CQ/29jkf64NWPVzjkA=
X-Google-Smtp-Source: AGRyM1tkSzZ6D5ILvqab8zXo3yg+wHUqQ7K5bD/agyl++p9ronNEmGXjzgYTHCP0hrx20V7g2KJ6Cw==
X-Received: by 2002:a05:6402:228f:b0:43a:896:e4f0 with SMTP id cw15-20020a056402228f00b0043a0896e4f0mr23879935edb.81.1657050837497;
        Tue, 05 Jul 2022 12:53:57 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id a18-20020a50ff12000000b0043789187c1esm18863714edu.80.2022.07.05.12.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 12:53:57 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-usb@vger.kernel.org
Subject: Re: Re: [PATCH 0/3] dt-bindings: usb: Document Allwinner D1 compatibles
Date:   Tue, 05 Jul 2022 21:53:55 +0200
Message-ID: <1688790.QkHrqEjB74@kista>
In-Reply-To: <44784082.fMDQidcC6G@kista>
References: <20220702195249.54160-1-samuel@sholland.org> <44784082.fMDQidcC6G@kista>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 04. julij 2022 ob 22:35:24 CEST je Jernej =C5=A0krabec napi=
sal(a):
> Dne sobota, 02. julij 2022 ob 21:52:46 CEST je Samuel Holland napisal(a):
> > These patches document the compatible strings for the USB controllers in
> > the Allwinner D1 SoC, which require no special driver support.
> >=20
> > Samuel Holland (3):
> >   dt-bindings: usb: sunxi-musb: Add Allwinner D1 compatible
> >   dt-bindings: usb: generic-ehci: Add Allwinner D1 compatible
> >   dt-bindings: usb: generic-ohci: Add Allwinner D1 compatible
>=20
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Applied all three, thanks!
=20
Best regards,
Jernej
=20
> >  .../devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml        | 1 +
> >  Documentation/devicetree/bindings/usb/generic-ehci.yaml          | 1 +
> >  Documentation/devicetree/bindings/usb/generic-ohci.yaml          | 1 +
> >  3 files changed, 3 insertions(+)
> >=20
> > --
> > 2.35.1


