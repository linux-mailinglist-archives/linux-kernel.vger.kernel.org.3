Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FC655D650
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345708AbiF1M2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345703AbiF1M1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:27:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AAF28E21
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:27:51 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v14so17446009wra.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tb0t65jsbHJl74LbXn7xY7xw4eMs9qTMATyi3JCBvfo=;
        b=U9my8jxUxg/O9/IM764HdUfoUJ1/0PxPY/DxLNTodgfsYi3V5aQYKxoNv4C8F0QnMb
         AhZ4UNDxOAr9aFw2ia2bXMBqXD85gflBsiu+PE4A7D1Yl8/7m6U/b8wd6mtPzKHEvjpP
         JNGgiB6zkj9JfswjNmwlMy16fZOMMXkDPvR+YoeWvU/+mi0Rja8j49tv6IvZlswnd9IU
         GxAJfsKibmF1vZSMv3bZ2vpXH7t9fsE7zFlWLU7ESHp1kscg46v70TFaeElCNQC0KJaH
         ZlC4LPGJ3u1HrhVgY28KdpW99YFobfyYkFRPzK/O2BlOlQ2IWB1QZSuGhLak8iosgf0V
         wG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tb0t65jsbHJl74LbXn7xY7xw4eMs9qTMATyi3JCBvfo=;
        b=hnDhqINYhfFDqrqO5jN0gudEgg8OEiSVF3U27XezpUwOEepE3i21R6fiyyMS0o/+Jh
         BWdayGlTAv9N2q3rgWfKp/V88FRwtpyoDY2/zxPflMI2PB2cnW9feeLApckMVYgKsb++
         cQP0A7ljljGRxxQL1Pv0XKDCqUTUcUiQiVMn1sO46QMTU44koJBHxte2O/xTwU4gPVT7
         PyQoaB8fx8AIlMqQ4BNJZF2ZP3QOVNdM7Zlpi7s+YhXaXIAMCNfBWN0WJvEA3QWeDt9L
         5hHZYSKbxvaqYkGvGUn73MXk0Wsk5j6NefQfGsJvAKfwl/AgPE5JVk3M6SeCw/EQdfrr
         myNw==
X-Gm-Message-State: AJIora+y/HWJBKi5iYveqxiuUqlpKw5J9cIzBka2NTKnD+SKAkSMSWIo
        w1rXwEwbAsb3w2ojsOG1w+HErw==
X-Google-Smtp-Source: AGRyM1sEgEQCWJLYG0thDMOLQ9G5zPwdAxURojB8U7z+FJm4KwwTAVmermo6VcLaUomfdQ3hiIRTgQ==
X-Received: by 2002:a5d:4251:0:b0:21b:885b:2fcc with SMTP id s17-20020a5d4251000000b0021b885b2fccmr17944898wrr.52.1656419270152;
        Tue, 28 Jun 2022 05:27:50 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id ay36-20020a05600c1e2400b0039746638d6esm17184212wmb.33.2022.06.28.05.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 05:27:49 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Makefile: Enable clang-tidy and clang-analyzer for gcc builds
Date:   Tue, 28 Jun 2022 13:27:40 +0100
Message-Id: <20220628122741.93641-3-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628122741.93641-1-daniel.thompson@linaro.org>
References: <20220628122741.93641-1-daniel.thompson@linaro.org>
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

It is now possible use clang-tidy and clang-analyzer even if your primary
compiler is gcc. Remove the checks that prevent gcc builds from using
these tools.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Makefile b/Makefile
index 9ea6867aaf9c..0afef56d8203 100644
--- a/Makefile
+++ b/Makefile
@@ -1901,17 +1901,11 @@ targets += $(extmod_prefix)compile_commands.json
 
 PHONY += clang-tidy clang-analyzer
 
-ifdef CONFIG_CC_IS_CLANG
 quiet_cmd_clang_tools = CHECK   $<
       cmd_clang_tools = $(PYTHON3) $(srctree)/scripts/clang-tools/run-clang-tools.py $@ $<
 
 clang-tidy clang-analyzer: $(extmod_prefix)compile_commands.json
 	$(call cmd,clang_tools)
-else
-clang-tidy clang-analyzer:
-	@echo "$@ requires CC=clang" >&2
-	@false
-endif
 
 # Scripts to check various things for consistency
 # ---------------------------------------------------------------------------
-- 
2.35.1

