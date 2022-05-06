Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3896051DB7B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442639AbiEFPHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442611AbiEFPHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:07:02 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A5F6B089
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:03:19 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id h10-20020a056830400a00b00605e92cc450so5068381ots.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5O83A53in6iugv9Za7chnRDs/elYEvhFVSRVxV/cAPQ=;
        b=JjsAarhXQvuBYdhTwKwB1xG0+3vKZfi2/JtSwspaNA3FG1v1yU1qyfpNtBz8V05odF
         qsvTZcoYVj/Rm85jVPh7kYBrV4giaBW7SLKOUmiauOcZ9XzrOX7dudSajJx3f9bnF37q
         Wh1atwX+UWG1itSWYoOf6yuHdyQp9Qb8QdWvnDv9Wis9IfqQ/Ga/SzZWaD2tmGGwE8uT
         ZnFFNUXSFbt36+fOrZjpJnTrrBr69qp6bY37VW0GOc5U5kWmxAm2JdEE1EkJMyNliWAU
         WdTUA7O0nMIzhPjdnAVGsN0ujvpEft8m74HMxzFwIzmJXRXCgWeiz+XgKYbDDNiGlIb0
         HeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5O83A53in6iugv9Za7chnRDs/elYEvhFVSRVxV/cAPQ=;
        b=MLPmUvC0Bv9mAi3qtaeF7sqNMv6cQ9RwPND8faoDc1SH7GLJItS2xw/alrlVoT4Tcv
         zwoNShXhBGCIETqhf6LSdzmuqiZn0haaUKr32Fdz8Qq+SwjclmgfM/G5DYSu4C4B0AMB
         cZlSo/Js//IHQdCsEgTME9sOdZAbq9XGpC8OP2EjsTFo5nAd+lw+Gd+b9587C5r8MYvL
         g+8Zy0+WY7pH4E75hVcwa4ur9xdEt90DEj7tCd83o/XEct/ZFTerArN7EautcsFumrw6
         erQ1jBYBOnKASnWEwP8FfOzSsblEg2h3GjgjHsyLsX0KVoKSguTE4OfYWP22WUtlQEuH
         cwnA==
X-Gm-Message-State: AOAM530wzOAQr6oD8wu52A8pHXgMh1If8OdZ6Wv+C3R//j5kL5LHXTYH
        11KkWtSgrFh6u/xlhzxzvUV97Q==
X-Google-Smtp-Source: ABdhPJxIy5QsYBDm6W0rLDvyCy60sB949cMonKwARD2zLmRg80jb+eZt+5HiHQALKWW0dKI2a9JDaA==
X-Received: by 2002:a05:6830:2aa1:b0:606:3a07:646b with SMTP id s33-20020a0568302aa100b006063a07646bmr1140552otu.229.1651849398269;
        Fri, 06 May 2022 08:03:18 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e21-20020a056808111500b00325cda1ffb9sm1665311oih.56.2022.05.06.08.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 08:03:17 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-kernel@vger.kernel.org, quic_kalyant@quicinc.com,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Rob Clark <robdclark@chromium.org>, devicetree@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: (subset) [PATCH v2] arm64: dts: qcom: sc7280: eDP for herobrine boards
Date:   Fri,  6 May 2022 10:03:06 -0500
Message-Id: <165184936433.73465.16527836487625041409.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220426124053.v2.1.Iedd71976a78d53c301ce0134832de95a989c9195@changeid>
References: <20220426124053.v2.1.Iedd71976a78d53c301ce0134832de95a989c9195@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 12:41:03 -0700, Douglas Anderson wrote:
> Add eDP support to herobrine boards, splitting up amongst the
> different files as makes sense. Rationale for the current split of
> things:
> * The eDP connector itself is on qcard. However, not all devices with
>   a qcard will use an eDP panel. Some might use MIPI and, presumably,
>   someone could build a device with qcard that had no display at all.
> * The qcard provides a PWM for backlight that goes to the eDP
>   connector. This PWM is also provided to the board and it's expected
>   that it would be used as the backlight PWM even for herobrine
>   devices with MIPI displays.
> * It's currently assumed that all herobrine boards will have some sort
>   of display, either MIPI or eDP (but not both).
> * We will assume herobrine-rev1 has eDP. The schematics allow for a
>   MIPI panel to be hooked up but, aside from some testing, nobody is
>   doing this and most boards don't have all the parts stuffed for
>   it. The two panels would also share a PWM for backlight, which is
>   weird.
> * herobrine-villager and herobrine-hoglin (crd) also have eDP.
> * herobrine-hoglin (crd) has slightly different regulator setup for
>   the backlight. It's expected that this is unique to this board. See
>   comments in the dts file.
> * There are some regulators that are defined in the qcard schematic
>   but provided by the board like "vreg_edp_bl" and
>   "vreg_edp_3p3". While we could put references to these regulators
>   straight in the qcard.dtsi file, this would force someone using
>   qcard that didn't provide those regulators to provide a dummy or do
>   an ugly /delete-node/. Instead, we'll add references in
>   herobrine.dtsi.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: eDP for herobrine boards
      commit: 366a0a194b3b3e3e52bc7b7b1ac35b40a1187902

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
