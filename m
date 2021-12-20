Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA1047A738
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 10:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhLTJh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 04:37:26 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59480
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229726AbhLTJhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 04:37:25 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EFA6A3F31F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639993043;
        bh=PPX3YdWz8XBg5nWlMkeTeSMy8Yji1L5ai8yIPtL4/z0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=l7fJMc7o60xlI82iMoyZXaq4DPyY1xTpo2SiKwB/idK2fXIOiVq9ABNX4T14afV8y
         bgXy+s7F0nJv3ZZd4J4J5rKia9SDqI4GMbdRzF/ll7moyNnvf0th55UO6+hclxqCx5
         FZ99JM+HqmmZ8rN5TstWcPqL4U/Gsv1gGqJ2aZ4sHJUKkUbnhgvW/tGQ+EptlnZnmE
         UjbrHgup2zIghbVsODfM1xXGUmYiqQC8KmiWE8ZbOfO1WbxG//iQC/H7eYfZFRaVcO
         oatBeWZR3y0zqxzB6eY9MDwNggldA4WKEQ5NAIcXyKkVSd966mkvtsJMClkBb8urME
         aQc3w1X+KUA9w==
Received: by mail-lf1-f71.google.com with SMTP id h40-20020a0565123ca800b00402514d959fso4280490lfv.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 01:37:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PPX3YdWz8XBg5nWlMkeTeSMy8Yji1L5ai8yIPtL4/z0=;
        b=q5+GEyBxSwYBn5ZGBpnD8KZhCtyZqvp5sa0BOQX8W6N8pYPHlgZvdfmdbaiCtINLa3
         ON5oG9CbH48yaGSFLUlGDKcRz/El4uYld/KKtZXn+5aowqCaEpnSURC0+JAlWqonpZ09
         EzA0CykOPx6Hd3KJBfB5ls/+nVajJQ4N47nakQxH2md/Se5SuIuxkaofyPKwPLdN/roV
         YL7DkwB+xJVEPcbS0JaazTwUKzWkMXDRb318sY5qDzzXIeNgYQL+OhK8A9RjhM+6vGQX
         1HT+HNkQ8haqUBG4IraaD1U3CtdFmGR54NN9FfQV+OQUHIz1u9+Z6U1Pu+tUXOFiK4I7
         TU+A==
X-Gm-Message-State: AOAM530vHPzkEgmFAryv+Sa9TldudFJzaruSb0QV+IG7wbWb2+8FHRnZ
        EO73ldaEU9hhC2ImZRYbP29x3gabeXazOxqJgyd7OWZHCk73+Cg12DASnVrxLjvMQVwJmzway92
        GnWS0epISsT+pueo4KVP3Ih+R4Y0UXjYHXl1rEzYhEw==
X-Received: by 2002:a05:6512:12c6:: with SMTP id p6mr15260014lfg.221.1639993043404;
        Mon, 20 Dec 2021 01:37:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXWObGuH1RsfftCnDZ0YbdrstEcS/ujGb1X7PLGAE+NoR7CrapjYRIfTWYCa3Ag4odsIBlJQ==
X-Received: by 2002:a05:6512:12c6:: with SMTP id p6mr15259989lfg.221.1639993043245;
        Mon, 20 Dec 2021 01:37:23 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id h15sm93443lfu.103.2021.12.20.01.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 01:37:22 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-clk@vger.kernel.org, Chanho Park <chanho61.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        David Virag <virag.david003@gmail.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Hao Fang <fanghao11@huawei.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>
Subject: Re: (subset) [PATCH v4 3/7] dt-bindings: Add vendor prefix for WinLink
Date:   Mon, 20 Dec 2021 10:37:18 +0100
Message-Id: <163999303689.14127.4038578698475142044.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211217161549.24836-4-semen.protsenko@linaro.org>
References: <20211217161549.24836-1-semen.protsenko@linaro.org> <20211217161549.24836-4-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 18:15:45 +0200, Sam Protsenko wrote:
> WinLink Co., Ltd is a hardware design and manufacturing company based in
> South Korea. Official web-site: [1].
> 
> [1] http://win-link.net/
> 
> 

Applied, thanks!

[3/7] dt-bindings: Add vendor prefix for WinLink
      commit: 2d6a1c7d57723efcb23a345d0ea5a10d76350390

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
