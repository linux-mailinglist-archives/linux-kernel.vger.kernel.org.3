Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883244A5862
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbiBAIRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:17:14 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56654
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235369AbiBAIRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:17:14 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2D28F3FFD6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 08:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643703433;
        bh=MItxx70iFew0YeZnNA7KR41aDD2ctvR1pwd1gDOLhyA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Y1yoJxBzrWfZFtnox+3UoAyTyMYpLsHg/B8PgoKuYofffqTwhPVl3C/wph68c64SX
         RskxcC3bol3BRKvO3Wceo7SYFl1UMaLFJR3Ezihu2InRlVIZ4ehBVOO4ik7XIO8Ln2
         IGNd1BSuXjCZZQy0VbapVuylcFVzja00ALlGagp0LTvXYpDKp9CuFORbjrSDAuc1mU
         jwPc7QSHRJop064vo8GGL5m7P6iu0mJ9HyY7B/nVXTzFeQ0rsTGruI/2Kxmmim12iD
         LtSiRoW/sbDUomHW0guZE+FHurxvogQvskw3dmC3OrMEPDl34Cml2emv/D9zbOUeUU
         jEMvox/3dlYVg==
Received: by mail-ed1-f72.google.com with SMTP id n7-20020a05640205c700b0040b7be76147so3769222edx.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 00:17:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MItxx70iFew0YeZnNA7KR41aDD2ctvR1pwd1gDOLhyA=;
        b=HlIidZH/cYxrYK2nisWX+Gq2Jcmw4++y23koPOKnQWCvNkkjsPCAJOhqclvAH5KGAr
         xJL0fSeAa00hGn/uBxsT0vMLja0lTSXk1jlJ2KxNAKC6oOGIzskqSpW7QYEpQnu+UY6l
         i9jlA0XUxZpC583n/MDAyKvrfTIhT1eQ/DBVAoXzMrk9ywP2/ORpFNhwpbO4ZPse+WkN
         83PDqy2XdLyvlPhrCJzfV7kdZmBD2SEQIlHk3MM+uRiLAMf0IoynxkoJ+fxtH4k+6EG9
         to79tRARWhmIqU6F0cqgI/1wa8zhAiBSxZVDyA+z2+h/Y4byDOCLTZkzufJ7KKcuoQhb
         d6YA==
X-Gm-Message-State: AOAM531DcW7XfV9NkBVhd5j7dULDuHf6FyEJwj/w5YnU1pOicZ1Q0jbG
        22sUhASa6r0tCfq+SjEhOhQ/2x7Abhg2E71wbW5dbTnuX9ex7rhWwXG8uTwFlE3KJqbvmii/nLj
        qAWPjY0dOgubkreCfI9yzKIoloMRlc1RWLyhDPkwlIQ==
X-Received: by 2002:a17:907:7e82:: with SMTP id qb2mr19890304ejc.496.1643703432585;
        Tue, 01 Feb 2022 00:17:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhOxyC/yzDk+upGVDMqjGzeMIciEE57Rpod35Osx007NQEYEitTAQ3J3/YfgtY6KfuQqdjZA==
X-Received: by 2002:a17:907:7e82:: with SMTP id qb2mr19890296ejc.496.1643703432455;
        Tue, 01 Feb 2022 00:17:12 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v8sm14179485eju.57.2022.02.01.00.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 00:17:11 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] clk: samsung: fix missing Tesla FSD dependency on Exynos
Date:   Tue,  1 Feb 2022 09:16:36 +0100
Message-Id: <164370330545.12265.2531636049712194501.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220129173407.278591-1-krzysztof.kozlowski@canonical.com>
References: <20220129173407.278591-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022 18:34:07 +0100, Krzysztof Kozlowski wrote:
> The Tesla FSD clock controller driver uses shared parts from Exynos
> ARM64 clock drivers, so add proper dependency to fix COMPILE_TEST build
> errors like:
> 
>   /usr/bin/aarch64-linux-gnu-ld: drivers/clk/samsung/clk-fsd.o: in function `fsd_cmu_probe':
>   clk-fsd.c:(.init.text+0x9c): undefined reference to `exynos_arm64_register_cmu'
> 
> [...]

Applied, thanks!

[1/1] clk: samsung: fix missing Tesla FSD dependency on Exynos
      commit: 0b59bc00a6936e8670b58d4307a2cfba341d40d0

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
