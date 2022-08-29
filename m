Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCEC5A41A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 06:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiH2EAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 00:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiH2EA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 00:00:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BD065D9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 21:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661745626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eQVsuwgc8uXKILvzGyvbWtTjg/syLvD78qexD18++Io=;
        b=PIRfcD3CHsVCDSBzRWxHcDU5vN1iyTwFwPyyVgkR398kTs3H6oPOmtSHeI+EQrgmsTHUQw
        Rp6x29lO/91CTUICEPzEaKilAsbtyXOccq6Kl4mDxhKl+HnUGKhw/K3WVFD4WS/+bRtB7G
        nd9RGJwTxR2YwK83nAVhnQGpkFdNsfg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-MGX3IdgNPZqK4dLJHzLY1A-1; Mon, 29 Aug 2022 00:00:21 -0400
X-MC-Unique: MGX3IdgNPZqK4dLJHzLY1A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4935185A7B2;
        Mon, 29 Aug 2022 04:00:20 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0001E1121314;
        Mon, 29 Aug 2022 04:00:19 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] kernel: export task_work_add
Date:   Mon, 29 Aug 2022 12:00:13 +0800
Message-Id: <20220829040013.549212-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly task_work_add() is used in several drivers. In ublk driver's
usage, request batching submission can only be applied with task_work_add,
and usually get better IOPS.

Secondly from this API's definition, the added work is always run in
the task context, and when task is exiting, either the work is rejected
to be added, or drained in do_exit(). In this way, not see obvious
disadvantage or potential issue by exporting it for module's usage.

So export it, then ublk driver can get simplified, meantime with better
performance.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/task_work.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/task_work.c b/kernel/task_work.c
index dff75bcde151..5f9a42a388f1 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -73,6 +73,7 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(task_work_add);
 
 /**
  * task_work_cancel_match - cancel a pending work added by task_work_add()
-- 
2.31.1

