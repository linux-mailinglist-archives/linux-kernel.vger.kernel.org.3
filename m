Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A53F4E6993
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 21:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353097AbiCXUBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 16:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiCXUBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 16:01:39 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A9E81186
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:00:06 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id h21so3905978ila.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NIeb4/VCYD/DVpQS7+hcb33JtSGPsyNTOD4hJRIfFYg=;
        b=ig2LZmT/ULNd6has1x+tgUYcp8IlB29NYiSSDQoLQq7e4dlU3i6HB1VA7Q9gZeYXWi
         M3lCuAvR1UpnzsELZRdyf8bqrTPOEdmnFXOCBwKCPDfaxWan6BjVu9tXgGEHa9RSd8kr
         owI6u9PErmK310L9agaXHuclkSSY1jcINq+B0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NIeb4/VCYD/DVpQS7+hcb33JtSGPsyNTOD4hJRIfFYg=;
        b=69ScXwJR5XDlYaAra9Ywj08lgXnk8cJE/lNP6w9lx7XI9E60Dzev2+WJ+2iY9cxFkT
         YEqtNSdkT9rtEJ4AGHMIDurNIfD2+KzGK155s/TJGbBazhslHYSrU4Px/bsxdMLRUbcS
         OF7GlAFhK4x3SCTeGmLEZ8KklM6r373ZRQv8WP2n1ePbvf+Re+lK7QGHCx3OXekRLMuR
         UzMnujDSsYazg1e+ISc3h7ykvydiEzlm3ppYg6xp+nXM8e4or2TDSqgL3Bf4uvRuOIJl
         ig3jSNCdWrih+rbWtP1WmHBHIT9AV/xmHg8o6yj2evdo+jbzzjcAuNHwyM7riEf4f9ye
         u4QA==
X-Gm-Message-State: AOAM530ZPEor5y97/HBbjrQ/VmzwgCx9LgfQsNazwljenOb8XCCKw1st
        yl8jGmDCrZgZw0dZR72TQ80ooEa3ESWX459u
X-Google-Smtp-Source: ABdhPJwrZTdpvcFAEB7Qk9pb7MJwNwyvscQtwHfB2u0ilP0s5vyWLlTO2ceWYgkoWpKIuRU7UrNdPg==
X-Received: by 2002:a05:6e02:1846:b0:2c7:b032:5d92 with SMTP id b6-20020a056e02184600b002c7b0325d92mr3636089ilv.237.1648152005880;
        Thu, 24 Mar 2022 13:00:05 -0700 (PDT)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id bk22-20020a056602401600b00649ee81166dsm1855286iob.37.2022.03.24.13.00.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 13:00:05 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id r11so3917300ila.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:00:05 -0700 (PDT)
X-Received: by 2002:a05:6e02:20c4:b0:2c8:5b82:3035 with SMTP id
 4-20020a056e0220c400b002c85b823035mr3583254ilq.220.1648152004944; Thu, 24 Mar
 2022 13:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220324101242.v1.1.Iebdb5af0db7d3d6364cb229a27cd7c668f1063ae@changeid>
In-Reply-To: <20220324101242.v1.1.Iebdb5af0db7d3d6364cb229a27cd7c668f1063ae@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 24 Mar 2022 12:59:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XchtJx3ZsL4Bxj29b_-43E8p2fiJ5SBQSzbW8wp+gNfg@mail.gmail.com>
Message-ID: <CAD=FV=XchtJx3ZsL4Bxj29b_-43E8p2fiJ5SBQSzbW8wp+gNfg@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Add device tree for
 herobrine villager
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 24, 2022 at 10:13 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Add a basic device tree for the herobrine villager board.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../dts/qcom/sc7280-herobrine-villager-r0.dts | 274 ++++++++++++++++++
>  2 files changed, 275 insertions(+)

Question: how does this interact with the patch:

https://lore.kernel.org/r/20220316172814.v1.3.Iad21bd53f3ac14956b8dbbf3825fc7ab29abdf97@changeid/

Specifically, if that patch lands first don't you need to add a patch
to turn on "pp3300_codec" ?

I was also looking at whether we should be enabling the wf_cam
regulators for villager. I believe that answer is "no", but _also_ I
believe that we should be _disabling_ the uf_cam regulators for
villager, right?


> +                         "MOS_LAA_AS_EN",              /* 90 */
> +                         "SD_CD_ODL",

I was somewhat surprised that "SD_CD_ODL" was listed here since,
diffing this with Herobrine, it appears that Villager doesn't have SD.
I checked the schematics, though, and I can confirm that the GPIO is
named this even if it just goes to a testpoint on the board. ;-) ...so
I'm fine keeping it here.

-Doug
