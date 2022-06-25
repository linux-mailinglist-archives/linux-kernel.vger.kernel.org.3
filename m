Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F4755AD4E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 00:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbiFYW7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 18:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiFYW72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 18:59:28 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95C713FA9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 15:59:26 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3176d94c236so55014277b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 15:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kz4CQpOKhPTyDsa60xKPIiVM3jnSyd80mVmcmJIhuHQ=;
        b=f0R0dNNfG+cy3gFp7wt9apjvTZnUDWzypyV4qpxTt0EYhTusE7dczqOjHtdnJ6vezN
         zHCYjY76OuU7+5Kurfz9oaZcDHK4a3uwUh3eDulaNbh8hB6891r6dpwGNRRrYLaL0rGI
         lXHEoGEl0PVXK+UANPXZuirl60K+W2t2Kir2E6bca3VxQvvETRSmzmqghmbYWZRf2c+O
         qQ7Uwvryau8aALkvZtL19zhwrXOxRQuMK4ocOgSBgDpdEydMdiCLF+mETnI5hsInX+0a
         9Jd7mhj/C6OsaaKO0Au+5T+hKmp/3hxrDjcU/5FKa/Ui/MGI9jYcSPGrFadHuCt/y8Bb
         VoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kz4CQpOKhPTyDsa60xKPIiVM3jnSyd80mVmcmJIhuHQ=;
        b=qXo7sh5WXZ+qa1J5rv+qj8Do2lhj2JC80C91klER6+BYM1+dULuQKHyfECD22iw+So
         JwXpFNf/z6VVAZ0jIdqhD7F50sHkdWmeY9TkkEiFx9aXG7OOZ5xIuKVfDVYl7Z9WE2Or
         LqM4axnGf3IJwuzaDzrMdxq5Oe/rjWyWw8fS661js3/3UwRspfzk4t23WZ6qQ7quNlH6
         hQR/rUtAiVpF67YPcKsat1reb239o+5EcHYlJPafgZu+gB49cqVV0HRVcjuHXrYXpJbk
         XDvXtPQen9So6hmMLNTpcV1Pif+QLdC3p5IrfSoARqtjxmL5vgqdWGoyOGvL3+4QLVdH
         +qSg==
X-Gm-Message-State: AJIora9MnLGxDuS277CNpHzh/v2HB+If+Md3gdFdz5QZxA6RAhTzUyl/
        hJmLNrgjceVoDTXiYiLGG95buJOuwk96JWox/pAebw==
X-Google-Smtp-Source: AGRyM1uosYwxlq64LUlIuBLDzEOZIVCn/f27F5vp117PBBS+sA4ZCR/UdMd9wStyWymJXop43cXKJFCZnY1Vqnm0CGM=
X-Received: by 2002:a0d:eace:0:b0:317:87ac:b3a8 with SMTP id
 t197-20020a0deace000000b0031787acb3a8mr6860068ywe.126.1656197966000; Sat, 25
 Jun 2022 15:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220427144620.9105-1-pmalgujar@marvell.com> <20220427144620.9105-3-pmalgujar@marvell.com>
 <CACRpkdaqeTs-jHPBmtdiz+LdMM0pz0zqt4diX=e+YpgaGr0Jbw@mail.gmail.com>
 <20220603090618.GA27121@Dell2s-9> <CACRpkdaOd0-k_mt0ZrKT-DbVc3f0b5uXXmXpBNH=hq3BGCB+vQ@mail.gmail.com>
 <20220613080452.GA1884@Dell2s-9>
In-Reply-To: <20220613080452.GA1884@Dell2s-9>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 26 Jun 2022 00:59:14 +0200
Message-ID: <CACRpkdY-+D1tkNJoWLpQH9-2AcE1xb546eJx5Nuq+Tw3WKj6mw@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: gpio: gpio-thunderx: Describe pin-cfg option
To:     Piyush Malgujar <pmalgujar@marvell.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rric@kernel.org,
        cchavva@marvell.com, wsadowski@marvell.com
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

On Mon, Jun 13, 2022 at 10:04 AM Piyush Malgujar <pmalgujar@marvell.com> wrote:

> Thanks for the reply.
> But as in this case, we expect a 32 bit reg value via DTS for this driver
> only from user with internal understanding of marvell soc and this reg bit
> value can have many different combinations as the register fields can vary
> for different marvell SoCs.
> This patch just reads the reg value from DTS and writes it to the register.

I understand that this is convenient but it does not use the right kernel
abstractions and it does not use device tree bindings the right way
either.

Rewrite the patches using definitions and fine control and move away
from magic numbers to be poked into registers.

Yours,
Linus Walleij
