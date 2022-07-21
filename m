Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1085F57CC0E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiGUNgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiGUNgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:36:23 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4813927CC6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:36:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v12so2170352edc.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZ+EaaTNcvyNclKTamsWDViD0TCzODM1RnJ73E0WdAY=;
        b=M5Lm6hdN0IaCIgqk+NnU2YYFc7XuxPONmUSZ259X+eoeZaBm2Nq3a2rHfQ7zMkWNj3
         zPEVdUeryYmsbaLGwuKw3VS4qZZuufbCeuSmSCmmT/Px6JFLyfOSGPdQ8QKujwXsalgY
         QjQDkue1sfu0li+R3yg1x6xPSir5QDi6/I7V8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZ+EaaTNcvyNclKTamsWDViD0TCzODM1RnJ73E0WdAY=;
        b=ur1/Ln29opzCcvdGP0W/tDw13OMBAZyp++7djMbG6coTwieGjCDxjd6Nqt8fRFmIp+
         gvsvqlzRTkPWxbZm2+A2PZerUdFb4Wk+YUKYAsrKlwiKUTvsRUJrrahKVfokwph2R0Xw
         pAl0Q2xuNu7ACPRX+KOVHDYa3uYkgFbvHgmEevmgnlPzXuBBDXkBbAVLXorMjSrv051N
         ph4lvltVnmzytHEFHFhLp6KG4neDdepbZZXoVh40t9zdhYdHT2aav7gQ7T/6Eu8HjLrO
         t7W9BU3YFsVLAAnQozz2WzSAklLzJNybQ7X1fIxGh643bhsdpDTSAbreyETnXmZfp4wP
         V7xQ==
X-Gm-Message-State: AJIora8fwLTJN3h2XrT+RlId85K5a/R38pgqqp1POoVfKY6G9RkXBJOA
        0jbsZURejTTEQoZFgxp3/3xNweeHq+g8gOuN
X-Google-Smtp-Source: AGRyM1uhb+KsgpIvCMLHHJxQ7L0hT0O03zI9hI+uWsq4SzXiuEzOeTM6Xz5FmmYqiH1UcxLWHR5Obw==
X-Received: by 2002:a05:6402:5518:b0:43a:9e32:b6fc with SMTP id fi24-20020a056402551800b0043a9e32b6fcmr58096626edb.252.1658410580679;
        Thu, 21 Jul 2022 06:36:20 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709060cca00b0072b2ef2757csm853983ejh.180.2022.07.21.06.36.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 06:36:18 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id n12so2300220wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:36:16 -0700 (PDT)
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr35138943wrr.617.1658410575960; Thu, 21
 Jul 2022 06:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220721033918.v3.1.I10519ca1bf88233702a90e296088808d18cdc7b1@changeid>
In-Reply-To: <20220721033918.v3.1.I10519ca1bf88233702a90e296088808d18cdc7b1@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 21 Jul 2022 06:36:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uuv0rGg1+8_b=R7SM-g87U_4TipwbNgVTXDd6T=X3qEQ@mail.gmail.com>
Message-ID: <CAD=FV=Uuv0rGg1+8_b=R7SM-g87U_4TipwbNgVTXDd6T=X3qEQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: Add SKU6 for sc7180-trogdor-pazquel-lte-parade
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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

On Wed, Jul 20, 2022 at 8:59 PM Yunlong Jia
<yunlong.jia@ecs.corp-partner.google.com> wrote:
>
> SKU6 is LTE(w/o eSIM)+WIFI+Parade
>
> Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
> ---
>
> Changes in v3:
> - Bindings and dts in the same series.
>
> Changes in v2:
> - Put sku6 before sku4.
>
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
