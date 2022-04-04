Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A534F1C5A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382237AbiDDV0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379419AbiDDRKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:10:19 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E281E40A25
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:08:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ot30so11392306ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 10:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LXXr7F0cW3RTrkA8M6uuznqZSvmvR1TGt0LOYkCfNSQ=;
        b=wBUWd1KOHSXpqah/8BaOgmo8qLPdZf1sdgt0au6YhBPtGFBBh2rBCHyFSGtQaXNZe7
         khGltgNxaO32X6qwHt4slyv3JWF+NX5P+dHNeemg4Dp4Rj2oEKD1T3M7L+jBkvG0cEaj
         XWzBID2cjpeX8s/+1fc7UvWjmeXe7cRskPgFVjXw5x5VHbcBDjc3bg59jDMUgbQMp0QD
         LFBiJ6j2JSV6MBnkz8TAYalVInVz6tEnJZIX0E2/DYb+fBpSM+arJRv+VD6RXlRi6b5Y
         Ek8TgLsFU9b5Qf6uMfaf/Q6xTn5QkVOkUzkmJD5P8m3DccA+TDLPfosr3ptDA05BQWii
         dHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LXXr7F0cW3RTrkA8M6uuznqZSvmvR1TGt0LOYkCfNSQ=;
        b=vcKkHev3ADuEjZkbBn685rmVtfJJDBznQVepxhnsnbKUy6cJEjRFlm8DfGZglTVH5C
         Mlbg8YlhGpKDsESk8CCwAKJX/TsnCi3/iKgC8SlxLPvC+X4ATzVy3+cjQP2QE9xQ6mKH
         +XxtEkGot4NLRB6pEVL5a/AgkVW3MfOsOpR3wui3gounecKh8jmqq/sVPmLQwUlWqxLE
         1kgZLnp/pggCo1eO3DJM7/iJKTrueBL8ms+m3vwolWeHgY8Pec2xirVcbxRsce0x7UR4
         BIDAkF+jVbK3F19h/JNRiOTfPfHnjriTfYAqlH2o1naoEfXdxOlgEdeZDFro6qbDA/DB
         1HXg==
X-Gm-Message-State: AOAM532tjEB3bDzpsriElFJGUbMBqbFnLFKfA3+cKPQNCzuy5jzMvOvB
        ErN9f+hp90dZ8/KMDYNeaJRCxQ==
X-Google-Smtp-Source: ABdhPJx2qo4HGcrJqr114ZtIIY4ckwTEFuRMwUlvOaFJCAC2pEj4AzRRvX7sa3sEZVcPo8HyRUAHlA==
X-Received: by 2002:a17:907:a41e:b0:6e7:9ea9:8350 with SMTP id sg30-20020a170907a41e00b006e79ea98350mr1021136ejc.377.1649092101002;
        Mon, 04 Apr 2022 10:08:21 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id u25-20020a170906b11900b006e08588afedsm4565827ejy.132.2022.04.04.10.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:08:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] memory: samsung: exynos5422-dmc: Avoid some over memory allocation
Date:   Mon,  4 Apr 2022 19:08:14 +0200
Message-Id: <164909209237.1690243.6125620782539753539.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <69d7e69346986e2fdb994d4382954c932f9f0993.1647760213.git.christophe.jaillet@wanadoo.fr>
References: <69d7e69346986e2fdb994d4382954c932f9f0993.1647760213.git.christophe.jaillet@wanadoo.fr>
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

On Sun, 20 Mar 2022 08:10:30 +0100, Christophe JAILLET wrote:
> 'dmc->counter' is a 'struct devfreq_event_dev **', so there is some
> over memory allocation. 'counters_size' should be computed with
> 'sizeof(struct devfreq_event_dev *)'.
> 
> Use 'sizeof(*dmc->counter)' instead to fix it.
> 
> While at it, use devm_kcalloc() instead of devm_kzalloc()+open coded
> multiplication.
> 
> [...]

Applied, thanks!

[1/1] memory: samsung: exynos5422-dmc: Avoid some over memory allocation
      commit: 56653827f0d7bc7c2d8bac0e119fd1521fa9990a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
