Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F495AF7F8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 00:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIFW1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 18:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIFW06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 18:26:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005D7272A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 15:26:55 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u6so16978183eda.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 15:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=a+Vs+P0ciT3P+roY2k8XBdIwCVWYhAwaTZ/i25+tK1Q=;
        b=G38S/EqecQ8sQP0LzugoHuJ4vO5tGIs1Irzd5Df2yBAJ60O5P5fac0bguYHaOigTSZ
         /8feiG7RBqs6a7WUgyG0z8RRq/IbpO2nf9njQRB0Vd5FXLenlPVPCSvkNxR3B5IQSHnP
         fGvhZTNH64t4bL+IDvTHVbgt/2/KnS70+CCcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=a+Vs+P0ciT3P+roY2k8XBdIwCVWYhAwaTZ/i25+tK1Q=;
        b=6OpFTLtE77mxoU/gUEbvcYQmWV/hSLxlHFlhvuM+m3wXCWU1R/ryPOxcY30LJYOrhW
         6aSCpINW3Wy97n4lFzsN7siwaT5T4GCGd4+mPHaWgF5yvWYsiFMmBAiOugzGWBH3MmJq
         Iy+decAe+KdFkF4RXjk0eDMIoRsObOEO20VE0U6bJ2KzQpeJpRfArkco30WFkYuN9F9K
         2tq8Z5jPpV44pu349t7pH02295he3h/SYnrGPRWi63GihOHmJ1ciWkn45Bie5BHyEqDZ
         lQ3fLoIGiV0bPpro62j5Cp3G4vxBNwzbwxJqhkVFtYNSW2ds+JOD95T/LWl/eJkQuIh7
         2EtQ==
X-Gm-Message-State: ACgBeo1W0+Vc+a1vX2P6esMtSvlq9VUhDha0NPK7VCYYtx+hul80ATZD
        4heNgBK0IzlrbGUGqthXyPNNYTGxb2+2BT4s
X-Google-Smtp-Source: AA6agR4yyho5gsHD2tv38sqyJT9+NBEnD1+iZirCFToRwlwxbgyKkDM/Jtoqy10tErN9hU+byITZ1g==
X-Received: by 2002:a05:6402:4003:b0:448:4c79:45e2 with SMTP id d3-20020a056402400300b004484c7945e2mr610636eda.376.1662503214350;
        Tue, 06 Sep 2022 15:26:54 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id f2-20020a05640214c200b0044eb4227bf6sm3232136edx.63.2022.09.06.15.26.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 15:26:53 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id d5so7624916wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 15:26:53 -0700 (PDT)
X-Received: by 2002:a05:600c:22d3:b0:3a8:424d:f386 with SMTP id
 19-20020a05600c22d300b003a8424df386mr280546wmg.57.1662503212860; Tue, 06 Sep
 2022 15:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220901024827.v3.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
In-Reply-To: <20220901024827.v3.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 6 Sep 2022 15:26:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wf2gPHzSXh_2bKe+KgYVhKDUgmEtx2nnBrQ9FawqxH9Q@mail.gmail.com>
Message-ID: <CAD=FV=Wf2gPHzSXh_2bKe+KgYVhKDUgmEtx2nnBrQ9FawqxH9Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: qcom: Document additional skus
 for sc7180 pazquel360
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moragues <moragues@chromium.org>,
        Henry Sun <henrysun@google.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

On Wed, Aug 31, 2022 at 7:50 PM Yunlong Jia
<yunlong.jia@ecs.corp-partner.google.com> wrote:
>
> pazquel360 is an extension project based on pazquel.
> We create 3 sku on pazquel360:
>    sku 20 for LTE with physical SIM _and_ eSIM and WiFi
>    sku 21 for WiFi only
>    sku 22 for LTE with only a physical SIM
>  Both sku20 and sku22 are LTE SKUs.
>  One has the eSIM stuffed and one doesn't.
>  There is a single shared device tree for the two.
>
> Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> ---
>
> Changes in v3:
>  1. Adjust the format of the changelog.
>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)

I think these two patches are ready to land if now is a good time. Thanks!

-Doug
