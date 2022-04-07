Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830FC4F8835
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiDGTif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiDGTi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:38:26 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8B32E9121
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 12:35:46 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l26so13001734ejx.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 12:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lyQlFSOypZUQvhyjs80bnzIhMNmzLPVPUoFxjVcMTGY=;
        b=jP5ULFv9DKY/jZA4Xzs0MaOR7a6irPvM/bLq2GmEoU2oaWufXLh3Ef22ekYD8wbysa
         EMTUVkWP5DSd3LslZ0uEaOVljcio1a0QBqqZHg00c75/5sml6FTM6EIMbCCDdE97wGjc
         BTHlx6LtTrqwrnn3McTD8OB+v2DC07eUL0EfZX5vovliTvjrvYhX05CyFToNAI4wESrf
         nehdUATF1qX7ZWMj5a56SbiGEU2vzFX0+tIkpEoCSZmV3+hU6ybXfqSDGJyo8uQplNQu
         PIwAyXod9sZClepxA7so5gq7xBlsOTR2HFSp78a2cxValZcbx+xDC8XdH1X+uTL4VTAC
         ixUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lyQlFSOypZUQvhyjs80bnzIhMNmzLPVPUoFxjVcMTGY=;
        b=rXktjsAKnOFRPCFHfrhMIIRb5YeCCj9hEHAaSySJHOSJYJCp4EpJZV0wDllKiFy8hG
         GOoJyt+7CnAunMwfmk9QysaWfptwNbHP81ZuB8AWN7yjw+Wrqg7j9jvCJ6fpT36oeMT4
         qP9o4KOsagWaPZ4AhlIejht38iuQfj6xrceDGOaSRgs3DMJhOlbQPSzj3YQGyQhxT8sZ
         LqOB0tba1IDJ7uTLNCZJ1ltPTdyVY13KisBtJ3kLT3b+0Rk4QvVAsqsCHy0jV08pXuVJ
         Xzp9AqekDotCct8pnaquyVLCNMg3Icpsi70oq2TXplwrD5KHS9I7c3pqkpf2IAKKTRzr
         uMBA==
X-Gm-Message-State: AOAM532ggCaNGCarZtfhWQGlmM2EVQP2LHGX4h8yah9DAHQKG87pigou
        e33V3HBaUMzuirud2tc0Oh8DJ0VjlgCrJFwV
X-Google-Smtp-Source: ABdhPJwmJnrqHLOom4NXtOrRUV3yDj9N0fTsVQlWFRls8HxRKNW9+x6qkHUzEBcEia+/3FLvEfmUiA==
X-Received: by 2002:a17:907:7286:b0:6df:f778:2585 with SMTP id dt6-20020a170907728600b006dff7782585mr14323981ejc.244.1649359851783;
        Thu, 07 Apr 2022 12:30:51 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id ds5-20020a170907724500b006df8f39dadesm7964617ejc.218.2022.04.07.12.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 12:30:51 -0700 (PDT)
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
Subject: Re: (subset) [PATCH 02/18] ARM: dts: ox820: align interrupt controller node name with dtschema
Date:   Thu,  7 Apr 2022 21:30:40 +0200
Message-Id: <164935983571.16396.7515463979118376133.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220317115705.450427-1-krzysztof.kozlowski@canonical.com>
References: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com> <20220317115705.450427-1-krzysztof.kozlowski@canonical.com>
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

On Thu, 17 Mar 2022 12:56:49 +0100, Krzysztof Kozlowski wrote:
> Fixes dtbs_check warnings like:
> 
>   gic@1000: $nodename:0: 'gic@1000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
> 
> 

Applied, thanks!

[02/18] ARM: dts: ox820: align interrupt controller node name with dtschema
        commit: fbcd5ad7a419ad40644a0bb8b4152bc660172d8a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
