Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BBD59C7B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238450AbiHVTBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbiHVS7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:59:55 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7824F693
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:58:00 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id o184so13275398oif.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=sx+UyfDWZj9lJoQgaGCVUpt7c9rW+3UXXFU2teNnr+s=;
        b=i/Bt7QN1Iml/UvONpD1gU8CUu+5EFH2d30OyL8Oq8NZw5oZbXgC/7+WzwWJMELOE2C
         C9Nj5VCS9TGZ6MS3y17fbjtsOmBq3f+yICabfF5/i2koXeKBIJeKf5porFUTDgkRN0l3
         5utqin9WpQcztPEQX+oiBX1m6x+C1PnQrZaDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=sx+UyfDWZj9lJoQgaGCVUpt7c9rW+3UXXFU2teNnr+s=;
        b=kTDGI5JSRcA9McVLAScmNyMNLS9GJMjkYxBJk1YdRyjqvngCsXkGuw74+UjtUk2Acw
         RLhG4FIOPTFj5OZircODz581Rlb/QIprQ/+dpIPXkcLKiY8C5q/OQUNRJok9hSAC1fJK
         gFL7PBc3SPnCa4LjR02xPKVYr/oMIHE2F27wOi67B08JlPRj9DDONL6MZfAfhwmvws+/
         CG1AfCDIfwHFNxif9JV+H3BF6HIHa/hNfj10vAzgG7IvcJZxSI115mpCG4MYVY2pkmaz
         dUZni36ZMGem+dFJKnZ/RwFc6kLHzmhEU0alHTOnb7sf0qTfg8n/hPYB7VKK4wpsoGnC
         tzYw==
X-Gm-Message-State: ACgBeo3r682gvQO62yws/1CrOZwaQQ9OKcShNSWwYshCsRytraKQyeBe
        Yvx46xeHbsJMTXBiZxVXlgI7mr/mxHlUFQ==
X-Google-Smtp-Source: AA6agR4CO327EbyBfreECyxpA3Y5yG//RLZVZSbILAGMeO6r0TcZEAFlYNZ3P5VAfz5aRPz/ODfNSw==
X-Received: by 2002:a05:6808:e85:b0:345:4fc2:4444 with SMTP id k5-20020a0568080e8500b003454fc24444mr4253944oil.245.1661194676610;
        Mon, 22 Aug 2022 11:57:56 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id q12-20020a9d630c000000b0061c80e20c7dsm3068094otk.81.2022.08.22.11.57.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 11:57:55 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id n124so2360329oih.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:57:55 -0700 (PDT)
X-Received: by 2002:a05:6808:20e:b0:344:997f:32b8 with SMTP id
 l14-20020a056808020e00b00344997f32b8mr10008134oie.11.1661194674906; Mon, 22
 Aug 2022 11:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220817123350.1.Ibb15bab32dbfa0d89f86321c4eae7adbc8d7ad4a@changeid>
 <f776de47-615e-d38d-8512-3e5391d6650a@linaro.org>
In-Reply-To: <f776de47-615e-d38d-8512-3e5391d6650a@linaro.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 22 Aug 2022 11:57:42 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOYJrqdtzOeFhJfxtB7bCEKZuR=ADGxoVsAFM_N6zPJ+g@mail.gmail.com>
Message-ID: <CA+ASDXOYJrqdtzOeFhJfxtB7bCEKZuR=ADGxoVsAFM_N6zPJ+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Add gru-scarlet sku{2,4} variants
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, Aug 18, 2022 at 3:02 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 17/08/2022 22:33, Brian Norris wrote:
> > The Gru-Scarlet family includes a variety of SKU identifiers, using
> > parts of a 3-bit space {0..7}. SKU2 and SKU4 devices (under a few
> > different manufacturer names) also use the Innolux display.
> >
> > For reference, the original vendor tree source:
> >
> > CHROMIUM: arm64: dts: rockchip: add sku{0,2,4} compatibility
> > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/f6ed665c9e2eb37fb2680debbb36ec9fb0e8fb97
> >
> > CHROMIUM: arm64: dts: rockchip: scarlet: add SKU0 device tree
> > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/9987c8776f4b087d135d761e59f7fa6cc83fc7fc
> >
> > Signed-off-by: Brian Norris <briannorris@chromium.org>

> > --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> > +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml

> > +          - const: google,scarlet-rev15-sku2
> > +          - const: google,scarlet-rev15-sku4
>
> This does not match the sources you linked in commit msg, so I am
> confused what the links are supposed to prove.

It took 2 patches to get there (because SKU0 had some additional
customizations later, which were already upstreamed [0]), but the
result is the same. I'm not sure which part you think doesn't match.

One difference: they're listed in different order, because that seems
to be how the YAML schema is organized. But it doesn't make any
material difference, as long as the -skuX variants are listed before
the non-skuX variants (i.e., "more specific" goes first).

As to what they prove? Well, whoever applies is free to drop them if
they'd like, but I figured more documentation is better. IMO, it shows
that the real product uses those strings, and implies (but not quite
proves) the bootloader is looking for those. That is useful
information, if one expects to use an upstream kernel with the
production bootloader.

[0] https://git.kernel.org/linus/5707e34166f546bf1fcdfd3da600e8187d04d937
arm64: dts: rockchip: Add gru-scarlet-dumo board

> Is this matching at least your DTS (dtbs_check passes)?

Yes. (Well, after patch 2. I didn't try to make this bisectable.)

Brian
