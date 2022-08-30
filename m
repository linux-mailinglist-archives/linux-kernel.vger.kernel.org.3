Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06B85A67F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiH3QK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiH3QK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:10:56 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CF5B5148
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:10:56 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b16so14868372edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=HeI9CTL7SZ6WtLybLU9iLg/U6rZRWLnwHzWBSTQbFU4=;
        b=fOyeEvOk2ivf1c403sCJD1/oW4ZOI511YvYZ/dcWVeWy6S0yfWiiroHc+RJ4MaEOKF
         y+cOf0WhLss9aFOYCvJO1z02hiL+gs87EwC+9eQqEa4G0OqsnoBtj7OULZfNGg9Zxo3M
         ojnGHlkGffIxH5/S4UAzo1njCwKy1UHn731VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HeI9CTL7SZ6WtLybLU9iLg/U6rZRWLnwHzWBSTQbFU4=;
        b=7X4NqKSNQqfyORUCk451ctsT1cGqXKAjHD4JvTAtQdIry25LBn2+UqZylN5vK4/eJ1
         iAPqRUCrNGIeb6xModkU+LcVPwwM9ViNfeFiTrGiZNIALC40kqJUurWMk5MPVxFXaHAd
         xb6jzvAQdDejQwvrQ85mxlV0+W2pFqgotAH1vx9/5ipeFh0E5fKjimG6JgytmvbCFpQ1
         r4Cum9tQjHwnYe4yB/dpHg8gBYurbBOUoAoxAfsXzozjgHBRs17whtAlLzvxhV5TTe5F
         MhwnuiwyxzRy9OFU9/3dr2FEoguomqYc5/PZ2b5lOJwXzJBTRLT1jUTW0JytPK3oEHRg
         qpqw==
X-Gm-Message-State: ACgBeo1+kVCy2LkWEjou0jZti4bFRUmOVyVvANb4FfCZTolSKjOdLz4U
        RR/+lrVMa5pjz85c7JnX9/oUpsWH6xGSiOej
X-Google-Smtp-Source: AA6agR5ADT6Uufylys1ZojV6yhfDw4LsVbj/xnc2FvAjMSgCw6dlTx+NYP+PbQtJ4WnFVfKYftRuZA==
X-Received: by 2002:a05:6402:2b88:b0:43a:6c58:6c64 with SMTP id fj8-20020a0564022b8800b0043a6c586c64mr21514696edb.348.1661875854208;
        Tue, 30 Aug 2022 09:10:54 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709061da200b0071cbc7487e1sm5967944ejh.69.2022.08.30.09.10.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 09:10:52 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so10233768wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:10:52 -0700 (PDT)
X-Received: by 2002:a05:600c:42c3:b0:3a6:431:91bf with SMTP id
 j3-20020a05600c42c300b003a6043191bfmr9703680wme.188.1661875852435; Tue, 30
 Aug 2022 09:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220830053307.3997495-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20220830133300.1.I7dd7a79c4cc5fe91c3feb004473feb3b34b7b2d8@changeid> <184d4ff5-e80c-6a24-8071-0b0a69710685@linaro.org>
In-Reply-To: <184d4ff5-e80c-6a24-8071-0b0a69710685@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 Aug 2022 09:10:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VorVNKHgybGAH=dD5ob+1RYoguczycjOYu-5VPu=9Jkw@mail.gmail.com>
Message-ID: <CAD=FV=VorVNKHgybGAH=dD5ob+1RYoguczycjOYu-5VPu=9Jkw@mail.gmail.com>
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

On Tue, Aug 30, 2022 at 2:33 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> > +};
> > +
> > +/*
> > + * ADDITIONS TO FIXED REGULATORS DEFINED IN PARENT DEVICE TREE FILES
>
> What does it mean and why it's SCREAMING?
> > + *
> > + * Sort order matches the order in the parent files (parents before children).
>
> Why? Sorting should be rather alphabetical.

We've had this discussion on the lists in the past. See, for instance:

https://lore.kernel.org/r/CAD=FV=U2C1W+JHWyGRfyRB=WiPKLYvtjO90UDoJ9p+Xwe09+ow@mail.gmail.com/

The tl;dr summary is:

* Going with exclusively alphabetical sort ordering tends to make
things more confusing when there's a mix of things that are overridden
vs. things that are fully defined from scratch.

* If we accept that some ordering isn't alphabetical then it makes
sense to have some sort of section headers to define when sort
ordering changes. Otherwise people are constantly confused and putting
things in the wrong place. Certainly there are lots of styles of
section headers, some of which use all caps.

* What's in this patch with regards to section headers and sort orders
matches other herobrine-related files. If you want to propose a new
way to organize files then perhaps you can submit a patch to do so and
we can evaluate whether it's cleaner or not. If you want to propose a
different organization, perhaps propose it on sc7180-trogdor files so
we can see how it looks on a fully fleshed out family. That will help
us evaluate whether it's easier or harder to understand.

-Doug
