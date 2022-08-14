Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00004591F8F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 12:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiHNKeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 06:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiHNKeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 06:34:13 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380ED5598;
        Sun, 14 Aug 2022 03:34:12 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kb8so9113990ejc.4;
        Sun, 14 Aug 2022 03:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=wzo/x007uCa6HXfMQAlfCGpeZPzzBdlngiaw5dHiDKo=;
        b=TRjw2/aFGxFEPk773kgZUbxVW7yh9qhMpDpQo3Y796X6EV/1Ec/ZY05nU90L3Cpt/A
         f1aqu+MMBpw80UIDHv6fghQCmkf75jcR/WU1g90lMwxo1xeAtlbpgotJ4YTuNKsr4Lfx
         s/LcbiMvKF74XhX6E9ZVKolfX5GQRnEmzf5OuN7/33R3Dt6Et8on9JXVb9G8RqpqZyzC
         ZsUegrj1hPQa2YARtOSh+ZxWGtnROHrkfLThuFaRzuI/3j+2waMRAA9gKW3jHivF5xRs
         nDsX6+rJ9vewzZETDFmhN2DYEzYK4lbZeaqEy675YWz0HdkANyrKQpF9FrgSFw04f+pV
         rtcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=wzo/x007uCa6HXfMQAlfCGpeZPzzBdlngiaw5dHiDKo=;
        b=z3iIny2uEawkpimqs94NvRpWtwtci4VgoGD+yBbZ1LLgSRTxk6sb3RzDwabUVEqfH6
         R0oW0606B16f+yRRA36rOxod8PzjNvGnU2DLprMezjrW6q3uW7RsT+d5P5w196e+Waj8
         SFpSD9bNP0zkamSD22Wc/CHmROTav4V2tkbA4TegS2qA8SN6DX6lm3Jc0qlErh9FQudC
         kLJj5t40NYLrR0TCmKea5nCG8M9L3FeSeKFttGlciIbBr1oivEtTlDi0mIpPVXbK5Hhy
         0KW5p8ZEDGVVwAzyANj960Ok8Y/v4blwTd+xgi2r5JKOqCR4SWmdben5Tt1aPBfjHKNu
         7udA==
X-Gm-Message-State: ACgBeo1D7zOiv1xczR55H9L4u9r1nr7NEjAS4+rb9SctgVP8kolbmYor
        B+0Am8TkLBM8gkDeca4i7Xg=
X-Google-Smtp-Source: AA6agR68vjtEeSmB4p3tGG238cu9MyJhZ+D4gcaOReUeNSdAs6XkWbWsaUH4Xda/O4ruBuUwqT21Rg==
X-Received: by 2002:a17:907:288a:b0:730:996d:c605 with SMTP id em10-20020a170907288a00b00730996dc605mr7191809ejc.682.1660473250865;
        Sun, 14 Aug 2022 03:34:10 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id n11-20020a17090695cb00b0072f9dc2c246sm2764897ejy.133.2022.08.14.03.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 03:34:10 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 4/9] soc: sunxi: sram: Fix probe function ordering issues
Date:   Sun, 14 Aug 2022 12:34:09 +0200
Message-ID: <4204539.ejJDZkT8p0@jernej-laptop>
In-Reply-To: <20220801030509.21966-5-samuel@sholland.org>
References: <20220801030509.21966-1-samuel@sholland.org> <20220801030509.21966-5-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 01. avgust 2022 ob 05:05:04 CEST je Samuel Holland napisal(a):
> Errors from debugfs are intended to be non-fatal, and should not prevent
> the driver from probing.
> 
> Since debugfs file creation is treated as infallible, move it below the
> parts of the probe function that can fail. This prevents an error
> elsewhere in the probe function from causing the file to leak. Do the
> same for the call to of_platform_populate().
> 
> Finally, checkpatch suggests an octal literal for the file permissions.
> 
> Fixes: 4af34b572a85 ("drivers: soc: sunxi: Introduce SoC driver to map
> SRAMs") Fixes: 5828729bebbb ("soc: sunxi: export a regmap for EMAC clock
> reg on A64") Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


