Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B86753E81D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiFFJW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbiFFJWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:22:48 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D92A19C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:22:44 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n10so27729792ejk.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 02:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wMcWekleBU1R4ydXfALVXkI2NKLW7AgpvxY4ncIRacA=;
        b=ib0YOks0X1Qk7/rvety5N+U7HD32Okyta3mj9sEZg8dYqtUZg7+DA7NaXUELmLiEF7
         1fFBNzRypcuwjK6fFTXHp7ms92pdTL3hyJwVdeSHdlD8GqEfsVOxQ/0GupB/M1JCjrdT
         kY8o7LrU4OmTs1iHCSMz+/DB2A6D9/EdzcxYGCqQLULY49+KavWX9AxdpXQFmtPpC+0G
         8AQ0HpjUlCGDd2LwMZXDZpTangDauyCez+HGthSl37E1lRCGooPPFpNIyGVuYmk9s5jO
         dknBhDL1kztGNkomqf7sp9WwnuvzEzDXESNZ4XCq7nE1Clk7y/cDviy3iqhUJVibH0HP
         P3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wMcWekleBU1R4ydXfALVXkI2NKLW7AgpvxY4ncIRacA=;
        b=yJhgqjFwkQwfpU0u004ziRmM58IyKR5PexZI0UfHr4C7jUgQA5Q+R9LH/pU+YEyQji
         jx+o+gDbN/J+Dt3vh9U3S/TcIUya3rRC+PCE0xOqof33W3qbwFZQo0oA39McKxGuqxnq
         tEJz5SAyJSs/32+UlmTUXIUGWoJVccwa15DIFRHc4qQ1tSioSfAJaIVn2MYTU2eYPwjt
         VuE3y0VAtg2KsBorP+0qy9Do7ER5qoxM0p23+NBoHUbCG8hQ7hWoq64CceEtiGWw4+IN
         See7QbbYAE0vMOLJgDhVrm4lDayAE7Nu/Gej3U58md+pqdkuZChCpqcJ36/vF8u0rQoa
         BDIQ==
X-Gm-Message-State: AOAM531N134ZisM+w38se8mUomimYYB1cd4Xhvx6eyBX1hTN1hwTB34r
        f76X1/b/vbu1hQkKoiHT7I5deg==
X-Google-Smtp-Source: ABdhPJwsZCmETJjxs+Dr26KxzjDyL71bfBLLMXwmtQkvBRv0/92dlzjh8V9/I77+6fWnkKoOZnYS2g==
X-Received: by 2002:a17:907:c29:b0:704:fbb:1943 with SMTP id ga41-20020a1709070c2900b007040fbb1943mr20412637ejc.486.1654507363202;
        Mon, 06 Jun 2022 02:22:43 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u21-20020a1709064ad500b006f3ef214e14sm5956397ejt.122.2022.06.06.02.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 02:22:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Tomasz Figa <t.figa@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: exynos: Fix refcount leak in exynos_map_pmu
Date:   Mon,  6 Jun 2022 11:22:34 +0200
Message-Id: <165450734050.62970.14209862492760707950.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220523145513.12341-1-linmq006@gmail.com>
References: <20220523145513.12341-1-linmq006@gmail.com>
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

On Mon, 23 May 2022 18:55:13 +0400, Miaoqian Lin wrote:
> of_find_matching_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> of_node_put() checks null pointer.
> 
> 

Applied, thanks!

[1/1] ARM: exynos: Fix refcount leak in exynos_map_pmu
      https://git.kernel.org/krzk/linux/c/c4c79525042a4a7df96b73477feaf232fe44ae81

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
