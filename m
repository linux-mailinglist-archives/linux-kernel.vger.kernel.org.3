Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240EB51F8C4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbiEIJfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbiEIJ2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:28:47 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119FF209B5D;
        Mon,  9 May 2022 02:24:54 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ba17so15535269edb.5;
        Mon, 09 May 2022 02:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LFcgVVJ7bK726HSSPtE+r4B2aXmQmGmr8tjtETzF3YE=;
        b=SCk+kS+aXSHUKOVJ2iBIKunz+vcKeLZXVRZZHJfW4513NoPDMHM/BlO9OtZ7pastdC
         W/17ymo2ZabbKF5AqescJlLZ70aU1Y97l5qpVLrA18jRc0OHqWQv8jc26EcjZrcOWJgx
         dHj0tCBpALYRpyVM+ddvFgwFOppJimHwgMIcd7eh5EABQOJIUoZWVsSh9zUzOph1salq
         27jvi086X5pbvzJgzxj/oTtHN9/bkaCl2rc7R84n0hivnm28KWv6VgNhxEqHfcwFy1Km
         FZvm+nMTTAeT0s1Qlvuzm7IvUgUETmh90LwK2vTHxI9i5QZ6N26z1U30HAg3ur85Fc7A
         avug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LFcgVVJ7bK726HSSPtE+r4B2aXmQmGmr8tjtETzF3YE=;
        b=IDm4iiYbLlhGGsSLZxelMdi/705R5RMDyqR7X+ypHUCuKCALZPHFimb/WuJ6knErEs
         rrroWqPiXD1NRSqU43obj2ONhUgSw1zp5BSODz9uQbg/pdraTvjC5LuHakbhY3m8lqj9
         0G+UgdugKH7fa7nHvnlTo4X2UkD+uZGnRBCMnopVxiU5ZtbwdUvX76A3UY9WwQJTU676
         o0f93gazFNX5gyQJuxUl1x86uL+2tRaWOLxSXSp662+w3IX8014i2qd30LSYOqn46QoE
         icTEDuID6FrZi2LT19K0TlqQUbrV4Um3kuhL2x1hH7ZaBoreDAQ97WWOtIefOmp0L8Uy
         GAZQ==
X-Gm-Message-State: AOAM530+P5+0SO2MMJbtvo16q2fOI9YJ8DOfMNYOQ09HQq83qmYJDYHU
        Bo4IP1DmqCl+l5/NpPtrgIs=
X-Google-Smtp-Source: ABdhPJx86XxIR0CMtq+ONANDVnTdQClivXE2E+RefrUi2Gb8ihwn5DKx9ngWTXM2K4DIENT7/NS20A==
X-Received: by 2002:a05:6402:4384:b0:427:b5c0:4bf with SMTP id o4-20020a056402438400b00427b5c004bfmr16757704edc.127.1652088292537;
        Mon, 09 May 2022 02:24:52 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id gz14-20020a170907a04e00b006f3ef214e62sm4869938ejc.200.2022.05.09.02.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 02:24:52 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: media: rockchip-vpu: Add RK3568 VEPU compatible
Date:   Mon, 09 May 2022 11:24:50 +0200
Message-ID: <3594222.Ivq9XVSPaC@archbook>
In-Reply-To: <422bf3bc-7787-97dd-6ab4-7570e5ce2ed8@linaro.org>
References: <20220508202544.501981-1-frattaroli.nicolas@gmail.com> <20220508202544.501981-2-frattaroli.nicolas@gmail.com> <422bf3bc-7787-97dd-6ab4-7570e5ce2ed8@linaro.org>
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

On Montag, 9. Mai 2022 09:25:23 CEST Krzysztof Kozlowski wrote:
> On 08/05/2022 22:25, Nicolas Frattaroli wrote:
> > The RK3568 and RK3566 have a Hantro VPU node solely dedicated to
> > encoding. This patch adds a compatible for it, and also allows
> > the bindings to only come with a vepu interrupt.
> > 
> > Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/media/rockchip-vpu.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> > index bacb60a34989..4045f107ca4e 100644
> > --- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> > +++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> > @@ -22,6 +22,7 @@ properties:
> >            - rockchip,rk3288-vpu
> >            - rockchip,rk3328-vpu
> >            - rockchip,rk3399-vpu
> > +          - rockchip,rk3568-vepu
> >            - rockchip,px30-vpu
> >        - items:
> >            - const: rockchip,rk3188-vpu
> > @@ -40,6 +41,7 @@ properties:
> >    interrupt-names:
> >      oneOf:
> >        - const: vdpu
> > +      - const: vepu
> 
> This should be enum (for both lines above) and you should add
> allOf:if:then with a constraints which variant can have which interrupts.
> 
> 
> Best regards,
> Krzysztof
> 

So something like this?

  interrupt-names:
    oneOf:
      - enum:
         - vdpu
         - vepu
      - items:
          - const: vepu
          - const: vdpu

What's the difference between a list of consts and an enum here?
I'm not very familiar with dt-schema, my apologies.

Also, since I don't know which of the other variants can have
the encoding interrupt and this wasn't brought up until now, I think
my solution will be to have a check for -vepu in the compatible and in
that case require that only the vepu interrupt is present, if that's
alright with you.

Regards,
Nicolas Frattaroli


