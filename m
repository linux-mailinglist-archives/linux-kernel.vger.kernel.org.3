Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF6754BBCC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243951AbiFNU3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiFNU3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:29:04 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B308F24BEB;
        Tue, 14 Jun 2022 13:29:03 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id h23so19327718ejj.12;
        Tue, 14 Jun 2022 13:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6vo5ChNd9bkGZCbil2zL+tyn6URWu9ehHcF9fcX0yBw=;
        b=GF5aqrG6+jO62KEf5kyJY6HiXbGBaETgNAiygw076aURoVfHfYn38EKb05/kUjm0NR
         xeJ5zImPDgo7yV9SHaAA7MQHEAZpmWM/TyijVmRnTfHoj2GIsQVqtrxaZmJqBRg99KaI
         TIrnhtNgQrwJl1o5/AbL6Ur/ML34SOjx9iMd7NrMAnEVgz8wcPJ5Ag7scAHMHKSABykY
         2IHOuvzd9ZBwMUIjIkQegQ9dzH54zcekWPMbp1Jk4M+YkZJyTZvMW+nPFpYKtYIGKayZ
         XZpP9ERjH4BDLr1lgzKHdq4McSM0vBrwHPTFOjC4CJA+0sCeCT4KaMy5Lgzti0Ekya+k
         SJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6vo5ChNd9bkGZCbil2zL+tyn6URWu9ehHcF9fcX0yBw=;
        b=oloogd94Cm+FqI6GJVytC53xuskjAuTqaJ8X6k1fb5bIdBfubFLZoTCoI31TMXgPv0
         m3bRFg2N1z7/Zaj3WNJTfiwUBhokNhea3F7iys7eFGR2XJ5nUBkXGcqIQ/DA0WN27p8H
         IKyM4KcHgxk92phVytGizgl6Ylq0+3InzLqrGcpz375CO6ALsuIS3LLWFNI9J7hMKFJk
         Vtca3ag4MfEzHQ1bnyAUQyajIHorBhItMnsfim7nBzXVAU+88bDNIb4RPwQs5xIHKxPW
         /739vTgXH4OZ3n+Dt+B9q2q8ofq8zCURWLhdV+2Xhq3yK/63mtkftunvy7J7KtE/il63
         4t0w==
X-Gm-Message-State: AOAM532pF5Jj9vPH728WUxxUoTVq7R+X2W+2zJVjgJA2vNzzBLEX/Pj5
        fwxQDwCBmd+JGjTLqb76lno=
X-Google-Smtp-Source: AGRyM1uBU1KCDF7xHMhWGVWcFkxuu2ljGCZQBrr9mJ2TRsZvMkGcbgRdTjujq3Suu7GDx3XkIUzwgw==
X-Received: by 2002:a17:907:9715:b0:711:ca06:ca50 with SMTP id jg21-20020a170907971500b00711ca06ca50mr5968019ejc.192.1655238542217;
        Tue, 14 Jun 2022 13:29:02 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id k24-20020a1709062a5800b006f3ef214dcdsm5448604eje.51.2022.06.14.13.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 13:29:01 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: Re: [PATCH v2 06/48] ARM: dts: allwinner: align gpio-key node names with dtschema
Date:   Tue, 14 Jun 2022 22:29:00 +0200
Message-ID: <2184827.iZASKD2KPV@kista>
In-Reply-To: <4743697.31r3eYUQgx@kista>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org> <20220609113911.380368-5-krzysztof.kozlowski@linaro.org> <4743697.31r3eYUQgx@kista>
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

Dne ponedeljek, 13. junij 2022 ob 23:02:22 CEST je Jernej =C5=A0krabec napi=
sal(a):
> Dne =C4=8Detrtek, 09. junij 2022 ob 13:39:08 CEST je Krzysztof Kozlowski=
=20
> napisal(a):
> > The node names should be generic and DT schema expects certain pattern
> > (e.g. with key/button/switch).
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Applied, thanks!
=20
Best regards,
Jernej



