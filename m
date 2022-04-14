Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617F35017B7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359445AbiDNPpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357092AbiDNPZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:25:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 187B0F47F4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649948945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bOuiYKp/29n8d96xb4w4281yD5PlXvWzIE+ZYrKmO3I=;
        b=MdBroEDnkmpfKW8/HeD49LRY9u8jrRxfGV4cCnfI4FN1s2wY1RMV5T7cyhKsBiFKobYmd1
        NtG634OgCoDdlTUTzM2PF7A630FUBT41+387ND2FSBoRwcsV1M8tyYU9iA7rgi4oZ8fKzR
        sbPocqTQMurvycYIcYcVnHkO4RGLusw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-ts_GjJCzNpedi50pTfN2Wg-1; Thu, 14 Apr 2022 11:09:02 -0400
X-MC-Unique: ts_GjJCzNpedi50pTfN2Wg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D451800882;
        Thu, 14 Apr 2022 15:09:01 +0000 (UTC)
Received: from turbo.dinechin (unknown [10.39.192.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10AB4C07F51;
        Thu, 14 Apr 2022 15:08:58 +0000 (UTC)
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
Subject: [PATCH 1/3] sched/headers: Fix compilation error with GCC 12
Date:   Thu, 14 Apr 2022 17:08:53 +0200
Message-Id: <20220414150855.2407137-2-dinechin@redhat.com>
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

With gcc version 12.0.1 20220401 (Red Hat 12.0.1-0) (GCC), the following
errors are reported in sched.h when building after `make defconfig`:

|   CC      kernel/sched/core.o
| In file included from kernel/sched/core.c:81:
| kernel/sched/core.c: In function ‘set_rq_online.part.0’:
| kernel/sched/sched.h:2197:52: error: array subscript -1 is outside
|  array bounds of ‘struct sched_class[44343134792571037]’
|  [-Werror=array-bounds]
|  2197 | #define sched_class_lowest  (__begin_sched_classes - 1)
|       |                                                    ^
| kernel/sched/sched.h:2200:41: note: in definition of macro
|  ‘for_class_range’
|  2200 |         for (class = (_from); class != (_to); class--)
|       |                                         ^~~
| kernel/sched/sched.h:2203:53: note: in expansion of macro
|  ‘sched_class_lowest’
|  2203 |for_class_range(class, sched_class_highest, sched_class_lowest)
|       |                                            ^~~~~~~~~~~~~~~~~~
| kernel/sched/core.c:9115:17: note: in expansion of macro
|  ‘for_each_class’
|  9115 |                 for_each_class(class) {
|       |                 ^~~~~~~~~~~~~~
| kernel/sched/sched.h:2193:27: note: at offset -208 into object
|   ‘__begin_sched_classes’ of size [0, 9223372036854775807]
|  2193 | extern struct sched_class __begin_sched_classes[];
|       |                           ^~~~~~~~~~~~~~~~~~~~~
| kernel/sched/core.c: In function ‘set_rq_offline.part.0’:
| kernel/sched/sched.h:2197:52: error: array subscript -1 is outside
|   array bounds of ‘struct sched_class[44343134792571037]’
|   [-Werror=array-bounds]
|  2197 | #define sched_class_lowest  (__begin_sched_classes - 1)
|       |                                                    ^
| kernel/sched/sched.h:2200:41: note: in definition of macro
|  ‘for_class_range’
|  2200 |         for (class = (_from); class != (_to); class--)
|       |                                         ^~~
| kernel/sched/sched.h:2203:53: note: in expansion of macro
|  ‘sched_class_lowest’
|  2203 |for_class_range(class, sched_class_highest, sched_class_lowest)
|       |                                            ^~~~~~~~~~~~~~~~~~
| kernel/sched/core.c:9127:17: note: in expansion of macro
|  ‘for_each_class’
|  9127 |                 for_each_class(class) {
|       |                 ^~~~~~~~~~~~~~
| kernel/sched/sched.h:2193:27: note: at offset -208 into object
|  ‘__begin_sched_classes’ of size [0, 9223372036854775807]
|  2193 | extern struct sched_class __begin_sched_classes[];
|       |                           ^~~~~~~~~~~~~~~~~~~~~
| In function ‘__pick_next_task’,
|     inlined from ‘pick_next_task’ at kernel/sched/core.c:6204:9,
|     inlined from ‘__schedule’ at kernel/sched/core.c:6352:9:
| kernel/sched/sched.h:2197:52: error: array subscript -1 is outside
|  array bounds of ‘struct sched_class[44343134792571037]’
|  [-Werror=array-bounds]
|  2197 | #define sched_class_lowest  (__begin_sched_classes - 1)
|       |                                                    ^
| kernel/sched/sched.h:2200:41: note: in definition of macro
|  ‘for_class_range’
|  2200 |         for (class = (_from); class != (_to); class--)
|       |                                         ^~~
| kernel/sched/sched.h:2203:53: note: in expansion of macro
|  ‘sched_class_lowest’
|  2203 |for_class_range(class, sched_class_highest, sched_class_lowest)
|       |                                            ^~~~~~~~~~~~~~~~~~
| kernel/sched/core.c:5711:9: note: in expansion of macro
|  ‘for_each_class’
|  5711 |         for_each_class(class) {
|       |         ^~~~~~~~~~~~~~
| kernel/sched/sched.h: In function ‘__schedule’:
| kernel/sched/sched.h:2193:27: note: at offset -208 into object
|  ‘__begin_sched_classes’ of size [0, 9223372036854775807]
|  2193 | extern struct sched_class __begin_sched_classes[];
|       |                           ^~~~~~~~~~~~~~~~~~~~~
| cc1: all warnings being treated as errors

Rewrite the definitions of sched_class_highest and for_class_range to
avoid this error as follows:

1/ The sched_class_highest is rewritten to be relative to
  __begin_sched_classes, so that GCC sees it as being part of the
  __begin_sched_classes array and not a distinct __end_sched_classes
  array.

2/ The for_class_range macro is modified to replace the comparison with
  an out-of-bound pointer __begin_sched_classes - 1 with an equivalent,
  but in-bounds comparison.

In that specific case, I believe that the GCC analysis is correct and
potentially valuable for other arrays, so it makes sense to keep it
enabled.

Signed-off-by: Christophe de Dinechin <christophe@dinechin.org>
Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
---
 kernel/sched/sched.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8dccb34eb190..6350fbc7418d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2193,11 +2193,18 @@ const struct sched_class name##_sched_class \
 extern struct sched_class __begin_sched_classes[];
 extern struct sched_class __end_sched_classes[];
 
-#define sched_class_highest (__end_sched_classes - 1)
+/*
+ * sched_class_highests is really __end_sched_classes - 1, but written in a way
+ * that makes it clear that it is within __begin_sched_classes[] and not outside
+ * of __end_sched_classes[].
+ */
+#define sched_class_highest (__begin_sched_classes + \
+			     (__end_sched_classes - __begin_sched_classes - 1))
 #define sched_class_lowest  (__begin_sched_classes - 1)
 
+/* The + 1 below places the pointers within the range of their array */
 #define for_class_range(class, _from, _to) \
-	for (class = (_from); class != (_to); class--)
+	for (class = (_from); class + 1 != (_to) + 1; class--)
 
 #define for_each_class(class) \
 	for_class_range(class, sched_class_highest, sched_class_lowest)
-- 
2.35.1

