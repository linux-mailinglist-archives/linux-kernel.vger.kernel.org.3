Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5B253E95D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiFFJWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbiFFJWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:22:47 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C2A7652
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:22:40 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z7so17922065edm.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 02:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMqWJhtAyYq2IUfZFroUIAerSMEPBvVpvuurqeNCYvs=;
        b=OFo8uppJzXZ9dL33NSJdpecRS/Coh98SLo26IW6BwmTiTcVnDEC+YVfZtOtfzSJ2JI
         9LEHqkJgC6yIJSftDx9Dy0QNhGWHh5CFy9MfxEeS3IM3Qhv5kHbWGt2NruIeBXGsB0Pn
         uCygGT4/DAV6y4Fdw1yJ/kwdhGAdgMBpsF1NQZwVNFSkJA2KTpwvjd/QCEtW8M/YUFT1
         wSTLhdn5918MujkrWEMarEQaM4MpdTDp9Il6EbOwdTWB/MBG2yrKPWjUD8TyC19JT2OK
         Akq26IjOSv2mM1WBIdeZf8dq6LDAeOg24BSDkYaIv8Nl6LNtbEYqRRLjjYVfIg38lZdD
         tMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMqWJhtAyYq2IUfZFroUIAerSMEPBvVpvuurqeNCYvs=;
        b=kwvyT0M3JqFOOeb4NzGYT2dSqDoGL8rLUsivWrWC1531oAGp044xHhCRLcyY9ycTLl
         OPCpEWqGv405TPGMrwBb/J2iMqrNOjS6bddnIKw2ePQGkAyzhrROLY9Vy301X4M9vWkS
         TMqBiBKKAD+xKeTPmxNIbGd+hPOFx8WIqmzfDZf3iuFwYxquLw6uVICMTVmiVaWd85h/
         4bI408s3HysEK1g3ATjxx0B4huDDoZYmhTPhkv84MsnVfuLvs6r0vPmRU2EerlHBmmxY
         D0j04W+p+udgnzN0fE2d/pa33Q0uR8JW2Tpd8Rb7lzV/8arlY8INyc2jrijEioAjTIz6
         b9yQ==
X-Gm-Message-State: AOAM5305fwQqQrMYgCalAZsaD9+h94z/MPl4K990TyynXwPqoHogzICx
        VkMLTkApd3RlO6y8THEdPjJYHA==
X-Google-Smtp-Source: ABdhPJx/X8ut+ZeKxFGC0bxQqfhkiA/i7ro48JbnFWKO71mIkbWH8LPakdxH6RVQafUsgWK9oUurwQ==
X-Received: by 2002:aa7:c492:0:b0:42d:ed6a:26e5 with SMTP id m18-20020aa7c492000000b0042ded6a26e5mr25368434edq.64.1654507359330;
        Mon, 06 Jun 2022 02:22:39 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u21-20020a1709064ad500b006f3ef214e14sm5956397ejt.122.2022.06.06.02.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 02:22:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-fsd@tesla.com
Subject: Re: [PATCH] arm64: dts: fsd: Add cpu cache information
Date:   Mon,  6 Jun 2022 11:22:30 +0200
Message-Id: <165450734050.62970.7702995773411139877.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220518132350.35762-1-alim.akhtar@samsung.com>
References: <CGME20220518132329epcas5p307c6908621c3faa94d085b4a2cc931e1@epcas5p3.samsung.com> <20220518132350.35762-1-alim.akhtar@samsung.com>
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

On Wed, 18 May 2022 18:53:50 +0530, Alim Akhtar wrote:
> Add CPU caches information so that the same is available to
> userspace via sysfs.  This SoC has 48/32 KB I/D cache for
> each CPU cores and 4MB of L2 cache.
> 
> 

Applied, thanks!

[1/1] arm64: dts: fsd: Add cpu cache information
      https://git.kernel.org/krzk/linux/c/5355559555b98cd2f0b96b2c4e56c32356f90cc1

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
