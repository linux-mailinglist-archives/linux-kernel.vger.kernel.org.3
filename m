Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D8F5A426E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 07:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiH2Fky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 01:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiH2Fkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 01:40:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A591EC6C
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 22:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661751649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iz9zXvjgdHtOHJ+rhuZ0Ot2g9+9/tXgRAndQOhZ7YQM=;
        b=XWrsFMPi3YoeTr4ESSXQa/khOUf+j9LNhia5i32TFzdk9WDNg9JJykvg/tJ0TMygXGHV/B
        h5eS5A9brTVkMaysE+yynyBQtLWqkzE2NJHbQzumiZHOEHsT5hPlHSDxoDpcv/cbB0WjFm
        ulFC14N8bjSky4keqXbfXhRg27n+JDc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-xpyIpT0FNU6hmUOgv1UQWA-1; Mon, 29 Aug 2022 01:40:44 -0400
X-MC-Unique: xpyIpT0FNU6hmUOgv1UQWA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB057101A54E;
        Mon, 29 Aug 2022 05:40:43 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7505E492C3B;
        Mon, 29 Aug 2022 05:40:39 +0000 (UTC)
Date:   Mon, 29 Aug 2022 13:40:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, ming.lei@redhat.com
Subject: Re: [RFC PATCH 4/9] ublk_drv: refactor __ublk_rq_task_work() and
 aborting machenism
Message-ID: <YwxRVEQlIw3oWmwE@T590>
References: <20220824054744.77812-1-ZiyangZhang@linux.alibaba.com>
 <20220824054744.77812-5-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824054744.77812-5-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 01:47:39PM +0800, ZiyangZhang wrote:
> If one rq is handled by io_uring_cmd_complete_in_task(), after a crash
> this rq is actually handled by an io_uring fallback wq. We have to
> end(abort) this rq since this fallback wq is a task other than the
> crashed task. However, current code does not call io_uring_cmd_done()
> at the same time but do it in ublk_cancel_queue(). With current design,
> this does work because ublk_cancel_queue() is called AFTER del_gendisk(),
> which waits for the rq ended(aborted) in fallback wq. This implies that
> fallback wq on this rq is scheduled BEFORE calling io_uring_cmd_done()
> on the corresponding ioucmd in ublk_cancel_queue().

Right.

> 
> However, while considering recovery feature, we cannot rely on
> del_gendisk() or blk_mq_freeze_queue() to wait for completion of all
> rqs because we may not want any aborted rq. Besides, io_uring does not
> provide "flush fallback" machenism so we cannot trace this ioucmd.

Why not?

If user recovery is enabled, del_gendisk() can be replaced with
blk_mq_quiesce_queue(), then let abort work function do:

- cancel all in-flight requests by holding them into requeue list
  instead of finishing them as before, and this way is safe because
  abort worker does know the ubq daemon is dying
- cancel pending commands as before, because the situation is same
  with disk deleted or queue frozen

With this way, the current abort logic won't be changed much.

And user recovery should only be started _after_ ublk device is found
as aborted.

> 
> The recovery machenism needs to complete all ioucmds of a dying ubq
> to avoid leaking io_uring ctx. But as talked above, we are unsafe
> to call io_uring_cmd_done() in the recovery task if fallback wq happens
> to run simultaneously. This is a UAF case because io_uring ctx may be
> freed. Actually a similar case happens in
> (5804987b7272f437299011c76b7363b8df6f8515: ublk_drv: do not add a
> re-issued request aborted previously to ioucmd's task_work).

If you take the above approach, I guess there isn't such problem because
abort can handle the case well as before.

> 
> Besides, in order to implement recovery machenism, in ublk_queue_rq()
> and __ublk_rq_task_work(), we should not end(abort) current rq while
> ubq_daemon is dying.

Right, I believe one helper of ublk_abort_request() is helpful here.


Thanks, 
Ming

