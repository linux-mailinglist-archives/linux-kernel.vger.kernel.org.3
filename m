Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48D94CE4EF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 13:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiCEM6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 07:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiCEM6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 07:58:16 -0500
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C206B20FCAD;
        Sat,  5 Mar 2022 04:57:24 -0800 (PST)
Received: from grover.. (133-32-176-37.west.xps.vectant.ne.jp [133.32.176.37]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 225CuBjJ008491;
        Sat, 5 Mar 2022 21:56:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 225CuBjJ008491
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1646484972;
        bh=HbfK+WR3fpzTNPKUUwev8caY8oon1l2ZmmSStF5FWqk=;
        h=From:To:Cc:Subject:Date:From;
        b=p4byQ0dhwMDAe9lQ8Wwi+jhTi0e63Pj73IdRsALxoYau54F84fozgQ/ECJEnk1gty
         1kPIqroN2GA6uOOQXnWaAUoEbiXKXMcrvJKL8AafM6oo5q5zD878RUDyUlG8ZP/Fy6
         BiovJEkrtDtyObiqJTyCFU0WUaKZw+XhUCwQudmKspFsA1f88vgoEgBbOIijFadWvl
         wfoZTzhg/QjzjCOSlji0mXQriUEqRkA0CdfwOXw5PrRqdvMFbGtWkdYN7OZEsNd3ti
         tc5fke1gp6hGR4FLFKgLklNipVnDCNWr77BY7DoYwcmrO/2q2LrUyHexdQwRgtg8AF
         kjcUiIeauFghg==
X-Nifty-SrcIP: [133.32.176.37]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, Fangrui Song <maskray@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] kbuild: add --target to correctly cross-compile UAPI headers with Clang
Date:   Sat,  5 Mar 2022 21:56:05 +0900
Message-Id: <20220305125605.149913-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When you compile-test UAPI headers (CONFIG_UAPI_HEADER_TEST=y) with
Clang, they are currently compiled for the host target (likely x86_64)
regardless of the given ARCH=.

In fact, some exported headers include libc headers. For example,
include/uapi/linux/agpgart.h includes <stdlib.h> after being exported.
The header search paths should match to the target we are compiling
them for.

Pick up the --target triple from KBUILD_CFLAGS in the same ways as
commit 7f58b487e9ff ("kbuild: make Clang build userprogs for target
architecture").

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Reword the commit description to mention agpgart.h instead of
    asound.h because the latter is in the no-header-test list.

 usr/include/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/usr/include/Makefile b/usr/include/Makefile
index ac206fb27c65..4215801e1110 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -10,7 +10,7 @@ UAPI_CFLAGS := -std=c90 -Wall -Werror=implicit-function-declaration
 
 # In theory, we do not care -m32 or -m64 for header compile tests.
 # It is here just because CONFIG_CC_CAN_LINK is tested with -m32 or -m64.
-UAPI_CFLAGS += $(filter -m32 -m64, $(KBUILD_CFLAGS))
+UAPI_CFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CFLAGS))
 
 # USERCFLAGS might contain sysroot location for CC.
 UAPI_CFLAGS += $(USERCFLAGS)
-- 
2.32.0

