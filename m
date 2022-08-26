Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8C15A22B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343573AbiHZINe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244686AbiHZIN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:13:26 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E5DD4BCF
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:13:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id d21so1746428eje.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=NXwitHio/7JwDumLFpAgiMLj63RaVL17ajcp21R6k2Q=;
        b=mgcopMPyOg5dStcVRGKVJ7sc/uHv47EJrRaQhXAtmc0rfwJ18NGlqkmPZ8PrUvg48P
         MNQfyaWkkDjjt3yjs92nvYyJGerfcBOfhUyLvQoBMX31pB9JqMdkkpotlr9g4XPjdPJf
         MZMS0Rznheo89L7t+kM3kIsVQNEXc//u6oB6+zyMCRGTviL4ZMHMvvkBy2vgLzRGWD3o
         cdcZVSLzUpeykDumVucvbYJY94WGedvDSrBwPTWd0m2HwNYpANQjZrHcOMgWhpfNUzac
         +9gdxj0hyP6wZp5X/p4T5eO5LwExgPWK90CTCVrSYFn7qm6foPijy6PwFFyMLMDt8XZ5
         lNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NXwitHio/7JwDumLFpAgiMLj63RaVL17ajcp21R6k2Q=;
        b=iAF04oxgpJGSr4yuIlSsol8qaLT9C26y0VgCJ1OcUOBo9AvytghiN46nXpWeCt2tU0
         74Vxt+0tiGaQv0KdgKGwTP4K7GNw8xVMK3MBQPNAvoFO3/Bh5jGQWueDXa1RGLEzX9lw
         UHky/eoGtfboTBL/6QvNBjww4w/EKfP1e2SRyOXhTYwCRvL2JF319iTBdCuHI4ZDXmVg
         Ia6fhjM4m8j3MKRtr8bQkb6DFmbLl7lKDwn6bkxmGGarUWmgM8SEabUTsxN7ZsmFATk3
         YeaMXywVa+W61vCtEqfGbjLTdtn4chJ/5xLMev8e/Mfn1pFR1Yhs/dM6CIFuC2I0YZJ0
         iVMw==
X-Gm-Message-State: ACgBeo0NBjECfbaT3NdvO2pnYZShwpb74vJ0LwkNP4E1Jd67dc9b05dX
        MRDLTw0JYUM4itVq1hs9GvX1wHdmjfFZcN7hOGnF1Q==
X-Google-Smtp-Source: AA6agR5NtfoC3IPV3u7qtblqvhnD9K3/BH7jOrVDVsoqgbkt9CEFcmJ42imT8TJOmGTee/F+/HtAZgpZSoLJolrOq84=
X-Received: by 2002:a17:907:6293:b0:73d:b27b:e594 with SMTP id
 nd19-20020a170907629300b0073db27be594mr4892481ejc.526.1661501602905; Fri, 26
 Aug 2022 01:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220819060801.10443-1-jinpu.wang@ionos.com> <20220819060801.10443-8-jinpu.wang@ionos.com>
In-Reply-To: <20220819060801.10443-8-jinpu.wang@ionos.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Aug 2022 10:13:12 +0200
Message-ID: <CACRpkdYYPGtaVbEwu=EP31cEx6Tc1JjrQsd7MaJ_7LjFTpnQFQ@mail.gmail.com>
Subject: Re: [PATCH v1 07/19] crypto: gemin: Fix error check for dma_map_sg
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On Fri, Aug 19, 2022 at 8:08 AM Jack Wang <jinpu.wang@ionos.com> wrote:

> dma_map_sg return 0 on error.
>
> Cc: Corentin Labbe <clabbe@baylibre.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>

Good catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
