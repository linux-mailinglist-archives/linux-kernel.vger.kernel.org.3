Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35CA50A278
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389265AbiDUObC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389266AbiDUOaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:30:15 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4503EAB7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:27:24 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id r8so5781576oib.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ufjm8eQVOmHSq6mbSZuwdtOmOtgkiUv7cvs2d7Tsqzg=;
        b=lc88I4IrzjCDq0usz3Ap64eq6els4c0Q8dPBj3xtOtsvVg15OT65MhjcL1VTJ3rlGR
         r1n6vPBJyEGyrBZvAboUG/VOXBD2/rZIQ7jlSRy95NoPV09fJxSUGuZypZ33mmXYDknd
         1coVYs8aTrVmSwQpbK0+i4KTuq04CpyUT/8vxIvPxJR6RXSKVRduGsMDvopcy7yEBRRX
         KaaTc2HE7RA2bO8jBL1hzzhNYoN6/CBP1eFsXzCWQVST7gqCq+386VisxLwDfFF+IChF
         lkZGvy8W17oRUESRArTDYfh9Qv8a77ENtcaFVV8yM/MNZgivs1D9t4pvLkp/iHsiI75J
         2MbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ufjm8eQVOmHSq6mbSZuwdtOmOtgkiUv7cvs2d7Tsqzg=;
        b=NJZ5Fv8q1DC8TYUixY3YYP9K/B6HILb0IE9RHs6a263etpnuxeOJPX371E6r4SjmV8
         i1W92womi4LpoLAqV/Eb7FkN9s+0nx593gLe7WUgS1MPxt3Px50QsT6iwST5PfnYpdZ6
         p75yzGbIOFlqRIfpDbyp2fGYccwvJedlMcozyUIVAZ6cpHOZUnaxaJcV56m91SHTcea8
         mOPTwWDfD68bHPTqN1YHhrqDQYIe9bj+tWhLsfc+emoNIhLhTMTyo/jtjCcSBsAa4o8m
         +iExIMPinYnWOMMFM7X/RHWXbgM3u/3NJIhR5oeY7xSD0l5WaWM77dAiN5xFVknY1FYy
         kMhw==
X-Gm-Message-State: AOAM5330sM6/hpvWDH3yhBvJkjqEegXsl2Pk7g9ORhKThQISr7mgBTAe
        8RygceMsa0R1b/luoB33geBUvg==
X-Google-Smtp-Source: ABdhPJxxHRoVLE3Remv3U2pn0rDem4OQU5/ftPllny7x5E7b3nt4YxU+rbz6XgxbotrSgEfF98DB1w==
X-Received: by 2002:a05:6808:138e:b0:322:2dcd:dc7d with SMTP id c14-20020a056808138e00b003222dcddc7dmr4351042oiw.159.1650551243482;
        Thu, 21 Apr 2022 07:27:23 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s14-20020a0568302a8e00b006054e841915sm4296295otu.73.2022.04.21.07.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:27:22 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vamsi krishna Lanka <quic_vamslank@quicinc.com>
Subject: Re: (subset) [PATCH 3/4] arm64: dts: qcom: do not use underscore in BCM node name
Date:   Thu, 21 Apr 2022 09:26:59 -0500
Message-Id: <165055095990.2574292.8000062145772271455.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220411085935.130072-3-krzysztof.kozlowski@linaro.org>
References: <20220411085935.130072-1-krzysztof.kozlowski@linaro.org> <20220411085935.130072-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2022 10:59:34 +0200, Krzysztof Kozlowski wrote:
> Align BCM voter node with DT schema by using hyphen instead of
> underscore.
> 
> 

Applied, thanks!

[3/4] arm64: dts: qcom: do not use underscore in BCM node name
      commit: fc0e7dd6d2e2c9f8b2c6497a190ee29d8f3aef3a

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
