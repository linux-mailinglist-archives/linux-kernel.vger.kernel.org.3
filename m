Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03675A32F0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 02:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345163AbiH0AGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 20:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345187AbiH0AGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 20:06:20 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DACE97CE
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 17:06:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id og21so5882883ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 17:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Z5Adbae5Xstm3Nft6JSqLTz+t6vgZm3JK+za1SvmuuM=;
        b=Tpup3l/YMsgBg+GPhioM3zHPeTRmGdpq8vjcCUGyupmzAuhmUPFwBqlmi4B6VquVWn
         cWJZzfzwyryyoXVqlOpJYk9FAo5Ihqxn6qlgCYv/6VVdrLotWY/osHXbmOv2w300xM7+
         OiXZbtAHdp6Tbm/0KwtjIu5kj0V7mIw27r41U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Z5Adbae5Xstm3Nft6JSqLTz+t6vgZm3JK+za1SvmuuM=;
        b=1CWOLse5857jNN6jo1N0w8WGZ48AUG3qMsQhEbZW1TB9KWOMmL3JM3ZF+KrNT3PEdx
         cNNf/zSr5g1oespUVTGQMVP9ywytRvbW4AriQidk5kePW/WjcTQ+iAKRajYR0BmQD5CB
         GOItCK3GfGdSojRNpC2flTMLK5+bcMTHwoUFYLC/YULWqMQbOIBgQMUSeWCbwAv6/E/P
         oOgEmeOooRKpgfYoUN4jKVnqLELbHiXNl/Phqn/iQwCy7hQaYsYmH9Lg1A6f531Ez1dQ
         TZtMXHGxk17tF1muYlmRtLQ22tdc18ChlR9M5+r75Wu3S8QG5I3W9EDGIDem9ATTciTV
         f+1g==
X-Gm-Message-State: ACgBeo1vrUKryWZOkfo3Jo0qriKpCMuZfPozq3HwDc/8tmhnIAHRxh3z
        eZk7V7bN7VfQiGSViL9eb0GBrCYg7WmKVkgg
X-Google-Smtp-Source: AA6agR6ZFMFB6JbSV7HFIYdYtg3lV7F5BAwkK74oOMNSRUnNEBBfY4HDQEt+cDYGnR0dVLvy2gXqVg==
X-Received: by 2002:a17:907:7244:b0:73d:a190:9859 with SMTP id ds4-20020a170907724400b0073da1909859mr6803954ejc.295.1661558768263;
        Fri, 26 Aug 2022 17:06:08 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id ku13-20020a170907788d00b0073d53f4e053sm1442267ejc.104.2022.08.26.17.06.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 17:06:07 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so1594012wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 17:06:07 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8b:b0:3a5:f5bf:9c5a with SMTP id
 f11-20020a05600c4e8b00b003a5f5bf9c5amr988458wmq.85.1661558767085; Fri, 26 Aug
 2022 17:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220826102513.1.If97ef7a7d84bcc2cf20e0479b3e00c4a8fb5a2fd@changeid>
In-Reply-To: <20220826102513.1.If97ef7a7d84bcc2cf20e0479b3e00c4a8fb5a2fd@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 26 Aug 2022 17:05:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U2N2gd6jCsxucwuU1xxnzBc5nL3odQp7vcQXmJsjwHOQ@mail.gmail.com>
Message-ID: <CAD=FV=U2N2gd6jCsxucwuU1xxnzBc5nL3odQp7vcQXmJsjwHOQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Document additional skus for
 sc7180 pazquel360
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moragues <moragues@chromium.org>,
        Henry Sun <henrysun@google.com>,
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

On Fri, Aug 26, 2022 at 3:27 AM Yunlong Jia
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
>
> ---
>
>  Documentation/devicetree/bindings/arm/qcom.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
