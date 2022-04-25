Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D29650E653
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243661AbiDYQ7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbiDYQ7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:59:20 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6D913F9B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:56:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id p18so14024159edr.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YXo+ObBRhEePToAUIshvslaAhUHCrrCP+3VFCVvt/4I=;
        b=Rgajd143kZY1K05Q9IPBzZEAvOdKl5fnxOqPjswV36E0PnneOrdTDzlLXfk6kEff2p
         ZleTcs3nOA0IxBGmk1VYNU3WpY+ADRDhClHGbKOIHkIpq3ZO8o2kLyocP4GGHG9F4YKq
         dQz+eUcxWYQmasGuiAGMdUiluNB71N08enuC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YXo+ObBRhEePToAUIshvslaAhUHCrrCP+3VFCVvt/4I=;
        b=t8obu0WXZqpr5vtQo1AYNRbccmoenDaaKDgFhXnCW3esRqqhwk8V0pxeOroRIuyJlw
         OKpc/u9VP5aYgIcwD/sPO/YzlEqJNpi9zHvmd7gjcEJRpmunYUo24g7bWUT2ur2sCIL7
         Qn68zHJsxYj6caaqbQhhVVJW3uZXW9IVzo6+VsdiRfcWmZyCDpgbQhkVUmM/mCwZTg3+
         1HQ/PIH6lMrhbLObuIKlBWWKnmTPivcIuv7sYv5B3SDJsc4d3kcfkKWPS8AF4iJMLjDX
         yIUB0mQUrWU+ipirss5ABINlz24TICCP7D/cZqOu/6SNz9YfF37DvEiABNyXDNwSvlwn
         L2mA==
X-Gm-Message-State: AOAM533ag1i7xPcfBW7mG8RwhlX70sztQMIV/2gLRVsxNr7C+S+fsXsd
        0mmHb19xxS/Ha+3uDeXz//GXGfr49nNjEQ==
X-Google-Smtp-Source: ABdhPJwDyh8faxEETNVX0YxxDDUaVjS4pxBpZ7/Bat0FIIqoimQchy7Ufq7LHHKR0k61eKjDB/yBYA==
X-Received: by 2002:a05:6402:1e89:b0:425:e3fa:f266 with SMTP id f9-20020a0564021e8900b00425e3faf266mr7337544edf.20.1650905774186;
        Mon, 25 Apr 2022 09:56:14 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id k7-20020a17090666c700b006e8688d5fcbsm3797310ejp.135.2022.04.25.09.56.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 09:56:13 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id j15so8518703wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:56:12 -0700 (PDT)
X-Received: by 2002:adf:f50d:0:b0:20a:e096:ef with SMTP id q13-20020adff50d000000b0020ae09600efmr1827132wro.679.1650905772336;
 Mon, 25 Apr 2022 09:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <1650621734-10297-1-git-send-email-quic_srivasam@quicinc.com>
In-Reply-To: <1650621734-10297-1-git-send-email-quic_srivasam@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 25 Apr 2022 09:56:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VoKE7DwoqSffXCbmx6MvOUEs7LbHiYtaR42BkHAei0dQ@mail.gmail.com>
Message-ID: <CAD=FV=VoKE7DwoqSffXCbmx6MvOUEs7LbHiYtaR42BkHAei0dQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280-qcard: Add ldo_l17b regulator node
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 22, 2022 at 3:02 AM Srinivasa Rao Mandadapu
<quic_srivasam@quicinc.com> wrote:
>
> Add pm7325 ldo_l17b regulator, which is required for
> wcd codec vdd buck supply on sc7280-qcard board.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
