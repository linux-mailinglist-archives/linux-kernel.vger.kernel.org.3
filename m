Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71598580E60
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbiGZIB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiGZIBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:01:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55172C137;
        Tue, 26 Jul 2022 01:01:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4F8FE1FA4D;
        Tue, 26 Jul 2022 08:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658822483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=dkriu3vkrAZS1wyG+iHdOUg7blF/kske8YRN1wSZz4Q=;
        b=G/TB7gZSJMp3dTlkyX9Ki+p/e4UW389p8OsG2awHmpK2GwdITd8kH6qbhW3bCC3p3nGZj7
        m4lXBtKAtQ+QEtV54gFl1IuQj6k6qQvt20GD1iFjhGUiK+yiCVbGwZni4CbGQlP1Vkdb5y
        AudXZOD8kdpxrmd9z6H25G3miMNiRbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658822483;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=dkriu3vkrAZS1wyG+iHdOUg7blF/kske8YRN1wSZz4Q=;
        b=Je4a71CxVKPiPCsa7bNGifnvDS+87Nu/eTsiZ6MwHT5+hTJayEBGDjr01+VPME59S5OT0p
        eATygcgUODSSFHDw==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id 45EAE2C16E;
        Tue, 26 Jul 2022 08:01:23 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id B9114444B2F; Tue, 26 Jul 2022 10:01:22 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rtla: Define syscall numbers for riscv
X-Yow:  My uncle Murray conquered Egypt in 53 B.C.  And I can prove it too!!
Date:   Tue, 26 Jul 2022 10:01:22 +0200
Message-ID: <mvma68wl2ul.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V uses the same (generic) syscall numbers as ARM64.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 tools/tracing/rtla/src/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 5352167a1e75..147921356e02 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -224,7 +224,7 @@ long parse_ns_duration(char *val)
 #elif __arm__
 # define __NR_sched_setattr	380
 # define __NR_sched_getattr	381
-#elif __aarch64__
+#elif __aarch64__ || __riscv
 # define __NR_sched_setattr	274
 # define __NR_sched_getattr	275
 #elif __powerpc__
-- 
2.37.1


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
