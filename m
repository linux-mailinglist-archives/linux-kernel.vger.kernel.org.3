Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D4250F061
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 07:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243809AbiDZFox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 01:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245012AbiDZFol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 01:44:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77717393E3;
        Mon, 25 Apr 2022 22:41:05 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d5so8583083wrb.6;
        Mon, 25 Apr 2022 22:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ivY9A8MlugZ6JM+jO9WfyfI8NDozRx01AU86/wCMjkk=;
        b=Y46WTmyvQ1TX2po88VJOtwZs3frKBkWm7UrRr4XGjsqw8mXs3kmWdf5CTJ6n2mgnNs
         s2r7IwmeLOY7UQT28VxgsxDM3rK1oV5g7gODgMPaX84y5vq+R8NwKwjJTITbZTltuK/K
         N9vxNiW7g+A6Y2O1GCMcEirKJWpsBr7S35w1nrcZ9enpB77Ly3J/1UbnJNzlNdZMxZah
         2dRZyg47Fr63FW4byIAoFHwRf7pnuHUubfqbfBxpnSuFNprCAxrV4q0dQKI+sNCvYKGr
         sBIFV4XaAsBub5wMl6ZHzt4xTklEiZmxBcCGZ/nlWVLxZwmH/Aa9enusyQA+3STVcqpI
         JUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ivY9A8MlugZ6JM+jO9WfyfI8NDozRx01AU86/wCMjkk=;
        b=40naeQIxIveGWtNbu9t3tlIgeSgPuvFlLPhUl8/1xfyKsnIWIPLThfSGskS3a4VU4w
         mT8JFuSWqPEdsWJsKrtn5joAStg1srML7M+za5ozRCKKCAkH/rCxCfv5RXoIZ2QdMEcr
         ZEt8uJMOFLYQCd2CHwNlynG6yJ0Cyhnx/RGewx3BSgYOtkxCw2iLvaUn7lcawqB0pjkt
         RQ4BUPux4DGP/rksTNnXQaVLdGvxr4Fs4wIKDjAt9Mk8IeTfGu+Ljy8HBSTZZCzQ059d
         DupUavN88axSYTqZZddskuACvOW9N6EcW7B0rJVSrFvWu823PV5fHJxUh8o4QmPdvuCh
         TLAA==
X-Gm-Message-State: AOAM533Kcj1O4JaOJKlcf+ENd83Sg8afnmKuoUxlUDfdpVB1fhtdNNSr
        mH6ACTMtQgU0Ov/1LjWXQlSW38wOScJ8Y8FD1lo=
X-Google-Smtp-Source: ABdhPJz4Be6fGelqulSb5go88CmpvpBppykdtB4VLAYI+zCd0IsU+v6yJwkDXWUpCzFIMC3z3y9zrrzkLeQ5bZlpUZI=
X-Received: by 2002:a5d:6e85:0:b0:207:a435:d9a7 with SMTP id
 k5-20020a5d6e85000000b00207a435d9a7mr16610956wrz.217.1650951663941; Mon, 25
 Apr 2022 22:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220418125630.2342538-1-gengcixi@gmail.com> <20220418125630.2342538-2-gengcixi@gmail.com>
 <714caf6e-5f81-6d73-7629-b2c675f1f1d4@linaro.org> <CAF12kFv6uioc7ATtXLpGTTDBFT1wYWZUBoyjQqP1bSUnut0pKA@mail.gmail.com>
 <a5a59f3c-00a3-afc5-24aa-1ae3de2600ec@linaro.org> <CAF12kFu5KW+fw=0kP6LrEqOvKYR38mELfPjG64=n+gudRxsZUQ@mail.gmail.com>
 <baa73bda-91af-8a31-67f4-6d5615862c73@linaro.org> <CAF12kFsxqdYERwhjC3tq9bNqzWS3P6Sb7VPCwHmQ=StF28Q-+A@mail.gmail.com>
 <5b00db5b-b179-af0f-71e4-e940c6a41018@linaro.org> <CAF12kFt=L7CV5RDBViPSNb9Y_Te4JJ-TZrx2N+w_P2px7_FemQ@mail.gmail.com>
 <0423e827-9592-ce6f-74ca-111a099a263f@linaro.org>
In-Reply-To: <0423e827-9592-ce6f-74ca-111a099a263f@linaro.org>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Tue, 26 Apr 2022 13:40:27 +0800
Message-ID: <CAF12kFuwgGJSXpC8e=6L1XgP4zFOjbdLazwuqR0jg=2OJ=RtRA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2022=E5=B9=B4=
4=E6=9C=8825=E6=97=A5=E5=91=A8=E4=B8=80 17:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On 24/04/2022 17:12, Cixi Geng wrote:
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2022=E5=
=B9=B44=E6=9C=8824=E6=97=A5=E5=91=A8=E6=97=A5 22:30=E5=86=99=E9=81=93=EF=BC=
=9A
> >>
> >> On 24/04/2022 16:22, Cixi Geng wrote:
> >>>>>>
> >>>>>> Neither here nor later you did not answer the question - why do yo=
u need
> >>>>>> such complex construction, instead of adding syscon to the clock c=
ontroller?
> >>>>>>
> >>>>>> Let me paste again my concerns:
> >>>>>>
> >>>>>>   You have nodes with reg but without unit address ("rpll"). These=
 nodes
