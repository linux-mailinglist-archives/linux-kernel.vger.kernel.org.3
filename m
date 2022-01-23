Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB69449737E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 18:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbiAWRLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 12:11:00 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59304
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239169AbiAWRKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 12:10:48 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 69F3E3F1CF
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 17:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642957847;
        bh=la1WFYXOpR980qBpdVlXWePzrUe/p8xwwZIz/t/dobQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=qBxNMQeLQGHuY2T2ZXUlGYSyZ78z/Q1nbwNE1rN3rRh9fy/rmMNYi3doJYgE8ImK2
         iRD9lc3CHamYtgJhH5uvx4GA+Deqmy41bKzKrEBMZxLZTarM7Zx7s+MCjGGWpqX7S0
         JRvPxCp4NXkIKtzOMEmkriix/8v6tZMHBb26Gy8Uzpypt4C+X0sEWyCL5iDYUnf+7C
         O5cprVExNq2e5zpHFDsaRGNl/GLEJ1HSXZqSl+c54+9klyMjVYoGq7vEJ6qcEfXoCt
         GHocSt9qmc+C1+ZeS0B51jWKcy6f/uRidJuNwLE0PwER/91v3AdXe0PygWYGct6HDS
         lpucwI8XATmug==
Received: by mail-ed1-f71.google.com with SMTP id c23-20020a056402159700b00406aa42973eso4432668edv.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 09:10:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=la1WFYXOpR980qBpdVlXWePzrUe/p8xwwZIz/t/dobQ=;
        b=ZJZZoi1BaB3JFLhZHOu5L6YaHBeI82IKzAI+vUt8lIVq6WK8OvhfCreROUlAcVdW1B
         rHVMr36evoNDo0ISpBs620qausQVCMc/f6RJJ5pOScbHr5Z3n7VIA2qHkUwi/lmx983U
         06xFNn5K12qGsMAV1qJsJazkVO/vEA7HjS1w/HcafGlrC933oXgvHCBLEK/JCsmC14O2
         Ys1QavrUnFPtz4xu4qwluBycs5+p+hFLZKzDV3XX7ps8Xb+Jzv2UhgaLSd/0OlCRNA0B
         mdhWLtEket43U7Ht5LZGLpGRgUJu/X1kUSCzj/vYq+LzEFHZoRdDk8dBOPRiXRgnyiiM
         E8nQ==
X-Gm-Message-State: AOAM532x1VrV3itroJkfXVawqPfU0LawcNzQOf70Kwjsd4PF4IJNc8+u
        ieZ1ZIxkTFI1qQMjICRxRZYSP6yda18jtfNxQywlkcSgkifhAwep3QrAOqwF9mmVaITrgvQjMa4
        xV2Xk0P+RIfaWkihD7KIJ2YKRElyrYNQbDp4SzvEmvQ==
X-Received: by 2002:a17:907:97cd:: with SMTP id js13mr10256965ejc.196.1642957847127;
        Sun, 23 Jan 2022 09:10:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxl8TtHBHfcwF5UxjxV3/HnBay1hEnttjPhYwLLhuOy7PgFM4dopOI0Hwjx40uaPmIRHsxnFQ==
X-Received: by 2002:a17:907:97cd:: with SMTP id js13mr10256950ejc.196.1642957846981;
        Sun, 23 Jan 2022 09:10:46 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id l2sm5208665eds.28.2022.01.23.09.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 09:10:46 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-samsung-soc@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sam Protsenko <semen.protsenko@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: (subset) [RFT][PATCH 1/3] ARM: dts: exynos: fix UART3 pins configuration in Exynos5250
Date:   Sun, 23 Jan 2022 18:10:39 +0100
Message-Id: <164295777263.25838.13469745668860262642.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211230195325.328220-1-krzysztof.kozlowski@canonical.com>
References: <20211230195325.328220-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2021 20:53:23 +0100, Krzysztof Kozlowski wrote:
> The gpa1-4 pin was put twice in UART3 pin configuration of Exynos5250,
> instead of proper pin gpa1-5.
> 
> 

Applied, thanks!

[1/3] ARM: dts: exynos: fix UART3 pins configuration in Exynos5250
      commit: 372d7027fed43c8570018e124cf78b89523a1f8e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
