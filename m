Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B96A58F704
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 06:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiHKEn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 00:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiHKEny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 00:43:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B96F5C9E5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:43:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gk3so31435801ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=+9HzSidIPMQTNNrGtqCekM+MdSXHeeycGGLancDPna0=;
        b=x7isIy17F2cNCmj/jxkdSbMSTaajfYMlebNQ/H+fgozeoYt7wwS2x0K6DF3KQjTvwO
         HCGxsJTgagsDzoJwLtxOH8CAGc3T8t2fA7hapLn4sUOITO+uQLvWxx2pzrlUa88EUldM
         co/UNPhr1X/crXT8vOjncV12/Xl/j1DrX6KZifdsfTFfKS7p5KjsKf8EqOk1rYyt91t/
         L6Uh2e/+jYMuv8tGAclc6ByAfeFCPKUh9Ffg8/UcXUQSkPsXAwgJS2Dk/VbxtPRS/9ht
         9r9EyTMHObPJEB9+NY3zaTA3UuZ16pOeASiH2bfBYVNuUxLWMomERpiq87hoVFFN8CSL
         RoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=+9HzSidIPMQTNNrGtqCekM+MdSXHeeycGGLancDPna0=;
        b=6GO4uqfSspTZ7eEPw8HojXTpbPsO+Tsi0jo7/sez6VDEutegQX5mjqpMFySNdZw/9o
         IZ0PfNR+9FhGUhJI+d/Q3renaK3QVrRv09TkdrrRqhUSW6pBpv8GgkgKiAgjH/XfB1rf
         YJsCyS2PZLfSd4TnTci9zzEjIDCDMjbEMx8WEakuU//MSB5PLmIiJS+zc6dHemyLHPye
         lQQum7nPigO6vWJ4hPs9udJZGRIBW+Jly13MbVnzRXeZhwv1qwB0zP5rO631mn/ZtwAq
         5QxH6N6OzbqAEnzSVRFw4bweyVVLKy/NEe13oTUeKKVX7dCTsVW2MM76bLjweE+fYBB4
         CeNg==
X-Gm-Message-State: ACgBeo1HVjAv+L3d4pmnWbbmm/TW4wnsJO54v5FBkGulo1GPA1REPqbH
        k24bfTPJAuqYIZddMjWGyjl9/Q==
X-Google-Smtp-Source: AA6agR4PCMeixDA9DlnrUDl+qifhXJsqFz2frjlQ5IbqWp2qbn2q/t28Afoc38O7gcn2dibSHweRzw==
X-Received: by 2002:a17:906:847b:b0:730:638c:b154 with SMTP id hx27-20020a170906847b00b00730638cb154mr22292843ejc.618.1660193031618;
        Wed, 10 Aug 2022 21:43:51 -0700 (PDT)
Received: from leoy-yangtze.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id cq21-20020a056402221500b0043ba7df7a42sm8493433edb.26.2022.08.10.21.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 21:43:51 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] tools headers arm64: Fix compilation failure
Date:   Thu, 11 Aug 2022 12:43:41 +0800
Message-Id: <20220811044341.426796-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When build perf tool on x86_64, it reports failure for finding the
header <asm/sysreg.h>:

  In file included from util/arm-spe.c:37:
  util/../../arch/arm64/include/asm/cputype.h:183:10: fatal error: asm/sysreg.h: No such file or directory
    183 | #include <asm/sysreg.h>
        |          ^~~~~~~~~~~~~~
  compilation terminated.

There have no sysreg.h in x86's asm folder, alternatively, this patch
includes the sysreg.h header in the same folder with cputype.h to fix
the compilation failure.

Fixes: 37402d5d061b ("tools headers arm64: Sync arm64's cputype.h with the kernel sources")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/arch/arm64/include/asm/cputype.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
index 8aa0d276a636..cddeada0ca31 100644
--- a/tools/arch/arm64/include/asm/cputype.h
+++ b/tools/arch/arm64/include/asm/cputype.h
@@ -180,7 +180,7 @@
 
 #ifndef __ASSEMBLY__
 
-#include <asm/sysreg.h>
+#include "sysreg.h"
 
 #define read_cpuid(reg)			read_sysreg_s(SYS_ ## reg)
 
-- 
2.34.1

