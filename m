Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0196B531F48
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 01:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiEWXfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 19:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiEWXfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 19:35:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1427D77F23
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:35:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gh17so18916174ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFxAkZflJR/W545LnWjxrxhpNM354S0CuGlPnKLeaRk=;
        b=MvUWlpw4z+I9tpkl6lmkoFhy+r0zDELAvtU2O2I6MSU+RNMdmQbnQZS/MjGfH2tLQy
         RVEoyXBnmlR80COfSyH1NCGGNDvIIhNqp0f87vrs6GPoSxgNnOwX8WbWQbUAm3sa0Qfw
         jAyL1mh+CBWKTyOzBSbap1KgRnAYYAS1KXrPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFxAkZflJR/W545LnWjxrxhpNM354S0CuGlPnKLeaRk=;
        b=f60pt4Obnac0l6Zff11Rg0DaGsFcYuTAnA1sDmLL42dy0v5WYlTPLLpuKCQD1Sxe6v
         2TMr9v0wVnzX6iHteyL9lKyZ0nkwF8v8EUUV8CIfzbG6nXdlGuVEWpjPcIMQU/kTU+FK
         16/k3qh5YjO0krbi4HLyyn0erNPhm7MK1oum1/NSwnk/uMCHUzL6Mcata7oL+PoxdFZq
         qYpSh1kttFjnev51ghtlLwbOJsmZQFN8oDJzFr2YLS+mHeEPS1n59aYQgydhiC7g428d
         Fnw8VMWbmZJwYe6FppGh2QkUyuoJm2P3U3SY7K2EZnyyTn/2qdbTYPKq/cyBTJRrm866
         kPOA==
X-Gm-Message-State: AOAM533PZ+upV7QvmQDxae8PIe9IK8oGIYr4u55xOEzG+IDOc8Otp7IY
        1kzz7byWFCyzv5bdrVbwOH333D7gSCprySIoucs=
X-Google-Smtp-Source: ABdhPJzIs6RzR28ZvrfU/ukArgFmdaESJ0nQr1qaEj6B525sxsg91ZZhTp1jpeKoNjI0vp5D3vU8OA==
X-Received: by 2002:a17:907:2d91:b0:6fe:e517:7356 with SMTP id gt17-20020a1709072d9100b006fee5177356mr6332131ejc.328.1653348937382;
        Mon, 23 May 2022 16:35:37 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id d18-20020aa7d5d2000000b0042ac13e232csm8842943eds.39.2022.05.23.16.35.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 16:35:36 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id k30so23385989wrd.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:35:36 -0700 (PDT)
X-Received: by 2002:a05:6000:1c03:b0:20e:5cac:1eb5 with SMTP id
 ba3-20020a0560001c0300b0020e5cac1eb5mr21027204wrb.422.1653348935739; Mon, 23
 May 2022 16:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220523142257.v2.1.Iedc61f9ef220a89af6a031200a7850a27a440134@changeid>
In-Reply-To: <20220523142257.v2.1.Iedc61f9ef220a89af6a031200a7850a27a440134@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 23 May 2022 16:35:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Urdfkzz6h4X-5tKvjFaT6eRTNP47s+evkjYaCEfq-Ndg@mail.gmail.com>
Message-ID: <CAD=FV=Urdfkzz6h4X-5tKvjFaT6eRTNP47s+evkjYaCEfq-Ndg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: HID: i2c-hid: elan: Introduce
 bindings for Elan eKTH6915
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 23, 2022 at 2:23 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> Like many i2c-hid touchscreen controllers, the Elan eKTH6915
> controller has a reset gpio. For the Goodix GT7375P touchscreen the
> decision was to add a new binding rather than trying to add a new GPIO
> to the existing i2c-hid binding. We'll follow the lead and do it here,
> too.
>
> SIDE NOTE: the Elan eKTH6915 is a touchscreen _controller_ that's
> included as a part on some touchscreens. The reset line isn't truly
> necessary for the functioning of the touchscreen, so it's possible
> that some designs won't have it hooked up and will just guarantee the
> power sequencing requirements with RLC circuits. Thus, we'll mark the
> reset gpio as optional.
>
> Note that if the reset GPIO isn't used there's actually no true need
> to use the "elan,ekth6915" compatible instead of the "hid-over-i2c" on
> Linux. However:
> - Officially using just "hid-over-i2c" for this device violates the
>   existing "hid-over-i2c" bindings. The bindings say that you're not
>   supposed to use "post-power-on-delay-ms" without specifying a more
>   specific compatible. Currently the Linux driver doesn't enforce
>   this, but it violates the bindings to just use
>   "hid-over-i2c". ...and if you're going to add a more specific
>   compatible anyway, might as well do it right.
> - Using this compatible means we don't need to specify
>   "hid-descr-addr" since it's inferred from the compatible.
> - Using this compatible means that the regulator names match the names
>   on the Elan datasheet (vcc33 / vccio) vs the generic hid-over-i2c
>   (vdd / vddl).
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Failure on my part. I should have carried forward from v1:

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
