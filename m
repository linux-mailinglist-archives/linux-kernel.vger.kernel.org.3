Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB7B5990A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239950AbiHRWkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239711AbiHRWkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:40:01 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6EFD31E1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 15:40:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id j8so5772909ejx.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 15:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=IjSeQulZP01xUbC8USliBx2oPfWvmG2UcFTgcurAAOM=;
        b=P9xvqk9NHwu+xbO9v1CQj1IbgkfjPi/VAsR2rs+ERg3WJNJnZnLDjeMOcIAv897NdQ
         y1wXBvkXKd6y6b2w/Ra1ymL9aFC9/vV3qytakRAIm07ptDI2Tnxo6Un5KOxMxyFWLPK5
         W11vtX2V1u/9FyImgAikGoI46CGWe296Gyjps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=IjSeQulZP01xUbC8USliBx2oPfWvmG2UcFTgcurAAOM=;
        b=NeVBHQLwuZ+aGBFINKSr5ZYvvz+NlzhlUA9amaFSdCub7m9j2EJoe+8v0A3/7RHnuu
         DNSZ/z3h7XnnhdvBL2ICiNtj73X5f/6k2blzidx1PqLqGJLzes07V53gcxKSDydvKY4G
         ADNVGSTQQpgXYu0xVk3672xeQbg7hgZ2e8k0K/kTtvoEhj8+wJxAvg6/8T1cJJ9dYHIq
         sMsdXoLiWUQfBJfK6rkvt1brQuuEfM5/NOymctwnK09OmhRLi0vjPqB/eO2S9Fwet1vN
         Tmsp/DBGWj8V9GVUtAN9DgJ9TIsOwy3avzUG2dpTNm2mqJL3rYptEJRb0j+dmtuL2rrx
         v+3Q==
X-Gm-Message-State: ACgBeo1ymC5SL6+j9sFfb9PWNKYAFch/d9nEO/h5aTjnSZ/CUBnpSO4n
        58ohqijAAqZ+GPvT2I2haDp9YQ/3f5tPblcV
X-Google-Smtp-Source: AA6agR4O8+1Y0R+ghdtBMehW04Laud3IbshcloSLUFG0urZRVaQspgukiAPi7dgBpe+7BQFOLxRKzg==
X-Received: by 2002:a17:907:7284:b0:731:82a3:16e3 with SMTP id dt4-20020a170907728400b0073182a316e3mr3151004ejc.30.1660862398351;
        Thu, 18 Aug 2022 15:39:58 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id r17-20020a1709061bb100b00731745a7e62sm1395764ejg.28.2022.08.18.15.39.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 15:39:57 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id e20so2771615wri.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 15:39:56 -0700 (PDT)
X-Received: by 2002:a5d:6881:0:b0:225:28cb:332f with SMTP id
 h1-20020a5d6881000000b0022528cb332fmr2614963wru.405.1660862395890; Thu, 18
 Aug 2022 15:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220818084216.1.I5c2b6fea19c4c0dec67fd4931f03df8e5ccaca95@changeid>
 <CAE-0n52GzxXEsToWzfU1TMuASuC6TKK7NXxYbBQWxNmM74FxZA@mail.gmail.com>
 <CAD=FV=WNuqtpnCr2Zn0z_L1OCiwD8dNzhDxvhfHYuYVmciPbuQ@mail.gmail.com> <60b5b49b-eb7a-c552-fcf1-3d3a360f8e25@chromium.org>
In-Reply-To: <60b5b49b-eb7a-c552-fcf1-3d3a360f8e25@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Aug 2022 15:39:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UkaiDSYvm7W1tnoty=3dnYTUaEmNcbP7=uEzniELt7QA@mail.gmail.com>
Message-ID: <CAD=FV=UkaiDSYvm7W1tnoty=3dnYTUaEmNcbP7=uEzniELt7QA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Add sleep state for alc5682 codec
To:     "Joseph S. Barrera III" <joebar@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alexandru Stan <amstan@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mengqi Guo <mqg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 18, 2022 at 3:19 PM Joseph S. Barrera III
<joebar@chromium.org> wrote:
>
> On 8/18/22 1:34 PM, Doug Anderson wrote:
> > I tend to agree with Stephen's analysis. We actually need to keep the
> > pullup enabled unless we are actually turning power off to the codec,
> > which we don't seem to be doing.
> >
> > I guess I'm a little surprised that we don't even seem to turn any of
> > this codec's regulators off in S3. That seems like it would be drawing
> > power that we don't want. Maybe the "low power" mode of the codec is
> > low enough and we need to avoid powering it off to avoid pops / hisses
> > in S3 or something? If that's true, this might be one of those places
> > where the "LPM" of the regulators might actually be useful...
>
> OK, fair enough, so suggestions on what I should do instead? Should I
> look at why or how to turn the regulators off? Should I look into LPM?
> Are there existing bugs for such work?

It would be interesting to know from Judy if there's a reason we never
turn the audio codec rails off. Maybe there's history that I'm not
aware of? Matthias or Mengqi might also have ideas of how much power
is at stake here?

Ah, searching through the ChromeOS bug tracker finds some hits. At
this point we should probably move the discussion off the lists and
bring it back to the lists when we have some results. Unfortunately
most of the bugs are not public and so having a discussion here is
just noise for most people CCed.

-Doug
