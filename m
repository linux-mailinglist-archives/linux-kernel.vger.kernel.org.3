Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0BC518979
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbiECQSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239256AbiECQSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:18:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B693B29F
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:14:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l7so34442593ejn.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 09:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bOowZENKEYBOQ5gQtuLs74mzTNH8Gi+Wvcp/0afqUT4=;
        b=EEwYnpnu/2Fhr2sQHT2uhYWiyPhvmtU8DzHokKeYAXu5vlR0UiuNcMwlij7eWJT/Nd
         KGBSe8Pej98sSFsthhMfgTmsJ5yPc7UFnVb+KTUDaeG/1/BJHloKuzgbBAk7p6W+v8RQ
         xOP2eAJC4V5tKxUYoLIDLfVmxDH3iyr65NTWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bOowZENKEYBOQ5gQtuLs74mzTNH8Gi+Wvcp/0afqUT4=;
        b=wRVWswraKtWFIkrk2CWklF7c7Sjz6Cmzm91d6ltr3++LQfJFO1OLQOXpGeUbeIFonN
         ITzfyuHn/5cn/ETgJ2UWacfTv9YYdZQ6LNH0GdPklbTtshRBnMr54TCjGOaon6bV+dWF
         KwdJyiQaScQXSHAu2QB1JiDavacEyVWuNPd+cTOUOftnhbqt8FwVp7/jv4mK99KdOfzd
         a6WXODrAoAcB2k1PZU8St18YF5dFGuZWq+BNR6E8lbGzpBhPT/RHhBKbb8anO3BUpaab
         jUSzMFHEYL4g65DuTQZDefw28pa7m42zR52hBtfLIemzS41snFMZK+vUTNkc5Hn9Lhjw
         mYIA==
X-Gm-Message-State: AOAM533xVywIoFRhruYFzIoBtXXUyOEtlFogCdgoGi9TgI39T49UGxbA
        3bSoV9AZw+vZcbDFWfC5RK4cjywIk7FWmeC9
X-Google-Smtp-Source: ABdhPJz6pj4HHgPnZlzEb79O2O1+j5MI2/03yKzcVgidabW85U43pbRk3v4l0+H1zL3PeQB+a79f6Q==
X-Received: by 2002:a17:907:1c87:b0:6f0:29ea:cc01 with SMTP id nb7-20020a1709071c8700b006f029eacc01mr16455099ejc.671.1651594477006;
        Tue, 03 May 2022 09:14:37 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id y5-20020a056402170500b0042617ba63d3sm8095549edu.93.2022.05.03.09.14.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 09:14:35 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id b19so24019499wrh.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 09:14:34 -0700 (PDT)
X-Received: by 2002:adf:f50d:0:b0:20a:e096:ef with SMTP id q13-20020adff50d000000b0020ae09600efmr13256382wro.679.1651594474057;
 Tue, 03 May 2022 09:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220503042242.3597561-1-swboyd@chromium.org> <20220503042242.3597561-2-swboyd@chromium.org>
 <2280875f-fbd8-0dfd-5a0a-1d7fceb856e4@linaro.org> <CAD=FV=UEBi9dctmhaAi1z+c+Sj5gtcRrc3FRW294T55dTiAidQ@mail.gmail.com>
 <cd1da207-1f15-f3f1-7190-56b983e75024@kernel.org>
In-Reply-To: <cd1da207-1f15-f3f1-7190-56b983e75024@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 3 May 2022 09:14:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XHNuvhekh=hepGePftaMXnDJGeJP=Lg8VfqmGdKt7HEA@mail.gmail.com>
Message-ID: <CAD=FV=XHNuvhekh=hepGePftaMXnDJGeJP=Lg8VfqmGdKt7HEA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: google,cros-ec-keyb: Introduce
 switches only compatible
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 3, 2022 at 8:54 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 03/05/2022 17:46, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, May 3, 2022 at 8:42 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 03/05/2022 06:22, Stephen Boyd wrote:
> >>> If the ChromeOS board is a detachable, this cros-ec-keyb device won't
> >>> have a matrix keyboard but it may have some button switches, e.g. volume
> >>> buttons and power buttons. The driver still registers a keyboard though
> >>> and that leads to userspace confusion around where the keyboard is.
> >>
> >> (...)
> >>
> >>>
> >>> +if:
> >>> +  properties:
> >>> +    compatible:
> >>> +      contains:
> >>> +        const: google,cros-ec-keyb
> >>> +then:
> >>> +  allOf:
> >>> +    - $ref: "/schemas/input/matrix-keymap.yaml#"
> >>> +  required:
> >>> +    - keypad,num-rows
> >>> +    - keypad,num-columns
> >>> +    - linux,keymap
> >>
> >> else:
> >>   properties:
> >>     function-row-phsymap: false
> >>     google,needs-ghost-filter: false
> >>
> >> Because these are not valid for the non-matrix-keyboard case, right?
> >
> > Isn't that implicit because this file has `unevaluatedProperties: false` ?
>
> But they are evaluated here, aren't they?

Only if the "if" test, though? ...ah, or is this a difference between
"unevaluatedProperties" and "additionalProperties" ?

-Doug
