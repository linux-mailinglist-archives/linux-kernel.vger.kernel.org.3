Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF43B4B7AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244703AbiBOW5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:57:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244682AbiBOW4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:56:55 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F60AB91D0;
        Tue, 15 Feb 2022 14:56:44 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i6so538643pfc.9;
        Tue, 15 Feb 2022 14:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=POzAhCa4IixjF4ZibUJMWzkiAVUOqTIvtrCBAa9XtUI=;
        b=QiFT92UGmZJstm3rmmKsxkuPr26DlSc+etVmkyJxJi0aaPC+5KEV7bpl6eAYqH7yiq
         sfa+8qJjjUFs2LjJEa/vYkiyic+8iNbxu7XMx0whXkq6QU59u80qHT1LmgZUy2+Vcohu
         SzTxNa186PHJ0xap2EuWJasgvLDcILNi+lWib5d/JgmV4yHczZA4kEyh+n3UpBvXAgzQ
         vi4UEBx/XemzSdFopgDe7NGuaKm+8hTXLQTlSk00b2XGVNyJlOBFZ8NfusBZub9ywgSK
         TQ6tGV4c/txf6wu7IDuRVhSpa7Vubx4SILIb2nNIzt0JB7Sbya6Zn5Sav+hQ8bpO9jkd
         Ub5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=POzAhCa4IixjF4ZibUJMWzkiAVUOqTIvtrCBAa9XtUI=;
        b=D2+bZMwah6ZCoQH0NCuJaGw6/NTxkBDeD/2l7zFkNVnGeoYS5cigL0FmsEsDpd0Ve1
         4boloGSzrRGSoKOpxnZCbEFBLGSwJxPGzXh384cRyWnNm4bHWG/8jCvurkxe8y2KP1AY
         j99oce9o6KBaVESUwSU2gqxavE2bcSVK3CZWMm0j1APgebOxulZDkVP/vp7FR2iW9ybE
         WLH33dud4XYK1EHpf3PL2EmUbxIzNDGSoc+5wFOc2ROnJeVnToTJvBoJRL6zhfZ90gxc
         xWSjisoas1cGRSLEVAbJkl3k0FNpJOhZ9km8W8xHVLzZzELBlPu75ZtoCiqTv+AaXII7
         tS2g==
X-Gm-Message-State: AOAM5305wa9lPcPU5/btUTwCKox+lOhVKP+hKhtnDf27jCs5LgXMrEko
        +uoHPt0aL9TCqFIYN2PahYeOIekDJ0Q=
X-Google-Smtp-Source: ABdhPJwiSmP3UbUKpZcfA9Hu3zgV9RSr23PPyK2sxzZ7F35qT0pS8xxaPaOaf8fxIAYRq6Crno5ttQ==
X-Received: by 2002:aa7:83c2:0:b0:4e0:91c1:6795 with SMTP id j2-20020aa783c2000000b004e091c16795mr104375pfn.54.1644965803669;
        Tue, 15 Feb 2022 14:56:43 -0800 (PST)
Received: from google.com ([2620:15c:202:201:4e4a:b0ff:e926:40e2])
        by smtp.gmail.com with ESMTPSA id u1sm6952013pfg.151.2022.02.15.14.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 14:56:42 -0800 (PST)
Date:   Tue, 15 Feb 2022 14:56:40 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Danilo Krummrich <danilokrummrich@dk-develop.de>
Cc:     krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH v3 3/3] input: ps2-gpio: enforce GPIOs flag open drain
Message-ID: <YgwvqAvi8OvGi0Ft@google.com>
References: <20220215180829.63543-1-danilokrummrich@dk-develop.de>
 <20220215180829.63543-4-danilokrummrich@dk-develop.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215180829.63543-4-danilokrummrich@dk-develop.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 07:08:29PM +0100, Danilo Krummrich wrote:
> The PS/2 bus defines the data and clock line be open drain, therefore
> for both enforce the particular GPIO flags in the driver.
> 
> Without enforcing to flag at least the clock gpio as open drain we run
> into the following warning:
> 
> WARNING: CPU: 1 PID: 40 at drivers/gpio/gpiolib.c:3175 gpiochip_enable_irq+0x54/0x90
> 
> gpiochip_enable_irq() warns on a GPIO being configured as output while
> serving as IRQ source without being flagged as open drain.
> 
> Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>

Applied, thank you.

-- 
Dmitry
