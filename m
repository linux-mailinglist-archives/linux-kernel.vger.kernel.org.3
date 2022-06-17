Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9179D54FDDC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243311AbiFQTry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiFQTru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:47:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5E71182B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:47:48 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id o7so10597470eja.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zwRRGT+7U6kcOm23L9Lh8UyJA5oTQ09EyApKVWspK0=;
        b=e2DlXCS6iKqa9GLoyvPsepDbCTXyGi98RLSEWodCnOkFJA74c2le7Q72NlLN0FGhO5
         pLm9bgB/9qGbnuSMzlu5tDFZQC7xuU1iUCExxn5Hdj3lzBHhFD5/Lsq6bU4kOJOvCjhU
         wm7pRl03A0DT+F2RuC3KT5SdOOfZiRlLmEhXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zwRRGT+7U6kcOm23L9Lh8UyJA5oTQ09EyApKVWspK0=;
        b=O3M3naxQKcYiKD1V27K0HinrW9npiY4MiRk02S+mMW5JVAXMBvcrEiLogxaNHdvuiz
         /OKN3ubmUrzz7Xy1F4aLFrdAcOnx6GWMOtEm1K9TRNVkE3matzKRltkj3BNLpUpKJ59t
         nZrscGxWso/o0B8soI/+L7wRhQkayAXclzJqKaJlQxNWt785fh5HfT4GgEPm8OpxIDd8
         KjW7FW0b45tLNptyAAZxqnzm0meFuuplZV51I89m+2kKe9KGaK2ydNy6ziGU2i3wT9l4
         GGcqZaM3ky0xiVOVKX7sFOPCbq5WdaOKJeWWWx79lDMTwvOl0PbTScZz1t+du3emLbwE
         Gwmg==
X-Gm-Message-State: AJIora/EZKHWN3dL4g7HHYHeuwwuoFqpPDa8kMH5BJOTe48zkGb1JcZA
        5FcmPEVtWqjM1ufz3VhllZgkiKOJQeR+SP3NiyE=
X-Google-Smtp-Source: AGRyM1srCZv/Uddge2gr0sRzEZYWTzz34qgL6IAa5GrMTSLfsBELAX+nMYx66smFLhqMv+js+PtboQ==
X-Received: by 2002:a17:906:308f:b0:709:af33:9fa7 with SMTP id 15-20020a170906308f00b00709af339fa7mr10395126ejv.369.1655495267153;
        Fri, 17 Jun 2022 12:47:47 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id ec10-20020a0564020d4a00b0042bd75c53casm4230954edb.83.2022.06.17.12.47.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 12:47:46 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id e5so2805339wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:47:46 -0700 (PDT)
X-Received: by 2002:a05:600c:2054:b0:39c:3f73:3552 with SMTP id
 p20-20020a05600c205400b0039c3f733552mr11938914wmg.15.1655495265869; Fri, 17
 Jun 2022 12:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220617111021.v6.1.I9e299d3fa6fbf50df6fc7207050bf5c3a7bf4c61@changeid>
In-Reply-To: <20220617111021.v6.1.I9e299d3fa6fbf50df6fc7207050bf5c3a7bf4c61@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Jun 2022 12:47:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wp=BMwkbXH+_cHyVP3_0Zh-KXO=N8Y7wg3SktEs7FEXQ@mail.gmail.com>
Message-ID: <CAD=FV=Wp=BMwkbXH+_cHyVP3_0Zh-KXO=N8Y7wg3SktEs7FEXQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] FROMLIST: arm64: dts: qcom: sc7180-trogdor: Split
 out keyboard node and describe detachables
To:     "Joseph S. Barrera III" <joebar@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
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

On Fri, Jun 17, 2022 at 11:12 AM Joseph S. Barrera III
<joebar@chromium.org> wrote:
>
> From: Stephen Boyd <swboyd@chromium.org>
>
> Trogdor devices that have a detachable keyboard still have a
> non-detachable keyboard input device present because we include the
> cros-ec-keyboard.dtsi snippet in the top-level sc7180-trogdor.dtsi file
> that every variant board includes. We do this because the
> keyboard-controller node also provides some buttons like the power
> button and volume buttons. Unfortunately, this means we register a
> keyboard input device that doesn't do anything on boards with a
> detachable keyboard.
>
> Change the node's compatible on detachables to the newly introduced
> "google,cros-ec-keyb-switches" compatible to indicate that there are
> only switches and no keyboard to register. Similarly, move the keyboard
> include that defines the keyboard-controller node out of
> sc7180-trogdor.dtsi to boards that actually have a keyboard so that the
> matrix properties are not defined on boards with the switches
> compatible. Future boards can either use the include approach or the
> node definition approach to describe a keyboard with possible switches
> or just some switches.
>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: "Joseph S. Barrera III" <joebar@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> (am from https://lore.kernel.org/r/20220518172525.3319993-1-swboyd@chromium.org)
>
>      evtest shows no more cros_ec device
>
> Cq-Depend: chromium:3609017
> Tested-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>

It's OK to re-post Stephen's patch with your series, but:

1. The subject shouldn't have FROMLIST. That's just for patches picked
back to a Chromium OS kernel.

2. You shouldn't have "(am from...)". Again, just for patches picked
back to a Chromium OS kernel.

3. No Cq-Depend. That's something for patches picked back to a
Chromium OS kernel.

4. You should remove tags that were added by the Chromium review
system, like Stephen's "Tested-by" and my "Reviewed-by".


Another alternative is to not post Stephen's patch but add a note that
your patch should be applied atop his, then point to his. AKA:

https://lore.kernel.org/r/20220518172525.3319993-1-swboyd@chromium.org

-Doug
