Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71C65017B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359458AbiDNPpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245359AbiDNP0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:26:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD323F55C3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649948947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xO4MPKDVg7yjY/S4cY28pZcVFGEmRz0kvVd69IjqQVk=;
        b=VnnOUcKF7XlG4I1F1nl1qKW2t52fuBc4mg5k16o+PcSbuWheFGcMzA30cUR9T5PIbWygvS
        /zK42tuJUuUOg07iyiqlbtQg4eQFINu56fyP6NbzS8BrG/JdhCWzeC6LZRiHp2/UXDDYIj
        I0N+V06nN3pOc8xnLheb6KWMr6yQmFs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-qPItWNDPNS6znkLVWjh0hQ-1; Thu, 14 Apr 2022 11:09:05 -0400
X-MC-Unique: qPItWNDPNS6znkLVWjh0hQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B4AB296A619;
        Thu, 14 Apr 2022 15:09:04 +0000 (UTC)
Received: from turbo.dinechin (unknown [10.39.192.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD40EC44CCA;
        Thu, 14 Apr 2022 15:09:01 +0000 (UTC)
From:   Christophe de Dinechin <dinechin@redhat.com>
To:     trivial@kernel.org
Cc:     Ben Segall <bsegall@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/3] nodemask.h: Fix compilation error with GCC12
Date:   Thu, 14 Apr 2022 17:08:54 +0200
Message-Id: <20220414150855.2407137-3-dinechin@redhat.com>
In-Reply-To: <20220414150855.2407137-1-dinechin@redhat.com>
References: <20220414150855.2407137-1-dinechin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc version 12.0.1 20220401 (Red Hat 12.0.1-0), building with
defconfig results in the following compilation error:

|   CC      mm/swapfile.o
| mm/swapfile.c: In function ‘setup_swap_info’:
| mm/swapfile.c:2291:47: error: array subscript -1 is below array bounds
|  of ‘struct plist_node[]’ [-Werror=array-bounds]
|  2291 |                                 p->avail_lists[i].prio = 1;
|       |                                 ~~~~~~~~~~~~~~^~~
| In file included from mm/swapfile.c:16:
| ./include/linux/swap.h:292:27: note: while referencing ‘avail_lists’
|   292 |         struct plist_node avail_lists[]; /*
|       |                           ^~~~~~~~~~~

This is due to the compiler detecting that the mask in
node_states[__state] could theoretically be zero, which would lead to
first_node() returning -1 through find_first_bit.

I believe that the warning/error is legitimate. I first tried
adding a test to check that the node mask is not emtpy, since a
similar test exists in the case where MAX_NUMNODES == 1.

However, adding the if statement causes other warnings to appear in
for_each_cpu_node_but, because it introduces a dangling else
ambiguity. And unfortunately, GCC is not smart enough to detect that the
added test makes the case where (node) == -1 impossible, so it still
complains with the same message.

This is why I settled on replacing that with a harmless, but relatively
useless (node) >= 0 test. Based on the warning for the dangling else, I
also decided to fix the case where MAX_NUMNODES == 1 by moving the
condition inside the for loop. It will still only be tested once. This
ensures that the meaning of an else following for_each_node_mask
or derivatives would not silently have a different meaning depending on
the configuration.

Signed-off-by: Christophe de Dinechin <christophe@dinechin.org>
Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
---
 include/linux/nodemask.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 567c3ddba2c4..c6199dbe2591 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -375,14 +375,13 @@ static inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
 }
 
 #if MAX_NUMNODES > 1
-#define for_each_node_mask(node, mask)			\
-	for ((node) = first_node(mask);			\
-		(node) < MAX_NUMNODES;			\
-		(node) = next_node((node), (mask)))
+#define for_each_node_mask(node, mask)				    \
+	for ((node) = first_node(mask);				    \
+	     (node >= 0) && (node) < MAX_NUMNODES;		    \
+	     (node) = next_node((node), (mask)))
 #else /* MAX_NUMNODES == 1 */
-#define for_each_node_mask(node, mask)			\
-	if (!nodes_empty(mask))				\
-		for ((node) = 0; (node) < 1; (node)++)
+#define for_each_node_mask(node, mask)                                  \
+	for ((node) = 0; (node) < 1 && !nodes_empty(mask); (node)++)
 #endif /* MAX_NUMNODES */
 
 /*
-- 
2.35.1