> >>>>>>   are modeled as children but they are not children - it's a worka=
round
> >>>>>>   for exposing syscon, isn't it? The sc9863a looks like broken des=
ign,
> >>>>>>   so please do not duplicate it here.
> >>>>>>
> >>>>>> IOW, sc9863a uses similar pattern as here and the DTS is made wron=
g.
> >>>>>> Because of this you need to create complex ways to get the regmap =
for
> >>>>>> the clock controller... Why not making it simple? Clock controller=
 with
> >>>>>> syscon?
> >>>>>
> >>>>> I find the history discuss about the sp9863 clock[1] and last
> >>>>> ums512-clk dt-bindings patch[2] which from chunyan.
> >>>>> please refer to the reasons below.
> >>>>>
> >>>>> These clocks are at the same register range with global registers.
> >>>>> the registers shared with more than one devices  which  basically
> >>>>> are multimedia devices. You may noticed that these are all gate
> >>>>> clocks which are in the global registers  ranges and are used to
> >>>>> controll the enable status of some devices or some part of devices.
> >>>>>
> >>>>> [1] https://lore.kernel.org/all/CAAfSe-s0gcehu0ZDj=3DFTe5S7CzAHC5ma=
hXBH2fJm7mXS7Xys1Q@mail.gmail.com/#r
> >>>>> [2] https://lore.kernel.org/all/163425295208.1688384.11023187625793=
114662@swboyd.mtv.corp.google.com/#r
> >>>>
> >>>> Which looks like discussion about different bindings. You had there =
a
> >>>> clock controller and additional clock device using "sprd,syscon". Wh=
y
> >>>> the rpll is a subdevice and not a part of clock controller. The same=
 as
> >>>> all other clocks coming from that clock-controller, right? What is s=
o
> >>>> special about rpll that is is a separate device, not part of the clo=
ck
> >>>> controller? It's the same address space, isn't it?
> >>> The hardware spec design these clocks are not belonged to the syscon,
> >>> the phandle is only used to get virtual  map address for clocks which
> >>> have the same phsical address base with one syscon.(I don't know the
> >>> historical reason for this design) It also can wroten a clock sperate=
d from
> >>> syscon by add the reg which same as syscon. but will lead to a duplic=
ate
> >>> mapping--one is from the clock,and one is from syscon. which make dif=
ficulty
> >>>  in analyzing some panic problems.
> >>
> >> I don't understand still. You said that they do not belong to same
> >> address space, right? But the sprd,ums512-apahb-gate in this patch or
> >> mentioned rpll
> >> (https://elixir.bootlin.com/linux/v5.18-rc3/source/arch/arm64/boot/dts=
/sprd/sharkl3.dtsi#L106)
> >> does not reference any other address space. It's entire address space =
is
> >> the same as address space of glbregs.
> > Maybe I didn't describe clearly, what I said is these clocks isn't the
> > syscom sub-clock.
> > from chunyan's explain:
> >  they  are at the same register range with global registers. in
> > originally we put them
> > directly onto the bus indeed when submitting the patches for SC9863A
> > clocks last year,
> > and it had a private property named 'sprd,syscon' which could provide
> > regmap for these clocks.
> > after follow Rob's suggetion we make them a child of the syscon. these
> > are all gate clocks which
> > are in the global registers ranges and are used to controll the enable
> > status of some devices
> > or some part of devices.
>
> You need to help me here with the naming. What is "global registers"
> range? Let's focus on sharkl3.dtsi and syscon@4035c000 with "rpll".
>
> You have a clock controller @4035c000, which provides several clocks,
> right? Then you have a rpll also @4035c000, so the register range is the
> same. The register range is the same, isn't it?

the anlg_phy_g5_regs is not a clock controller.
In fact, this is just to provide an address for other modules to call regma=
p.
not provide a clk interface or device.
The clk configuration of rpll is based on the anlg_phy_g5_regs register.
The analog_g5 asic document is not only used to configure rpll, but also ot=
her
functions can be configured, but currently our driver is only used to provi=
de
configuration rpll, so the range of the device node of rpll can be less tha=
n or
equal to the range of anlg_phy_g5_regs.
Hope this could explains your question

Best regards,
Cixi
>
> I still don't see the answer to my question - why do you need a child
> device for one clock if this looks like part of the clock-controller?
>
> Best regards,
> Krzysztof
