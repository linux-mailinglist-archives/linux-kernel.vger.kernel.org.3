Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97F94A7983
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347192AbiBBUda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:33:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236170AbiBBUd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643834007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FSCcYBtevS72h8Rb3ThNAKipb4CG2TPJPslkwwiiaHA=;
        b=AuaLnb3nI3m6rnKaIrAec0KUsS8Kl5H00zJvM0RfuoOOMQkas2vacutx3NdMbvoAwT74n2
        4u5AGyoYveZpwM64gf2rHuwSgtcGGo7Tu1dCCKbY3LB/anz3ZadW8stLWyf7lE4FltgMY6
        N7RL+SYtIDE9ZWN4PJLft5Y0OTOFJME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-CsfU89KkOJ6_0-acPHmVUQ-1; Wed, 02 Feb 2022 15:33:22 -0500
X-MC-Unique: CsfU89KkOJ6_0-acPHmVUQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0445100C661;
        Wed,  2 Feb 2022 20:33:19 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36C3512E30;
        Wed,  2 Feb 2022 20:32:44 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 1/4] lib/vsprintf: Avoid redundant work with 0 size
Date:   Wed,  2 Feb 2022 15:30:33 -0500
Message-Id: <20220202203036.744010-2-longman@redhat.com>
In-Reply-To: <20220131192308.608837-5-longman@redhat.com>
References: <20220131192308.608837-5-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For *scnprintf(), vsnprintf() is always called even if the input size is
0. That is a waste of time, so just return 0 in this case.

Note that vsnprintf() will never return -1 to indicate an error. So
skipping the call to vsnprintf() when size is 0 will have no functional
impact at all.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: David Rientjes <rientjes@google.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Roman Gushchin <guro@fb.com>
---
 lib/vsprintf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3b8129dd374c..d419154b47bb 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2895,13 +2895,15 @@ int vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
 {
 	int i;
 
+	if (unlikely(!size))
+		return 0;
+
 	i = vsnprintf(buf, size, fmt, args);
 
 	if (likely(i < size))
 		return i;
-	if (size != 0)
-		return size - 1;
-	return 0;
+
+	return size - 1;
 }
 EXPORT_SYMBOL(vscnprintf);
 
-- 
2.27.0

