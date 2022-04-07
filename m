Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673F84F8832
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiDGTi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiDGTiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:38:24 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6268F2E9101
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 12:35:45 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b24so7576664edu.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 12:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rNwKqGxuMSmu4ITdMt4hiQ6a/iL0Wffb/UMWAJM9vH0=;
        b=hsmvyBbxXvdx21ikiwmuVndGz4VB9w7Tp8QBKQn+4CNqn/NDD64qxOegLGjhBwUvk3
         1E+8EUa5A2Auwb3N3Llk4fxWapEcn3LN0wxkTDB1P9oj27ObGxdhFs1Fmom5yEAvf4+0
         Sv0kaRJ/+TffnA0DPFpUTnFmRLwCPyKQvOmGmGM9rnwe+GURB2bz0ghQGZSfxK3QHZrk
         NqAUOD/MDWWFbu4ci+xw0dluP9fgDaVkoG0pVyFmoRAvxyYTBdu00RdXAJ/pAqd4S6aR
         fozXIq5Ahdtd4zb8ETOFZSYh6dMmR0zl7kVWfhmWN1TufP0wK2yDZGelYLssdjZzPHsr
         edfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rNwKqGxuMSmu4ITdMt4hiQ6a/iL0Wffb/UMWAJM9vH0=;
        b=CUjawfDTOJcMRhK59TvWeNVr88dsBc/bzRwN7hEKItq6YGZawip7ALQ2So/uiXIKw8
         wNwxTZCNXvg5TRTQHr6ZQK0wbQPFUs5PAdU1qeut/paKn11tjoOcsUtFsRK+ySphHY39
         d+nwt65F/knW2bFwgHGvGulrUVTH1OOXiLIFCaJzpqDEyvdjNAyXy23ZzwXp7prVyiP3
         BxY5uGPm9oq2vxixDHAS+msdz1qBMXJAUgws6CuJ9wN55Flnj0kH4d0vvjroTRm7Czm1
         0xIW3GK9VH2z9PJ2PvlXIhGVyD8RRB0mi4kRehikXv/mtnhDvguJ4t1xQhe3mCXXqs/T
         1NcQ==
X-Gm-Message-State: AOAM532r+cY/EjaWopHLW4Wu3VTC0i7siNqBFdTUrZ4X/vSqNlJj14p2
        siM4zm1oLZ5uDc6lkKLZwYlNrL569jIfl+2z
X-Google-Smtp-Source: ABdhPJx538vA9HnshG5J/vO6w3P62mH/HcbQXvcsr2oa0UiljWyZJm8pcZNCtCmIOY/cboHmSFz0hA==
X-Received: by 2002:a50:c3c6:0:b0:416:293f:1f42 with SMTP id i6-20020a50c3c6000000b00416293f1f42mr15809234edf.187.1649359849767;
        Thu, 07 Apr 2022 12:30:49 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id ds5-20020a170907724500b006df8f39dadesm7964617ejc.218.2022.04.07.12.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 12:30:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        John Crispin <john@phrozen.org>,
        Tero Kristo <kristo@kernel.org>,
        Daniel Palmer <daniel@thingy.jp>,
        linux-riscv@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Paul Burton <paulburton@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Bert Vermeulen <bert@biot.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Nishanth Menon <nm@ti.com>, linux-oxnas@groups.io,
        Linus Walleij <linusw@kernel.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Walle <michael@walle.cc>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Suman Anna <s-anna@ti.com>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        openbmc@lists.ozlabs.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 01/18] ARM: dts: nspire: use lower case hex addresses in node unit addresses
Date:   Thu,  7 Apr 2022 21:30:39 +0200
Message-Id: <164935983571.16396.11670729285639659849.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220317115542.450032-2-krzysztof.kozlowski@canonical.com>
References: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com> <20220317115542.450032-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2022 12:55:25 +0100, Krzysztof Kozlowski wrote:
> Convert all hex addresses in node unit addresses to lower case to fix
> dt_binding_check and dtc W=1 warnings.
> 
> Conversion was done using sed:
> 
>   $ sed -e 's/@\([a-zA-Z0-9_-]*\) {/@\L\1 {/' -i arch/arm/boot/dts/nspire*
>   $ sed -e 's/<0x\([a-zA-Z0-9_-]*\) /<0x\L\1 /g' -i arch/arm/boot/dts/nspire*
> 
> [...]

Applied, thanks!

[01/18] ARM: dts: nspire: use lower case hex addresses in node unit addresses
        commit: fa04ccac619085332563fb433ffc4ecc8ba5489e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
