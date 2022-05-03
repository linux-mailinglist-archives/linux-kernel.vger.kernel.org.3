Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362845188AA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238737AbiECPjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238615AbiECPip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:38:45 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBFCB7C
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:35:12 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id o5so9973120ils.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 08:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0FsDSj/gYms8H9/x7f/lo1swpziM40WrdI9xhy57C3M=;
        b=T+1w+41qi/SUDALtKFt5pALUPTwdTk3xL6e2vcdgxWaYXP8KJCATmyp6AB5/XG2R2n
         cxttGDxrpTrugEQTya0kvYSuTkOZB1gTsbf6SCSBFv8Ju68fEv9fI1LHVIa6ZhlOMkew
         aDkzgsQDFYdieq/KdrXWnc4F+7LcvhIMoJbC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0FsDSj/gYms8H9/x7f/lo1swpziM40WrdI9xhy57C3M=;
        b=zx1/JSosvkE5IQ+qQ9fKLogcWjXwrBxlQW56VCLaNWprE9hx2RWUzqm528KCmwSl5Z
         aLUax3V/WY2gKtal+j8yoGpN9AwO9/v4LcKHgg0cUCPHWAkoT44hprv+LXF5uDZxvkzH
         /Llq2G/ir7JJz9fMphVsWJdQ6Q5AwcKi2ycggRFHlNuq9W078Uk3Omt/tt9Icob5Pd4z
         IdihHcXMTxU9cxrnAZSbde1CoWqzkfrmshhs6l/hxkvZOeMAjigqFfEt9B5lgg/QLOY2
         gcdJyl5OpxYoTRz2D/2NV4TA+TGl7Df9vTN/hXE+MmMg1gsk5QVs3Erxj3i+yJ1saqzD
         rAwg==
X-Gm-Message-State: AOAM533OSjTFC6PEGGNLsPd6GB5TH6AWcl47qYyYgU9DgOUdCoWCSytQ
        Clww52Y0d3txnoYnp1UCpFUT7KlxxOYuD92a
X-Google-Smtp-Source: ABdhPJzwq7OVo7+aKGQ6e1XQbkZPpDpIuq3AJDbM+1G6/PYLGizh69fHq162zWaVu24lkQGr9YDoXg==
X-Received: by 2002:a92:c56f:0:b0:2cf:2e4d:5610 with SMTP id b15-20020a92c56f000000b002cf2e4d5610mr2227088ilj.253.1651592111905;
        Tue, 03 May 2022 08:35:11 -0700 (PDT)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id n42-20020a02716a000000b0032b3a7817e3sm3932337jaf.167.2022.05.03.08.35.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 08:35:11 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id y11so9965742ilp.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 08:35:11 -0700 (PDT)
X-Received: by 2002:a05:6e02:b23:b0:2cd:89db:f685 with SMTP id
 e3-20020a056e020b2300b002cd89dbf685mr7200200ilu.296.1651592110840; Tue, 03
 May 2022 08:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220430011402.1.If7c3471db53bea55213f7bcf17e9043084d3ac0c@changeid>
 <20220430011402.3.Ic20d0c002ac5406b880cbdf9824739f38740926c@changeid> <dbcb45d6-d495-1e5d-b7ad-963096e5fe9d@linaro.org>
In-Reply-To: <dbcb45d6-d495-1e5d-b7ad-963096e5fe9d@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 3 May 2022 08:34:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WhAqQnxwNaW4kfq9Wuwsz6YYzBgSn=KX9Se_5o2mkcsA@mail.gmail.com>
Message-ID: <CAD=FV=WhAqQnxwNaW4kfq9Wuwsz6YYzBgSn=KX9Se_5o2mkcsA@mail.gmail.com>
Subject: Re: [PATCH 3/5] arm64: dts: qcom: sc7180: Add quackingstick dts files
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Joseph S. Barrera III" <joebar@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 3, 2022 at 8:31 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 30/04/2022 10:15, Joseph S. Barrera III wrote:
> > Quackingstick is a trogdor-based board. These dts files are copies from
> > the downstream Chrome OS 5.4 kernel, but with downstream bits removed.
> >
> > Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
>
> (...)
>
> > +/*
> > + * Google Quackingstick board device tree source
> > + *
> > + * Copyright 2021 Google LLC.
> > + *
> > + * SKU: 0x601 => 1537
> > + *  - bits 11..8: Panel ID: 0x6 (AUO)
> > + */
> > +
> > +#include "sc7180-trogdor-quackingstick.dtsi"
> > +
> > +/ {
> > +     model = "Google Quackingstick (rev0+)";
> > +     compatible = "google,quackingstick-sku1537", "qcom,sc7180";
>
> Here and in other patches you keep adding undocumented board compatibles.

Sure, but perhaps we could continue the conversation at:

https://lore.kernel.org/r/CAD=FV=W_SA-3PfDFi-Gkjk9pew5bchFNjQhXX8MkZyuy5UohEQ@mail.gmail.com/

...to avoid forking it and losing all the context.

-Doug
