Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C678657CE5F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiGUO6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiGUO6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:58:31 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D383ED7A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:58:30 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id os14so3646277ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ltOZJ2KphG0d0DW5kFxQw6cxwCf3XHhnrjNPEB6uAhM=;
        b=GqcHAHQ4dhPcrDRrtzT1QFXBo9SckIDkd5pucGoABBMli/cpoSkioJ6cvz4F17aKpk
         J1b8mXuerCqilCV36ldocszUddyXRxKShRGF06LQ8abRM+DPmjUznZz+quSoY9VeZO6V
         fALHQi/5OCjS8u//p5bgNNYY4BxK08ZdxexH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltOZJ2KphG0d0DW5kFxQw6cxwCf3XHhnrjNPEB6uAhM=;
        b=NPKCGI8tgbc42WRgP/+v6dSMZ4UAUEAxfJcXRfsdclzLvhMWfT9fZHKbqAl3Jfs+w4
         z94rafEinS3HOa77i7chBBfFYl1EyoDRjDY55UfSVEccaXS21RThcoXfbeRMgUTG1rNV
         GzE/tKzrP8ia2RpjqPRv9bdtus8pI8SHEXE/Zjits+X3kDH/snDPcgUwteQe/aImE6pi
         +d3EM4FChUciwosz/P6PneCfv7XsD5s4KeMfY14X6r2d+ZoL+3kdpGtR38GyO7PvndU3
         3Cs7o+GJ8H9y0slzLyi5ZEGT4TD0Z78+YKRhZ9D36tFkSQES+FewTZhnFx6ESFbpGad2
         wLyA==
X-Gm-Message-State: AJIora9s7xhSfbZC68kUScudjIDIVf+vii3awauR8KiKwqy6Sl6pykYL
        NCH0bSULEAQH+/JrGpSxICixJJ0cJUXyvFuBQ5k=
X-Google-Smtp-Source: AGRyM1sV4PrLW3Kz5/o+37hRI1dnwK8nclmAtyg4eaeog0K95dXFLj99tn9CMJ649EQEFfiwctZAKQ==
X-Received: by 2002:a17:907:7628:b0:72b:4d6f:ce8a with SMTP id jy8-20020a170907762800b0072b4d6fce8amr40835298ejc.59.1658415508879;
        Thu, 21 Jul 2022 07:58:28 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b007121361d54asm955129ejn.25.2022.07.21.07.58.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 07:58:28 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id z23so3620666eju.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:58:28 -0700 (PDT)
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr35414211wrr.617.1658415135216; Thu, 21
 Jul 2022 07:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <1657038556-2231-1-git-send-email-quic_khsieh@quicinc.com>
 <YtkrDcjTGhpaU1e0@hovoldconsulting.com> <Ytk2dxEC2n/ffNpD@sirena.org.uk> <CAD=FV=UQGXqVkew544f3RDtWb3virRHWiafBAxK3ncb5wmVYwQ@mail.gmail.com>
In-Reply-To: <CAD=FV=UQGXqVkew544f3RDtWb3virRHWiafBAxK3ncb5wmVYwQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 21 Jul 2022 07:52:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WuyKAwLwJ80uv15jBPO=W9F7FGZ4dAci+CncwF0WPfOw@mail.gmail.com>
Message-ID: <CAD=FV=WuyKAwLwJ80uv15jBPO=W9F7FGZ4dAci+CncwF0WPfOw@mail.gmail.com>
Subject: Re: [PATCH v16 0/3] eDP/DP Phy vdda realted function
To:     Mark Brown <broonie@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

On Thu, Jul 21, 2022 at 7:39 AM Doug Anderson <dianders@chromium.org> wrote:
>
> > You could add a way to specify constant base loads in DT on either a per
> > regulator or per consumer basis.
>
> Yes, this please! ...on a per consumer basis. :-) It's been on my
> wishlist for a while and would eliminate a massive amount of code /
> tables in the drivers.
>
> We could debate syntax, but I guess you'd either do it w/ two cells
>
> vdda-phy-supply = <&vdda_mipi_dsi0_1p2 21800>;
>
> ...or with matching properties:
>
> vdda-phy-supply = <&vdda_mipi_dsi0_1p2>;
> vdda-phy-supply-base-load = <21800>;

Ah, sorry to respond to my own thread so quickly, but I just thought
of a reason for the "matching properties" solution instead of the two
cells. It would allow the SoC "dtsi" file to specify a base load while
the board "dts" file can then specify the supply. That feels like it
could be a nice solution.

-Doug
