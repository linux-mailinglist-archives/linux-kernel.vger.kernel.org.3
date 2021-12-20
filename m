Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D2647A73D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 10:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhLTJh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 04:37:28 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59554
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229759AbhLTJh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 04:37:27 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1C56B402E3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639993046;
        bh=g6qji2pb2cXYir7bn0MZqaQvSo0VOIHA4X4Dl0hqX8Y=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=X4g7A3Cdhz28fUFhoQ0WHWNxNKeSQKM0BIJGGqHutHin6zxFCg5o25Ju9ugWLnntp
         CzRqar3YQXbAYSPueaCc88Muzw6KkM/e6GyIcoFK6MQJtD01MYxV8d4QJAw03g9ckX
         h+nLN+3jJh/u7jmqgDPhqK9vFwOuImOiALt+d9obIAlBGpAFWhTcLuxK3ahBAqZS99
         SDl7BSnePRR9QbQz5k/hySn4Wo9nFq50D69uZryv7oXx8roqoZwxvNwaEwBdYg+gNh
         K/wAYS7J7zM+zQ9axaHzPxTtY8yy5f9yBSVnoZdM+mixyCnBCIpoO+itx+RiS+6N4F
         /UL2EgXKHvw1w==
Received: by mail-lj1-f200.google.com with SMTP id o15-20020a2e90cf000000b00218dfebebdeso1558976ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 01:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g6qji2pb2cXYir7bn0MZqaQvSo0VOIHA4X4Dl0hqX8Y=;
        b=X7WzDujIRZU4RRbGLwSNLbd160DMofSLSLzqyCZr7w7ptWIj1nBnE1kpYPSS8wCZHs
         5QxleJWL/idTSyCPrJdP/mSb7COs+THaW4cTal9gmAAbIV7xlOjNxtowOWg5cl/g3Cog
         HiBwOsNAOWk4XrxgOgiGTtbJ4UcduDm0F7Jkzm/1G7tdYLGo9O/4YSGNhSNvY0UFYG25
         P/KCniVn4oImbCBy+ViKOh9pISyHJlixsoM94abhn7cHEPHzsZ2xHBovbVgrwJ8KrTwR
         Up4sMFGApSYZ0W0SVEK8mebTw1ZpkEyshVsj4VB0pH9roHZg5u4ilIUT/B6Hd2QIdOTs
         M6Ug==
X-Gm-Message-State: AOAM531t8Mx3AGj5P8Xe+o1pKzybwWEZjlkwji+bRDcK3yHD2igJVTf4
        0+/k/1PPoE15EgomUjBQQwdN+M5dCSAZal76J2ugh0nuOk3C70xcInJ1rLd8ajKpWa45Wc+2STK
        8b58Z/TEdIMBN/XCD4cKx+Lcg3xeIIQCyur0HJPJnkA==
X-Received: by 2002:a05:651c:1031:: with SMTP id w17mr13802021ljm.112.1639993044797;
        Mon, 20 Dec 2021 01:37:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcb4zCkuksbBh2a+v2wndWfr4lS0Fi1HqUBer1cJ9x95qXKkE6G8NaCPHqp0YjKf8Gv1eP+w==
X-Received: by 2002:a05:651c:1031:: with SMTP id w17mr13801996ljm.112.1639993044655;
        Mon, 20 Dec 2021 01:37:24 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id h15sm93443lfu.103.2021.12.20.01.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 01:37:24 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-clk@vger.kernel.org, Chanho Park <chanho61.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        David Virag <virag.david003@gmail.com>,
        linux-kernel@vger.kernel.org,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Hao Fang <fanghao11@huawei.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>
Subject: Re: (subset) [PATCH v4 4/7] dt-bindings: arm: samsung: Document E850-96 board binding
Date:   Mon, 20 Dec 2021 10:37:19 +0100
Message-Id: <163999303689.14127.12844004374381607436.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211217161549.24836-5-semen.protsenko@linaro.org>
References: <20211217161549.24836-1-semen.protsenko@linaro.org> <20211217161549.24836-5-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 18:15:46 +0200, Sam Protsenko wrote:
> Add binding for the WinLink E850-96 board, which is based on Samsung
> Exynos850 SoC.
> 
> 

Applied, thanks!

[4/7] dt-bindings: arm: samsung: Document E850-96 board binding
      commit: e1ba2f940ba4c4c3b4d0a520301a920591c421f9

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
