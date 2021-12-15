Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F715475D4B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244741AbhLOQWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:22:10 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:50716
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239539AbhLOQVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:21:55 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2A4383F177
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 16:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639585314;
        bh=UQpra13r/imnuYK+P2IbZ5XGTwYfQ/5zZ4iMI2bSBTk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=GzvKAZkxxlYT7X3R+dnU2AfMFq4aLyoUrAhWiZuPlL8LbER8dJ1ovWIpXAspMWd8o
         UZJGf3ZiHuC5FIf5gDhPzkHhlHZBjSjWxyQBMzPYSVvwzkgbLiOg8Ap5PlfM3PWyXB
         k2xgcFSajHtDtD3WVaEX2md89HCTUnYj5jLq1da7jXkLlyYek1VYouq5IOdFPGv2K6
         Fof3EE9rZ3g2rjAb96R1dyniMoMPmHiphZGoIow8Q2jeXOdPEKxvbNG10yzmy9jLK1
         jgpkUgtU3xEpTxjhH0QhM0OAZzasyQryEwnWVCDXJorvLQCNTOE/0AL85E5if6AByC
         Eibke0aUZnPrQ==
Received: by mail-lf1-f71.google.com with SMTP id m1-20020ac24281000000b004162863a2fcso9766344lfh.14
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:21:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQpra13r/imnuYK+P2IbZ5XGTwYfQ/5zZ4iMI2bSBTk=;
        b=CN0XmGAgRYxck43xh/IBJEn4CDLHDhghkENxrHeXy+xPYYhNsJvf/vSKSOb3SwUh8q
         vo+N8s871yRk32h5UXVUiGkxuK9xizvrTBl2ONLa+VprWaopTZpIPa8nv5TsYdvu+ju/
         TAxgNh8Iv2Ul61MfE2bt/orQ+Qj+p9QGnzCk3/Y8oWdfFCiCO/o5fSQZQpDVpD9ytgGr
         5EIlczSru24TA4GJ7mLiKcN8twuOfICg8aDOFTydG9yv5D6k7iF4UeKnTK53VDoMkVP2
         mgoTjPslxs0Ls2ABjsW2HxTKfwfl14c6dSWIe61h0afvGYU7KM4tZFtLxNqfpB7pBEFH
         jqpw==
X-Gm-Message-State: AOAM530p1Hd/RkqeIlGMtls3lckEtn3vQF5nN6adxGKqxoa6YXvCSbll
        uxxIfEiNgEGza0lruVydCR4ZUzSEG8DaFkYuIMkIoEYVDAzeFKgT921uEqWBmwVVKa9LMfJPu2K
        w0Y8kRC5FiGa22fV/BCWPtk/CcqjlRHnjcLHkAi0Yqg==
X-Received: by 2002:a19:d61a:: with SMTP id n26mr10578625lfg.313.1639585313507;
        Wed, 15 Dec 2021 08:21:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxxRxyxjrUFbKudwdQ61hGbDEEI0JDnv9cU9sfFXGEl6TAeZSdjkJkyUrkdyqRBNhl+99x1pw==
X-Received: by 2002:a19:d61a:: with SMTP id n26mr10578610lfg.313.1639585313346;
        Wed, 15 Dec 2021 08:21:53 -0800 (PST)
Received: from localhost.localdomain (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id l4sm507392ljg.60.2021.12.15.08.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 08:21:52 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     David Virag <virag.david003@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-samsung-soc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 3/7] dt-bindings: arm: samsung: document jackpotlte board binding
Date:   Wed, 15 Dec 2021 17:21:16 +0100
Message-Id: <163958527260.183299.17749602272220762675.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206153124.427102-4-virag.david003@gmail.com>
References: <20211206153124.427102-1-virag.david003@gmail.com> <20211206153124.427102-4-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 16:31:17 +0100, David Virag wrote:
> Add binding for the jackpotlte board (Samsung Galaxy A8 (2018)).
> 
> 

Applied, thanks!

[3/7] dt-bindings: arm: samsung: document jackpotlte board binding
      commit: c96ebc5fde274edcc02543dcfb6a1ee097f98070

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
