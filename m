Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4955A1280
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241402AbiHYNkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240817AbiHYNkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:40:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBA4AE5D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:40:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r4so26143896edi.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=C3elOk/LV3mnV2ehruMejhTIIEkQ+o9YVKjS0Rdu5gY=;
        b=KxoHAR5Gnx7WnM53USU+UWe+NsORBkYmqzRsUncx3r7cO7fjjBh/HRqs/K8EVAd6l1
         IxIxV5P1dQt4NICnaEJNKMhprjTNQc9Y2Ph8LJfMco2J8nodI582ZtRYcmXtNbl7bme9
         lzS17HGWOfFnn4u7hTC7W6B4dWQs4STFGudQWy0lI6sSx46wGX7Dsw9acQ2+d4cLfYBZ
         jXFkPkkppC+AxMnUAgRqfBBuHvEJ0xN6DUW7w07g5/FEUohayOPvQR03No7z9lJB78lQ
         riU8pcammoIQgmwJ1nwGuJpE+rU/8RFPQu+de3jgvNf00R9ORAWOpKz1To2x9bQvSsny
         GkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=C3elOk/LV3mnV2ehruMejhTIIEkQ+o9YVKjS0Rdu5gY=;
        b=I5imVysJeW23LETCfBsCIgDZ/KEVCBMVsR+HNJ7AKlLTUcQ/JTIapm7lWJ+Nv/Esom
         yLlc574Prf8zmFgYdAc6k8+dNGOmBuAVJDvBDJiC/5oyiL4F958KbdrX0B6eXawQgfNt
         pvvNwqyjFbvWCtOa6hG8c9EkjrxQ233Rni3Hp1hAz/xlPO+yAGJJbtTnY6V5ETQ+rEfp
         dL2oq5r9hISxYlKiTA068V0FbCwfaIniejdITWxm9OK6jTBOY2BRXo6CZAvgh8qlB6Tn
         O16e4X8rmzOzMwmgmBUE3GfFZM1gaRw+9kseISgA+wxeaRUowRHRGminj9IIi33pIUhU
         /Xjw==
X-Gm-Message-State: ACgBeo0FJLAvBg0AFwzaT6GSQMFqragYccbdG8a7C0n61a1wCqwHS3om
        tw4SIk+f7GO3AaQE4Z8r1efeLkCsnXIK26Jq2sSgUQ==
X-Google-Smtp-Source: AA6agR43gxImzSfY1ti7ho1ZHcUy3o57rrqq5Jay0sPfgAmtytCI6sCMZQ0L885wu9pZ8Zvuqk9VoPa/tutbIdm9gC0=
X-Received: by 2002:a05:6402:4517:b0:443:7fe1:2d60 with SMTP id
 ez23-20020a056402451700b004437fe12d60mr3301565edb.133.1661434813903; Thu, 25
 Aug 2022 06:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220818135522.3143514-1-arnd@kernel.org> <20220818135737.3143895-1-arnd@kernel.org>
In-Reply-To: <20220818135737.3143895-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Aug 2022 15:40:02 +0200
Message-ID: <CACRpkda+sV+Hh+aTUj7FCtJgoXEn7eweMj6gyNJ7CdMwbwwM_A@mail.gmail.com>
Subject: Re: [PATCH 02/11] ARM: defconfig: clean up multi_v4t and multi_v5 configs
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 3:57 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Integrator now selects the regulators and versatile selects the
> reset driver, so the correspondig options can be dropped from
> the defconfig files.
>
> Fixes: d2854bbe5f5c ("ARM: integrator: Add some Kconfig selections")
> Fixes: 1c6e288da6cc ("ARM: versatile: move restart to the device tree")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
