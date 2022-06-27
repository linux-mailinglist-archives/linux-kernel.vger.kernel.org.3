Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A0655E135
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbiF0JRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiF0JQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:16:29 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1176A60F7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:16:28 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id fd6so12045348edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Qsr1FlLpUE+oTnmXUwcy6BnE1qyFeqIPJCLey9SG+As=;
        b=C8ZIE3MDLv6pruuNUtXJZPSAmjy6YTA2c5G+UUd1/MGqU3aHlmuEi/9RP0p7u8UO8M
         pKiy48pA/+TIXwaOAKdUQ5VYZ4a4rYxIunZZ3OCKDUef6CvSP9kzjaLKw5hOxXYYqAET
         SCNyjqxGRqtmKcL0Xo/t/ctqEG11KRKziTckkfwPBBTki/rEBWh/eU6M8NCPHxbh0XB7
         TJq6ZI9KX3Vyy8pGSF3rro5FFPVAsXam0Qrz8R8+kj0r/86anur5Ku/Brrq6+DKEWmG2
         xikm9rkXWAAY8QJKobLGgucftI0mrb91izBGxPiR3vW64b/QVP1PN4P8EaH53Dt9zhZK
         /VJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qsr1FlLpUE+oTnmXUwcy6BnE1qyFeqIPJCLey9SG+As=;
        b=Z14ybaJwujW/YkbbrjV/Ia/nCwhi+tLNmTC746/wkfj05pWLsyiJMWB1ctfi7Q23rB
         fIJWyyW3phe85HC+41IcF+Dd/Ifz+Y9JNgUqwcOYFHmuPmW04TFOnUjePgbeVES4ynkT
         v9Jxg/Vyd7AdjzFNvmfjRuPx+sgEXu47kZ9BOw9BEXPx1XUDZJ8SF34fPUIW2asn9Mj9
         YyypYyyQhGne4rjrLb0jMplwxkQFv3aFNLWLCyCjjAGY1DBfeNdn58W4H1qzxAbcYJAo
         cSl+SV62WUgnMwJHxkR8NT6KLO3SuRBDTqh6sarvw96IBLUivjvoMdzJakmAV1ZKOqx+
         vgmg==
X-Gm-Message-State: AJIora+0EsjZCi0hB/s5/QjnezctHmXXWsaGFaHC7Sdc5zNVp4pVQuSC
        dlJNZRHx7+pNbWqkuu45+hnB/g==
X-Google-Smtp-Source: AGRyM1vf3++B9U/STCuaVWvJvJ1tUX93/d4AkESqtHqEG21q6AG3lq7KBBh477coeyvaRta7SekIrw==
X-Received: by 2002:a05:6402:34d2:b0:435:9d8f:3328 with SMTP id w18-20020a05640234d200b004359d8f3328mr14916816edc.88.1656321386675;
        Mon, 27 Jun 2022 02:16:26 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gy10-20020a170906f24a00b006f3ef214e2csm4805395ejb.146.2022.06.27.02.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:16:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        arm@kernel.org, alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        olof@lixom.net
Subject: Re: (subset) [PATCH v3 39/40] ARM: dts: at91: correct gpio-keys properties
Date:   Mon, 27 Jun 2022 11:15:59 +0200
Message-Id: <165632135506.81841.11437380975129537903.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005333.18491-39-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org> <20220616005333.18491-39-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 17:53:32 -0700, Krzysztof Kozlowski wrote:
> gpio-keys children do not use unit addresses.
> 
> 

Applied, thanks!

[39/40] ARM: dts: at91: correct gpio-keys properties
        https://git.kernel.org/krzk/linux/c/fa8cc83a3bffaa868b789a424d5573b7901edd7c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
