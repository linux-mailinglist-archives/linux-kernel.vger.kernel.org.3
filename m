Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DFE564448
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbiGCD7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 23:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbiGCD6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 23:58:33 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7433BF65
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:57:40 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-f2a4c51c45so8815759fac.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 20:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=u9N8NjI9RBrK1bB9eLmzIxfM+IEIjeSqvIr00rCFrxQ=;
        b=zU2DrGyy7lyOGwSFs8J7uDLDzJfFW/2EW1zwVcWQbXbPySwG0Ttk8+O0I5dGJtUgtq
         UIIm3THiA4zYc7K3x1sJgWBAWpL8yp7KO4PIpgV/h+TY+Fj7kg0dootOqXJAoC55CwuQ
         BRT/hoqU7neaTxjV0tXA+poq8yDWlDTCJxLMxo/ZGDG7S195YWcj5OmdVLtwkuDf7XLM
         gXwSgbmt4PZXBlTpQWxeGUKql2qhrAuhegxURu/8pUnFKs0SFBc50pLFLXxWTVEd7uCp
         s26zoYFy6FD8Q4EZKFyEFEt7aHGcQDZTehXKzTrSNwH95jST0mdhflFbsgdXS9f8DeaL
         muoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9N8NjI9RBrK1bB9eLmzIxfM+IEIjeSqvIr00rCFrxQ=;
        b=tlbKItnav/vMAMns9/H7nHmUlqhB3XfGiXYMuSzWx8yW/bU2aRKN8lS0K6XWb5jnUc
         ld1PveptgALIYoDm0GrlujOo61GYFK0vBghkv+bOJa3mBQc8TjwWS1kVGKP+9O98HFCp
         i0qzOF8RLguaJcPE0cmE8TG5diW+UnC0ootXKAs+B2b3xrbO8Co4WO7rQw3lKxvaaskF
         ipllLRO4c5291SX1DOb/UnITNepE4F6kvh9YdBn/eK0Th8pilpl0tqhyAyEpKrcL8woH
         N+8t13eS3SvVwrKzC0hp3660NCk+fDczLjsTwbXK62DsSReGYRxpOrTkuDuhNmgcyhMi
         6r3A==
X-Gm-Message-State: AJIora+pCMss8kdn58ndypvYGTOs+n1DTWRn77jmx+lwiGvpLrra7Yv0
        zMi1IIZDf4sfrVt/7pURYEjuSA==
X-Google-Smtp-Source: AGRyM1sCO2vgss9UERO0Jwo66AuRz/k9wQea3+pwnz8Osbr0h4IUvpUIsNmnDsYnrES8IjESIFLO+g==
X-Received: by 2002:a05:6870:ec91:b0:101:becc:467c with SMTP id eo17-20020a056870ec9100b00101becc467cmr13776664oab.186.1656820654633;
        Sat, 02 Jul 2022 20:57:34 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 25-20020aca0f19000000b0032e5d0b5d5fsm12965910oip.58.2022.07.02.20.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 20:57:34 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        soc@kernel.org, Arnd Bergmann <arnd@arndb.de>, arm@kernel.org
Subject: Re: (subset) [PATCH v3 21/40] arm64: dts: qcom: align gpio-key node names with dtschema
Date:   Sat,  2 Jul 2022 22:56:28 -0500
Message-Id: <165682055971.445910.10604625512115231111.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220616005333.18491-21-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org> <20220616005333.18491-21-krzysztof.kozlowski@linaro.org>
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

On Wed, 15 Jun 2022 17:53:14 -0700, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern
> (e.g. with key/button/switch).
> 
> 

Applied, thanks!

[21/40] arm64: dts: qcom: align gpio-key node names with dtschema
        commit: b08f5cbd69dcd25f5ab2a0798fe3836a97a9d7c6

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
