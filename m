Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21F65925F7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 20:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiHNS3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 14:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNS3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 14:29:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636CC17E12;
        Sun, 14 Aug 2022 11:29:10 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a7so10267240ejp.2;
        Sun, 14 Aug 2022 11:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=XB5MYP1ObQdhC9Im6M6kovBu00CUIfbX057+jD5STfU=;
        b=o6rnUv3Xj8cQ2rQjg18UO08EBTbc+8mKWNIv34B1Homy7Qi200vG8NkMRX5UIfl7lU
         E8mbjGgWmhHSi7Vazc3Ls/5foMmUWgVUGXjI2za7Rht5zQ4KV/OHCd2IZWeofEM45hiX
         /lYJCIXH4/hjsIzEJKaM1Va3qW3RHXhXB/Ef6aBhp2o1XyJ2fg2HYCEK9mHHfaWfn0N8
         v22lOVf4mhGVUjOMRHxBCAPfUSPv6egliXmdpjaeuZ9+kM3kq2h8Di2/Yqg3KRRrEWrs
         cZp3BHssaXD1tt79X0I1THLSeI6sXfYUUWfE88p/rKxaOHfS+PP0CM8+kkW+P9jew53w
         uVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=XB5MYP1ObQdhC9Im6M6kovBu00CUIfbX057+jD5STfU=;
        b=8GxlNVw1Lrx3epeAZIVGUB66SCGFnOEcWcEKQB7+Q42jb8wk/pCLkXMms37zk2yTwB
         2wj0dEjfwCaRPdUnrEh3IgUaB/xhOY8jCwy74KVjZBhWyK+UqT+v0+B+gFHE/4GsWI5G
         NuW6nCTb0Oz5gEw9LP/P7RPvEVrxocRkd/u1+Eb1PP7BKkRGmcGN4Sd0ARgyvp/KADC4
         InGrPkvpi3p7/sG8gHG3pNXm8osRmPXS4skNkdfC8Etn+Z/wE8NyD/RtZ3/G03w/s5qs
         zSYgANR3wEs+fj1ZOYabBMgSX6KIZvPY+ePvDa62Rhc3ACJm495aYa+gFjajW3XooFFS
         Y0Ug==
X-Gm-Message-State: ACgBeo3g5pUnnAfkwPdpUaDrDj4q0Z3vUgk3vouvWYveaTxkzG1OXAzp
        RCUNtS6zNCynxoe8G+li+q4=
X-Google-Smtp-Source: AA6agR6WQOQwzUrL+8I/1eLkVEaS4OfvGTklYYUB7u3jpPbUvQNJmwIzmGjEi4DW5MynTEsu0+WmnA==
X-Received: by 2002:a17:907:7ea8:b0:731:4fa1:d034 with SMTP id qb40-20020a1709077ea800b007314fa1d034mr8444116ejc.758.1660501749019;
        Sun, 14 Aug 2022 11:29:09 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id f7-20020a056402068700b0043ce97fe4f7sm5195487edy.44.2022.08.14.11.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 11:29:08 -0700 (PDT)
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
Subject: Re: [PATCH 6/9] soc: sunxi: sram: Return void from the release function
Date:   Sun, 14 Aug 2022 20:29:07 +0200
Message-ID: <1868640.taCxCBeP46@jernej-laptop>
In-Reply-To: <20220801030509.21966-7-samuel@sholland.org>
References: <20220801030509.21966-1-samuel@sholland.org> <20220801030509.21966-7-samuel@sholland.org>
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

Dne ponedeljek, 01. avgust 2022 ob 05:05:06 CEST je Samuel Holland napisal(a):
> There is no point in returning an error here, as the caller can do
> nothing about it. In fact, all callers already ignore the return value.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


