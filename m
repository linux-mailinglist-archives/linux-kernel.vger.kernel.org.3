Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50534554BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357602AbiFVNvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357560AbiFVNvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:51:25 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFAE2F01C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:51:24 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ay16so15037082ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1tMe+AiU8DKRx6/oa1fADyFtfsdt5zf5zus2rlM628Y=;
        b=WLrqEPTDWCxELbbCYBkNzQrlci4iuDiO0DU2ioBN9DwcW7jQ7pOE+5VP1zoWQnflXZ
         dTaN6XDGRWpJSvQIkolJpH6dMOgXlqqiGej5wPGxL+YAggm3OuMAv0cl4q4wDs6QtzrH
         M5G/FfnuufzkHuYqhYgUb2JRvxkQexCB3PTug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tMe+AiU8DKRx6/oa1fADyFtfsdt5zf5zus2rlM628Y=;
        b=yPRh3shlCKogJU881iE8swgIGKmRs/hv/HG5CnmGlriB5k8szrjpm1czm/kzn+PROJ
         cBPSs3KESWbVw+Iech0Md5qsSAEtrErz6E+Acwbao1925QTxJuXJ1bJMo3YARRyZykHa
         nl8GxZw0zJ8BrHRpG2Mmm7hv2SruYui9XQ4LsxB5JoGERHwL5WRfzeuzPX0JMM0zqOzq
         4feGoe4//u2r1IRkrq1bqgn38WAgfVoSlTzhR0V4UHoAQ2OHwJEfC+v3DQ+0Y9mxGEaj
         o/PmYwmdpvX95HhxfJ4XJp1nq7gTs6UTRyaILcdIJVtyeiODjVPqr0L87dWgwAdfag12
         b3uw==
X-Gm-Message-State: AJIora+0VZszIiBa+QXl4fTRj5vlhC3tbgUIpD+W/f8KhX+s2d7ukm47
        X/NZ9EpBM1BFBz+nc9h2Qj0rYD7VAlgONw==
X-Google-Smtp-Source: AGRyM1tbWP8+BUX39jZglKhLzBpfZLdq4T/1jJmGrz5fRM23lMhsYeFo5nX68+cU58cSidAqMj98aw==
X-Received: by 2002:a17:907:72d2:b0:722:f9c8:c3fa with SMTP id du18-20020a17090772d200b00722f9c8c3famr1111895ejc.608.1655905882767;
        Wed, 22 Jun 2022 06:51:22 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id c4-20020a056402120400b004356112a8a2sm12349815edw.15.2022.06.22.06.51.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 06:51:20 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id o16so23524701wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:51:20 -0700 (PDT)
X-Received: by 2002:a05:6000:1c0d:b0:216:c9f4:2b83 with SMTP id
 ba13-20020a0560001c0d00b00216c9f42b83mr3489538wrb.405.1655905879653; Wed, 22
 Jun 2022 06:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220520143502.v4.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
 <20220520143502.v4.4.I1318c1ae2ce55ade1d092fc21df846360b15c560@changeid> <e5a7367b-af35-b382-0f2a-e68fe07a4123@linaro.org>
In-Reply-To: <e5a7367b-af35-b382-0f2a-e68fe07a4123@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 22 Jun 2022 06:51:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V9nfJq0_Xvfwid8ev1m9zW2n0zRPSo6fPepHOks8E=PA@mail.gmail.com>
Message-ID: <CAD=FV=V9nfJq0_Xvfwid8ev1m9zW2n0zRPSo6fPepHOks8E=PA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: arm: qcom: Add / fix sc7280 board bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        patches@lists.linux.dev,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Julius Werner <jwerner@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Jun 22, 2022 at 1:27 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/05/2022 23:38, Douglas Anderson wrote:
> > This copy-pastes compatibles from sc7280-based boards from the device
> > trees to the yaml file. It also fixes the CRD/IDP bindings which had
> > gotten stale.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > It should be noted that these match the sc7280 boards as of the top of
> > the "for-next" branch of the tree
> > git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
> >
> > (no changes since v2)
> >
> > Changes in v2:
> > - Use a "description" instead of a comment for each item.
>
> What's the plan for these patches? This is one was reviewed, the 5/5 had
> comments. Is there going to be resend or pick up?
>
> Some other folks work depends on this.

I thought patch 5/5 was waiting on Bjorn to say whether he wanted a
change or was happy the way it was.

In general this series, like all of the Qualcomm dts patches at the
moment, is blocked waiting for Bjorn to have time to land things. I'm
assuming that if Bjorn wants the 5th patch changed then he will still
land the first 4 patches and then I can make changes to 5/5 and send
it as a standalone patch.

-Doug
