Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4440F4FC1FB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348543AbiDKQOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345205AbiDKQNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:13:38 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E1040E61
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:10:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i20so10650573wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e/UKO7aq94SBKfZjsreZz7LQuRqGyX1nZfKdXNtn4DQ=;
        b=Z/J52qRPfnLZdQ0L470rDwvtkPzhm9V03L7neg+b1u402HJBgaKHe+C7zJQ0iquVBd
         xYvv1L/7dcaNhEvWgjcOZ7a1+WeQiNWcf6lp7eRFZoAKwgacOgNlorj7hPOr49e6wIwq
         /+fR87Kh8d6BGbagZui3KJcoEB1e5HkAL2uQIg82BjQiOyEiZz/1jWiGvbVYEe97Q7zD
         p/2k+UZQTCnU4xha5cdDRe54CluXLWA39aUw41PtbLHtWB2/tfZyL2CbHN/EUZpzacVx
         ZTooWK694sFHyuvXAM2FFYrI3fuJFUygYO8bC9C3tDsQLD+dGvsBBXnUbM/B7TZIdEbO
         MrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e/UKO7aq94SBKfZjsreZz7LQuRqGyX1nZfKdXNtn4DQ=;
        b=7CM6vCuEA3W6RCD3CHoFee+vDb5ExNac9NxRK/HuAtWwrrCsbEdHCmTBBUMgYR8xUP
         Fb/J5vP1hkZ96VI+a03PpIlSUNQz/ijF4sJCXD5pGk6bsmYwVLoE7bb/cXfUZ7IlN1aV
         Kjwv2nNjb6ka3UzSWpTHsXdk92wB5CeOaoVGQNHdPmFcXrqbCG0HCkA55Hf3e28d/yFl
         L9so5b0kcRGXSZKbD+vWnYfPa8cQIqnzrcMWgb21A9D+6aX4oE4Y8ebBatvQNrV8qztE
         Z9ApEcTcDg1QBwqZ6t/1RyQAvDag6cDOR1wJjG3A4EU5Yae2bYQ0ByOHHnKuFEHmGwfj
         7nUw==
X-Gm-Message-State: AOAM530iTT+TEaPhd6vI5SIZ4IuIL1ud1UI/j/HhUmdoU6YbxO2zlvun
        usCdw5djslAgLtGeITPGLZ8FJg==
X-Google-Smtp-Source: ABdhPJxGMh4bpG9dA7tQfjqfzADDhs413Y4knEG1ir0hHP7QToWNiaFOX5m46YuRx9ZQ2hbojg87mg==
X-Received: by 2002:a05:6000:144e:b0:205:9a80:b4c3 with SMTP id v14-20020a056000144e00b002059a80b4c3mr25378634wrx.179.1649693428548;
        Mon, 11 Apr 2022 09:10:28 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:d1:e096:d183:1bc5])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d6243000000b001e33760776fsm26481090wrv.10.2022.04.11.09.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 09:10:28 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Guillaume Giraudon <ggiraudon@prism19.com>, kernel-dev@prism19.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: meson-sm1-bananapi-m5: fix wrong GPIO pin labeling for CON1
Date:   Mon, 11 Apr 2022 18:10:26 +0200
Message-Id: <164969253195.978802.10778276725936874657.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411144427.874-1-ggiraudon@prism19.com>
References: <20220411144427.874-1-ggiraudon@prism19.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 11 Apr 2022 10:44:28 -0400, Guillaume Giraudon wrote:
> The labels for lines 61 through 84 on the periphs-banks were offset by 2.
> 2 lines are missing in the BOOT GPIO lines (contains 14, should be 16)
> Added 2 empty entries in BOOT to realigned the rest of GPIO labels
> to match the Banana Pi M5 schematics.
> 
> (Thanks to Neil Armstrong for the heads up on the position of the missing pins)
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.18/fixes)

[1/1] arm64: dts: meson-sm1-bananapi-m5: fix wrong GPIO pin labeling for CON1
      https://git.kernel.org/amlogic/c/962dd65e575dde950ef0844568edc37cfb39f302

-- 
Neil
