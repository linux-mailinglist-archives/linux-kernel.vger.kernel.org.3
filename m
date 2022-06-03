Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727A853D22E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 21:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345544AbiFCTGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 15:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348914AbiFCTFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 15:05:18 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D5B30F78;
        Fri,  3 Jun 2022 12:05:17 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u3so11537323wrg.3;
        Fri, 03 Jun 2022 12:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H4l6l2+LqiOAH0dZelhPsMXnUGKfvd85Zt0GdanrYgo=;
        b=M5hnMb4CuBoUZpZeyvJDSxPSJ9OKj9E4VW0RDQ2aQNYV7/RnjpzNdxWpaAyjvTKLN7
         USHIBU9qf22PFo4NgZ3humWSzMGISiVv666dwxX3rlb1OOQWksEomMKRWukUL8apazlR
         KPRl8LyO4WQvhm1CENAZKFlWqsr57FK+YpRv8gANAz0miyCko1XScotlwE5dcACPUjfe
         9ILTCLGcaiWkQnQKFPXGMXNhJ8VnJoaqLUVgj3Noyr/Nn/1Gwl39ikS/rpTENK5LT5Oj
         Ns9gvKC20I9JCkCW9/rOxDFfwvRmis//ni+8mACpmwP/3+PIp+Tx5vJr5bZTvKHqhUKJ
         hSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H4l6l2+LqiOAH0dZelhPsMXnUGKfvd85Zt0GdanrYgo=;
        b=684s/57T8w+PVvG2fCdCRpuSHHHJZFck9Fm2uFCxsT/9eydB7IRE6wK4p6ejhEfIct
         T76B40dcfR/lIxnvb/XSlvVda7F4IywZSqjs3YmQjxs3yzMo20cLbZe6BAbGryamNWJS
         aCjMNhT5zXq9BCjCjk1j3yEq9h9tEgN45VtjptznDdI4ByLslM64qT2XvFk/uj/AzSEI
         Q5AZ6myQ0q4p5v90YWSxij92HSUkphQXpwC+V8700cQsh1LXDiX693Ns3K4RNDUHScgU
         R91y48fFHnYaKU9rshIJHw4lJ9udTtWKk0IMlAlfkCdnMfXOXiDOzRAufFyRNiKgiNcA
         xVAg==
X-Gm-Message-State: AOAM533p/KDnI2In+qznO0t0hVozHcqqUbYYoGNAjTC3lpzjXPqvCxBV
        7y/+w5ktaPWLjdITXUiY/mkTu/+Boho=
X-Google-Smtp-Source: ABdhPJyenvVHsJ92MUvPmQJQfRXhRzsHiPrPAS0MBFnshuaYBPsmApjEVhnJsiJ+UARO477OXI92lA==
X-Received: by 2002:a5d:6348:0:b0:213:3a8e:e75d with SMTP id b8-20020a5d6348000000b002133a8ee75dmr7758317wrw.55.1654283115278;
        Fri, 03 Jun 2022 12:05:15 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id d12-20020a5d4f8c000000b00210346cd0b7sm8059568wru.101.2022.06.03.12.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 12:05:14 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v5 0/1] ARM: mstar: cpupll
Date:   Fri,  3 Jun 2022 21:05:08 +0200
Message-Id: <20220603190509.45986-1-romain.perier@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of the remaining patches of this series. I have kept
the cover letter in order to do not loose context of the previous series.

This series adds a basic driver for the PLL that generates
the cpu clock on MStar/SigmaStar ARMv7 SoCs.

Unfortunately there isn't much documentation for this thing
so there are few magic values and guesses.

This needs to come after the MPLL DT changes.

Changes since v4:
- Removed merged patches (dt-bindings documentation and dt-bindings)
- Rebased onto 5.19

Changes since v3:
- Added Reviewed-by on Daniel's patches
- Removed "[PATCH v3 8/9] ARM: mstar: Add OPP table for mercury5"

Changes since v2:
- Re-ordered Kconfig by name
- Re-ordered includes alphabetically and removed useless ones
- Used timeout for cpu_relax
- Returned DIV_ROUND_DOWN_ULL() directly in
  msc313_cpupll_frequencyforreg()
- Returned DIV_ROUND_DOWN_ULL() directly in
  msc313_cpupll_regforfrequecy()
- Reduced the number of lines for msc313_cpupll_of_match
- Removed CLK_IS_CRITICAL

Changes since v1:
- Re-worked the series and ensure that 'make dt_binding_check' passes.
  The required commit is merged now, so it is okay.
- Fixed coding style issues in the driver and makes check_patch.pl happy
- Added one more commit for extending the opp_table for infinity2m.


Daniel Palmer (1):
  clk: mstar: msc313 cpupll clk driver

 drivers/clk/mstar/Kconfig             |   8 +
 drivers/clk/mstar/Makefile            |   2 +-
 drivers/clk/mstar/clk-msc313-cpupll.c | 221 ++++++++++++++++++++++++++
 3 files changed, 230 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mstar/clk-msc313-cpupll.c

-- 
2.35.1

