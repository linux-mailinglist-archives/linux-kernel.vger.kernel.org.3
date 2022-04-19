Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A5A507056
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353311AbiDSObK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348414AbiDSObH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:31:07 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EFA21E39
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:28:25 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id u18so21517259eda.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5snmPtDHGIGoFLwIYFGnYkPTgTDRFy3yrXSk8RuXhBw=;
        b=RyaK5z0senBGYKHrGTylo+K2ugRhGTPqMnF4qLnrgyVkDI+tdjmEz5eOzR0Y1AW6QU
         y1zPZmrNqRLvm0vTSqh+xmmubISocvwjC4qL1JKLlSIvglE/JhI/7doQ6ENEmXj3Clrj
         zYxT/lkQ+Dzv5Oo+hLcoDdnTp0p5Kfr/Kplng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5snmPtDHGIGoFLwIYFGnYkPTgTDRFy3yrXSk8RuXhBw=;
        b=iNBaA4+P8/xMvi6rCUJILbe9c3P+vwla7waGYJOlV0+H96x7fgwC4a0I/Gu0SzQznK
         cBLoGe57DGVhcJppqPLYY9Px/teHBblfB6G62oxe6fPB4+czniN32ql35Fo96+ZzBJM5
         nNue6GoSz//N8xgGaKkGFAwW/cS8xzEtmKoAH3b84rswOQdvASmB5Fc3CjkylYAbPjOc
         wAqGmTWwI9+4X9sRvCpcGDrXykQq84xM9Cy9IgF91Dep5hf42rXH1RpVn2TCHLRFJXah
         M7kDbO0K5+tFlms8Fp2o1USvYEx9E6c5K4pSjc7h1KU+98m4tzEgNCKVra89OtRo9eRo
         VlIw==
X-Gm-Message-State: AOAM533WoIpZzmZ0KoRsLY5RqsX3/XNvObSERWCbYn4QwkxmizWeF3qB
        eMyH+tkIeWsdI99ovZdWbdSV1MGocD14No69
X-Google-Smtp-Source: ABdhPJwZrgMqFGSdqajnE8z/JN+ZS9o2MKnD99b+lqeYi3Cggt+QqqaFdCtX733SJixoUTb552L7Rw==
X-Received: by 2002:a50:ba8a:0:b0:423:bdf5:41d6 with SMTP id x10-20020a50ba8a000000b00423bdf541d6mr16336862ede.204.1650378503346;
        Tue, 19 Apr 2022 07:28:23 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id g24-20020a056402321800b00423e43ebb60sm3497143eda.61.2022.04.19.07.28.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 07:28:22 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id r64so10790288wmr.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:28:22 -0700 (PDT)
X-Received: by 2002:a05:600c:210b:b0:38e:c62a:398b with SMTP id
 u11-20020a05600c210b00b0038ec62a398bmr20157535wml.118.1650378502020; Tue, 19
 Apr 2022 07:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <1650349697-13540-1-git-send-email-quic_vnivarth@quicinc.com> <1650349697-13540-2-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1650349697-13540-2-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 19 Apr 2022 07:28:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XYduCsrzKYRUR18y+OfJCrjdbDErSPEtz0bYF_VXbMPA@mail.gmail.com>
Message-ID: <CAD=FV=XYduCsrzKYRUR18y+OfJCrjdbDErSPEtz0bYF_VXbMPA@mail.gmail.com>
Subject: Re: [V4 1/2] arch: arm64: dts: qcom: sc7280-idp: Configure cts
 pinctrl to bias-bus-hold
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        quic_msavaliy@quicinc.com
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

On Mon, Apr 18, 2022 at 11:28 PM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> WLAN rail was leaking power during RBSC/sleep even after turning BT off.
> Change sleep pinctrl configuration to handle same.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
> v4: modify subject of patch to indicate file it is applying to
> v3: apply same change to active state and other sc7280*.dts* as well
> v2: used bias-bus-hold as per review comments
> v1: intial patch used bias-disable for sleep pinctrl in sc7280-idp only
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

You should have carried my tag forward. In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
