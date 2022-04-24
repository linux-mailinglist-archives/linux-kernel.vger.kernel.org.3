Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D2550D2E6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 17:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiDXPi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 11:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiDXPQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 11:16:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C179D15DD62;
        Sun, 24 Apr 2022 08:13:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t6so14119183wra.4;
        Sun, 24 Apr 2022 08:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FWeCcnpzZqH7svo/ZdB5Q/Oo1t1JBiHSzF3RVitO9AI=;
        b=Gm8BIwyhq8yHVI47LdqrobLhOB/zcyGWNZJ8N4Vbax/cOxbo4+LOmw6PSI8Z8Qz0F+
         j/UMUXmtqfgEW7l1AIjRMa9VQZVuqrCcONP7DGpkyBrPDRIftp64s2AANLUEcw4Y4J5e
         GD1DQcKgH8ITWJBcSbZI61LA9RjRD36OljQUG7aoAIN10f3bMVNdkOrbcfe02qV2a1FM
         oNo0Ru0tZqAFHFr+94pOueK9vWG4FL9deBwSd6Sw84RWZZ136t55YkSwal+tkY37R8kb
         8RwrsabYmEnVrebn+Ypcn9dZNhQt9KEl3+w8Tp1iQBBq/RSeYx1qo7rNzntbuiIvgRRe
         OVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FWeCcnpzZqH7svo/ZdB5Q/Oo1t1JBiHSzF3RVitO9AI=;
        b=4kqYV4cGZd/+UNS9/HVdZHirdvNQxTinJgqd5FnvD3Pf/ypsvn79DK5uSsKZM8VuEF
         Wl/PgjK+MdajO//JlCIuKck20i47Ano6CjWSxllevJ4od5vX0OWYDfSxlVhFh/n9wR4d
         msfbXyy0hlsBPTSybRG7uUlKqFrmfSgJUmgr1dcjFA50GMTn5gHK84OGjJltSDuT4kfI
         36VG5VWzI9RmastOk7TLTC/Jz/nY9ZsuFcXGfaMojNDJrla9r7o835KmFvjrbrv7SEaC
         EnmstSJaE3Ngi6TGDI9BGCrj3wUdh8MTDdQO83jjYonqmi299T+LWiziKdm3Ok2xxlM0
         xixw==
X-Gm-Message-State: AOAM531Z7WOJOsdNvd8vsVt5sSAyJrbwmceoa6Qol9aHqWt1veMVmEyX
        Mnr5ig+YlkjpzuzgbIbuOawiCE4RGBPiD4ApIBw=
X-Google-Smtp-Source: ABdhPJzfdZ8+nLnH1Kpa93XiW8FsjIIqN1jTW9uKwPw5/4uzXbPDdbXn1Ob18xayy7S/oNKmqzsqZhQtaCGlfY97wcw=
X-Received: by 2002:adf:f50e:0:b0:20a:c54a:42b0 with SMTP id
 q14-20020adff50e000000b0020ac54a42b0mr10805165wro.511.1650813207388; Sun, 24
 Apr 2022 08:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220418125630.2342538-1-gengcixi@gmail.com> <20220418125630.2342538-2-gengcixi@gmail.com>
 <714caf6e-5f81-6d73-7629-b2c675f1f1d4@linaro.org> <CAF12kFv6uioc7ATtXLpGTTDBFT1wYWZUBoyjQqP1bSUnut0pKA@mail.gmail.com>
 <a5a59f3c-00a3-afc5-24aa-1ae3de2600ec@linaro.org> <CAF12kFu5KW+fw=0kP6LrEqOvKYR38mELfPjG64=n+gudRxsZUQ@mail.gmail.com>
 <baa73bda-91af-8a31-67f4-6d5615862c73@linaro.org> <CAF12kFsxqdYERwhjC3tq9bNqzWS3P6Sb7VPCwHmQ=StF28Q-+A@mail.gmail.com>
 <5b00db5b-b179-af0f-71e4-e940c6a41018@linaro.org>
