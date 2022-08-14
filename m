Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C355925F9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 20:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiHNS3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 14:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNS3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 14:29:47 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD8317E17;
        Sun, 14 Aug 2022 11:29:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id qn6so10207924ejc.11;
        Sun, 14 Aug 2022 11:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=YM/EzX/v/N7HQ8RLOhFApRZ0Ncx8MJgn8JX0fsX1BSc=;
        b=XqgHhVJ45K7Y4IMlRanR9Rj1I/nKidTWQMTwmxgFrwhqcwDzDWEqBh3Ol6wFV7lmHT
         U24NzDZdZn0QR4pCUuo2wByLM+iWQ33IUKbhEHXwXHaDIALlwZ14sg1RjadOCq5heKmt
         I9N/hCj/yDGqf4gR9i7eavO+5nwsyTeGuLYQwPCyYZ+2oX43a2/pCCqhnRtrZWPBFx2/
         BWZjLBKlSXiT4HI6w5ei8h/yaoEfgOH9g59C+8Ss3K/uvtMEFgpSBWQXqtKDXdzS3Pra
         Vqnb80z1uWtGJ4UTpLn6DeREI4ATZolS+GXbwGCZ3klH8pJGU83bvT4rINrlgFtsJCWd
         rKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YM/EzX/v/N7HQ8RLOhFApRZ0Ncx8MJgn8JX0fsX1BSc=;
        b=UmI689F9Z42+gpVSI52qdEvdoN74yzl411PMOgl2Pxv+BJGMp7WX+bpJ3kzkNUjgDH
         4rDoJ7VAZeYG+Wb7SBhPQYweDwjSJSS0FPMgDKUgeNSKtXdnHb8HZ5VcjICfg00uMvWm
         7BBAMyJY6Qnv0HZmdy7a9alMe6kjRtQ66Xsp72WMskgvo9k+QxIgWYYrXJnNeNUWr5lA
         xhdz2b2ONCAoF3dsSorskppLwgKeFmz+0r73fm48EpC6FoWe8sMpk0j+y5EDFL8o7phz
         OrZPSJpngZHB+SHIGgDKlMyoF1A3bh2xJkGS1rOuI75fNOAMFaw2ELAav/unXgIWLpU7
         HXBQ==
X-Gm-Message-State: ACgBeo3CG49QNNRY8aZjqt87ge88Z9gehH3x3j5cYrU1TJ5jAFRwqOtw
        7csQhF+I8s7IgH3ho3adr8E=
X-Google-Smtp-Source: AA6agR5aEUqDD55iAOGa2vGjq+YEYaXPiLBsN3zLIyyxT3OmPIMg9OLUoUoN39a/AJR7nSa6Ft0qLw==
X-Received: by 2002:a17:907:3e93:b0:730:a92b:e7e1 with SMTP id hs19-20020a1709073e9300b00730a92be7e1mr8562025ejc.621.1660501785749;
        Sun, 14 Aug 2022 11:29:45 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id bv18-20020a170906b1d200b007315e57ba0asm3211222ejb.114.2022.08.14.11.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 11:29:45 -0700 (PDT)
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
Subject: Re: [PATCH 7/9] soc: sunxi: sram: Save a pointer to the OF match data
Date:   Sun, 14 Aug 2022 20:29:44 +0200
Message-ID: <44879236.fMDQidcC6G@jernej-laptop>
In-Reply-To: <20220801030509.21966-8-samuel@sholland.org>
References: <20220801030509.21966-1-samuel@sholland.org> <20220801030509.21966-8-samuel@sholland.org>
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

Dne ponedeljek, 01. avgust 2022 ob 05:05:07 CEST je Samuel Holland napisal(a):
> It is inefficient to match the compatible string every time the regmap
> is accessed.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


