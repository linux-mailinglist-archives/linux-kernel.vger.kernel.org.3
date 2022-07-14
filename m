Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10735575139
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbiGNO6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiGNO6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:58:05 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7636F5E33B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:58:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ez10so3845266ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rmwz5UdPDv24j9r/+qXMLUwb1qPdbsCqRql7+qkdLJs=;
        b=cBnF70BmBTyQ0KYw65AGC7GPK0gtdqWmk/Tf/JXFG8mMNz0BzuRU/6XEtfPK7jI2oH
         JcrIEjJLGRShuiUNIupNKcqHaWlWWgRpJIz+NlfLHgHWAthrpbz1xMJb/0zgX+TJPsBI
         d8vPIChTYB8Njs0gL8IgYBdFj4WFO2ABsZawg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rmwz5UdPDv24j9r/+qXMLUwb1qPdbsCqRql7+qkdLJs=;
        b=4yVGkZS263dE/E4nFYsViZb89lM1k6MAW10MJ0zfcAkmid4bkUahHQdS9wuV94scfk
         qU0S5XvcsyaS/j08TeZnlLYK0wfa4C4Fl4cvME9IBog3U4x5W+EaB8DNITKMZLc9YkNr
         m7CR+NSaKnIglitK/OCpv2n82vjQMBS19AZbFr8/pxPDv0pdavZ5janeeLoyNKY1Gxit
         iOxfFs9Cs/62lLXIJi4+BIOEaM4DqK8/Msc/zAB8vLMMNm6O1dBqMLoyHjw2UptWWHn4
         t2ehvWjd6JP6CsDL9Tn+OmIFwYTPkvSnHz1uXwF7g6lN/OWq1BnPWnZuZNHB1ulpN2Ku
         KbJg==
X-Gm-Message-State: AJIora+XLJrqwoVDtwft9l7az4wkFAFwa5XU2VAHq53iYn5eAbefX+7I
        Mxg1OcbL2wd57A+j8gXv/sb+gd/UpAimgOlD
X-Google-Smtp-Source: AGRyM1sJ49EKX2xlMOrhP5lMjztR+wrGvlJUeFcyRundqPZFKtBH/cFkSvOjSGGsxtpuOmBo/UCkrw==
X-Received: by 2002:a17:906:9b93:b0:72b:8fad:6cf8 with SMTP id dd19-20020a1709069b9300b0072b8fad6cf8mr9005716ejc.415.1657810680839;
        Thu, 14 Jul 2022 07:58:00 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id s12-20020a1709064d8c00b006feec47dae9sm782328eju.157.2022.07.14.07.57.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 07:58:00 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id p4so1227636wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:57:59 -0700 (PDT)
X-Received: by 2002:a05:600c:3ace:b0:3a0:4ea4:5f77 with SMTP id
 d14-20020a05600c3ace00b003a04ea45f77mr9537025wms.57.1657810679294; Thu, 14
 Jul 2022 07:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220714074958.86721-1-jinghung.chen3@hotmail.com> <SG2PR03MB500619860DC13133A0B5EB4FCC889@SG2PR03MB5006.apcprd03.prod.outlook.com>
In-Reply-To: <SG2PR03MB500619860DC13133A0B5EB4FCC889@SG2PR03MB5006.apcprd03.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 Jul 2022 07:57:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XFCjCx=uXHWpEi04C-V9p-3qOp1W1g_0WXA4k-nRr1Zw@mail.gmail.com>
Message-ID: <CAD=FV=XFCjCx=uXHWpEi04C-V9p-3qOp1W1g_0WXA4k-nRr1Zw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: arm: qcom: document sc7280 and
 villager board
To:     Jimmy Chen <jinghung.chen3@hotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
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

On Thu, Jul 14, 2022 at 12:50 AM Jimmy Chen <jinghung.chen3@hotmail.com> wrote:
>
> This adds a LTE skus for Chromebook Villager to the yaml.
>
> Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> -Add this patch
>
>  Documentation/devicetree/bindings/arm/qcom.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
