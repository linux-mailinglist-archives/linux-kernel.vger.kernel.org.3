Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174525503F9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 12:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiFRKMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 06:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiFRKMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 06:12:16 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F088289A4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 03:12:14 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655547132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6gCORpqIn3d/NBPvqVW659+3N0QQIoiOoDBkotO/tDk=;
        b=LCuBUhKLE1O8m4Fu/5J7OHhoDHaCH/lqwFAvXpwH3Ony44hPrWZaEjeA31MnKrOvfe72r2
        okE9w01POYggNBCmKbLpiEf/aTVODRoEdwZN0tNBpQxjUrrVvZWD98SMpLEQNk0aeEQcId
        pbbmCuGorFFqV1ZqFcsExbc+tLUazdM=
From:   Fanjun Kong <fanjun.kong@linux.dev>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Fanjun Kong <fanjun.kong@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm: declare static variable inside a function instead of global
Date:   Sat, 18 Jun 2022 18:11:34 +0800
Message-Id: <20220618101134.3073210-1-fanjun.kong@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Global variables are global capacity variables, unless they are
shadowed, they are available to the entire program.
To reduce the scope of a variable as much as possible is always good
practice.

Signed-off-by: Fanjun Kong <fanjun.kong@linux.dev>
---
 arch/x86/mm/init_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 39c5246964a9..582eab896480 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1515,9 +1515,10 @@ static unsigned long probe_memory_block_size(void)
 	return bz;
 }
 
-static unsigned long memory_block_size_probed;
 unsigned long memory_block_size_bytes(void)
 {
+	static unsigned long memory_block_size_probed;
+
 	if (!memory_block_size_probed)
 		memory_block_size_probed = probe_memory_block_size();
 
-- 
2.36.0

