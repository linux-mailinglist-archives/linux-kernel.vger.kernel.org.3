Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAB14A6418
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242012AbiBASij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236866AbiBASii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:38:38 -0500
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD0AC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 10:38:38 -0800 (PST)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 54DAD101BFE; Tue,  1 Feb 2022 18:38:36 +0000 (UTC)
Date:   Tue, 1 Feb 2022 18:38:36 +0000
From:   Sean Young <sean@mess.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>
Subject: [PATCH v2] selftests/ir: fix build with ancient kernel headers
Message-ID: <Yfl+LOPk+KQdc0Us@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit e2bcbd7769ee ("tools headers UAPI: remove stale lirc.h"),
the build of the selftests fails on rhel 8 since its version of
/usr/include/linux/lirc.h has no definition of RC_PROTO_RCMM32, etc [1].

[1] https://lkml.org/lkml/2022/1/28/275

Fixes: e2bcbd7769ee ("tools headers UAPI: remove stale lirc.h")
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Sean Young <sean@mess.org>
---
 tools/testing/selftests/ir/ir_loopback.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/ir/ir_loopback.c b/tools/testing/selftests/ir/ir_loopback.c
index 06256c96df12..f4a15cbdd5ea 100644
--- a/tools/testing/selftests/ir/ir_loopback.c
+++ b/tools/testing/selftests/ir/ir_loopback.c
@@ -29,6 +29,16 @@
 #define SYSFS_PATH_MAX 256
 #define DNAME_PATH_MAX 256
 
+/*
+ * Support ancient lirc.h which does not have these values. Can be removed
+ * once RHEL 8 is no longer a relevant testing platform.
+ */
+#if RC_PROTO_MAX < 26
+#define RC_PROTO_RCMM12 24
+#define RC_PROTO_RCMM24 25
+#define RC_PROTO_RCMM32 26
+#endif
+
 static const struct {
 	enum rc_proto proto;
 	const char *name;
-- 
2.34.1

