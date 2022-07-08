Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE0C56C031
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbiGHQwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239477AbiGHQwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:52:35 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDB96EE81;
        Fri,  8 Jul 2022 09:52:34 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u12so38618428eja.8;
        Fri, 08 Jul 2022 09:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8K5Ogw41nMH5eAaVwuRakPZpwEVH+oq2WUfL0plnyXc=;
        b=dWLlQ1yydSoGV/onW98bsgX35+vMSlNMsket/8Fyvc8SrE6hn740hXzGV95JLJA6tA
         k8yWVE+6rzac12IUsPfv6jg2UnIPG9ImaPqwihUwRrqGoGOccgYaYL7evSXCwGlHbdoc
         ObNLwhypzlNCHvPLRgcgcjphwCMjF65xIr9MmeLnTwnbjHLSTohwXEB585pdbdImVOye
         RUU3W+1ZZJjdT1AtHq3SiI2+Zn/QYSqdbElsYsy5VkT4I9wwvz9eLevZsMJkBDAT7FUC
         4sRjWcyJZQl8y2sNT8aeJx5Ql4FKsU9soxSehP5YrCxca/3ymAlRd3CEddmUEXV/6cU1
         Fs4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8K5Ogw41nMH5eAaVwuRakPZpwEVH+oq2WUfL0plnyXc=;
        b=PAZ03XwqUeBdpTXjSqPngF1I0jDIGuv9snpORNQ3jTWrm4ANd6/sF1d8sklMFjxYmY
         tqX7Zmx9jwve8vsnqXv5Jrm0Rzt9BTSFWggX5QPLWBHyls4i6AkkOWB8YD6P+UKZn3iw
         TOK2mW4FOoSm4jCl+K/mMvekuu/hNmb+dfofwV3hiJ2LU+W1WOe4SwCIaENz2FZdENNs
         M//k3No19ZBtFTatJ/vRReRYcBkpOaAMdL1sesGOWc2QTtCTfVI4IwDfSQP8Wmf7bSo0
         ic5JbxvzHAk92Mh3+qV0yK4vFV4rVrXJC2jC49fUeTb9LgJ1Tp9nEt53JkKdsA37iOVV
         VhLA==
X-Gm-Message-State: AJIora8iGbNJ3cZXUhaWLs54yHT5WDW27fQNot34tqxQcVsgm8tKQQrK
        k3PuqhdcUWymoCzz0CIzcwU=
X-Google-Smtp-Source: AGRyM1teGdrjWgVIBtYPOIVjKMgc0MrMFUoul1cut9eS4Urax2mFKBTuoI3djwJtCIBUSKRFquznxw==
X-Received: by 2002:a17:907:16a2:b0:726:abbc:69bf with SMTP id hc34-20020a17090716a200b00726abbc69bfmr4341349ejc.363.1657299153059;
        Fri, 08 Jul 2022 09:52:33 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id y20-20020a170906559400b00722dcb4629bsm20667163ejp.14.2022.07.08.09.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:52:32 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Samuel Holland <samuel@sholland.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: Re: [PATCH v2 3/3] arm64: dts: allwinner: pinephone: Enable internal HMIC bias
Date:   Fri, 08 Jul 2022 18:52:31 +0200
Message-ID: <2758935.Y6S9NjorxK@kista>
In-Reply-To: <13043007.uLZWGnKmhe@jernej-laptop>
References: <20220621035452.60272-1-samuel@sholland.org> <20220621035452.60272-4-samuel@sholland.org> <13043007.uLZWGnKmhe@jernej-laptop>
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

Dne ponedeljek, 27. junij 2022 ob 22:53:05 CEST je Jernej =C5=A0krabec napi=
sal(a):
> Dne torek, 21. junij 2022 ob 05:54:52 CEST je Samuel Holland napisal(a):
> > Revisions 1.0 and 1.1 of the PinePhone mainboard do not have an external
> > resistor connecting HBIAS to MIC2P. Enable the internal resistor to
> > provide the necessary headeset microphone bias.
> >=20
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
>=20
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Applied, thanks!
=20
Best regards,
 Jernej


