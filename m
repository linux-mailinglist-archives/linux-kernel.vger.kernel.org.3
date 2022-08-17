Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799C0596A91
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbiHQHpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiHQHpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:45:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31F779A55
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:45:29 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M70PJ2YSKzhZ28;
        Wed, 17 Aug 2022 15:43:16 +0800 (CST)
Received: from CHINA (10.175.102.38) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 17 Aug
 2022 15:45:27 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4 -next] fault-injection: allow stacktrace filter for x86-64
Date:   Wed, 17 Aug 2022 08:03:29 +0000
Message-ID: <20220817080332.1052710-2-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817080332.1052710-1-weiyongjun1@huawei.com>
References: <20220817080332.1052710-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FAULT_INJECTION_STACKTRACE_FILTER option was apparently disallowed on
x86_64 because of problems with the stack unwinder:

    commit 6d690dcac92a84f98fd774862628ff871b713660
    Author: Akinobu Mita <akinobu.mita@gmail.com>
    Date:   Sat May 12 10:36:53 2007 -0700

        fault injection: disable stacktrace filter for x86-64

However, there is no problems whatsoever with this today. Let's allow
it again.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 lib/Kconfig.debug | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 38d259b1d262..c6795f4656d7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1944,7 +1944,6 @@ config FAIL_SUNRPC
 config FAULT_INJECTION_STACKTRACE_FILTER
 	bool "stacktrace filter for fault-injection capabilities"
 	depends on FAULT_INJECTION_DEBUG_FS && STACKTRACE_SUPPORT
-	depends on !X86_64
 	select STACKTRACE
 	depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
 	help
-- 
2.34.1

