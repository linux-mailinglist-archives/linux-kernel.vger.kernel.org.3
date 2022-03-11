Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D054D5BE7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347103AbiCKHF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347099AbiCKHFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:05:14 -0500
X-Greylist: delayed 339 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 23:04:02 PST
Received: from forward104o.mail.yandex.net (forward104o.mail.yandex.net [37.140.190.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CC4CD300;
        Thu, 10 Mar 2022 23:04:02 -0800 (PST)
Received: from iva8-4db386e07e2e.qloud-c.yandex.net (iva8-4db386e07e2e.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:951e:0:640:4db3:86e0])
        by forward104o.mail.yandex.net (Yandex) with ESMTP id F01DA65D3543;
        Fri, 11 Mar 2022 09:58:18 +0300 (MSK)
Received: from iva4-b3ebd202b141.qloud-c.yandex.net (iva4-b3ebd202b141.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:b3eb:d202])
        by iva8-4db386e07e2e.qloud-c.yandex.net (mxback/Yandex) with ESMTP id bRRjuwgxmY-wHeaBClW;
        Fri, 11 Mar 2022 09:58:18 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1646981898;
        bh=r8NGPub2yLP8J/GwfOvg8WvFWw+/jFkgoKD0eVjdXgQ=;
        h=Date:Subject:Cc:To:From:Message-Id;
        b=SWX5Kq24ysI5oBLPhKYLAQmqUdAo1o/0t8oesx+AztTuQwfhUgWk4QQ30DwHNNvi8
         Vm5GFni0dqhFkfWfy9cF3oBweSkG/zADmtdlL1sfuIYFFaEttcNjn89wCC7eVK6q8r
         v/SpZ2iYNSnGRUN30ejtk5+pg5xxYHJhXbYc9iTY=
Authentication-Results: iva8-4db386e07e2e.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by iva4-b3ebd202b141.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id QxfEVveCLI-wGKOa0GN;
        Fri, 11 Mar 2022 09:58:16 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     linux@yadro.com, Nikita Shubin <n.shubin@yadro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Mao Han <han_mao@c-sky.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: Fix fill_callchain return value
Date:   Fri, 11 Mar 2022 09:58:15 +0300
Message-Id: <20220311065815.9985-1-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <n.shubin@yadro.com>

perf_callchain_store return 0 on success, -1 otherwise,
fix fill_callchain to return correct bool value.

Fixes: dbeb90b0c1eb ("riscv: Add perf callchain support")
Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
---
 arch/riscv/kernel/perf_callchain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
index 1fc075b8f764..7aca6a238173 100644
--- a/arch/riscv/kernel/perf_callchain.c
+++ b/arch/riscv/kernel/perf_callchain.c
@@ -68,7 +68,7 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 
 static bool fill_callchain(void *entry, unsigned long pc)
 {
-	return perf_callchain_store(entry, pc);
+	return perf_callchain_store(entry, pc) == 0;
 }
 
 void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
-- 
2.34.1

