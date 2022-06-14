Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A2054AAB1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354523AbiFNHbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348432AbiFNHbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A97B43E0F0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655191891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2u1UJeCG+WneWifdMmrdhoGBRpopTVWJT/OvMvoPDO4=;
        b=OxsNwEpQMg4rmbYxtiFLgaj75lcu9bASiLGCx1TrU0RMfK0njgcmovH1QsJXaWAi1uMFWb
        HG4eWlsL0t+DJjhsnbe5bpxC8HnPYyVL3aVO0dzpidjlV7gzhg76wFWQITW9r9Jx3aHNAm
        EE5VwFuD7xzKP35c0fzQuDV1U2sh93k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-4ZXueI-ENXCFF3VJOXoeCA-1; Tue, 14 Jun 2022 03:31:27 -0400
X-MC-Unique: 4ZXueI-ENXCFF3VJOXoeCA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9828101A54E;
        Tue, 14 Jun 2022 07:31:26 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A581E40EC003;
        Tue, 14 Jun 2022 07:31:20 +0000 (UTC)
Date:   Tue, 14 Jun 2022 15:31:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, djeffery@redhat.com, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, ming.lei@redhat.com
Subject: Re: [PATCH -next] blk-mq: fix boot time regression for scsi drives
 with multiple hctx
Message-ID: <Yqg5QxSM+lub8DY0@T590>
References: <20220614071410.3571204-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614071410.3571204-1-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 03:14:10PM +0800, Yu Kuai wrote:
> We found that boot time is increased for about 8s after upgrading kernel
> from v4.19 to v5.10(megaraid-sas is used in the environment).

But 'blk-mq: clearing flush request reference in tags->rqs[]' was merged
to v5.14, :-)

> 
> Following is where the extra time is spent:
> 
> scsi_probe_and_add_lun
>  __scsi_remove_device
>   blk_cleanup_queue
>    blk_mq_exit_queue
>     blk_mq_exit_hw_queues
>      blk_mq_exit_hctx
>       blk_mq_clear_flush_rq_mapping -> function latency is 0.1ms

So queue_depth looks pretty long, is it 4k?

But if it is 0.1ms, how can the 8sec delay be caused? That requires 80K hw queues
for making so long, so I guess there must be other delay added by the feature
of BLK_MQ_F_TAG_HCTX_SHARED.

>        cmpxchg
> 
> There are three reasons:
> 1) megaraid-sas is using multiple hctxs in v5.10, thus blk_mq_exit_hctx()
> will be called much more times in v5.10 compared to v4.19.
> 2) scsi will scan for each target thus __scsi_remove_device() will be
> called for many times.
> 3) blk_mq_clear_flush_rq_mapping() is introduced after v4.19, it will
> call cmpxchg() for each request, and function latency is abount 0.1ms.
> 
> Since that blk_mq_clear_flush_rq_mapping() will only be called while the
> queue is freezed already, which means there is no inflight request,
> it's safe to set NULL for 'tags->rqs[]' directly instead of using
> cmpxchg(). Tests show that with this change, function latency of
> blk_mq_clear_flush_rq_mapping() is about 1us, and boot time is not
> increased.

tags is shared among all LUNs attached to the host, so freezing single
request queue here means nothing, so your patch doesn't work.

Please test the following patch, and see if it can improve boot delay for
your case.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e9bf950983c7..1463076a527c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3443,8 +3443,9 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 	if (blk_mq_hw_queue_mapped(hctx))
 		blk_mq_tag_idle(hctx);
 
-	blk_mq_clear_flush_rq_mapping(set->tags[hctx_idx],
-			set->queue_depth, flush_rq);
+	if (blk_queue_init_done(q))
+		blk_mq_clear_flush_rq_mapping(set->tags[hctx_idx],
+				set->queue_depth, flush_rq);
 	if (set->ops->exit_request)
 		set->ops->exit_request(set, flush_rq, hctx_idx);
 


Thanks,
Ming

