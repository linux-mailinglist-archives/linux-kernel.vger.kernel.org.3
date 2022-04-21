Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28B750A260
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389367AbiDUObQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389349AbiDUOaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:30:24 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91CA3FD97
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:27:31 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 12so5753858oix.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d2ljouS/NpyCeddFpyIfjibsWr5AFiZwDxJgcpp7ScU=;
        b=BbpDQvemCdZVqmb7nHXXs3coqPhdk0qtRa4x7/1gBOhP9l4iw9jADHsviJQ7FGmMFh
         lwVjRS9Pt49yI/lahyfPIFslnEHOe5xLFZ7CDJy7VUlmORpJNaIoliyk9zV2+GoYo3f5
         Oj4mRNsDtf0RSyGCTCMWM9ciA1j48YwniEb63nXu9aaYdEEURpQefnAQfONr/L1wSQ5k
         N64GREE5ONZs5NDPX6KI+7EInR87qWSYNzh9iOoHdBpPXCuSWxwB7L8rvMwONVTo1w7G
         Gu53muN8Wb02OHUF9cLwwyiM3rCj0lCyqG0/2wlpSwXV/R5iFljrYdVovGWXZRWM1ymL
         5Elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d2ljouS/NpyCeddFpyIfjibsWr5AFiZwDxJgcpp7ScU=;
        b=vOPRz+hyaSlaNQdxO5Py9BLOrlMj2i2Yod4WcVVZCmHXH171PnxkeOGFZ97ayZs2R6
         B3thXq/wHAbXCEpAiIohZymddELCYFBoorEjJk7z+L5+l0U2v/uAZzB5MIIpBZNSpNG1
         o5P4FvayZLsAzn4O2CnftlZ2RTDv1bKyJQAmKUlpZEg+i/ZljKO1eO0WPusA1XOeRTPx
         mhFZHqTws132sCSBmtfXbWlhZapZnkYXhMLligl3jgALsWiPkgcJYeYem+XLuL5MXTcK
         WSt5qtpKaeaKv8cDsvKT70chMxoSKIU5/CDv8lSAOez3wjUf3wReqtDT4ryu2iy+xl6M
         1Tmw==
X-Gm-Message-State: AOAM533cp907f7RnhOTkS/b2ygn89FfM65NYYnhsaM9BIIqUAUZ76uqT
        kI8VL+1o2ywx74VhSb11yoq7Kg==
X-Google-Smtp-Source: ABdhPJx88FVVrMymF5gKvcCBYCUtPX/ISFPeHlaE7O//hDUPNqrMeGTrMmybmJEhcEkrBXUAUv+EXA==
X-Received: by 2002:a05:6808:23d1:b0:322:97f8:69d7 with SMTP id bq17-20020a05680823d100b0032297f869d7mr4348215oib.241.1650551250958;
        Thu, 21 Apr 2022 07:27:30 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s14-20020a0568302a8e00b006054e841915sm4296295otu.73.2022.04.21.07.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:27:30 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mukesh Savaliya <msavaliy@codeaurora.org>,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v2 2/4] dt-bindings: qcom: geni-se: Update I2C schema reference
Date:   Thu, 21 Apr 2022 09:27:06 -0500
Message-Id: <165055095990.2574292.2416504278084349472.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404182938.29492-3-singh.kuldeep87k@gmail.com>
References: <20220404182938.29492-1-singh.kuldeep87k@gmail.com> <20220404182938.29492-3-singh.kuldeep87k@gmail.com>
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

On Mon, 4 Apr 2022 23:59:35 +0530, Kuldeep Singh wrote:
> We now have geni based QUP I2C controller binding in place as
> dt-bindigs/i2c/qcom,i2c-geni-qcom.yaml similar to other controllers,
> update reference in parent schema and while at it, also remove
> properties defined for the controller from common wrapper.
> 
> 

Applied, thanks!

[2/4] dt-bindings: qcom: geni-se: Update I2C schema reference
      commit: fcf2c0f7cbcad29f1decb88567e54c2451b60ba5

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
