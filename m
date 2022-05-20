Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A36152F4AA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 22:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353530AbiETUvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 16:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353539AbiETUvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 16:51:00 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762C9A443
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:50:58 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s3so12172211edr.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BCvNUzoNJgliggAjbNOVF+e73ln10qSAqagPa48fyAw=;
        b=hlkKiLZ74U8oZ5crxOdHHzyWx5PrDTiFFFh7Zv05xV8i3b0J8CW8fv4Woq7QPCoOVE
         7ADjNRKYYmxsp7KiN052EgelmGfHN+etwMZakEHNvP/mGUk7IbM1uDt4foMCxao8j/TZ
         8zn/OYgfIanRUj2Y+H+t/Ww6LCVKamBwBlssM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BCvNUzoNJgliggAjbNOVF+e73ln10qSAqagPa48fyAw=;
        b=DW8SHQkqZpapLBaaL0xadKW6zx2qcL7UKeOeWxgv0A7FvClT3kKTGTkwEoOdQJW76R
         KbWtEqrkXkuzFJAjhSO7FhU2HjM7ZDxV1PsCwCyRZeaHX42UjgWH2qy/14iDBbKUIBHQ
         TaxnjnYUi+G83i89uXINePJfuHhhTYmnZFgZBqgrJaqEkHHO6FRzaEk3s5nkRfKY2eAi
         HEDNQrtjU5jiilnyB/0kf6RxdVqCsss83mOX+z8JGcWqHSQbroi2wFQFee1uwEhc+gyq
         rqOfgCNGWKIYjhVVlO9bpnKQhapo+9mCsmU5tbfIFWfzguScvYPEf/W29OoaB9fh4JnH
         kc+g==
X-Gm-Message-State: AOAM530d7N6irX1wOqfO5/KIPjCWxQ2FpZZ5nTxMqfP1KAY2Ca1d9f46
        fGGFTYB0MRlBcsFacAaoqyqVIxHODjBfqwpp2Aw=
X-Google-Smtp-Source: ABdhPJxaBQbuHXJKAxMdW2B1Zv1fCfmvY2rWy7YbX/3WEkl/bKOb4iTMld+nQJSidePE9/1N9WJ2Qg==
X-Received: by 2002:a05:6402:1704:b0:42a:c480:dcc8 with SMTP id y4-20020a056402170400b0042ac480dcc8mr13105806edu.59.1653079856871;
        Fri, 20 May 2022 13:50:56 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906024a00b006f3ef214e5asm3596459ejl.192.2022.05.20.13.50.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 13:50:54 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso4968530wmp.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:50:54 -0700 (PDT)
X-Received: by 2002:a05:600c:3d8c:b0:394:6097:9994 with SMTP id
 bi12-20020a05600c3d8c00b0039460979994mr10079039wmb.29.1653079854130; Fri, 20
 May 2022 13:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220520161004.1141554-1-judyhsiao@chromium.org> <20220520161004.1141554-4-judyhsiao@chromium.org>
In-Reply-To: <20220520161004.1141554-4-judyhsiao@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 May 2022 13:50:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vpds9p7LLfxiwhNdDTdxb=CffcMjgxRva5EHc9VJ4LDg@mail.gmail.com>
Message-ID: <CAD=FV=Vpds9p7LLfxiwhNdDTdxb=CffcMjgxRva5EHc9VJ4LDg@mail.gmail.com>
Subject: Re: [v2 3/3] arm64: dts: qcom: sc7280: include sc7280-herobrine-audio-rt5682.dtsi
 in villager and herobrine-r1
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Judy Hsiao <judyhsiao@google.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 20, 2022 at 9:10 AM Judy Hsiao <judyhsiao@chromium.org> wrote:
>
> Include sc7280-herobrine-audio-rt5682.dtsi in villager and herobrine-r1 as
> these boards use rt5682 codec.
>
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts | 1 +
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts  | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
