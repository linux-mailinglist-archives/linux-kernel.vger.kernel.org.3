Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC1D56981A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 04:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbiGGCby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 22:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbiGGCbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 22:31:36 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706352F3B2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 19:31:35 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id o73-20020a4a2c4c000000b004284fd4e052so3246184ooo.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 19:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HmbEGlmgz9inbfRdXswr9utl0AqPzk/QhsgAgC2XwtI=;
        b=YyOkcEg1nXPEDqSuGVhcQUNsQITymByi5yzjSWlSBOLOKxn3jtVcDA7Mf63TCJY4M9
         GzIw1SPZvg/bVpWePYmPt2Q+m4Z1Cr/1119jMXw6Ox7x/Nc6CJjZY+moFhobFXpNwJwq
         5/07tq+5L6LQMRa0wlUU43WSJUBnHwK0dPbkAgKY5go9qxbk2ENeLW4pVpAuji62cYN8
         GYCIdi6CGEjxqWqxtEnQrlySvW57u5tTEtYBvz0VjoFea0f3Ik8+caczfrzS6NrT0rpG
         Tfbt1VVLfBTqjuSO1V1kg2B4xQT17JnpVNOejc8E0YhhKK4VPGq58MgDDU63k/XBVjIg
         xrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HmbEGlmgz9inbfRdXswr9utl0AqPzk/QhsgAgC2XwtI=;
        b=HqQ69kERLtKbC2L9DBXkSDOGwWf3TellpH3P1kB1CFw+/kH5NdWMaX7DBJD+N5T2oS
         wnFTkyXPmvrN6PBol21PGogts4FsfT8OQvuOD/X/7bqaVoC7QxyP3kiWD5wEW4UrrL5+
         McPUGaKiwh7gt2cQ8wseGpNIix9muEzIRU3GH2vTRzyDrmZKOuGcVr0Hy3qfTasSlSpa
         BabmKqDbJL5N4sza/HltUXkK2OSaNKPdewQei8wxS/p1a9dqQqcZ7yK1cb/ShzFeYsLa
         Y1R7WdCtTRBwm8wSYm5Zi0YIi4YM3EMa8vYfA3f6GHv+gZ38s4PaELHQyAz+24pO7DuF
         JAVA==
X-Gm-Message-State: AJIora9FNSUj20Xh7b1Z1MmhNy2Ze+EWWYVhMZbBd4iISPcXnW+m0UDu
        I2BwZeNbT9S5UvnvU5sBsu0LZA==
X-Google-Smtp-Source: AGRyM1uOLxFCyR+T8i4wtTM/J6Zo80ApbrLtbf6uQPT2Q3Bx1WlzbF4CUac/xbzPFJxqb8NG09f/YQ==
X-Received: by 2002:a4a:e9a7:0:b0:428:89cf:34d3 with SMTP id t7-20020a4ae9a7000000b0042889cf34d3mr6714117ood.41.1657161094760;
        Wed, 06 Jul 2022 19:31:34 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x48-20020a056830247000b006168c71ca4asm17024469otr.56.2022.07.06.19.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 19:31:34 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: Re: (subset) [PATCH v8 3/4] arm64: defconfig: enable Qualcomm Bandwidth Monitor
Date:   Wed,  6 Jul 2022 21:31:12 -0500
Message-Id: <165716107315.864223.9487866032857198134.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220704121730.127925-4-krzysztof.kozlowski@linaro.org>
References: <20220704121730.127925-1-krzysztof.kozlowski@linaro.org> <20220704121730.127925-4-krzysztof.kozlowski@linaro.org>
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

On Mon, 4 Jul 2022 14:17:29 +0200, Krzysztof Kozlowski wrote:
> Enable the Qualcomm Bandwidth Monitor to allow scaling interconnects
> depending on bandwidth usage between CPU and memory.  This is used
> already on Qualcomm SDM845 SoC.
> 
> 

Applied, thanks!

[3/4] arm64: defconfig: enable Qualcomm Bandwidth Monitor
      commit: 76f11e77f919397f31198354cd0e0bd8e76f8748

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
