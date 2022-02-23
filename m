Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5454C156F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 15:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241598AbiBWOcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 09:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbiBWOcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:32:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 281A5275EE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 06:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645626696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YxLpiB7JcAtWZKh8Bz5fym9bypONvzzglGIYn+ip4xc=;
        b=GFYSuOyjWumNAt/jWyNBtt4b1arX1zrtsleD1/6Rezn4Pm1smbBK5Zwo90yCGOTFGpeMv+
        xeJboKONhahes/XLoH5s9Jf0iDs04NM1Ow3H5b24UHGh1u0y9gcecn1n+jvqHy9WLcoB2R
        dB/zPLl7NQUKITMkmYfEnmMCVhqGsPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245-CrjbTZfqNpG5zC5hgpFv8A-1; Wed, 23 Feb 2022 09:31:31 -0500
X-MC-Unique: CrjbTZfqNpG5zC5hgpFv8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCF882D4;
        Wed, 23 Feb 2022 14:31:29 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4268927CC5;
        Wed, 23 Feb 2022 14:31:07 +0000 (UTC)
Date:   Wed, 23 Feb 2022 22:30:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH RFC] blk-mq: fix potential uaf for 'queue_hw_ctx'
Message-ID: <YhZFITXtiL8Xaord@T590>
References: <20220223112601.2902761-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223112601.2902761-1-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 07:26:01PM +0800, Yu Kuai wrote:
> blk_mq_realloc_hw_ctxs() will free the 'queue_hw_ctx'(e.g. undate
> submit_queues through configfs for null_blk), while it might still be
> used from other context(e.g. switch elevator to none):
> 
> t1					t2
> elevator_switch
>  blk_mq_unquiesce_queue
>   blk_mq_run_hw_queues
>    queue_for_each_hw_ctx
>     // assembly code for hctx = (q)->queue_hw_ctx[i]
>     mov    0x48(%rbp),%rdx -> read old queue_hw_ctx
> 
> 					__blk_mq_update_nr_hw_queues
> 					 blk_mq_realloc_hw_ctxs
> 					  hctxs = q->queue_hw_ctx
> 					  q->queue_hw_ctx = new_hctxs
> 					  kfree(hctxs)
>     movslq %ebx,%rax
>     mov    (%rdx,%rax,8),%rdi ->uaf
> 

Not only uaf on queue_hw_ctx, but also other similar issue on other
structures, and I think the correct and easy fix is to quiesce request
queue during updating nr_hw_queues, something like the following patch:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a05ce7725031..d8e7c3cce0dd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4467,8 +4467,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	if (set->nr_maps == 1 && nr_hw_queues == set->nr_hw_queues)
 		return;
 
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_freeze_queue(q);
+		blk_mq_quiesce_queue(q);
+	}
 	/*
 	 * Switch IO scheduler to 'none', cleaning up the data associated
 	 * with the previous scheduler. We will switch back once we are done
@@ -4518,8 +4520,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_elv_switch_back(&head, q);
 
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		blk_mq_unquiesce_queue(q);
 		blk_mq_unfreeze_queue(q);
+	}
 }
 
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)



Thanks,
Ming

