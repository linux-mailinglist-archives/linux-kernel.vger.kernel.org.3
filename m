Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FB4570643
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiGKOxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiGKOxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:53:32 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B44D42
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:53:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l23so9253812ejr.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+DfESfcXMEMmXuDDJXvPYmOkPUKFW71mpdMtJevL6Y=;
        b=k7PwvkOX9vMswnngnpFJUR2Yim1tQzngfTgvN+kCBYpI1huL1ZQcx9t9kq1P/LJt/R
         PF2+6hYpLabGkw3gMvvi/HqDFOnXjayJCtaIrlo9A4HZqGWfd5eA7Ox4gFkYsY5QY6+N
         wIuDOcK8xlSMPM8Qu5fedhAMOfkNGz4Ew5pik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+DfESfcXMEMmXuDDJXvPYmOkPUKFW71mpdMtJevL6Y=;
        b=y3VbBBSUknvsKs4MCZmOEDU8LAfnwhCEqNbeoQqlxlGxQXW9STbuuRXLG/IoOYSPqz
         wFH2v1oHZjg2v7Gtntvkicj33LIs3jM0mhe28Jm5HvXb5qYd8RrNBVs+cxmlMUgzlCgM
         1vNeuzlQkRaIOZRFqIU32O9B1sriwyYOdIuMdT5GWlowrvfkZt4P6+Y59+C7jRKCs8bt
         nmwDXsFyrT4kLJCNphSMrgjNE7yKON/CQE+cwcq2cjyaLbtEaiFSrfQrWmC/dy7D+SFj
         sQOnPfhyqf4Ow351OUd0IA/3imv5eZaBF0MpYuv4G3H7XmyVCzy50FXGw/QBBfttPZY6
         rr1g==
X-Gm-Message-State: AJIora8HtzjOdRJllwi2ZcgC3SKZ7mtRKLcv//UwstbYkRtaYpA9Pylx
        v8C4lA3Uszlc2gIm4VqPBkBJSBckb38lowKD
X-Google-Smtp-Source: AGRyM1u/cmhXKu50eMpktTaS4tiins1sHFucowWxbyMqkY/cAt1LoBJC7aKd02eExCpWSq0QWeACgA==
X-Received: by 2002:a17:906:6a02:b0:72b:47ae:2a4f with SMTP id qw2-20020a1709066a0200b0072b47ae2a4fmr9088030ejc.446.1657551208269;
        Mon, 11 Jul 2022 07:53:28 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id bf14-20020a0564021a4e00b0043a78236cd2sm4459558edb.89.2022.07.11.07.53.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 07:53:27 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id v16so7321874wrd.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:53:26 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr16792836wrr.583.1657551206156; Mon, 11
 Jul 2022 07:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220711082709.39102-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220711082709.39102-1-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Jul 2022 07:53:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ue+LUHKmG_ceMO-qGqJXkmqMcvyjLFCGNK8s2VBDDd2A@mail.gmail.com>
Message-ID: <CAD=FV=Ue+LUHKmG_ceMO-qGqJXkmqMcvyjLFCGNK8s2VBDDd2A@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: sdhci-msm: add MSM8998
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
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

On Mon, Jul 11, 2022 at 1:27 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Add a MSM8998-specific SDCC compatible, because using only a generic
> qcom,sdhci-msm-v4 fallback is deprecated.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
