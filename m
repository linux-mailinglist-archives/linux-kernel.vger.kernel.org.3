Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED785538EE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbiFURc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbiFURcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:32:54 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FC9D5C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:32:52 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 68so10647904qkk.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDWLd8u/JyYSgS8BLWA6BB5+c2/1y05vpI/5e/F2mDE=;
        b=P1dagRCaJZH8jhpZC5udWDf1siXWgC4t/oJeBFlsrALbnhNl3JfXg8bUY5w2WYMUNV
         fns4Sybzhaf0akPLERfffEnXMHGejmhQGaxMg3zRUlryIsxZRtP/MmJJz/wK16qxApdW
         v88ye42cesewiXa5FFLDttxOgm5arcV1OtUDpRGUyrHMnappvZma7HFL+pW2PRQnH7Jt
         d8YJkk7gKXkZ7j0dCIMsI7IA/qmjoU0IUMkGCdEPkl2kqWZMkrnYf9FHvSFIO/DQLeDg
         +PxZVEv5Q0XxhVQ4pVf7Fip8lhcW5yRjF1pqYXtCyRK3qNTpv38JRFiR1qEbulCMdved
         rC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDWLd8u/JyYSgS8BLWA6BB5+c2/1y05vpI/5e/F2mDE=;
        b=UhkPCw2NRJo0SjEaeIXv7I6cJRZw5mr7unMUFdCrHpYseXvhRyLKfASGSWXETKVn2/
         6IG9bhF5b9p5gFXYpz/sdXzc/XKG+F3yr1n/29D9Y6vkg4JznNcKqv6fph6U1BY0fbO0
         p0qJSl7Smop3PuFOb3SNCY7U4RU8S+oPuQ5Yunc45PrVwrTsdugHoa7iBuScml08y65S
         5aXnWgK6PGsGminuaqMwUbadGoRiqHDNU4wdetL9z5lW7nFFJub1i1ll/KQ0ErKVtkL6
         TX/3a/wb4W50/M8OhGUfb7SlTy+504cfM8hmf50ERYzN/hHj2j/whGIbNlaEyx6Ldg2+
         c9EQ==
X-Gm-Message-State: AJIora+AZkZzm43xBjwueCXieCsskfjGOd4T78LFvudh6sZpdw/IIxrM
        i/b7TwM4xlZg6BFXusyx7/wyHIZvnnjCUlabfz1bdw==
X-Google-Smtp-Source: AGRyM1vAJ4oTLEa5lfkAbGOEqYgOyVlTv6vZRypfxxDvdKLImqLbizvk+7KZy/EwBm+aWMjWiL2MV5Sw3IXcWNtJIp4=
X-Received: by 2002:a05:620a:4305:b0:6a9:3829:c03 with SMTP id
 u5-20020a05620a430500b006a938290c03mr20769832qko.363.1655832771711; Tue, 21
 Jun 2022 10:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220621160621.24415-1-y.oudjana@protonmail.com>
 <20220621160621.24415-6-y.oudjana@protonmail.com> <CAA8EJprQTiU+=ajKSWbFfbHuVxjEiybTPNez66Ob+4YZ+fXW_A@mail.gmail.com>
 <XJ8UDR.9Y06T8FUTMOH2@gmail.com>
In-Reply-To: <XJ8UDR.9Y06T8FUTMOH2@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 21 Jun 2022 20:32:40 +0300
Message-ID: <CAA8EJppHu1Ld4OdGbMXhxrMAW6=Z79vCKk-Q6Whvi3BVpF6fKA@mail.gmail.com>
Subject: Re: [PATCH 5/6] dt-bindings: clock: qcom,msm8996-apcc: Fix clocks
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 at 20:29, Yassine Oudjana <yassine.oudjana@gmail.com> wrote:
>
>
> On Tue, Jun 21 2022 at 20:07:50 +0300, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> > On Tue, 21 Jun 2022 at 19:07, Yassine Oudjana
> > <yassine.oudjana@gmail.com> wrote:
> >>
> >>  From: Yassine Oudjana <y.oudjana@protonmail.com>
> >>
> >>  The clocks currently listed in clocks and clock-names are the ones
> >>  supplied by this clock controller, not the ones it consumes. Replace
> >>  them with the only clock it consumes - the on-board oscillator (XO),
> >>  and make the properties required.
> >>
> >>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> >>  ---
> >>   .../bindings/clock/qcom,msm8996-apcc.yaml         | 15
> >> +++++++--------
> >>   1 file changed, 7 insertions(+), 8 deletions(-)
> >>
> >>  diff --git
> >> a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
> >> b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
> >>  index a20cb10636dd..c4971234fef8 100644
> >>  --- a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
> >>  +++ b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
> >>  @@ -26,22 +26,18 @@ properties:
> >>
> >>     clocks:
> >>       items:
> >>  -      - description: Primary PLL clock for power cluster (little)
> >>  -      - description: Primary PLL clock for perf cluster (big)
> >>  -      - description: Alternate PLL clock for power cluster (little)
> >>  -      - description: Alternate PLL clock for perf cluster (big)
> >>  +      - description: XO source
> >>
> >>     clock-names:
> >>       items:
> >>  -      - const: pwrcl_pll
> >>  -      - const: perfcl_pll
> >>  -      - const: pwrcl_alt_pll
> >>  -      - const: perfcl_alt_pll
> >>  +      - const: xo
> >>
> >>   required:
> >>     - compatible
> >>     - reg
> >>     - '#clock-cells'
> >>  +  - clocks
> >>  +  - clock-names
> >
> > I think we can not list them as required, as then older DT files won't
> > pass schema validation. But I'll leave this into the hands of Rob and
> > Krzyshtof.
>
> The old DT files that didn't have XO defined had a wrong
> compatible string to begin with (fixed in [1]), so I don't
> think it's a problem.

Looks fine to me then. (Though Rob and Krzysztof have the deciding voice here).

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> >>   additionalProperties: false
> >>
> >>  @@ -51,4 +47,7 @@ examples:
> >>           compatible = "qcom,msm8996-apcc";
> >>           reg = <0x6400000 0x90000>;
> >>           #clock-cells = <1>;
> >>  +
> >>  +        clocks = <&xo_board>;
> >>  +        clock-names = "xo";
> >>       };
> >>  --
> >>  2.36.1
> >>
> >
> >
> > --
> > With best wishes
> > Dmitry
>
> [1]
> https://lore.kernel.org/linux-arm-msm/20210527192958.775434-1-konrad.dybcio@somainline.org/
>
>


-- 
With best wishes
Dmitry
