Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D997850A273
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389315AbiDUObE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389220AbiDUOaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:30:10 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5F23EBB4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:27:20 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id e4so5799289oif.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ax4avlN0oglfzD6swQB5upAnrR9vbmcO4lly1CB9MS0=;
        b=WsC04F1RsX1JNzcannfCWEjoteFcPfSy9HqfKLlLLTSxKaAMW7vo8kPvQ7SvxIA6Az
         9YtRXmHBaxvC9+gXLPvne/Qy+0JtquZhXTKVBz5Ea99QSDnatgl1Ir0cnm+nIHD8GLYl
         G9lIfXbTKgztzzhNMoNW7xaq4yvZ2xzkfXXfKBRurKTXLxBCIbdsin7VitVBvUFo7fD2
         BMLl1XY+ISNNf9Yd9ZL7WADg+zhKDnfBQ8F4wLelxoXPNzDcLlTSR0JigF5DZteMcXTd
         9ooTO4DRB31uXzPaPfZVuBZtmL63ckMptbfxHy1rT689f4dbtNMflQ+kL9z72FB9g2rk
         mOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ax4avlN0oglfzD6swQB5upAnrR9vbmcO4lly1CB9MS0=;
        b=nkC6Koih33lRXgc/AKoGM3CR8x4LH+4v50RW763bPiuXaJlyhqcZiPOUiXNcExSPop
         LaIulLKjAgVTKnnhJdCrNIN60O3bAK83emKuoBb5lKCvAA2GWEGjaeA6aTfo3uu8xqeM
         ZYWqubNzflHXQLaqgfpNRUWcE9Gyv1VLl4/JkcLa1z/mk1c73Wah5BiDQQ/jaV1c0w71
         zN0HkjmZQB0Kgb++WvHWMxyEE03o/hOfRu7VwRGoIRPDDazYpMvNqAqTXAy1LKFtu3Zf
         pu7lLFaR1+3SHhh68TuJ28MIq1lDKgw55Gah9Jc3p9BbuxAbwM3O83B4PulxDEVVh5Uo
         z/zQ==
X-Gm-Message-State: AOAM533D/mT8HR/j0drJ2hrEp0QDil3hm9JD6EzLQ5X1R0K+jgPOiH/P
        vkMXzeUvmnFFETXbifGzdv0U4A==
X-Google-Smtp-Source: ABdhPJwaFVAfSTDez3Zu80iJyqsv3GD/rPUN1R5xCe3IUJJdfZQU4qTP1ofMsk33NJeB4R6esgp1sQ==
X-Received: by 2002:a05:6808:180c:b0:322:3d43:c38b with SMTP id bh12-20020a056808180c00b003223d43c38bmr4162516oib.8.1650551239426;
        Thu, 21 Apr 2022 07:27:19 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s14-20020a0568302a8e00b006054e841915sm4296295otu.73.2022.04.21.07.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:27:18 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vamsi krishna Lanka <quic_vamslank@quicinc.com>
Subject: Re: (subset) [PATCH 1/4] ARM: dts: qcom: sdx55: do not use underscore in BCM node name
Date:   Thu, 21 Apr 2022 09:26:56 -0500
Message-Id: <165055095989.2574292.3311309854371304681.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220411085935.130072-1-krzysztof.kozlowski@linaro.org>
References: <20220411085935.130072-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2022 10:59:32 +0200, Krzysztof Kozlowski wrote:
> Align BCM voter node with DT schema by using hyphen instead of
> underscore.
> 
> 

Applied, thanks!

[1/4] ARM: dts: qcom: sdx55: do not use underscore in BCM node name
      commit: 568cd3243331b6bf0702665f7bd90baa93e2b3ac

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
