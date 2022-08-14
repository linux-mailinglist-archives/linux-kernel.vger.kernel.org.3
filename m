Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B08591F87
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 12:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiHNKVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 06:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiHNKVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 06:21:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A4E22BF5;
        Sun, 14 Aug 2022 03:21:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gk3so9057928ejb.8;
        Sun, 14 Aug 2022 03:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=NgLSVABhBcWdug9UrtD9+LNXeaw8h4QX1AgubMiZPaE=;
        b=EWvXkmaUv98OEwpQ4/IYmrswQI0ewNc7UtMSIuYn7fJHsAM62v+gfIu/BTKPAVTH1B
         pQTRJZQv1BNl8pixFn+wZTIHhHoqpcmYv6cDoko00mjKMdziHvqpzvIrriE+j85mNz6l
         s8S1bnbJ6jIGOucu2dAE2VPK0XTHPOCFA4mjuzfJ8JCtIAUWRmYzP/T17Qn4G+5rVCWx
         O/jxBkup/cUM/qCQsuyA1Uk18oBlV+V0xGbArxcE+nl7Bi6L3tzBzMCzoHiy27ngq2le
         VbSAlwRMnQiXV0gO1fxLwLwUbfhMGZWygn1Ad+EpxitARvigcros1fJ+HWjCeb3ekbLu
         vgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NgLSVABhBcWdug9UrtD9+LNXeaw8h4QX1AgubMiZPaE=;
        b=Q5mhTQLbjirrM1O7umtSTmn8C4ZUDANLosaUmv22aoCSupotv4DZg/5K7rZw4x5FRL
         a+Hcb5bLFJ1YryzYL2kZaxwcE9WQJTti9KLLNOFAxZh+hK7emVyyofB6PQ7HtnGb0uNR
         bFkEMd/Kd5eDxEbA2d8eB52bYZDe4YqbXFyyjrWmeQdpYWcr0y9RKqTafMEX+U0Gf32j
         5/VvL+hr4pDL0ZKE6YJVKyH6wbUsRg9LlD7tXetH3xQ7dlfM2mxXezLfSQF7CbeZVFeq
         YXYQDWJGAzTj9yDHioaUM657z8avfaFukZ2p7BMpmWN41Kx8TnRREowgwFIqfz+PSZNH
         CggQ==
X-Gm-Message-State: ACgBeo2BpJN2vFerdPwgeyXWNy26NxedMcNDBcv9ySp/LSXp3eDvRt3L
        i4RcYuxwLz8OCszGyzQxfCo=
X-Google-Smtp-Source: AA6agR41uSYgu6jwgwi4GNbOiiHGpeVDJUS+R3XUJ+D/AlJZSWhM9JJEsC2Abiy5Ip6gc0dNsSdgCA==
X-Received: by 2002:a17:906:fe45:b0:734:ca71:9672 with SMTP id wz5-20020a170906fe4500b00734ca719672mr7419035ejb.446.1660472492615;
        Sun, 14 Aug 2022 03:21:32 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id jl4-20020a17090775c400b00734a9503bcasm2788909ejc.135.2022.08.14.03.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 03:21:32 -0700 (PDT)
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
Subject: Re: [PATCH 2/9] soc: sunxi: sram: Actually claim SRAM regions
Date:   Sun, 14 Aug 2022 12:21:31 +0200
Message-ID: <3368908.QJadu78ljV@jernej-laptop>
In-Reply-To: <20220801030509.21966-3-samuel@sholland.org>
References: <20220801030509.21966-1-samuel@sholland.org> <20220801030509.21966-3-samuel@sholland.org>
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

Dne ponedeljek, 01. avgust 2022 ob 05:05:02 CEST je Samuel Holland napisal(a):
> sunxi_sram_claim() checks the sram_desc->claimed flag before updating
> the register, with the intent that only one device can claim a region.
> However, this was ineffective because the flag was never set.
> 
> Fixes: 4af34b572a85 ("drivers: soc: sunxi: Introduce SoC driver to map
> SRAMs") Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


