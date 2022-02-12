Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A134B3681
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 17:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbiBLQhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 11:37:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237408AbiBLQhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 11:37:17 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB28E214
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 08:37:13 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5BC14402C6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 16:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644683832;
        bh=15hMJzU1fmathDo+CvBtL4KOBTGHiJyQDvhqhMcjvDg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Y7W2mMsV9ij6Vtq8SNjvdXrExl4B2t1a8UKyzYYEBn1iEZaZ6DQRrHeoGMHMEsmJG
         W0Py8ZGhsxfq9eRtIw1EeVNDTO8AVl+h2c8zoHyQWK4u6uDc3ZK/KwncwoYImHpyGc
         A5LUGC04kNbSk1j7dfPbY7e/MKrQutODOUBTdN4eCU476P6o7bW1fF/ttHzg5d33uz
         STrpE8gY/F/UFxyZ2HN4MA0ldC7MAT2fd2zVmr8ibQ6fo4Qu7lNL3xliE6FpPkzkW2
         pvWFzzbvDoTsxrLKos/L4T+2/Z47V5zEX9yjl5TbSH8l/MUx+iSiFNpabbiE96qTRC
         oCX81aESHCLEg==
Received: by mail-ed1-f69.google.com with SMTP id t3-20020a056402524300b0041010127313so5160609edd.16
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 08:37:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=15hMJzU1fmathDo+CvBtL4KOBTGHiJyQDvhqhMcjvDg=;
        b=7gHToTWqWkqn1nG6TVCIzBYdYBcNbliAPCIVlGVRi7mHqsPRW981csXNEdfRL8KzoQ
         FMaqGvaI1IVSqpdgq4XBscoYpYfZGuXCLCS1DNCP+d4mxW6KeN/rscnR+l9C4PFhoWFi
         0KSz8ldBJAG5xY8U2qXQJNREnuQ4jJk+6k5Vw1JEnSnrpw1qEyIa5ssbK7Ubn6qLo78M
         V/297j+3t+vO4kFJ/pOTmBgRDr5x+EibAO6t9ke5JXAjg06E2QwiAjmhYznjKw5Aip/x
         6riZJJkaK0XRqIl9oaxcwfR+ddSMY97foIeWY8nvYHuuKvcVLBXuqWkEcqB8xbA+WC4b
         Ze4w==
X-Gm-Message-State: AOAM530HOvwsOOqbMWpUCMylg3rwAuZu1/kBg8dd7oUKi6g2p27FW3oa
        eYWPyqw8D8YHjNPr11QgCeKh6OE4f0t32ZOhvpKHptBMb/peey8reEr6XiIr3TRH6hQM0WP19av
        BWnUvM/WOtONWmZLGLTWE3UMyjOlrEuH6TozwJn8RhA==
X-Received: by 2002:a50:9dca:: with SMTP id l10mr7054313edk.311.1644683831489;
        Sat, 12 Feb 2022 08:37:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKd2PgvPfnFZh8rSZyPq0B14QPo5js//TUm4+syJvIQzZKlxeHGKY7MDAVXnpzjoJMBxl36w==
X-Received: by 2002:a50:9dca:: with SMTP id l10mr7054288edk.311.1644683831272;
        Sat, 12 Feb 2022 08:37:11 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id x10sm2494443edd.20.2022.02.12.08.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 08:37:10 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     stable@vger.kernel.org, Sylwester Nawrocki <snawrocki@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: (subset) [PATCH 02/10] ARM: dts: exynos: add missing HDMI supplies on SMDK5420
Date:   Sat, 12 Feb 2022 17:37:04 +0100
Message-Id: <164468382250.54495.17613053424810805341.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220208171823.226211-3-krzysztof.kozlowski@canonical.com>
References: <20220208171823.226211-1-krzysztof.kozlowski@canonical.com> <20220208171823.226211-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2022 18:18:15 +0100, Krzysztof Kozlowski wrote:
> Add required VDD supplies to HDMI block on SMDK5420.  Without them, the
> HDMI driver won't probe.  Because of lack of schematics, use same
> supplies as on Arndale Octa and Odroid XU3 boards (voltage matches).
> 
> 

Applied, thanks!

[02/10] ARM: dts: exynos: add missing HDMI supplies on SMDK5420
        commit: 453a24ded415f7fce0499c6b0a2c7b28f84911f2

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
