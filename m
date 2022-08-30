Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688805A6953
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiH3RN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiH3RN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:13:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B949BA176
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:13:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id nc14so18607234ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UvXjdpOBOlQjXTxcHn0j8A5QeMGUq/3slCHIZyddxdM=;
        b=Fnv5wPVDAk09qRTv+WtGrIZllXwiu2F/otARTbIkHxUNdqqLyJyPZawqnGFHLVb4cr
         Y9E67W2H8MQRfMD9BMeCnD6cb0/Wy5wfJJJ53jp9nFHhZlAJ8ZBKbM61XWMdtcon+o1v
         kX2NroAuimYpcIR9rGExM05zQgE9DD5+dY2Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UvXjdpOBOlQjXTxcHn0j8A5QeMGUq/3slCHIZyddxdM=;
        b=L94Ck9qItaa6G1+1eRcAm7PGvhW8Xzb00swRsy8/jPMkfU7np7+JfJXKYGGSwdbcjE
         vXNCtpZc+bb42EwrQKjqHh4hE85mDdzH5buue4SEIcfiL+YEwlceJ2PwsXDCHWBBVkLt
         kR5xAV13KpWLhpVWXSm++S6NL1gGyU9YAtT0EuajDGqZMFqC+l/2drGcTE27A7cdun2B
         CholDE2wlPEX2fjlZQevaPGhwnLcjmZpNQ7LzRtSTwG23BvpOYBYMwFPo9H+oEai15WK
         FdXE/hLBbbY6bTtLZNRZnUR9G9lyBYAh5GJxovRyl9Nu/lEQD/qe2O2VZM2JVTsHOSkS
         zM7Q==
X-Gm-Message-State: ACgBeo2NCFTvrERcgPDTMr/Bl4eDszeLJWbLU8AFvAu/uHBRYAHD0scZ
        dFD7oL4vVRX5rDpMmlYm1W3+x1+bM1FSfWJE
X-Google-Smtp-Source: AA6agR7RGloCj1FWOfNLisnHrRnVwsRwa+Rck7YSXvyW7lodsYltFNqyg7sgH2r0x/UFZ5ej+D3LDQ==
X-Received: by 2002:a17:907:a218:b0:731:2b2b:f34 with SMTP id qp24-20020a170907a21800b007312b2b0f34mr17898166ejc.404.1661879603844;
        Tue, 30 Aug 2022 10:13:23 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id t17-20020a508d51000000b00448cb764290sm1339521edt.92.2022.08.30.10.13.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 10:13:23 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id k9so15144757wri.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:13:22 -0700 (PDT)
X-Received: by 2002:a5d:6881:0:b0:225:28cb:332f with SMTP id
 h1-20020a5d6881000000b0022528cb332fmr9527247wru.405.1661879602477; Tue, 30
 Aug 2022 10:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220830053307.3997495-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20220830133300.1.I7dd7a79c4cc5fe91c3feb004473feb3b34b7b2d8@changeid>
 <184d4ff5-e80c-6a24-8071-0b0a69710685@linaro.org> <CAD=FV=VorVNKHgybGAH=dD5ob+1RYoguczycjOYu-5VPu=9Jkw@mail.gmail.com>
 <bc707091-3417-bc89-70bf-3a2496a11196@linaro.org>
In-Reply-To: <bc707091-3417-bc89-70bf-3a2496a11196@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 Aug 2022 10:13:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U+JdT8YMwMdbcK+14fSBXt7U3J7DtZFR0LxER0bS_9fQ@mail.gmail.com>
Message-ID: <CAD=FV=U+JdT8YMwMdbcK+14fSBXt7U3J7DtZFR0LxER0bS_9fQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64: dts: qcom: sc7280: Add device tree for
 herobrine evoker
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 30, 2022 at 9:50 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 30/08/2022 19:10, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Aug 30, 2022 at 2:33 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >>> +};
> >>> +
> >>> +/*
> >>> + * ADDITIONS TO FIXED REGULATORS DEFINED IN PARENT DEVICE TREE FILES
> >>
> >> What does it mean and why it's SCREAMING?
> >>> + *
> >>> + * Sort order matches the order in the parent files (parents before children).
> >>
> >> Why? Sorting should be rather alphabetical.
> >
> > We've had this discussion on the lists in the past. See, for instance:
> >
> > https://lore.kernel.org/r/CAD=FV=U2C1W+JHWyGRfyRB=WiPKLYvtjO90UDoJ9p+Xwe09+ow@mail.gmail.com/
>
> Good explanation, such sorting rule is quite nice. The part about
> regulators is still a bit confusing, I guess it is about some other
> pieces in some other place?

Yeah, we originally started with the regulator sorting of "parents
above children" long ago when it helped avoid some cases of
-EPROBE_DEFER in Linux. The -EPROBE_DEFER isn't a reason these days,
but when I looked back at it I decided that I quite liked "parents
above children" and that it matched my mental model.

Specifically, take a look at
"/sys/kernel/debug/regulator/regulator_summary". Parent regulators are
listed above child regulators because it makes the most sense to think
of the regulator tree. Obviously we can only do this in the dts for
regulators that are separate nodes and not ones provided by a big
PMIC, but we often end up with quite a few of those in the end.

In "child" device trees that are overriding a single regulator (like
evoker) the comment is a bit nonsensical, of course. I'd be OK with
removing the "Sort order matches the order in the parent files
(parents before children)." in the evoker device tree since there's
really only one regulator in this section. The only downside would be
that when someone adds that second regulator then they might not know
the sort ordering. ...so I would be fine keeping it too...


> But isn't this kind of obvious from
> including other DTSI?

Isn't what kind of obvious from including the other DTSI? That the
sort order should match the sort order of the parent for this section?
It wasn't obvious to me. Since there are usually just a few regulators
that referenced like this it seemed like it might be easiest to just
alphabetize them in the child device trees. ...but I settled on
thinking that matching the parent was marginally better. Since I
debated it myself I decided it was probably better to comment so
others understood the sort order...

-Doug
