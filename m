Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6904150A5C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiDUQ3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390687AbiDUQXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:23:14 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BDE21E39
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:20:24 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id y16so3359425ilc.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jTmusAwV684aMFKs/ZUE0USXjWO4fp53UX1om3MGtII=;
        b=Nrnvl0OWGMELGK7BoERttSSU3k9U6KUVq6m6cjxcpQAup5ZK+dm2scxx+z9XbHF+uJ
         6W1kI6Fy8lOkCpoiQw8vSjLeEfD1yUtZys7Vy0amFGpgH/Xw8I3npCSLHXN8tOLVp462
         YlBxXXRt4ZYhilcS3X+45XAwxVTrloIy28gkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jTmusAwV684aMFKs/ZUE0USXjWO4fp53UX1om3MGtII=;
        b=end6gvogdBD073x+A3Ppl6hMTi5xqzDMS5kuWoZz3y1Ai9/sQgbIRfw/ATguWDPvX6
         5fhg3RbpWkCdTXCVyGhp87ieBL4SEXxwwo52zTYyiC4dGrGMuNmQU/JmMhZt/xSnDaWj
         vdlfJLtbJDx1ZY0HZiJIIxX3+hYktc4A8EmJrwxijWgdh31IXBpX5L1hxmWaudSWkUwI
         +8+bm9BKSLut0qDC8OfDJw/gxUUCf74bp8yiyuwTNFtRjAHWmapz8baGyP+xS5ANE5bG
         liNt79Hj79zasQfQokFJMOc9eqfQQrWfSmKrgEgfSz2yRK3W4LQPnmNLFL4CdxIsaLCT
         bU4Q==
X-Gm-Message-State: AOAM532MHr1FA5wqN4lJgYw5wdSmXSKvAFP1zdkJmPyDIhPLN7Dh/5HX
        y4B2UfVi5+mUzALI76vvpzttIfdBHaVbAie+pMY=
X-Google-Smtp-Source: ABdhPJy+JcESsbPmhPjVyau+ivTeYUZ3hr2mX1DTNGSgJIWZwMmlFmt4W5Dx+mLftiv56EmqVLe00w==
X-Received: by 2002:a05:6e02:170d:b0:2cc:11df:39f5 with SMTP id u13-20020a056e02170d00b002cc11df39f5mr222513ill.12.1650558023873;
        Thu, 21 Apr 2022 09:20:23 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id t5-20020a92ca85000000b002cbfcdd1183sm10185776ilo.42.2022.04.21.09.20.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 09:20:22 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id h83so5818256iof.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:20:21 -0700 (PDT)
X-Received: by 2002:a05:6638:2607:b0:323:c9c9:e219 with SMTP id
 m7-20020a056638260700b00323c9c9e219mr200203jat.229.1650558021381; Thu, 21 Apr
 2022 09:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <1650550779-8133-1-git-send-email-quic_srivasam@quicinc.com>
In-Reply-To: <1650550779-8133-1-git-send-email-quic_srivasam@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 21 Apr 2022 09:20:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VODaTxu+c8cXWyy8Mw1Qm145vwt-UspirE6k-XL-MZdg@mail.gmail.com>
Message-ID: <CAD=FV=VODaTxu+c8cXWyy8Mw1Qm145vwt-UspirE6k-XL-MZdg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add ldo_l17b regulator node
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        quic_rohkumar@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 21, 2022 at 7:20 AM Srinivasa Rao Mandadapu
<quic_srivasam@quicinc.com> wrote:
>
> Add ldo_l17b in pm7325 regulator, which is required for
> wcd codec vdd buck supply.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)

The ${SUBJECT} should probably mention qcard somehow? Right now your
patch subject makes it sound like this applies to all sc7280 boards,
but this only affects those including the qcard dtsi file.


> diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> index b833ba1..17d0c05 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> @@ -113,6 +113,11 @@
>                         regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>                 };
>
> +               vreg_l17b_1p8: ldo17 {
> +                       regulator-min-microvolt = <1700000>;
> +                       regulator-max-microvolt = <1900000>;

All the other regulators in this file specify:

regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;

Why doesn't yours?
