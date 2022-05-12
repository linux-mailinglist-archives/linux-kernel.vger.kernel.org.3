Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBF15257AE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 00:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359104AbiELWTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 18:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351294AbiELWTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 18:19:47 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB572802F6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:19:45 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ba17so7895616edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=McSS2ps7lAda0B7Hjqm4GcEs6ir76cLprhYeL3EvtQM=;
        b=FpKUMneT2lkBkxD8QufbxsbC3iS2M4kA4XRmF3F+SntKp7qqDK9yyAtfeOxgnr9a3j
         wwP3HiFOGA9hJIaks57Co+DyFPOq1f1kjR1dq4QGVQ0NSV6f5vppoZjBxU3toP3xQccx
         Z0uZZ9G3jvEjNFvB4TkXgwrYoNmR0Hgz+ts1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=McSS2ps7lAda0B7Hjqm4GcEs6ir76cLprhYeL3EvtQM=;
        b=AUiHTDLEMeDtzAmMqzZ/gr2NxMOdoyDJcY9q15k9gjx/rOI6oMp3KEOliTNfQ+IyUf
         jqIVl49x7E+aPLwcNTALuGs2pFc5TWxvNIz7yaATjahWo+Sjz38Cw7vNh7wpDv6GHaV6
         vXdwZQ3ViHMjy6ZFzDjED63S9rQAm/G/UEtd3haTuF5wCoNkc6cP6ZbZcka25X20g8aq
         djoOKPZ1o6qFKiG5jZS4zqqMhiJezXBQ/scywo2xcxptScsKDThc1o6M24mJjH4Xgarj
         2ZEN4SIOim0kOpyQX+FdOGLXkAsQx4Qg5m6SMrcsEfV9H3t6G6U3Ku8APa9EQF4OqoI8
         fzmA==
X-Gm-Message-State: AOAM533Zftj8XSeXtA7Jo8oV8KRGotVmDLEl2AU+rWcVDng6+7m6LKCM
        dGZkX0JMScG+zK1bljzH5KuKqs1hANf6IM03
X-Google-Smtp-Source: ABdhPJzpPtRNzGKF/DHv1wa+PJldCmzuIzHqdZaYIh0mCf7s0djJehFui/+E8yn8UiYbsM5tH0T/9w==
X-Received: by 2002:a05:6402:3485:b0:427:cde4:2097 with SMTP id v5-20020a056402348500b00427cde42097mr36348855edc.264.1652393983875;
        Thu, 12 May 2022 15:19:43 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id gx24-20020a1709068a5800b006f3ef214dc2sm176238ejc.40.2022.05.12.15.19.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 15:19:43 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id v12so9049278wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:19:42 -0700 (PDT)
X-Received: by 2002:a5d:6d09:0:b0:20c:53a9:cc30 with SMTP id
 e9-20020a5d6d09000000b0020c53a9cc30mr1382071wrq.513.1652393982520; Thu, 12
 May 2022 15:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220510154406.v5.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid>
In-Reply-To: <20220510154406.v5.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 May 2022 15:19:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vkiqxv5QRiEqCjZVSNUH=K1N+JuYEsXu=XtFNxRtvttw@mail.gmail.com>
Message-ID: <CAD=FV=Vkiqxv5QRiEqCjZVSNUH=K1N+JuYEsXu=XtFNxRtvttw@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] arm64: dts: qcom: sc7180: Add wormdingler dts files
To:     "Joseph S. Barrera III" <joebar@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
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

On Tue, May 10, 2022 at 3:46 PM Joseph S. Barrera III
<joebar@chromium.org> wrote:
>
> Wormdingler is a trogdor-based board, shipping to customers as the
> Lenovo IdeaPad Chromebook Duet 3. These dts files are copies from
> the downstream Chrome OS 5.4 kernel, but with the camera
> (sc7180-trogdor-mipi-camera.dtsi) #include removed.
>
> Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
>
> ---
>
> Changes in v5:
> - Replaced _ in node name with -
> - Ordered nodes by name

So it's a bit of a judgement call, but generally the rule is that if
you didn't make very big changes from one version of a patch to the
next that you should keep "Reviewed-by" tags that you've already
received. In this case the changes you made from v4 to v5 were very
small and also very non-controversial (it's hard to believe I would
object to these changes). Thus, it would have been better to keep my
Reviewed-by tag. Everyone understands that it's a judgement call so as
long as it's within reason people won't be too upset at you for making
your best guess. If you're unsure, you can always add a note "after
the cut" (AKA "Commit-notes" in patman speak) explaining why you did
or didn't choose to keep someone's tags.

That being said, offline Stephen pointed out a problem with all of
your v5 patches. Specifically, in the meantime while you were spinning
your patches, Stephen's patch series landed in the upstream tree.
Namely:

19794489fa24 arm64: dts: qcom: Only include sc7180.dtsi in sc7180-trogdor.dtsi
d277cab7afc7 arm64: dts: qcom: sc7180-trogdor: Simplify spi0/spi6 labeling
51d30402be75 arm64: dts: qcom: sc7180-trogdor: Simplify trackpad enabling

Since he won the race of getting the patches landed, that means it's
on you to adjust. You should modify your patches to match what Stephen
did in those 3. ...and, presumably, the changes Stephen is requesting
here probably _are_ big enough that you'd want to remove my
Reviewed-by tag for v6.

Speaking of Stephen, he reviewed your v4 patches, but you didn't copy
him on v5. In general if someone responds to a patch in the series you
should CC them on the next version.

-Doug
