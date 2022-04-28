Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDC4513EB4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353039AbiD1WxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbiD1WxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:53:08 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1251EC1C87
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:49:53 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id w187so11624468ybe.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4y/h2CdaCT5aLcDGH4vyOwMEkajTPv3gIH/CP9hJ7RA=;
        b=zf0mXXTka8NgKEFkBHSJ/qfYmus5/JFJZILWQI1MilIp9S9gi0aQG4qJtwmC4PxuNO
         RSYQMGBFZpxLRocrDGZyJPKpZNDphWcnBj53tOuqOuGeRPirZgNm7F8rPOqCqtQzmLdx
         GaRODpmnNmyCk+M+xuaweNEeOK7dTTwVQdRGyoG4TgIYRP7Zq+EUx0IUUjdxHzuDNXTO
         lWcLeJyZ5yHgxTW+OLrSpG7B57WiYdo+Av7nQUcy7E636Ziu8Bm+Q3bLop4Zl6FkaEUv
         uzBgPzLVLRRwHCCZlDPqYou6rERZyuDVyyB9FFq0UjQcplmLwodBNRB4ZJkSqoIxQ0G5
         Z9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4y/h2CdaCT5aLcDGH4vyOwMEkajTPv3gIH/CP9hJ7RA=;
        b=hvgTjtxfQXd4+yRmbr8KOlgliJigj174RPyW7JFl7pU2sRDZnY9BSy0u0x/q6ASAMe
         kMftuwqNolLJ+NQuii3bWjvXCsqMngRcahOX3SRYDlp0HnI/3LAS0aJPtsZPhc7H79I6
         k71u8b7TgWmtnQ7XhU15jdcconm7OprA/0RTi9iwVM6oabTmS+NARSXWIVvbj3zYsiEi
         UCikkANhtEIq9+7bbsCjhEMEo1X1V9r07yJtPr6zSyJWB49EdBPO67/hm/pESB8hCXW0
         Yziw9hr7NpMpR/WNA0wAoFQ8g8fG0p6/XDeqIx3nkBhjIXuuy3MIoD/KRfS9vsKH7X8S
         66+A==
X-Gm-Message-State: AOAM5338dQGgdFb6KjYrfdDebbGaXVpejX4jrI8jSC4bv8MsRrEgjwWT
        gTD14+OXRPu39CVy36woLnvn6fU1NlNlugEKl56gIg==
X-Google-Smtp-Source: ABdhPJzqCCPSOEN3jFOUYTqgtVwOHJNyh29726bF/LKrEzWJCg+CybXlzXS2RFlHdIdfZ3PbxqUrieuD6UWUK9NlNZM=
X-Received: by 2002:a5b:dc5:0:b0:624:f16d:7069 with SMTP id
 t5-20020a5b0dc5000000b00624f16d7069mr33306209ybr.295.1651186190787; Thu, 28
 Apr 2022 15:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220422105339.78810-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422105339.78810-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Apr 2022 00:49:39 +0200
Message-ID: <CACRpkdbKYYfeVnLBU3o1E6KJAy8gpg70aCxMcEb1SGGdG1Rfkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: mvebu: Fix irq_of_parse_and_map() return value
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 12:53 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The irq_of_parse_and_map() returns 0 on failure, not a negative ERRNO.
>
> Fixes: 2f227605394b ("pinctrl: armada-37xx: Add irqchip support")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied!

Yours,
Linus Walleij
