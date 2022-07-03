Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C4956441C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiGCEAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 00:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiGCD6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 23:58:34 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD72ABE34
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:57:40 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u199so9026508oie.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 20:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wokBQ9oSEwUwrcHF6wAKwWoV89oOxGjTHUwzBoOGs24=;
        b=bL12LAB3rEQdAn2JQRCTf0LpRKpn+JzX3ieVgMtQT3UhMdxymbZld5z39AT1Y6okaE
         hbpRbj54K1PFl7wgqDaGqo5NZ2C+GxYbsMX7c1xwzXFG8Zo+5nG1pu0K6HKckDGn5OsY
         Z0nh8EJrHEblYv+5iY2cCnCMTz4r3pksGitrmtmyGJ4jbPAxqFvozDT9mDR6uqO7jH93
         50uB3kdGLbBcOV55kyIw9qeRcay1zxHL7T+QkUOIshcbvRXzXnFfaYTlLkeTkmOsk/zC
         F3SECl9ZxO2KnKL2d2+WEg1cJQqnz35RScCukaT4zu6sDMlWQjdhYmdIZnaNDerTOaYE
         v4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wokBQ9oSEwUwrcHF6wAKwWoV89oOxGjTHUwzBoOGs24=;
        b=Yv8luZIuJEEk5J8vwVDPP0x47DNXW/PEniMneSpFaKNUFslBY6fZPfWd+CDz0O4z/P
         E1njHjffgSxuYEHE12mv/t1BfPKf+vtVM7oTBwE+ms+7VtLjVFGemoZlpjE0oqQG2CjF
         MenCeNP+ZlSHIIKaJW0rmh28JpFed/WYunyBL5EXmEeeIcy+aAwd/TLIQLEHptyYlKHj
         HtBCfuhQCn8eGbm3lAfUJWwzpbcyjwi3l3NheKfkW/ANGDms/xN33l92Q9UOPkk1FDWH
         RxZnkF/v4wNDQcStPJxK2fjNRQmw6LWhaD13UAgtbGEVqaktBSHBlDmZu+gdufZqdU18
         iNXw==
X-Gm-Message-State: AJIora/G18QqMMGYAp7CsJA8nvvR1Q8eK44eLrQGcEicG2uoJkrXkB1y
        OTmSco7yz24Z9eFgmGGm4V0daQ==
X-Google-Smtp-Source: AGRyM1vuXUCA+tQfvJJg96GCfC+5BfENK66OKsnDvm3laAYX1gPBJjntoDg50GLsHL7ckr1ccrAkGA==
X-Received: by 2002:a05:6808:10c2:b0:335:c2a8:d1f7 with SMTP id s2-20020a05680810c200b00335c2a8d1f7mr9836599ois.123.1656820655646;
        Sat, 02 Jul 2022 20:57:35 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 25-20020aca0f19000000b0032e5d0b5d5fsm12965910oip.58.2022.07.02.20.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 20:57:35 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        soc@kernel.org, arm@kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: (subset) [PATCH v3 22/40] arm64: dts: qcom: correct gpio-keys properties
Date:   Sat,  2 Jul 2022 22:56:29 -0500
Message-Id: <165682055968.445910.595101220376167281.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220616005333.18491-22-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org> <20220616005333.18491-22-krzysztof.kozlowski@linaro.org>
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

On Wed, 15 Jun 2022 17:53:15 -0700, Krzysztof Kozlowski wrote:
> gpio-keys children do not use unit addresses.
> 
> 

Applied, thanks!

[22/40] arm64: dts: qcom: correct gpio-keys properties
        commit: 5a4b0b853a2914403746b0a1decab695202ff242

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
