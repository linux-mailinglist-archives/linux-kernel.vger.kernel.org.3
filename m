Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D049B54EB9A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiFPUs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378749AbiFPUsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:48:03 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C8E31510
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:47:59 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y196so2470123pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DSrnqAFWoF8mM4JPrtGHlUHqt2gHTlKj7WZsyQLOO9Y=;
        b=NgrhyL1PF0ArhJm3ZhmdVUCh7jC1G5NtECPB4odxnvf36oIlo9JvJxiwHUOikYnGez
         OZfYmHP8lBAcxmsCX8JHuOyz2fSjl1a/gbp4YZzz+fcUUxozbYkaHcm7iUjUMyYs77nh
         ptLlGDzrt0KJ9WVl/mJX/KRi7YLkikhaZtxY+3sl1xUw2weLKkSzVSatDZF5srb6gVTj
         L5hynDAGPpaDVarNiOTx00gFaJHpnxyj1Emh3ipGEdzu6G8DIds4TxAMyRLtQbJK+8Xs
         QojnrCRX9V5dwo1ThTzJ8xEXXmh97WnM6DDJmGcEmlfmtIgfZJ4X7Hse164v7gPkCfv9
         V2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DSrnqAFWoF8mM4JPrtGHlUHqt2gHTlKj7WZsyQLOO9Y=;
        b=RIb/Txrs+8y2kON9O5GjLOGFFGvCW7wgCF7Mhzq82Sz+qrN+IDaq6PZQHSmovSxNez
         iUa/e3iyxPRsLucBhuP4+SAUdXcFylCo0uf4dBrjtok/A1VeDFSgJZJQAju2HzCCYABG
         2eA4ryNt2p27lEtZJJTxykOb5I9mx0Xbgvf0VkMkl0PrmSAL5uES8NH78IPoC4JmGvoA
         0HHfpCP11SOp96dCpYM9fqGVnMvNPeMs3RaCqtsANk8kH8UfxzxXgZGqnHwBsa+ApM+n
         +M37djOjlvIN8IaMHpcuNg1MiRFQ3gpClXzueBIjBjgq1Z0kj6iwFnn+w1mkVfd0FV3s
         +euQ==
X-Gm-Message-State: AJIora/VK0in9Fgz1cCt6Pqv5QHYimxPwspVmXl90H0N/9/3iGdJCUdS
        tdgpDBI36TkHsbzVB+TXA30rPQ==
X-Google-Smtp-Source: AGRyM1s3VZTZrltd4/YYrXxaN7XSMklshqxOTInsXy0XAwRNWsYt3C+nUfHUDZDFdXfzDYBLQBwVzQ==
X-Received: by 2002:a05:6a00:14c8:b0:51c:29fb:7b2 with SMTP id w8-20020a056a0014c800b0051c29fb07b2mr6611600pfu.24.1655412479376;
        Thu, 16 Jun 2022 13:47:59 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id 203-20020a6218d4000000b0051ba0ee30cbsm2165453pfy.128.2022.06.16.13.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:47:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Nancy Yuen <yuenn@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Fair <benjaminfair@google.com>,
        Patrick Venture <venture@google.com>,
        Tali Perry <tali.perry1@gmail.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: nuvoton: adjust whitespace around '='
Date:   Thu, 16 Jun 2022 13:47:20 -0700
Message-Id: <165541242280.9040.13557968338799812389.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526203724.831215-1-krzysztof.kozlowski@linaro.org>
References: <20220526203724.831215-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 26 May 2022 22:37:24 +0200, Krzysztof Kozlowski wrote:
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=' sign in property assignment.  No functional
> changes (same DTB).
> 
> 

Applied, thanks!

[1/1] ARM: dts: nuvoton: adjust whitespace around '='
      https://git.kernel.org/krzk/linux/c/f30528c6b08a4e4b8e6a36ef10c1e7bc918bf6f0

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
