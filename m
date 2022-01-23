Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C52C497366
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 18:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbiAWRJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 12:09:44 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:42980
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239111AbiAWRJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 12:09:42 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A310A3FE09
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 17:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642957781;
        bh=ePTizDonA+OpdDxQjlZzfgfs6adWUNJR8tlQ8p2f6KQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=SXSFM+0ZOi8VLK8is0gS4grGwc8DNUU95gU/Q5w1AMskr7YoDJUUcneb2b0naJEOj
         7pQ2X9w//aFe1QxB+Raqy5w2K4ctFUSR6VNhRayUPdegM9RK2rcA/6SJwy42uyze+t
         4ayuI7jnn56iE39yQXkFE7gOMY8wJJwBeFb3U0kQcbpPpxLeGTm6T0YZej9Nq7w+tw
         qbWJeNqbuIf5nNSmZZL4cHgbjdTc8KdEgB6L1LKZRdCWQ5RttDtZm8PDgPQbqn7F0Y
         wgUiKKMPn9p6siJM7Sev6Fa+oMmq0kTCkrS72OjlDdufXnUJYkcC/gUlFRF9uIxzFY
         2M/g2Cx0XU4hQ==
Received: by mail-ed1-f71.google.com with SMTP id f21-20020a50d555000000b00407a8d03b5fso1605128edj.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 09:09:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ePTizDonA+OpdDxQjlZzfgfs6adWUNJR8tlQ8p2f6KQ=;
        b=o9G5E6Z8Gvw5rfOqJAaKmi2bjunnK22B3qHmWPauJyCW0eQN5eEGQCKRUIS8NPCaRi
         Qzz5TcSAVZpXgcpdlShSAshGKcWemHiFOueClTIoQ+W3rEO8bEdQP4XYzw+ZXh8f6dH4
         su5MmG1bOiTxYzCknJmklB8RgdmmhGD+lWw1GogDJ0m6GaWddPRvQLiaaBPK9bmNs8Hr
         Pam3FYPj8OWxgOQk7rDgOpm2bpZTIhnivZ1YklCzNYOvtt6IrQjGBrEteMt38PLGCxHU
         IYMsSyABm0R4vhDFHG0pOJu9dqObqQ9PO+g5GGXfaSRDrATYZerpkoGFFKXea8aaYOKP
         +NfQ==
X-Gm-Message-State: AOAM532va0ra+NrnbRnaM+aYXFWSvVWRZ/lLoRPb+AhplVc4Pgt0w0bU
        tdD26a7ZG0PhqUCOYQpbAFwcvC0GIWfq+aineslsN14FFJEjv2qle1GBR8I49UJtuFp7yoawIWX
        nEoQZZdZbO+HbTRJVml6hxsarq6JE7iSLEuCNStbcCg==
X-Received: by 2002:a05:6402:51c6:: with SMTP id r6mr12458039edd.129.1642957781015;
        Sun, 23 Jan 2022 09:09:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/47hK9ZhwwsqsPZ/IvH8K8jkFZiBCHqU2S/mB2wP0xJ3s1Gx6dsi/xoOtbDgS6Kkb5/Um6w==
X-Received: by 2002:a05:6402:51c6:: with SMTP id r6mr12458025edd.129.1642957780847;
        Sun, 23 Jan 2022 09:09:40 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id o11sm5268176edh.75.2022.01.23.09.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 09:09:40 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-samsung-soc@vger.kernel.org,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/3] ARM: dts: exynos: drop unsupported MAX77802 regulators on Odroid XU
Date:   Sun, 23 Jan 2022 18:09:30 +0100
Message-Id: <164295777264.25838.6589941658920976244.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211228164305.35877-2-krzysztof.kozlowski@canonical.com>
References: <20211228164305.35877-1-krzysztof.kozlowski@canonical.com> <20211228164305.35877-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2021 17:43:03 +0100, Krzysztof Kozlowski wrote:
> The numbering of regulators is not continuous and the MAX77802 does not
> support regulators LDO16, LDO22 and LDO31.
> 
> 

Applied, thanks!

[1/3] ARM: dts: exynos: drop unsupported MAX77802 regulators on Odroid XU
      commit: 0d42eb5ac66d816c95573135951142483640181c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
