Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E7E57E3DF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 17:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbiGVPmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 11:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiGVPl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:41:58 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB5333A08
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 08:41:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id j22so9256434ejs.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 08:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QNhoAdkJOYGCxLXCG955jmFipTL24RpGzlTxtZa1urY=;
        b=TxtGiAqK/5NTEiqtOp73RYwUCkkv7lcxld3R3yrkBkg7ZyF7309NXSljnRcxB92tsP
         f5ZYnL9+vSwOFyD7Bcgsk8ORCZ2YRTw0wdpWCh3ut2w40WmngM1AMHIoCGeW+fJMjE9Z
         EKCOqRWKw2qP/6QyNYXS77o5mw/dCPD1SRauI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNhoAdkJOYGCxLXCG955jmFipTL24RpGzlTxtZa1urY=;
        b=P30Gnvr/q5HP1DIpRMYKGMCFabxAch6rx6ORyhzxq3GfPRIRSy46Bz15/OxPwZ07d3
         TrMQ9UHJsNWXAkNEpKSblXkAaRqEmPehzrURoeYIW+By3X3g9iJ6PZxjtkC5DhlnBhpx
         0H+hzOAFkXGpgq9lQIS/OMAWFh0m3eOmybIeiVQvxtkkwg18aa9WSW96gccmnQmjrXLy
         zZWLr0GvWH4EUAlvgFsNQg0VnxpAo7JWEDMCSk9rFGNfwOEwuvvT/ZVTNCHTI2jAzpJZ
         I0+7B5vvLPfjve9aW8zp9JaOxeOv6QjY6gytBs6obhnikU+7mZnDYCgF8TrssLIasS4b
         EY5Q==
X-Gm-Message-State: AJIora/TN7R9aadNdqbelJR98MHT9VncbsSint9P8+nIlrB1EkGcWnDC
        2DonHFUWZi6GgBUNbta5/JGoN+t+KKbvk7h8bdM=
X-Google-Smtp-Source: AGRyM1vG5hdwa/m+uFEg/u2MK07y1XrBCA09U1Xvc4mlqaxFxSBYyzvWKIquw8fxf3jEMrmOfxTmYQ==
X-Received: by 2002:a17:906:84f7:b0:72b:57c2:5e13 with SMTP id zp23-20020a17090684f700b0072b57c25e13mr413590ejb.702.1658504511630;
        Fri, 22 Jul 2022 08:41:51 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906594800b00722e7e48dfdsm2088501ejr.218.2022.07.22.08.41.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 08:41:49 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id bv24so7031233wrb.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 08:41:49 -0700 (PDT)
X-Received: by 2002:a05:6000:2c9:b0:21d:bd7d:3af6 with SMTP id
 o9-20020a05600002c900b0021dbd7d3af6mr341263wry.405.1658504508765; Fri, 22 Jul
 2022 08:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220721033918.v3.1.I10519ca1bf88233702a90e296088808d18cdc7b1@changeid>
 <20220721033918.v3.2.I7ecbb7eeb58c5e6a33e32a3abf4d6874e6cb725c@changeid>
 <CAD=FV=WSBgupLFMCZgianck6uTkAyqrG0WK2ChSbNbJdhOPdLA@mail.gmail.com>
 <4b2fe9d0-f590-0fac-79fa-bb05da1d61df@linaro.org> <CAD=FV=XmaNdc9k98vAwbcN-sm0w_WeqhRsK_AUm3h4LZ5-egmQ@mail.gmail.com>
 <c2b03863-2249-13e6-98e0-731c1b40d0a9@linaro.org> <CAD=FV=XKC_fbBzna8TgiPRmPH_=AQ3ckv2EEjoNvayKQ83Uciw@mail.gmail.com>
 <20220722002210.GA2223409-robh@kernel.org>
In-Reply-To: <20220722002210.GA2223409-robh@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 22 Jul 2022 08:41:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U1yqdPzdtJFu+Rk56TOX1kYX2BZ16XGuMoM+=Re5NA9A@mail.gmail.com>
Message-ID: <CAD=FV=U1yqdPzdtJFu+Rk56TOX1kYX2BZ16XGuMoM+=Re5NA9A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: arm: qcom: Document additional sku6
 for sc7180 pazquel
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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

On Thu, Jul 21, 2022 at 5:22 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jul 21, 2022 at 11:29:13AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Jul 21, 2022 at 9:52 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > On 21/07/2022 18:43, Doug Anderson wrote:
> > > > Hi,
> > > >
> > > > On Thu, Jul 21, 2022 at 9:33 AM Krzysztof Kozlowski
> > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > >>
> > > >> On 21/07/2022 15:37, Doug Anderson wrote:
> > > >>>
> > > >>> Not worth sending a new version for, but normally I expect the
> > > >>> bindings to be patch #1 and the dts change to be patch #2. In any
> > > >>> case:
> > > >>>
> > > >>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > >>
> > > >> I would say worth v4, because otherwise patches is not bisectable.
> > > >
> > > > You're saying because `dtbs_check` will fail between the two?
> > >
> > > Yes
> >
> > OK. Then I assume you agree that reversing the order of the patches
> > won't help, only combining the two patches into one.
> >
> >
> > > > How does
> > > > flipping the order help? If `dtbs_check` needs to be bisectable then
> > > > these two need to be one patch, but I was always under the impression
> > > > that we wanted bindings patches separate from dts patches.
> > >
> > > I don't think anyone said that bindings patches must be separate from
> > > DTS. The only restriction is DTS cannot go with drivers.
> >
> > I have always heard that best practice is to have bindings in a patch
> > by themselves. If I've misunderstood and/or folks have changed their
> > minds, that's fine, but historically I've been told to keep them
> > separate.
>
> Correct.
>
>
> > > Bindings for boards go pretty often with DTS (subarch). This is exactly
> > > what maintainers do, e.g.:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/log/?h=arm64-for-5.20
> > > Bindings for hardware should go via subsystem maintainer (drivers).
> >
> > OK, fair that in this case both the bindings and the yaml will land
> > through the Qualcomm tree. I guess it's really up to Bjorn and whether
> > he'd prefer "make dtbs_check" to be bisectable or whether he'd prefer
> > the bindings and dts change to be in separate patches from each other.
>
> Bindings go first if applied together because you have to define the
> binding before you use it. But sometimes things go via multiple trees
> and that's fine because it's just easier. In that case, the subsystem
> tree is preferred for bindings (i.e. with the driver). But in this case,
> Bjorn is the subsystem tree.

Thanks! I'll interpret your response as:

1. Keep this as two patches and it's more important to keep dts and
bindings separate than it is to avoid breaking bisectability of "make
dtbs_check".

2. Bindings should have been patch #1, but it's not a massive deal.

3. I'll assume that Bjorn will yell if he'd like this series re-posted
with the reverse order.

-Doug
