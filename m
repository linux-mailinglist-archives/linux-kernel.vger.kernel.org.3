Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624B15518DD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242613AbiFTM1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242621AbiFTM1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:27:16 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4CF17E19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:27:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id cf14so5120838edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kx6XMykad/d14cBUqtaVK4xhkwzYv9syG6kbZ8B3OLc=;
        b=NJM1j58SQhGOALkwIW9S8Haj6YHY+JPmkObMMt7tZLwnNVlIR01pLFH8xNFK35suoh
         LHq2aZbrUVbzBtMemeCJraC/c7dwMU68yS1YEQPH88i5MkMWXBe20cXVG4kGwDhEPkmn
         e6RVR6j7AoIzv9c24z2SynU/h3mio8CFxbF0o8cFfCGJDuLA6L8TpR5D8wpqwoKl3MYc
         AwHgzQJlQ7ozqe9aGEQ4UNPY3UC6jTu86XxeN7idaLZLMpajb7NTBrCoES2WeEjZDVLa
         QybN/NEuskgsukrdhWTEa4cfW3Jji8LERLjXyOaxgN5xcQVUmcBIuhm6NofTsLBKTFaD
         ev9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kx6XMykad/d14cBUqtaVK4xhkwzYv9syG6kbZ8B3OLc=;
        b=QlbvwvCXejLBy6Mzv/OBu9tlDmcepDFuMzIiLQRkf2OrwJ85iLa2IM7O2aad2KS+a8
         6AquwhglEx8r4bc86Pd/6dbsoAhUJcEGe+mnID1H/L45ZCWRpQ2oSQe0jZtUFICKiQoY
         /oJdHnit2dA9OXe+/iiANOI84x6sEM1BHUybSfTe4p2Pc65nEEFNfX4yEpoNKaHvi8WJ
         6oFE3/JHXXdiIWyyryg1xqtdl55hzo5zLAVoF1WwcQ7Js7YKeL1kXBAjGpotJRnVlh2c
         Kh5/SHc53THpdFH+5Pl4Ig7PAmJ+2IERIGpkvAa6iyMO7j6+phTlUh8qmZglC4twU5qP
         fGfw==
X-Gm-Message-State: AJIora9OT0+4egvEtJp2Ma9eoXt3UQyOdXfybIueZYf+wkrlsxTdY3Ee
        2NnOktMMQxWksDCr6yeWPef9EQ==
X-Google-Smtp-Source: AGRyM1scCdWEmscckL5jtAuMJFVGXw9+p/efbuJaJKWgrrSl0YQLQyU+78vqoHyDOR5hupPHm1lIdQ==
X-Received: by 2002:a05:6402:1854:b0:435:7f6e:e553 with SMTP id v20-20020a056402185400b004357f6ee553mr7721242edy.282.1655728033079;
        Mon, 20 Jun 2022 05:27:13 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906300400b00722dcb4629bsm15987ejz.14.2022.06.20.05.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 05:27:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     David Virag <virag.david003@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        phone-devel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 2/5] dt-bindings: clock: Add indices for Exynos7885 TREX clocks
Date:   Mon, 20 Jun 2022 14:27:08 +0200
Message-Id: <165572802724.43913.542242741939754382.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220601233743.56317-3-virag.david003@gmail.com>
References: <20220601233743.56317-1-virag.david003@gmail.com> <20220601233743.56317-3-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2022 01:37:40 +0200, David Virag wrote:
> TREX D Core and P core clocks seem to be related to the BTS (Bus Traffic
> Shaper) inside the Exynos7885 SoC, and are needed for the SoC to
> function correctly.
> 
> Add indices for these clocks.
> 
> 
> [...]

Applied, thanks!

[2/5] dt-bindings: clock: Add indices for Exynos7885 TREX clocks
      https://git.kernel.org/krzk/linux/c/e756e932a3a16418cd8bad757b028bfb337b4a51

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
