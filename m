Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0CB5925FD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 20:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiHNSdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 14:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNSdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 14:33:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAC2186D0;
        Sun, 14 Aug 2022 11:33:02 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id e13so7160987edj.12;
        Sun, 14 Aug 2022 11:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=zaD0QsHlBYtf4Ki9lXXQFpBLOd/Qqq44+HllUIDIkU0=;
        b=oCiFQIT1Wesz8V7dSxhqQbEwbmJR+fK2wVw0hctE+UEAryjXq/+gO/cSLwToXPio0x
         jlEXAHEhuOb4SqTxleUL9VUJvMdTvR8N7ubImSbDPNVzJl+/OhhVkNS8YODSqZ5OVv1g
         9OSOdVcufKjvFLnEkbj1eb9eNHpfFEb1y1zDl3/nMAmUN7GBDw/cNcibI5Vvxxy/6C0L
         1VOn0KkuHe2Bq0if6AcS93RMbOYPGWP/5XKaDe1p/Kj8yXjqVLZJtIDjAHNwxiZFAZYw
         RrK1Wro9aYjybAowQqlp6nqXJUCoVBdCobybcKBzeNRoXOmSyuGG9ivbOYqxeRyZVtbr
         NguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zaD0QsHlBYtf4Ki9lXXQFpBLOd/Qqq44+HllUIDIkU0=;
        b=Iz8/yyKGVmvpUBttzSW/DjMVuC+ig4xeU9xUxbflbQ0RsXrdyfXl2KJZqH3fKy4f4Z
         AnBafu2ePwPU8XYW2+fyNXktzri641pIzHS9MI7/1evM7hYnjH0YH/0cOQd25f1E/8vy
         PS6Y12Q+O1w1/c/6GIgVm11D6s51P6ZpATi+HcpEsHm6GJx5Zg0Rq5kFCQ1U2gp/AooT
         +uRWuUohy6dODKvec0TJR5c+Dd58yQ75SCI6mnQVVHoSpysWoTS1YBEQpf3AkqKbdd1v
         oO96Fdm9H9FbT6Q5yTqfrlFgLxDUDOROZp8Kj7ODL4ziR7HJsRq7Y+ExaPoOTIXvzZTy
         vR5Q==
X-Gm-Message-State: ACgBeo3hh+x09czSXtS0S0JtJXCCMQmbTcwkZnKfjUhEEFlj3FcGMYiG
        YBMW9mYIap5/FwL0WbJPMtw=
X-Google-Smtp-Source: AA6agR4FTYkP7bDcMcKlD4vH5lBr7LzdSZfS1wAeR+eLXj3Wi3XFrs97S7PTb85MzYLV6lEkkZw/Vw==
X-Received: by 2002:a05:6402:4301:b0:43e:4d31:6ec0 with SMTP id m1-20020a056402430100b0043e4d316ec0mr11827309edc.69.1660501980722;
        Sun, 14 Aug 2022 11:33:00 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id e12-20020a056402088c00b0043a43fcde13sm5155615edy.13.2022.08.14.11.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 11:33:00 -0700 (PDT)
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
Subject: Re: [PATCH 8/9] soc: sunxi: sram: Export the LDO control register
Date:   Sun, 14 Aug 2022 20:32:59 +0200
Message-ID: <110700941.nniJfEyVGO@jernej-laptop>
In-Reply-To: <20220801030509.21966-9-samuel@sholland.org>
References: <20220801030509.21966-1-samuel@sholland.org> <20220801030509.21966-9-samuel@sholland.org>
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

Dne ponedeljek, 01. avgust 2022 ob 05:05:08 CEST je Samuel Holland napisal(a):
> Some newer Allwinner SoCs contain internal LDOs managed by a register in
> the system control MMIO space. Export this from the regmap in addtion to
> the EMAC register.
> 
> Use generic names now that the regmap is no longer EMAC-specific.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


