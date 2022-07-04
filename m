Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADAA565E8B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 22:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiGDUfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 16:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiGDUf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 16:35:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E95BE1F;
        Mon,  4 Jul 2022 13:35:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id o25so18423018ejm.3;
        Mon, 04 Jul 2022 13:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l5RKSEwMtYWUzRQ7RcuOICxLgoH1DtWLQtcUXxCeKHo=;
        b=cuuhrnB1Z3qMtW1Rte2htfl1jyJZuMjDt6eYBMPcdlfZO6h5Tk8lzSNU8TBINmyjsE
         WIzVD9Q85f4Px1O2uq1wtus48tCNFG/Ms1UhxQy8t0DlGfAMWDZoiaPUq7rnFXDUY3xp
         MvwP5fqRA9eM6JBwK+OoW0pBx8oZld6jdyBB76Jh2QhLA1+MAqRvPap4xS8m86+i0wyz
         VLcmkO3GMq9j74GW6fA1JKneoJ7Cr0+II+Gsx01355O/wosjGmVQXe6ilukT8XbIPSQH
         gzbTlNAE+f5Nijsrz5830jxhRHYaUVvLn3uq50HqUQDDBwFcQO9c2sUTlJyP6YGo6xPZ
         nejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l5RKSEwMtYWUzRQ7RcuOICxLgoH1DtWLQtcUXxCeKHo=;
        b=bZSf28dUZYFO70s/nBRcG+47V5QyAa5B5AD0x9S/b45xjXR8nDI7m9Bh9fsAE7Bgpq
         dUcGENQlC8oWdMI8oHodX9LhIWgDqavMrIVS8/jzU6xIuNUclZ3UMsG8SpjVmnKdcpc0
         6aa0/CQLG0eLwJRsA8eD9rB/zMYIamjDurggMuX95hx0zIaf3x+OQyIqd0zZBrbXNyMm
         nGSt0/vh6rMlOjSDxrPCG74i7s/aJSUBIyssy6ZXvniwf0mX3QmdDNjBQED+zfFxw+GU
         XTElWNcWRfzV2Z9qHRX0JAz93tXwB4nFv0v5zbS3Ufn9tKmulpAqbJVE4UAUUHMy3HVc
         /IyA==
X-Gm-Message-State: AJIora+28nhYeXW7ubw13ZNNRZ/PPm4SErDoer/Dsf3h0uIRgmsjZ03B
        iW/Zq8kQDlKgjR5QT78+V3M=
X-Google-Smtp-Source: AGRyM1tlNsZvI5Qs15Ak98v/bYen0FnGftmRy+1cPsXpKDmi6R1EGXR3Z5hY5U8PyRS+UxnPErWYMQ==
X-Received: by 2002:a17:906:d550:b0:723:5c2c:8a71 with SMTP id cr16-20020a170906d55000b007235c2c8a71mr29789718ejc.254.1656966925403;
        Mon, 04 Jul 2022 13:35:25 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id uz12-20020a170907118c00b00711aed17047sm14599009ejb.28.2022.07.04.13.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 13:35:25 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] dt-bindings: usb: Document Allwinner D1 compatibles
Date:   Mon, 04 Jul 2022 22:35:24 +0200
Message-ID: <44784082.fMDQidcC6G@kista>
In-Reply-To: <20220702195249.54160-1-samuel@sholland.org>
References: <20220702195249.54160-1-samuel@sholland.org>
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

Dne sobota, 02. julij 2022 ob 21:52:46 CEST je Samuel Holland napisal(a):
> These patches document the compatible strings for the USB controllers in
> the Allwinner D1 SoC, which require no special driver support.
> 
> 
> Samuel Holland (3):
>   dt-bindings: usb: sunxi-musb: Add Allwinner D1 compatible
>   dt-bindings: usb: generic-ehci: Add Allwinner D1 compatible
>   dt-bindings: usb: generic-ohci: Add Allwinner D1 compatible

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> 
>  .../devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml        | 1 +
>  Documentation/devicetree/bindings/usb/generic-ehci.yaml          | 1 +
>  Documentation/devicetree/bindings/usb/generic-ohci.yaml          | 1 +
>  3 files changed, 3 insertions(+)
> 
> --
> 2.35.1


