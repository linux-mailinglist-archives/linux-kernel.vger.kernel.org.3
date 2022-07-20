Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3E657BD40
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbiGTRyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbiGTRyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:54:12 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3C061B05
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:54:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id tk8so23058014ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ctz6Bj/1tsBk5/T9SJKUKyY4+CIziBZQwdo01hjp3G8=;
        b=lWkIFnYQD7yxdJ57mymN1bcXuzrHSYZCACCxSHvSeafJkvzxKZlV017M9cIEtJXSv5
         +ZFDy3IT9RrVDw6hsr/wUNGKWtnZ+YcKjdx++Ity5lrfjq6zIlz36my/ku9QrfAPnGMW
         p79Zo6qOUcw0VhLATLslDn3XqfD9hxLIWL+Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ctz6Bj/1tsBk5/T9SJKUKyY4+CIziBZQwdo01hjp3G8=;
        b=hxBzcseiM/pe9cwHpKxAe5MDNjAHQO36RJplloUX7IwQ1RQ7vuho2s2mwGWpYJHWzC
         Hjb675hxghBE3iYQsOHcnOOFnS+y/Z/SaIVgdDBK8qTrH5VkwEvCX0zOFBE0RIQtkc0C
         wG/tdjGgctWCZ6/+a/yttKuNl5kaHSa0oqwY/mSuk/ilnCO025wS+qaaCp1Pvdg3b5o2
         vPBf/rCtZP22rqsNW8mYlWl4pyxMnkVW8J5K5f/381immubyiykiDTDz7LoSymaOJdZM
         TDngbX+p90cX0K3LjCgu5ULKSDanTtibMQhZBF8KeVan81xK4vYFTFCM1fdPKxkZomaS
         uDZg==
X-Gm-Message-State: AJIora8tgUgL3TrxJS6kptIRmezQ/xbCAk544YEypHNxCWMcV1v3B79V
        CfKDtgk+wsMbKrU4zCFbsoZGe+Ag2VqVNkoe
X-Google-Smtp-Source: AGRyM1s44+bj2ujcpPXzkXYSMTaTLZI7niiUHH+EitdShCTHHemoKs+UnDwA5tilWwbkBLQszAItdQ==
X-Received: by 2002:a17:907:1dca:b0:72b:3cb2:81f7 with SMTP id og10-20020a1709071dca00b0072b3cb281f7mr34618076ejc.567.1658339650382;
        Wed, 20 Jul 2022 10:54:10 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id d27-20020a056402401b00b0043a8f5ad272sm12790033eda.49.2022.07.20.10.54.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:54:09 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id bv24so3317837wrb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:54:08 -0700 (PDT)
X-Received: by 2002:a5d:5889:0:b0:21d:bccd:38e3 with SMTP id
 n9-20020a5d5889000000b0021dbccd38e3mr30862732wrf.659.1658339647846; Wed, 20
 Jul 2022 10:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220720025058.1.I5bfba8857ea0d43c747ecdc3a950875abd56927f@changeid>
 <7a04c9af-0ccb-7711-249f-73908fe7ec36@linaro.org> <CAD=FV=V1MqQzNxq_L8sGtu2JwAAL_FWKXkw9bhCHcD0DycFMUw@mail.gmail.com>
 <bcbca05e-2b75-a405-b1ea-21b276931a90@linaro.org>
In-Reply-To: <bcbca05e-2b75-a405-b1ea-21b276931a90@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 20 Jul 2022 10:53:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UEt4fcVaFvS8nr7Z0GNYM1T=mz7iUhwg+bBkWtbO4c1g@mail.gmail.com>
Message-ID: <CAD=FV=UEt4fcVaFvS8nr7Z0GNYM1T=mz7iUhwg+bBkWtbO4c1g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: Add SKU6 for sc7180-trogdor-pazquel-lte-parade
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 20, 2022 at 9:55 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/07/2022 17:13, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Jul 19, 2022 at 11:10 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 20/07/2022 04:51, Yunlong Jia wrote:
> >>> SKU6 is LTE(w/o eSIM)+WIFI+Parade
> >>>
> >>> Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
> >>> ---
> >>>
> >>>  arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
> >>> index 764c451c1a857..4649eaec6318d 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
> >>> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
> >>> @@ -14,7 +14,7 @@
> >>>
> >>>  / {
> >>>       model = "Google Pazquel (Parade,LTE)";
> >>> -     compatible = "google,pazquel-sku4", "qcom,sc7180";
> >>> +     compatible = "google,pazquel-sku4", "google,pazquel-sku6", "qcom,sc7180";
> >>
> >> You miss binding change and sku6 should be rather added before sku4 as
> >> it is more specific, isn't it?
> >
> > Just to close the loop: the order doesn't matter at all. Neither sku4
> > nor sku6 is "more specific". One has the eSIM stuffed and one doesn't.
>
> Thanks Doug. Then the commit description could be improved, so reviewer
> does not have to ask such questions. Otherwise it is confusing to see a
> board which says it is for LTE version but it is actually not for LTE
> version (or whatever combination you have).

Yeah. I guess it makes more sense with the background knowledge that
the different SKUs are:

LTE with physical SIM _and_ eSIM
LTE with only a physical SIM
WiFi only

...so both sku4 and sku6 are LTE SKUs. One has the eSIM stuffed and
one doesn't. There is a single shared device tree for the two.

-Doug
