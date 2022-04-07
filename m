Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A484F86FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346807AbiDGSO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbiDGSOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:14:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6BB82128EF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649355143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=YuAxLAgmvKMBQBwK85qk9slVwH48ebauOcjJTTF6T00=;
        b=c5N5i7Uz7NWztcsOG4GwNvRpfr1hT7FA0Ugwk41r+8zCaW11oCjxDSNqAJEsOHoHndJqDZ
        i6nRbE921YZhdMtdGVYuSfmc/Nmyqo2JTib+6Do9cPnbPpPgV9dj0+6LEvYSr447zGIqsc
        NJZN56OX3UEfUq8QAUqCzMt5CmvW9fc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-MBXjcZLcNGeg6b9Rrjdtzg-1; Thu, 07 Apr 2022 14:12:19 -0400
X-MC-Unique: MBXjcZLcNGeg6b9Rrjdtzg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0088B3C01DB2;
        Thu,  7 Apr 2022 18:12:19 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF009C27E86;
        Thu,  7 Apr 2022 18:12:18 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH] sched/headers: fix redundant include of autogroup.h
Date:   Thu,  7 Apr 2022 14:12:17 -0400
Message-Id: <20220407181217.20487-1-pauld@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
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

In kernel/sched/core.c there are two #include "autogroup.h" lines
in a row. Remove one.

Fixes: e66f6481a8c7 ("Reorganize, clean up and optimize kernel/sched/core.c dependencies")
Signed-off-by: Phil Auld <pauld@redhat.com>
---
 kernel/sched/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d575b4914925..45447fa386e4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -80,8 +80,6 @@
 
 #include "sched.h"
 #include "stats.h"
-#include "autogroup.h"
-
 #include "autogroup.h"
 #include "pelt.h"
 #include "smp.h"
-- 
2.18.0

