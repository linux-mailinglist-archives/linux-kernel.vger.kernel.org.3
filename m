Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3424F8836
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiDGTik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiDGTi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:38:26 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB152E9134
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 12:35:46 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r13so12983023ejd.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 12:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wB+5pL8Q6kh3phLfe/wl9bW/HyBhBBXGQDI+exqcUH4=;
        b=miUZU1+cai59rQSB0SoyRhIMCeXiMlIU/t3EofOJnChIBd78OGzRYQdlKTCLNATIPV
         BxNu8+ofPHsaqE48mXvnk+6jPCT6LIYSfMexoS8BcckKt2esUOLxGsSJa0lOkWumSBuU
         Y7WLWhGPIt2kyu6X7cqy/0jur7e7zZd6subdoM/RqNf/mnwbVjayRl/HvrzM2tbsKJzD
         FRxKJkAegctXz36lhFsXOMUaAtGvnDyim+6MkHsxp4vokyRKBLIbA5keQBk6Dnr1MDBb
         ti9px+SNuyPjzKmOkNa03CY+DlIx68rfwoBeRwe3j+7IF9gDBT6FIU+nKWJFxrXlM/Bb
         lq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wB+5pL8Q6kh3phLfe/wl9bW/HyBhBBXGQDI+exqcUH4=;
        b=SUSW+uU1bMEHHlN7mPsn11AtHWQDgZ++Y4jbto/zWKO9lui0Q1GDsMlrvWExBBIbqV
         gX0v31KQmihViWz9uImSv35sg88pZKfgowUR+3qttOS6TYI9amrgJ4MJh5iVclWlOI43
         Ck1nzTsBvJ6gWEm2rONuWylQodNHY1EZTqCmVjeg4kthFp2MzKpn85Hr2FFkYgRz9ivq
         dWfMKEmiXeq/WLuwcvr9hKU6WBo3+ZmgSGBx1aaTuu6YI/qYIbw35v+lFUHthzE0zyGx
         SjQxRVM6Hem1Qrzl1Kg1LazSGD/eEyvC8xKW1rHuySIQU7zUJSJa2FFoSfZxJtaurnq5
         USmw==
X-Gm-Message-State: AOAM533JW/iG3AW98nQFlNZW6P1eAfzX8pDQ4X9WgW5NiZVK3ni8UNXe
        sB0/0uhEeY9M0IybQsT0i9ei9st/XLCKkf+5
X-Google-Smtp-Source: ABdhPJxRfXfrSIWn4/qr0nRuf4o2TE2+XC893QWxjZy3p6w3KQnOv0eLC+hpBVra32fzFfvUvTYUtQ==
X-Received: by 2002:a17:907:9711:b0:6e8:4a3e:692c with SMTP id jg17-20020a170907971100b006e84a3e692cmr261934ejc.296.1649359853838;
        Thu, 07 Apr 2022 12:30:53 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id ds5-20020a170907724500b006df8f39dadesm7964617ejc.218.2022.04.07.12.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 12:30:53 -0700 (PDT)
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
Subject: Re: (subset) [PATCH 03/18] ARM: dts: socfpga: align interrupt controller node name with dtschema
Date:   Thu,  7 Apr 2022 21:30:41 +0200
Message-Id: <164935983571.16396.7116611701613809087.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220317115705.450427-2-krzysztof.kozlowski@canonical.com>
References: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com> <20220317115705.450427-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2022 12:56:50 +0100, Krzysztof Kozlowski wrote:
> Fixes dtbs_check warnings like:
> 
>   $nodename:0: 'intc@fffed000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
> 
> 

Applied, thanks!

[03/18] ARM: dts: socfpga: align interrupt controller node name with dtschema
        commit: c9bdd50d2019f78bf4c1f6a79254c27771901023

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
