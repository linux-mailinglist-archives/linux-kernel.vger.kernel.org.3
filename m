Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E8C4A61A2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 17:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241258AbiBAQxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 11:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiBAQxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:53:13 -0500
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB44BC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 08:53:13 -0800 (PST)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 9C4FA101BFE; Tue,  1 Feb 2022 16:53:11 +0000 (UTC)
Date:   Tue, 1 Feb 2022 16:53:11 +0000
From:   Sean Young <sean@mess.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>
Subject: [PATCH] selftests/ir: fix build with ancient kernel headers
Message-ID: <YflldzHZPVK3OQRJ@gofer.mess.org>
References: <20220128075346.GG8421@xsang-OptiPlex-9020>
 <YfO39Q3mNHMQOkd4@gofer.mess.org>
 <CAADnVQJ3RCPUQ0k9nu2urrRK=U7SUetuPmY0_b17M_PD=j4fkw@mail.gmail.com>
 <e5b72f09-a208-a579-3e51-10935ccee1ff@linuxfoundation.org>
 <YfQqI2ryOYEDuvON@gofer.mess.org>
 <347bae9f-f775-4976-3d27-b0c725211d78@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <347bae9f-f775-4976-3d27-b0c725211d78@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit e2bcbd7769ee ("tools headers UAPI: remove stale lirc.h"),
the build of the selftests fails on rhel 8 since its version of
/usr/include/linux/lirc.h has no definition of RC_PROTO_RCMM32 etc.

Fixes: e2bcbd7769ee ("tools headers UAPI: remove stale lirc.h")

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Sean Young <sean@mess.org>
---
 tools/testing/selftests/ir/ir_loopback.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/ir/ir_loopback.c b/tools/testing/selftests/ir/ir_loopback.c
index 06256c96df12..8dc104690adc 100644
--- a/tools/testing/selftests/ir/ir_loopback.c
+++ b/tools/testing/selftests/ir/ir_loopback.c
@@ -29,6 +29,13 @@
 #define SYSFS_PATH_MAX 256
 #define DNAME_PATH_MAX 256
 
+/* Support ancient lirc.h which does not have these values */
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

