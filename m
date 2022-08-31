Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3233C5A7D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiHaMPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiHaMPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:15:18 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83A9BC1E
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:15:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id h5so16384515ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kWB6H8/eRT0uvs+7dpZN0LfgkIKsMbM/vLGI21NZpGM=;
        b=AqpsGQxz0Z5xEtEA2iTVL+MHr93DKFmuEVs5lC21yVoP8sAEtUttoNxOg16xoO8FWT
         iz5fcIJSylAWLoJdbt/iB1BSAvpsnm6J5BdtLWRy18zlaYp9FFyUFHSPby+PN6ZittFK
         Rv78F+ZJ/VU4Z3YIxyXQvP6F7TFAm8EhqeMstDp+b6d40NuB3kvomcK1QKE0tMSHOSTE
         hrVsRkdiXae/rFdkub4hNciY8Xp22pq6x/XBmKVzhIkk5lDO2Cx5w+9jdRem5Ue/3hnO
         Lxjeb5a6QfoyPwnSyew3K3/QEEs4sGEB4j4ypct9IJsNhKWIkE6V3pu2e0sM+WGqFYO/
         XsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kWB6H8/eRT0uvs+7dpZN0LfgkIKsMbM/vLGI21NZpGM=;
        b=PyhyQwYRswq8+knryVadtPy5hZ2fWGkq0BiBedErgala0kL21NZiQLneBc0vBPbgYB
         s8ZEBhhZrZzjj4XG9QKhmSZjEx9U0PaoMzc9NwK/b5z84wuc0Mqoq8Pc8XvHTUOwUQ7B
         ageHAouJrEK82vB3Worts3ppVRkAMGk6FLnGtWroJvqUWkuC3ge3Axni8YL+f+UzfAYs
         eG7lKOJ9Xq7pTB40Jbd+g+taVC5RAqjorPXBNjXihlYG0GnZ5D6C80o437s/1U4ZuqH5
         7imzCKxKf/XBuviHDNI4daCr/qc2bKnX555yBf1pWS6hkUHvxk6p/mfe3SWT0i2+r8ig
         6iXw==
X-Gm-Message-State: ACgBeo3y+vxWyop8OrxT/N5uo85pJEPvTLXENz14ZHpfEFHaSBeuylSl
        LvtSyd6pqv/MGJQqkklCDSIEOV1m+ofsfzDL2d7wDA==
X-Google-Smtp-Source: AA6agR431HKmf0TUg6YlMD0uxoGOijdkT6OeZopqLPwbMGaOIN9VRF8Kz4zNCsyebmooon1v1jTmK62J5TvWsl8ex3g=
X-Received: by 2002:a17:906:cc5a:b0:741:5240:d91a with SMTP id
 mm26-20020a170906cc5a00b007415240d91amr13306282ejb.500.1661948115397; Wed, 31
 Aug 2022 05:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220818101839.28860-1-billy_tsai@aspeedtech.com>
In-Reply-To: <20220818101839.28860-1-billy_tsai@aspeedtech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Aug 2022 14:15:04 +0200
Message-ID: <CACRpkdZSw9Nn8hp+C3SPw4_EkXn0mkLh8tSO5zhGR8xdv=Jk8g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: aspeed: Force to disable the function's signal
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     andrew@aj.id.au, joel@jms.id.au, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 12:18 PM Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> When the driver want to disable the signal of the function, it doesn't
> need to query the state of the mux function's signal on a pin. The
> condition below will miss the disable of the signal:
> Ball | Default | P0 Signal | P0 Expression               | Other
> -----+---------+-----------+-----------------------------+----------
>  E21   GPIOG0    SD2CLK      SCU4B4[16]=1 & SCU450[1]=1    GPIOG0
> -----+---------+-----------+-----------------------------+----------
>  B22   GPIOG1    SD2CMD      SCU4B4[17]=1 & SCU450[1]=1    GPIOG1
> -----+---------+-----------+-----------------------------+----------
> Assume the register status like below:
> SCU4B4[16] == 1 & SCU4B4[17] == 1 & SCU450[1]==1
> After the driver set the Ball E21 to the GPIOG0:
> SCU4B4[16] == 0 & SCU4B4[17] == 1 & SCU450[1]==0
> When the driver want to set the Ball B22 to the GPIOG1, the condition of
> the SD2CMD will be false causing SCU4B4[17] not to be cleared.
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Patch applied!

Yours,
Linus Walleij
