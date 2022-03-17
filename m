Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344214DC801
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbiCQN5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiCQN5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:57:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10EBE1042B2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 06:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647525344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=3qWgFKPuWbwkNXZxQSeQl0sRheg0mQTqRVZcOh+jo7o=;
        b=HlkCqTj8Sbwj/AFCZKt8cmnYDT56YI7ue494fWqs/FEq6k9SqlOJD8tmxL7MJIEVTLZ3Qf
        u1Xix47dYBaRjNg+YayLqV2adSjJV1k+2XirjszUTbwYDAYz5Ui6SvUmJB6Z9HEcAa4AW/
        w/RklRWibuMTs+rdrN3wdNL1vDdddRs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-Y7cZe7tNMCy7UxgEWPzCHQ-1; Thu, 17 Mar 2022 09:55:40 -0400
X-MC-Unique: Y7cZe7tNMCy7UxgEWPzCHQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50D341044563;
        Thu, 17 Mar 2022 13:55:40 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 810822011571;
        Thu, 17 Mar 2022 13:55:38 +0000 (UTC)
From:   Michael Petlan <mpetlan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        jolsa@kernel.org, atrajeev@linux.vnet.ibm.com, maddy@linux.ibm.com,
        kjain@linux.ibm.com
Subject: [PATCH] perf symbols: Fix symbol size calculation condition
Date:   Thu, 17 Mar 2022 14:55:36 +0100
Message-Id: <20220317135536.805-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this patch, the symbol end address fixup to be called, needed two
conditions being met:

  if (prev->end == prev->start && prev->end != curr->start)

Where
  "prev->end == prev->start" means that prev is zero-long
                             (and thus needs a fixup)
and
  "prev->end != curr->start" means that fixup hasn't been applied yet

However, this logic is incorrect in the following situation:

*curr  = {rb_node = {__rb_parent_color = 278218928,
  rb_right = 0x0, rb_left = 0x0},
  start = 0xc000000000062354,
  end = 0xc000000000062354, namelen = 40, type = 2 '\002',
  binding = 0 '\000', idle = 0 '\000', ignore = 0 '\000',
  inlined = 0 '\000', arch_sym = 0 '\000', annotate2 = false,
  name = 0x1159739e "kprobe_optinsn_page\t[__builtin__kprobes]"}

*prev = {rb_node = {__rb_parent_color = 278219041,
  rb_right = 0x109548b0, rb_left = 0x109547c0},
  start = 0xc000000000062354,
  end = 0xc000000000062354, namelen = 12, type = 2 '\002',
  binding = 1 '\001', idle = 0 '\000', ignore = 0 '\000',
  inlined = 0 '\000', arch_sym = 0 '\000', annotate2 = false,
  name = 0x1095486e "optinsn_slot"}

In this case, prev->start == prev->end == curr->start == curr->end,
thus the condition above thinks that "we need a fixup due to zero
length of prev symbol, but it has been probably done, since the
prev->end == curr->start", which is wrong.

After the patch, the execution path proceeds to arch__symbols__fixup_end
function which fixes up the size of prev symbol by adding page_size to
its end offset.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/util/symbol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index fb075aa8f8f2..dea0fc495185 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -231,7 +231,7 @@ void symbols__fixup_end(struct rb_root_cached *symbols)
 		prev = curr;
 		curr = rb_entry(nd, struct symbol, rb_node);
 
-		if (prev->end == prev->start && prev->end != curr->start)
+		if (prev->end == prev->start || prev->end != curr->start)
 			arch__symbols__fixup_end(prev, curr);
 	}
 
-- 
2.18.4

