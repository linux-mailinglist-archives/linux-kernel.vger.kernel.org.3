Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BDA534272
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343541AbiEYRvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343539AbiEYRvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:51:09 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B28B182
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:51:08 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id p74so18489119iod.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=po4fZuhQjua5xFboKSeszJd6bmcTvYOuQalf/Wsj6NM=;
        b=GbhWDbOof7USuznbJj3BOp8b+rV7AnZCEjomngAQ1Tm5K6yUmSM9VrF2rXhlIFjjxh
         Ckx8hCMaloSM9IWCHuDmn+jYngmhlml2zbUjugw3WU1TYudDq+AFiXNlTNWyO3lXGFWV
         QYHTlGr7/VhKpgW6q/UlmIRt1ynDNIl5jQp0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=po4fZuhQjua5xFboKSeszJd6bmcTvYOuQalf/Wsj6NM=;
        b=MdRHPJ0EmT0o4Uu3a+gRrgMQcYOj7gqnGOzzg2XbK8G7NSGBCXPxWfXC4MpftReDSX
         7xXhcgoVFdQm/m12ei+pyf9/wG+hlfffMzWATAeEdgZ7KbXvFEuHK1lLuGN6m3+jZFMG
         AeIX7+JC1L85sWtj6TJNkornvkHFMvMd5GC7ejqesV8/rh2V/bNvwf+Q3ByPgcQUqa90
         3A1iJBM9/jmm+7uRU0k01s1ZlE3GOgRqt0XKYzG0GevGqUExROaGckkUlIQBC+NxlNQN
         uhncefeQrz2HD3bATpRI+Z56kN4dz/7ifXnLyAiaKO+OLX7n61583P00eTSdk6TgO1cn
         wpXQ==
X-Gm-Message-State: AOAM532BOGPIs49xPJNPZlrVVYQhw3VMrP/0qBSPBwUyZQHFCAyDnqgM
        JvW+tQjbAa3fdYA1RDM+HV9E6EvGcYC2BPXhaEQ=
X-Google-Smtp-Source: ABdhPJznEa7HkbfXVRXWRyywEQzmgpYW6u/+75Srljc2ICMmX2SZBGV2QpQdANCQCHQcVm+D80JUpw==
X-Received: by 2002:a05:6638:1446:b0:32e:a9c4:10c3 with SMTP id l6-20020a056638144600b0032ea9c410c3mr11733029jad.280.1653501067060;
        Wed, 25 May 2022 10:51:07 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id f21-20020a056638023500b0032b3a78175fsm4308624jaq.35.2022.05.25.10.51.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 10:51:06 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id a10so22116439ioe.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:51:06 -0700 (PDT)
X-Received: by 2002:a02:6d61:0:b0:32b:fb61:9d88 with SMTP id
 e33-20020a026d61000000b0032bfb619d88mr16675388jaf.184.1653501065709; Wed, 25
 May 2022 10:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220525014308.1853576-1-judyhsiao@chromium.org> <20220525014308.1853576-3-judyhsiao@chromium.org>
In-Reply-To: <20220525014308.1853576-3-judyhsiao@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 25 May 2022 10:50:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uf6OhDBpr_-ennq0_c61x_sr4_ma6a=z8PWvaPGFyP_A@mail.gmail.com>
Message-ID: <CAD=FV=Uf6OhDBpr_-ennq0_c61x_sr4_ma6a=z8PWvaPGFyP_A@mail.gmail.com>
Subject: Re: [v3 2/3] arm64: dts: qcom: sc7280: Add sc7280-herobrine-audio-rt5682.dtsi
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 24, 2022 at 6:43 PM Judy Hsiao <judyhsiao@chromium.org> wrote:
>
> Audio dtsi for sc7280 boards that using rt5682 headset codec:
> 1. Add dt nodes for sound card which use I2S playback and record
>    through rt5682s and I2S playback through max98357a.
> 2. Enable lpass cpu node and add pin control and dai-links.
>
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
> ---
>  .../qcom/sc7280-herobrine-audio-rt5682.dtsi   | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
