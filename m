Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E565175A3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386635AbiEBRVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386620AbiEBRVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:21:16 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9269B1DA
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 10:17:46 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l7so29012108ejn.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gMqBgTrhfUKKEl/G5V1eWPOJxywdk0FK8Tb1dsdlXpM=;
        b=Fc3vRfuW5NtMW7EI2ZBMV+YnIKqAMpApdt4JOF20Q5AAQ6HDr4LiYSVM0xZoUyNqn+
         OgeNUG46t2hjmY46svxZFz3QtaSSArm1HTAVYQil+AjrxmYeEUh7vEQwXgLEnVl5aq6t
         ZtoZ8IKY/USy5HQHZcyaOmwqGjHrFecdY3cNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gMqBgTrhfUKKEl/G5V1eWPOJxywdk0FK8Tb1dsdlXpM=;
        b=tV3S8GGSZNueVh4BiWEvKz6MGTFkESLgPeooTdKyrex/J8rFLkl0+EeAYd1iqXqOwy
         3nL3a1QfUllJMXdXs0p1koof9g7ol3Mel9WhnIwh7AsaSJKFjI3MCuBl9ghr5BhLL8OM
         w+PtDsLu30MCMLvf0+XE8jg2B8y37s7Cgja7qps59F15vzfajr/M1VbFcHu7m84SRNR7
         RMdCQaUHqrSIMU8MhKBAoN3ULkOsOWMGOudtf9KLN/90FR7plZa6j7f8REq+UfyrUXLB
         Iw0PiY8PpdRkPCfQv7k5bleoafKTh/70PBSXqFreUIW6BTUu9IuqIrSJcRYFUYa4Lvle
         CStg==
X-Gm-Message-State: AOAM532puXR0GPPr9jEOW/O3bJX+mOpIVT0II+HAFgZmwJrFOEYFtXXM
        VibLE8G/E0crT50YdE8TLLW1no1Cxh9Xl97v
X-Google-Smtp-Source: ABdhPJymMQzdS5x5ykX/WUNocfxc6pX5Q4deuPG9cl6nEjFU5xLZYM4Kl/29Z2dXdEYqpkJ901OwGw==
X-Received: by 2002:a17:907:1b10:b0:6e4:bac5:f080 with SMTP id mp16-20020a1709071b1000b006e4bac5f080mr12120491ejc.24.1651511865121;
        Mon, 02 May 2022 10:17:45 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id zp1-20020a17090684e100b006f3ef214defsm3746311ejb.85.2022.05.02.10.17.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 10:17:44 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id k2so20366603wrd.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:17:43 -0700 (PDT)
X-Received: by 2002:a5d:42c8:0:b0:20a:d91f:87b5 with SMTP id
 t8-20020a5d42c8000000b0020ad91f87b5mr10141812wrr.301.1651511863286; Mon, 02
 May 2022 10:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220430011402.1.If7c3471db53bea55213f7bcf17e9043084d3ac0c@changeid>
 <20220430011402.3.Ic20d0c002ac5406b880cbdf9824739f38740926c@changeid>
In-Reply-To: <20220430011402.3.Ic20d0c002ac5406b880cbdf9824739f38740926c@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 May 2022 10:17:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UKSsOoer-9sUMP4AYF=A0L2Wg+cZ40Q_22m=GZjoUzuw@mail.gmail.com>
Message-ID: <CAD=FV=UKSsOoer-9sUMP4AYF=A0L2Wg+cZ40Q_22m=GZjoUzuw@mail.gmail.com>
Subject: Re: [PATCH 3/5] arm64: dts: qcom: sc7180: Add quackingstick dts files
To:     "Joseph S. Barrera III" <joebar@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
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

On Sat, Apr 30, 2022 at 1:18 AM Joseph S. Barrera III
<joebar@chromium.org> wrote:
>
> Quackingstick is a trogdor-based board. These dts files are copies from
> the downstream Chrome OS 5.4 kernel, but with downstream bits removed.
>
> Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/Makefile             |   2 +
>  .../sc7180-trogdor-quackingstick-r0-lte.dts   |  38 ++
>  .../qcom/sc7180-trogdor-quackingstick-r0.dts  |  26 ++
>  .../qcom/sc7180-trogdor-quackingstick.dtsi    | 324 ++++++++++++++++++
>  4 files changed, 390 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