In-Reply-To: <5b00db5b-b179-af0f-71e4-e940c6a41018@linaro.org>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Sun, 24 Apr 2022 23:12:51 +0800
Message-ID: <CAF12kFt=L7CV5RDBViPSNb9Y_Te4JJ-TZrx2N+w_P2px7_FemQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] dt-bindings: clk: sprd: Add bindings for ums512
 clock controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Orson Zhai <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2022=E5=B9=B4=
4=E6=9C=8824=E6=97=A5=E5=91=A8=E6=97=A5 22:30=E5=86=99=E9=81=93=EF=BC=9A
>
> On 24/04/2022 16:22, Cixi Geng wrote:
> >>>>
> >>>> Neither here nor later you did not answer the question - why do you =
need
> >>>> such complex construction, instead of adding syscon to the clock con=
troller?
> >>>>
> >>>> Let me paste again my concerns:
> >>>>
> >>>>   You have nodes with reg but without unit address ("rpll"). These n=
odes
> >>>>   are modeled as children but they are not children - it's a workaro=
und
> >>>>   for exposing syscon, isn't it? The sc9863a looks like broken desig=
n,
> >>>>   so please do not duplicate it here.
> >>>>
> >>>> IOW, sc9863a uses similar pattern as here and the DTS is made wrong.
> >>>> Because of this you need to create complex ways to get the regmap fo=
r
> >>>> the clock controller... Why not making it simple? Clock controller w=
ith
> >>>> syscon?
> >>>
> >>> I find the history discuss about the sp9863 clock[1] and last
> >>> ums512-clk dt-bindings patch[2] which from chunyan.
> >>> please refer to the reasons below.
> >>>
> >>> These clocks are at the same register range with global registers.
> >>> the registers shared with more than one devices  which  basically
> >>> are multimedia devices. You may noticed that these are all gate
> >>> clocks which are in the global registers  ranges and are used to
> >>> controll the enable status of some devices or some part of devices.
> >>>
> >>> [1] https://lore.kernel.org/all/CAAfSe-s0gcehu0ZDj=3DFTe5S7CzAHC5mahX=
BH2fJm7mXS7Xys1Q@mail.gmail.com/#r
> >>> [2] https://lore.kernel.org/all/163425295208.1688384.1102318762579311=
4662@swboyd.mtv.corp.google.com/#r
> >>
> >> Which looks like discussion about different bindings. You had there a
> >> clock controller and additional clock device using "sprd,syscon". Why
> >> the rpll is a subdevice and not a part of clock controller. The same a=
s
> >> all other clocks coming from that clock-controller, right? What is so
> >> special about rpll that is is a separate device, not part of the clock
> >> controller? It's the same address space, isn't it?
> > The hardware spec design these clocks are not belonged to the syscon,
> > the phandle is only used to get virtual  map address for clocks which
> > have the same phsical address base with one syscon.(I don't know the
> > historical reason for this design) It also can wroten a clock sperated =
from
> > syscon by add the reg which same as syscon. but will lead to a duplicat=
e
> > mapping--one is from the clock,and one is from syscon. which make diffi=
culty
> >  in analyzing some panic problems.
>
> I don't understand still. You said that they do not belong to same
> address space, right? But the sprd,ums512-apahb-gate in this patch or
> mentioned rpll
> (https://elixir.bootlin.com/linux/v5.18-rc3/source/arch/arm64/boot/dts/sp=
rd/sharkl3.dtsi#L106)
> does not reference any other address space. It's entire address space is
> the same as address space of glbregs.
Maybe I didn't describe clearly, what I said is these clocks isn't the
syscom sub-clock.
from chunyan's explain:
 they  are at the same register range with global registers. in
originally we put them
directly onto the bus indeed when submitting the patches for SC9863A
clocks last year,
and it had a private property named 'sprd,syscon' which could provide
regmap for these clocks.
after follow Rob's suggetion we make them a child of the syscon. these
are all gate clocks which
are in the global registers ranges and are used to controll the enable
status of some devices
or some part of devices.
>
> So if it does not belong to the same address space, where is this space
> defined?
>
> Best regards,
> Krzysztof
