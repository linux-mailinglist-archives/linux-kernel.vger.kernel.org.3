Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C39596A34
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiHQHQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiHQHQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:16:28 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFD66B641
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:16:27 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id by6so12706028ljb.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yMl+tFEzdGX0GitYuhgBuJRmYAvfMaE0QWbJ9B74bmM=;
        b=jERj0BQc6jtjmk3aX2so6suyIqC4kUKNDcNFS+Ed/rrs9STbN5Yd1FYsoAX6s+lMR0
         LS1xlvBwtGX+C7oMzkO/Rnx4U02Gj5qY6ntH/otZpSzhgP77seTfbn/lxqirqQAF3TMV
         vNvA/owLK8lJlFqkF52wRT12pMKspOsiHnFKvbkSIMrUwYmNuZumhe8z9SlhoC+luZaA
         x/9hpotWnTm1evmLqxP1Pjfb38XxbQnSMqX2TM02cYOO8zGMupvwkT9r1ZBNkjK1cP+m
         MMvh2RMTGJthOeV90RF8EXxRAbXNeJio3halgALUrZgoJf32l7qvS6pc3H92srNYSEDi
         MOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yMl+tFEzdGX0GitYuhgBuJRmYAvfMaE0QWbJ9B74bmM=;
        b=O81rmIq4VZCfcm0yfDBVKb21X41g4pciD5q5Xk6CGzJKFYkHl6xLhL3nZ3stOlen5O
         1f0oQOzFiOTVqOTZoP1yOa8i/0VD+JMXGGETACdwl5ipyANwDntKjFREIHAHJduMIqWR
         W3c6qjcYQQMzKcgxNFFkUQuMk6mjIqBSlnkPRW8ijlcxptbjq0+uWDrZXsYWsy/xmyJQ
         4oY3AuiIDmAOlXHooCUBM1gUYjbh16YLp8ecK9MFj7TPgy6tk3f0Llh6nqb3CsmkJ5XL
         Zyx13PRzJ3DDrEENrq+WUfD+VI7uiDVYcevhXvMbgvqBKmcF0OKGINPTGvaR3AdI6j+k
         w8Cg==
X-Gm-Message-State: ACgBeo0+T1z+dHM+adPZ6V6gck8/Ok0FwcKHGSucV4Li8SPTd8ajvKLr
        LHgOymLUlNGpAEKXYXOaGTCO6g==
X-Google-Smtp-Source: AA6agR5tHMDeP9wC5S6V+QAUunrsvKpymMUjcoZVKMjiVQBpOa+B3iShBPv0JAwFqXuAtmK35ByBog==
X-Received: by 2002:a2e:9613:0:b0:261:8022:d67d with SMTP id v19-20020a2e9613000000b002618022d67dmr5101654ljh.28.1660720586299;
        Wed, 17 Aug 2022 00:16:26 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id h8-20020a0565123c8800b004786eb19049sm1597520lfv.24.2022.08.17.00.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 00:16:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     f.fainelli@gmail.com, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v5 0/3] Add Broadcom STB memory controller driver
Date:   Wed, 17 Aug 2022 10:16:23 +0300
Message-Id: <166072058033.27255.17777055235605907073.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220812222533.2428033-1-f.fainelli@gmail.com>
References: <20220812222533.2428033-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2022 15:25:30 -0700, Florian Fainelli wrote:
> This small patch series adds basic support for controlling self-refresh
> power down on Broadcom STB memory controllers. We might be able to
> contribute more features to the memory controller driver in the future
> like accurate reporting of the memory type, timings, and possibly some
> performance counters.
> 
> Changes in v5:
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: memory-controller: Document Broadcom STB MEMC
      https://git.kernel.org/krzk/linux-mem-ctrl/c/0da0b6bf854dcfb047fec70bbbadabb7ff0fcb3e
[2/3] Documentation: sysfs: Document Broadcom STB memc sysfs knobs
      https://git.kernel.org/krzk/linux-mem-ctrl/c/df0269bb936430c2e5c45b158fbbe5a13728d53f
[3/3] memory: Add Broadcom STB memory controller driver
      https://git.kernel.org/krzk/linux-mem-ctrl/c/65991a63d02decf269e7d5334620df0dd5919762

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
