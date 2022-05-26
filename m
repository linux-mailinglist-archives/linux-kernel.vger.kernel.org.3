Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A444534A93
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 08:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbiEZG5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 02:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiEZG5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 02:57:49 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B8527CD9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 23:57:48 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B2F883F6F1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653548262;
        bh=Txe6Joc+D2sNVGRTbSJSoJjs7Jo7D+TANko+R2z0/4w=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Gk3I4s94BFUXCCpNnVF/4kUk5N+/I5jbu+FcRxbVYdptMlNc4IjI1VDX6SDrn2Fsq
         TFd3IlodBIGiV3GBe2f3w61oz6M92fyKOMrCVuGUBX3YMHU8tLLMxoBG891ruAg9U1
         TBNgHBhi2TRqQPqLDDMmNBXLe0CFpzhgyotR1xLyz9nTIo7cZQUybTScT93Uog/qjt
         J9oJ+F2tqoUYEjfr35rrifmXG7SQie9BzIiyYhHeYb4EMaFLmRnB7RVOcAjI2mT8oq
         ZZBFdOqwE0L/R49sNGbDiGHnqjb5G4yEB7KIZO3W9U4GmMSaR7+hjTmXP/SaNZlDcB
         V9FPEusLWIMRA==
Received: by mail-ed1-f71.google.com with SMTP id e3-20020a056402330300b0042b903637bbso484102eda.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 23:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Txe6Joc+D2sNVGRTbSJSoJjs7Jo7D+TANko+R2z0/4w=;
        b=tz8NAihoRQ2OVW/ZWNB2yYD/37Vm7nx2VVWxnRhsV+3iKTkAQC2lH/oY7TAQqYyHUR
         WOg2mL5ch5rmVZYQYRaANEowEaE+386Ty7pRXpmwoiaorK3NJvg/ru8pUfhnGWsWhrYk
         O1mQt6zSrBP9/AUlrsp59sBf4bfmB57Fq6aJ8BiVQxMRkD9v/2rof0cZKyYreEkZOWhC
         WayiP3ZHv+ncCZZN8YmKv4hebJb4nwXZHhllk1HjlxT+b4Cy9NWp6/5gpheb2PQWb0cE
         7rnQgpjPoJH3zzJAXqUEb9Pkc2fjd2evSiSXMdbQdpOKAeuSZG+xav6umeDDq1IQcONE
         YIDA==
X-Gm-Message-State: AOAM533+fLpRnmJq9eB9eOZOpty9tIQZ5P9Ddewsc0G1A3w5g9VMMuCt
        bX+VOilHrEWdBRsLX6tA8fbiH9iYGtTDlfb8Xqm8YIzZdntp9WRGv/bSurFH2HLtPv8vDj/Ywle
        iAciVcFD3lCVncwW62Eyb62Z0n1+yPSTEI64pFuzvtQ==
X-Received: by 2002:a17:907:2cc5:b0:6f9:1fc:ebef with SMTP id hg5-20020a1709072cc500b006f901fcebefmr31436517ejc.121.1653548262292;
        Wed, 25 May 2022 23:57:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAzlMCLTa7rB0D14mp1uSRSJck3CimWoqaJa1PBLLHcC7RI032CbnbDvhBqTGp/pQy8R5TgQ==
X-Received: by 2002:a17:907:2cc5:b0:6f9:1fc:ebef with SMTP id hg5-20020a1709072cc500b006f901fcebefmr31436506ejc.121.1653548262126;
        Wed, 25 May 2022 23:57:42 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id w15-20020a17090652cf00b006fed8dfcf78sm220906ejn.225.2022.05.25.23.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 23:57:41 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 1/2] powerpc: Kconfig: Replace tabs with whitespaces
Date:   Thu, 26 May 2022 08:57:36 +0200
Message-Id: <20220526065737.86370-2-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220526065737.86370-1-juerg.haefliger@canonical.com>
References: <20220526065737.86370-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs after keywords with whitespaces to be consistent.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 arch/powerpc/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 174edabb74fa..b4acaa77837a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -11,7 +11,7 @@ config 64BIT
 
 config LIVEPATCH_64
 	def_bool PPC64
-	depends	on LIVEPATCH
+	depends on LIVEPATCH
 
 config MMU
 	bool
@@ -446,7 +446,7 @@ choice
 	default MATH_EMULATION_FULL
 	depends on MATH_EMULATION
 
-config	MATH_EMULATION_FULL
+config MATH_EMULATION_FULL
 	bool "Emulate all the floating point instructions"
 	help
 	  Select this option will enable the kernel to support to emulate
@@ -1235,7 +1235,7 @@ config PHYSICAL_START
 	default "0x00000000"
 endif
 
-config	ARCH_RANDOM
+config ARCH_RANDOM
 	def_bool n
 
 config PPC_LIB_RHEAP
-- 
2.32.0

