Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468B65462DD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344674AbiFJJx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347433AbiFJJxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:53:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5C1AF32C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:53:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z7so34529590edm.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zKEy3pvm/pZJfBDk6QzX0XhSCgP4GJCuIuAN1XuMp8Y=;
        b=Dk8nh5ItfXVaDGkTMVMrgJtXWV7hhEYlNnF/DG3Vjli8AWb6Plu9bDZcd4LQ5DfPhB
         VW/TLF+gEFlW4nYdXFMqQfQhpwawvfWuvwF6+k3tH9mDFg29qBcFSaISOWxtWWPJ8tRM
         Kqd2NDHm2l90HH6RuWsmYaqPI4nQnd7vCkJyKwWcYMgQsaV8XcSI9QaHxw+bRYFxW+t6
         MWGfKROqUUTYEJ3cinAj62e4n0WQXIbemTYPvHnlMwXyEl7c6+PcsN9kJshykSA/XTaW
         CKOkayCgxjPOO3cGnpqIIAI8euu9cNatMwDDSMjwHcOStdxGffPBGbREVe44BfUJW703
         30Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zKEy3pvm/pZJfBDk6QzX0XhSCgP4GJCuIuAN1XuMp8Y=;
        b=kla24UGwW2uAtPFAY3GY1x5kgnWcQirYOJpGrw8KMXRkP2UoeV5wuB7S3ZxMYLGWUl
         HQDnVb5Opmm9yROuXHUZqbdiEKkkRRP5Pf3/RDXqSyncc0Lw8i1FwI3bifvvj3Nf2IAa
         1auxaagHzQwD+CA6fV42dMUZBjPoSNWCjKWFBq3JGtPJamOJg5PM7f4GNDCS666hh9KL
         MKlgTNVAFfFK5HoMaTqgh3eqdleT/ntMvdG9Sw9HWyDmSRQMo+VLfWN0n8+Cl00nbrbh
         f2i9VemLBpHLPeo2s3hu4xnHhO3ZikA5KlI1O7n1LiIo95elTcYWTt3cWxqIDq/iXFDJ
         pZlg==
X-Gm-Message-State: AOAM532RnfUKiuyZSHStPH73DI8L6FIs5WD1c58tRA/W60unlU8y/1lt
        0geQW4Shn3nOlpHHNnMh8ekbtw==
X-Google-Smtp-Source: ABdhPJxHSpa5HKTZBSli/12ysLX0DJEMxvYMgmsT2QEBLzerIrZdBBwZC8Mv3rH2J8Vn0jsupErFoQ==
X-Received: by 2002:a05:6402:2706:b0:430:6238:78d5 with SMTP id y6-20020a056402270600b00430623878d5mr37918961edd.413.1654854830713;
        Fri, 10 Jun 2022 02:53:50 -0700 (PDT)
Received: from [192.168.0.201] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g9-20020aa7c849000000b0042a2d9af0f8sm15876033edt.79.2022.06.10.02.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 02:53:50 -0700 (PDT)
Message-ID: <8e02ad54-5dad-aee7-6fa8-70c72f93bf5e@linaro.org>
Date:   Fri, 10 Jun 2022 11:53:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 11/20] reset: npcm: using syscon instead of device data
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Robert Hancock <robert.hancock@calian.com>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20220608095623.22327-1-tmaimon77@gmail.com>
 <20220608095623.22327-12-tmaimon77@gmail.com>
 <91549b70-08fc-ed6f-c48e-5bcb70ea63d0@linaro.org>
 <CAP6Zq1j2VZno4w4w0QCYwHnRaVqiM=DnNSmND1vOGDs_wfi2zw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1j2VZno4w4w0QCYwHnRaVqiM=DnNSmND1vOGDs_wfi2zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2022 23:37, Tomer Maimon wrote:
> Hi Krzysztof
> 
> Sorry but I didn't ignore your comment.
> 
> For not breaking exciting boards I add the following patch in V2
> https://lore.kernel.org/linux-arm-kernel/20220608095623.22327-11-tmaimon77@gmail.com/

No, it does not solve it.
1. Patchset goes via separate trees (DTS are always separate), so it is
not bisectable. One of the branches/trees will have broken DTS.

2. All out of tree DTSes are broken. This is expressed as ABI and - with
some reasonable exceptions - you should not break it.
https://elixir.bootlin.com/linux/v5.19-rc1/source/Documentation/devicetree/bindings/ABI.rst

You have to keep backwards compatibility, so parse/handle both versions
of DTS.


Best regards,
Krzysztof
