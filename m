Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D358C475BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243897AbhLOPTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:19:43 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:51656
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237934AbhLOPTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:19:42 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 85EC83F1D7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639581581;
        bh=YsgM5wVM9boJb3f4RQ+uT9iXUGMe1XTlP9oHfwmk45A=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=da8DrCSKINZY/HNf9Gvm61nO1yqjgrZw8eZ3TGBy7b4NGX3XNiippjrtFY1FhTKll
         FL8kY0vpY34za/7RRAeM7Afs05x0DuYofo5sZ7Sr4Lf1FjHIJZzvj5HJZ8QocYEYRJ
         YTYg3nyz2HRK8/VyR6k7RwgBe6XJMFd/C9RqCtakTZ1tBkb6WnpFwwSC5dF9n9WCcJ
         N5h0eCBsa7BIrMxltNq3+ZvLdzqoCjw7TckKQVPhNJb+aL2ixZiH6aKZOnSpvnVPvu
         hDyDUnpncF/xAUS8hOmu2LB9CGk9ekU/kLweCFWesjfUcYYTslc5ITEKh+Oc9RS3VF
         9G3H3Q7x/v6ZA==
Received: by mail-lj1-f198.google.com with SMTP id r20-20020a2eb894000000b0021a4e932846so7194458ljp.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:19:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YsgM5wVM9boJb3f4RQ+uT9iXUGMe1XTlP9oHfwmk45A=;
        b=h+1EKryqBTg1edwhCojac++B928/7f8Qmn3bRS04G1TlmjCT7PXDB/ClqoV2HdELwR
         Kj48gxHsSQ7ID7hs7/Qduq6+9SEzNEQhZuMs8a360h3ZaM0rUfLuY+yh5lOSgut4z/B5
         +WGIBcvocTeZ6R++Ufu7q/BzVMP/bmWEtcyC1FEYYxz8LlCvlcqQcALZ310UO1vdsZ7b
         rO0RYYr5B1FF3LpfKx0NBRLqEmfh5MIxmwNzaphptmOVEnUxNZe6jkgqsnpBsvn9qqFs
         yzSWban91NNCK7RM7ZJBvcYzFQQVhkchDX+JdtTPiSqCnm9lVf7k0T1+I3aI07ri8Ja/
         0d9g==
X-Gm-Message-State: AOAM5321q/sFIARTVIrZxtjpQZEj9LzVl+qc/MYVIeLcdMu91NbtVM1Q
        W0Fa8buLDYe9Oide3PZuYfbanCSCsWxxNu9GkFkEmmnXtzrejUfk4fYcKGylE5jBvtrcg67RwRs
        vBf1/QrRPTAR/zoja8ZwmNBDPgD9QmNwNT7+7JBqgaA==
X-Received: by 2002:a2e:a69f:: with SMTP id q31mr11141852lje.236.1639581581023;
        Wed, 15 Dec 2021 07:19:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2IsUQ0xYTrqnY6XxwscM20tZetyuhv4/dvH5xU4yzBjcJu2+c20b2h6TUw6oAw3b4SkqOpg==
X-Received: by 2002:a2e:a69f:: with SMTP id q31mr11141835lje.236.1639581580840;
        Wed, 15 Dec 2021 07:19:40 -0800 (PST)
Received: from localhost.localdomain (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id k14sm364798lfu.210.2021.12.15.07.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 07:19:40 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: soc: samsung: keep SoC driver bindings together
Date:   Wed, 15 Dec 2021 16:19:04 +0100
Message-Id: <163958149735.164220.7940374210521750754.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211213112057.16709-1-krzysztof.kozlowski@canonical.com>
References: <20211213112057.16709-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 12:20:57 +0100, Krzysztof Kozlowski wrote:
> Recently added Samsung Exynos USI driver devicetree bindings were added
> under ../bindings/soc/samsung/exynos-usi.yaml, so move there also two
> other bindings for Exynos SoC drivers: the PMU and ChipID.
> 
> Update Samsung Exynos MAINTAINERS entry to include this new path.
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: soc: samsung: keep SoC driver bindings together
      commit: 69bac8e4260865ab56d565593c44a519291f36ff

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
