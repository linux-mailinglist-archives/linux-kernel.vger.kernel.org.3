Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3DF55E869
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347327AbiF1ODR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347288AbiF1ODP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:03:15 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69F61EAE8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:03:14 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-317741c86fdso118164467b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zqNkJzAQzs28Q1o/gRe5m9k79AWr8i1R4AXoynI12dE=;
        b=zW0BdLuu1tTq2VORVGBdVTiywbBewnHgpJhbRmO8VpZTvNeExcgN1FT1Sb/S/WoleG
         q0z9dUxVq8mhgA4j0H6Xb9ZFZ+/VBDsXiZ2AM8iMKgmicRMxcnpjDH5lFF5t1xih8+BR
         lacNPOyDve1VtaYdevKG0nW8M4QuDkSWoxPbi7c8iVxPnrBO0ZheZl8fRcB+eq0NdgJF
         rdlJNXxlO9MzzNIjUyvcMdDYr3owpyUkJ6GDqtiChiL7Z5V26A5h8COMgsB9DZUep9R4
         s4gfT484bJTiJK3LFVWle5KC4cjUphgruHI/QjrNdz8sUK5WohU6loUtU4roNW0d1rN1
         CfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqNkJzAQzs28Q1o/gRe5m9k79AWr8i1R4AXoynI12dE=;
        b=UYsIHkH0108kpvhcBoYsdSOvKYpT6YNTfz9P0RPTlHK/wEZNggphgTGn5Vnom04Qas
         fDX5J/iapruQ/qrhdISWYgPl/2bU77hK2xmKg8LaFXLmwAhn0+rmA7s4M5a/l4gkA3sp
         /mVSplJMtLfvZr6imFu3V35Lciy6Msn089lsIdc7HMZEKafYD5/rWgY50g3TZtSQf8XJ
         ty/04lq+oa9B4Wq6yBdc8d2NdmOrj9QhM7Gbdw2BksTA5tUh6mlgQQQp1DDsfxzA3hg3
         KgN9302AbiWBci6aMbSXdGolIwI0ZDqqBqNCKt2bu/wIa/zh87Xw4rKg3Mx/JNKXZoaI
         3+/w==
X-Gm-Message-State: AJIora9zajWCafBApcXPhRftECFe4cL3ppjnjap4KDI+uwVGVZlXy9EQ
        LWziuQpPmBTLbE+5B3FE+6td6IiU8Kr0ny7aDlNuww==
X-Google-Smtp-Source: AGRyM1vhf8tPs2JkZTz3EqRMlUacvdlAeS8akfQNMQTliotfy3ldW9d/I30sQQu06nl1Ii5zhiXjWFa2yC9loZqcsN4=
X-Received: by 2002:a0d:eace:0:b0:317:87ac:b3a8 with SMTP id
 t197-20020a0deace000000b0031787acb3a8mr22165745ywe.126.1656424993629; Tue, 28
 Jun 2022 07:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220621034224.38995-1-samuel@sholland.org> <20220621034224.38995-3-samuel@sholland.org>
In-Reply-To: <20220621034224.38995-3-samuel@sholland.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jun 2022 16:03:02 +0200
Message-ID: <CACRpkdaxodnaJsKfFMvYHWtPwZyACiec4iX3ZXSBL5Ptfa6mRg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mfd: axp20x: Add AXP221/AXP223/AXP809 GPIO cells
To:     Samuel Holland <samuel@sholland.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 5:42 AM Samuel Holland <samuel@sholland.org> wrote:

> These PMICs all contain a compatible GPIO controller.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

If I can get Lee's ACK on this patch I suppose I can apply patches
1-3 to the pin control tree?

Yours,
Linus Walleij
