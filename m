Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF0A523A79
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344876AbiEKQj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiEKQj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:39:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E46A6E8EE;
        Wed, 11 May 2022 09:39:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id i27so5183520ejd.9;
        Wed, 11 May 2022 09:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wuJ85LzoJRTqUhxUdivNhhyhKIi6qZtS9mW54zLXzCI=;
        b=iiKpqEho+iTsam9OSQMO7b0tE1w9WoUryaoiVxDtMeerHmXp30BR6A59hYZ1uoN+L+
         cct+2DPf3NvH2LBE7HppPi4ZjBp7n755AdOSmQ98GHrt28pXEd8Qsn3pk/8zu8BP9NpU
         72jRXVhdkkNo2t5Cgj4k8MkLpI1YnqVglZPeZN5Zh+UfM8HnEaFsT8uAEH706wQRRqpo
         wZ1AMGdA9WEIvxJY2NMECCM8fUKWeKdAqVCsx3ArMu+Y9cIeWnIwdPOO5IncTe5uX7vg
         ItbnLe67bUwKKD5GG8z5SQWR0kaLnukpldz07VITIdhIYXqjEM6C7odJ9VGLZXLGFZfC
         pupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wuJ85LzoJRTqUhxUdivNhhyhKIi6qZtS9mW54zLXzCI=;
        b=wBD+YUOE/rsHQTV0yiabq9yQ1VKW08fdpjmpTgBlqc1gCoXMVGEGBI769ofuDGdEuP
         pHfj/TvN/I0UCXZCwpz3aXbMeksn0OCTomHq1tf3ylc0pNVB/qMSwcCx+COUJibC2jY5
         daPY3tJwHLTtSsaArK0VaWs1A1qp18DDd0Y+abGDQNKsJ8jmmsjVPiZI4rZXlpHWBSjs
         9tLpsQ1WzinX3UpSU/L7mlWGerHH80XtRyUt8XlvLRG0jfLtR99TtUOjryBaGrhWs4Po
         UvbzpobQKb1RfrAULKC3uqCyP5gvOD1MQX3U4NtbAAOez5FkyDQaiw2xoVpgt3vCsH/P
         LsMQ==
X-Gm-Message-State: AOAM531mPF7rfDyEZogeU6OyG/HgIte3JkEnCAsOo4O26H4VWV2RYdoK
        /mE1vQPCn8v8/R9EkjpPxwM=
X-Google-Smtp-Source: ABdhPJwVdUjdYNHQDUWiDOlIQIJ3TgAkOAOMXfzEukY8HEFYvt3YDNxs1GNlFUSIle37aTchXgIIDQ==
X-Received: by 2002:a17:906:4fd5:b0:6f8:5aa9:6f13 with SMTP id i21-20020a1709064fd500b006f85aa96f13mr21390266ejw.267.1652287164116;
        Wed, 11 May 2022 09:39:24 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id a7-20020a170906670700b006f3ef214e31sm1137536ejp.151.2022.05.11.09.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 09:39:23 -0700 (PDT)
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
Subject: Re: [PATCH v3 1/3] dt-bindings: media: rockchip-vpu: Add RK3568 VEPU compatible
Date:   Wed, 11 May 2022 18:37:54 +0200
Message-ID: <2486415.XAZu0pfo7u@archbook>
In-Reply-To: <bc4c395d-4e21-1d15-96be-00a5cad1d6f7@linaro.org>
References: <20220511155309.2637-1-frattaroli.nicolas@gmail.com> <20220511155309.2637-2-frattaroli.nicolas@gmail.com> <bc4c395d-4e21-1d15-96be-00a5cad1d6f7@linaro.org>
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

On Mittwoch, 11. Mai 2022 18:00:09 CEST Krzysztof Kozlowski wrote:
> On 11/05/2022 17:53, Nicolas Frattaroli wrote:
> > The RK3568 and RK3566 have a Hantro VPU node solely dedicated to
> > encoding. This patch adds a compatible for it, and also allows
> > the bindings to only come with a vepu interrupt.
> > 
> > Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > ---
> >  .../devicetree/bindings/media/rockchip-vpu.yaml | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> > index bacb60a34989..965ca80b5cea 100644
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
> > @@ -39,7 +40,9 @@ properties:
> >  
> >    interrupt-names:
> >      oneOf:
> > -      - const: vdpu
> > +      - enum:
> > +          - vdpu
> > +          - vepu
> >        - items:
> >            - const: vepu
> >            - const: vdpu
> > @@ -76,6 +79,18 @@ required:
> >  
> >  additionalProperties: false
> >  
> > +allOf:
> > +  # compatibles that end in -vepu should only have the vepu interrupt
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            pattern: "^[a-zA-Z0-9\\-,_.]+\\-vepu$"
> 
> Why not listing the compatible how I asked? This is the common way of
> handling allOf:if:then per variant.

Because I was afraid that if this wasn't general enough to apply to all
future vepu-only instances of Hantro, then my patch might be bikeshed
into requiring a v4. Clearly, my worries had the opposite effect.

Also because I thought it was cool to use a pattern for this to enforce
consistent naming in the bindings.

> 
> https://lore.kernel.org/all/ea94f18d-3172-98bb-0892-a98236a08018@linaro.org/
> 
> Your patches do not apply on next, so the set might not have been tested
> by Rob's bot.

Good to know. Once I send out v4 in a few days and maybe after some more
opinions so I can stop bombarding the mailing list with tiny revisions
of the same patch set, I will base it on linux-next.

I'm happy to report though that this passes dt_binding_check with W=1
without adding any new warnings. I do actually run those checks (and
checkpatch) before submitting.

> 
> Best regards,
> Krzysztof
> 

Regards,
Nicolas Frattaroli


