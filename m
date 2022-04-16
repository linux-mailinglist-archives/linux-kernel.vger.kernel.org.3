Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675C15034B5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 09:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiDPHsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 03:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiDPHsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 03:48:33 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1242AFC
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 00:46:01 -0700 (PDT)
Date:   Sat, 16 Apr 2022 09:45:55 +0200
From:   Guilherme Amadio <amadio@gentoo.org>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] perf clang: Fix header include for LLVM >= 14
Message-ID: <Ylp0M/VYgHOxtcnF@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header TargetRegistry.h has moved in LLVM/clang 14.

Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
---
 tools/perf/util/c++/clang.cpp | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
index df7b18fb6b6e..1aad7d6d34aa 100644
--- a/tools/perf/util/c++/clang.cpp
+++ b/tools/perf/util/c++/clang.cpp
@@ -20,7 +20,11 @@
 #include "llvm/Option/Option.h"
 #include "llvm/Support/FileSystem.h"
 #include "llvm/Support/ManagedStatic.h"
+#if CLANG_VERSION_MAJOR >= 14
+#include "llvm/MC/TargetRegistry.h"
+#else
 #include "llvm/Support/TargetRegistry.h"
+#endif
 #include "llvm/Support/TargetSelect.h"
 #include "llvm/Target/TargetMachine.h"
 #include "llvm/Target/TargetOptions.h"
--
2.35.2

