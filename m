Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF1D5AF327
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiIFRxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiIFRxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:53:14 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0719A6A3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:53:10 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso15798616pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 10:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=flM6z/aZfaObx6vFxYOPjGjlbxViOKss6sBC4Qc+hjQ=;
        b=eFIZwLRx3uLBvbGaNPmxLmj0jp/S5xhwz/osy9fHPsxPkSMZNlVz8VI4St7EPXzsnJ
         6j2G1qPE1odjUdAb+1lWOC1WtIFUHhPWDzmo/dm5Na6d47C9xnxdeq1vGzlI5LIdWO2y
         z3hOr49qqCF0PRowYLjSMzptiRPHzdVcK1N5xUHNxY1slofijTNjrYi7U5bqAF7kH6Dt
         i5MMFM2Q/OaPVGg4Q5w2ceLvKrHL3oC0QhOcuM0WaSzEnLtMkILC8fVYEf536gQiMtKL
         XI051Ld1yHsk67f/c6HKTa0LvF0j1rHavTHcemF2mZFf1WHpLd/ha7lrVJnbfNTR3EZ1
         U82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=flM6z/aZfaObx6vFxYOPjGjlbxViOKss6sBC4Qc+hjQ=;
        b=sdG38X+Cuw/OhSEZF7yCjNyAl89hNj4VeHL9NhAoPyPSweGsgI3mJ5zAHmLMlRgdUd
         iSYkifnmV1lg325CqVVVt/SLKc3344njAUg4YRaEICFblFceRsjJCDwysjCF522XQTKQ
         r9JSx4NX8ZJEDeRbyXzK0undhgRd5AChlMXpKjfBOrDQSLeu9S++FKVAkn4BCmpkr+fF
         HpV0yEJzqjx4CSG8MlKkjcK/Ze0FH8tEwkFTH6MvguVx+r25QS0fjTnXSIJ/vX+rHZcu
         4r+EvdHTkKA3+6NG/Ej6mSbgkyv5bvh3QvOQJuiB0/hIF0/CDG34/jc4OleOQJYjS6Xt
         gzQg==
X-Gm-Message-State: ACgBeo1RJlsrQWpr8j3yj0aEKqg8jG5PUwwvCFYktCD6pBYsgEhCmFo6
        YIoIOJvZJUyk6EUvwYXzMHs=
X-Google-Smtp-Source: AA6agR77VJGd9XphIhSwKRClsidOdx1OdfrRael+fgw+iMaS7Xf9mpXfj8X9627uG2+4eJHFqfJe5w==
X-Received: by 2002:a17:90b:1a91:b0:1fd:c26c:a3bf with SMTP id ng17-20020a17090b1a9100b001fdc26ca3bfmr26499106pjb.213.1662486788617;
        Tue, 06 Sep 2022 10:53:08 -0700 (PDT)
Received: from 7YHHR73.igp.broadcom.net (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id v65-20020a622f44000000b00539aa7f0b53sm10404244pfv.104.2022.09.06.10.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 10:53:08 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     soc@kernel.org, michael@walle.cc,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: defconfig: enable ARCH_BCM
Date:   Mon,  5 Sep 2022 20:39:56 -0700
Message-Id: <20220906033957.4377-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 96796c914b84 ("arm64: Kconfig.platforms: Re-organized Broadcom
menu") introduced a new symbol ARCH_BCM and made all of the Broadcom
SoCs Kconfig depend on it, but did not enable it in the defconfig.
Thus, now the defconfig doesn't include support for any Broadcom
architectures anymore. Fix it.

Fixes: 96796c914b84 ("arm64: Kconfig.platforms: Re-organized Broadcom menu")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 91e58cf59c99..4c8b09c6b49f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -33,6 +33,7 @@ CONFIG_ARCH_ACTIONS=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_ALPINE=y
 CONFIG_ARCH_APPLE=y
+CONFIG_ARCH_BCM=y
 CONFIG_ARCH_BCM2835=y
 CONFIG_ARCH_BCMBCA=y
 CONFIG_ARCH_BCM_IPROC=y
-- 
2.25.1

