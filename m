Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9AC53BF51
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 22:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbiFBUIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 16:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239094AbiFBUId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:08:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6C337A3D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 13:08:30 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v25so7646496eda.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 13:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgACnyK4+wOiS5MKuMTnoonRsVlmK8PYmGJQJvcgO6E=;
        b=gCNQf5treIeOY896E1dwCdHz3vHIg34Tiv2t6JPnU8eRhXoHeu6+4L3Uh/UmmoSB4J
         frLhr+7HqIhSw29Lu1hlJ8Fl7ddyJgm7PH15YadqhbxolK5DpD9Oozcz3nAx9uaLJYZl
         w+l3zgS2iBUS4NjgZcWirSTVwqmGjn+NPH/cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgACnyK4+wOiS5MKuMTnoonRsVlmK8PYmGJQJvcgO6E=;
        b=aSqRh1LdHuBYh1b3QGbR8rkQ/nRv0FOApiwrqNHQhZ9jGacVcH9kI8oEW5ywNyOAMx
         6lqtg+/Ljp2jaKwJR+/rd3dYH5M6acYy6fsTgzqKguRJ06w7Py00hMQUicUyLq+Hg7CL
         bcLxOOM3xetudH0jA0BPZq/+LJ+T6jS5ZBe0h6FZFRSbiV2BX4NtivvpW8ze7ePQBKFy
         MGyXxV4cbyXiUsQFVFdB+t9Y7y9Rp6ttgW69ONjcHvmTVV1LIY9qsPvOyMFOzd4WMPXv
         0To5KyMz+mi7GFJYmBVJPUk3JbQRR4ueP4f3HM0jaGSoZCkENGHRRtGYA/rG408cJavv
         qyoQ==
X-Gm-Message-State: AOAM531nriQRSe5wB7gsy3UlJ4gMFRkfZwlWvOzXKmvezBuH9SzSevtY
        WB0BKMdF4JRZqQ61/5eGpC7qWJgBrPOafw==
X-Google-Smtp-Source: ABdhPJzPFOH/TDeD5O+AxdFlhT0NqCiCG8wMe6TFHcSHRdOXnncIj00z36nSppQj1wvOPffqou0Inw==
X-Received: by 2002:aa7:d295:0:b0:42d:e371:ded2 with SMTP id w21-20020aa7d295000000b0042de371ded2mr7365651edq.336.1654200508896;
        Thu, 02 Jun 2022 13:08:28 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id gg1-20020a170906e28100b006f3ef214da9sm2103383ejb.15.2022.06.02.13.08.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 13:08:27 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id e2so7826182wrc.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 13:08:27 -0700 (PDT)
X-Received: by 2002:a5d:68d2:0:b0:210:31cc:64a6 with SMTP id
 p18-20020a5d68d2000000b0021031cc64a6mr4886531wrw.679.1654200506938; Thu, 02
 Jun 2022 13:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220602190621.1646679-1-swboyd@chromium.org>
In-Reply-To: <20220602190621.1646679-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 2 Jun 2022 13:08:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X6702aSaEnpXUhF40b0kZuz1QvOBLNg-xcNDYbVCbsDw@mail.gmail.com>
Message-ID: <CAD=FV=X6702aSaEnpXUhF40b0kZuz1QvOBLNg-xcNDYbVCbsDw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: Remove duplicate sc7180-trogdor
 include on lazor/homestar
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
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

On Thu, Jun 2, 2022 at 12:06 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> The sc7180-trogdor-{lazor,homestar}-*.dtsi files all include
> sc7180-trogdor.dtsi and sc7180-trogdor-lazor.dtsi or
> sc7180-trogdor-homestar.dtsi, so including it here in the
> sc7180-trogdor-{lazor,homestar}.dtsi file means we have a duplicate
> include after commit 19794489fa24 ("arm64: dts: qcom: Only include
> sc7180.dtsi in sc7180-trogdor.dtsi"). We include the sc7180-trogdor.dtsi
> file in a board like sc7180-trogdor-lazor-r1.dts so that we can include
> the display bridge snippet (e.g. sc7180-trogdor-ti-sn65dsi86.dtsi)
> instead of making ever increasing variants like
> sc7180-trogdor-lazor-ti-sn65dsi86.dtsi.
>
> Unfortunately, having the double include like this means the display
> bridge's i2c bus is left disabled instead of enabled by the bridge
> snippet. Any boards that use the i2c bus for the display bridge will
> have the bus disabled when we include sc7180-trogdor.dtsi the second
> time, which picks up the i2c status="disabled" line from sc7180.dtsi.
> This leads to the display not turning on and black screens at boot on
> lazor and homestar devices.
>
> Fix this by dropping the include and making a note that the
> sc7180-trogdor-{lazor,homestar}.dtsi file must be included after
> sc7180-trogdor.dtsi
>
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Cc: "Joseph S. Barrera III" <joebar@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Fixes: 19794489fa24 ("arm64: dts: qcom: Only include sc7180.dtsi in sc7180-trogdor.dtsi")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> It would be great to get this into -rc1 if possible to fix broken
> display.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I tested and this fixes the "no display" problem on Linus's tree on
both homestar and lazor.

Tested-by: Douglas Anderson <dianders@chromium.org>
