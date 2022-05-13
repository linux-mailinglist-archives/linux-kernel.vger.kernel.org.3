Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC861526730
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382416AbiEMQgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344683AbiEMQgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:36:35 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21EF44A17;
        Fri, 13 May 2022 09:36:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g23so10546125edy.13;
        Fri, 13 May 2022 09:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3cBFD5kdFALSZmKX9KchzCHehvA180EgcT2tz16vaRo=;
        b=GnZYb5Eu1phxRNnKCJsb7GM7lv4wPRJ0aUB2f+TwmxuPplkZiCEm3UQGqjt/C6vrhL
         e/S1e67jLzEhLoqJwPFZ0BJopCDKWFEM1iTYwWw3K5atAgViYkReBt1pl1dZqOI+lCki
         cTk4fvLnVEZ1XhWnvuTp6tU/8SDuGk51E/SYkHBGhTv9CyNekZ/w6Yz2hO821eS0Bx6F
         j07nxeTU5Y7eWH+mU2oSNn6/HBDwF7uK55wPrfHtee+jmMFKyk/A7gfb9hNjqVSi6W80
         SkPqS99URF/5W1BxEqf5kGaHmRLHiAYQ44n8hTyPeaPkpKtRCqO1iK0V9f3TfEo7ku2W
         lWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3cBFD5kdFALSZmKX9KchzCHehvA180EgcT2tz16vaRo=;
        b=AelKrLA0gCHQRFgAXAATI2NdeQtdyJZXIWxqBqx+RhUtZ2TZBp5oXYD+UFFle2U6w/
         x/ml0yX42sMBLyV1WRlxcN0JxtPgQqYUv4eTtHxw/0RXk1tsJrS9kBwumzjGyU6OEXp5
         ElB/EwPFggw2zXykBlHUfTrjhRdYac5VJivXDqnmF7us5GITtTYFgC8dubiVlw8PkEg+
         EjxjgOhZ3sKyU7nRbcxtJHL27ztS18fRQWfp0O7DP9PQEMVlgWwxn4PzZtZm7tNc/IGy
         DMazObQTJOXku10tDNWV+jycsbQdefkIPTlDEj9O0DwHE6HVfSTRZRrpt5qggeNdyqb4
         aLkA==
X-Gm-Message-State: AOAM531eawzeEkfPpDT5PobqoqaD1gcabHB3IHEuqGUtEYjRE2a1m7rD
        A2WglrQndaiLyD4jsWEfZd39rE/90VWCmg==
X-Google-Smtp-Source: ABdhPJzViOpa8TCGaT8IZEo4DTneEvijoN5YV2tng0kmzjGaAg1J/rbzBFhZjbERyS6WEg5GBGkkkA==
X-Received: by 2002:a50:cd08:0:b0:426:1d9b:4b13 with SMTP id z8-20020a50cd08000000b004261d9b4b13mr41233120edi.360.1652459792345;
        Fri, 13 May 2022 09:36:32 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id b21-20020aa7cd15000000b0042a2e5e1a7dsm1136810edw.37.2022.05.13.09.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 09:36:31 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: Add Hantro encoder node to rk356x
Date:   Fri, 13 May 2022 18:36:30 +0200
Message-ID: <42373378.kc9IRrpb2S@archbook>
In-Reply-To: <20220513152358.GA334264-robh@kernel.org>
References: <20220508202544.501981-1-frattaroli.nicolas@gmail.com> <CAAEAJfDMG9ykJQHUf6oB5gjV_J0M+eycCqiUvDv2WjpC3g8dKQ@mail.gmail.com> <20220513152358.GA334264-robh@kernel.org>
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

Hi Rob,

On Freitag, 13. Mai 2022 17:23:58 CEST Rob Herring wrote:
> On Fri, May 13, 2022 at 10:07:51AM -0300, Ezequiel Garcia wrote:
> > [...]
> > 
> > I didn't ignore it, I just didn't reply to it. You think this is about
> > changing a dt-binding, but you are actually introducing a new dt-binding
> > since you are adding a new compatible string.
> > 
> > You are doing so by extending an existing dt-binding.
> > 
> > I am explaining you the _existing_ dt-binding models the (incorrect) idea
> > of a combined decoder and encoder. Since your device is encoder-only
> > and has a single interrupt line, you should omit the interrupt-names,
> > because it doesn't not add anything.
> 
> While in general I agree on single entries don't need -names, given just 
> 'vdpu' is already allowed I would go with symmetry here and allow it for 
> the encoder.
> 
> If you wanted to mark 'vdpu' alone as deprecated, then that would be 
> fine too. No need for an if/then schema to disallow interrupt-names 
> either. Eventually, I plan to (optionally) remove deprecated schemas 
> from validation and that would have the effect of requiring 
> interrupt-names to have 2 entries here.
> 
> Rob

After some discussion in the #linux-media IRC channel on OFTC, we've
come to the conclusion that moving forward with a separate binding for
encoder-only instances would probably be a wise move, as the VPU binding
assumes we'll always have a decoder, and breaking this assumption will
just make it more complex the longer we go on not separating these.

While I was writing such a separate binding for v4 of my series, I
discovered that this makes things quite a bit simpler. Especially
looking into the near future, there will be between one to two
additional compatibles that will be added to this binding for the
RK3588, as it has no less than 5 instances capable of encoding
JPEG, and I believe at least one of them is capable of other
formats as well.

Regards,
Nicolas Frattaroli


