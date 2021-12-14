Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68644739D4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 01:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244573AbhLNAyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:54:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35705 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242836AbhLNAxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639443234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fq9s0r164LWy02TJ0Ub018+SzHlr28SqOgtzWxq+oV4=;
        b=BifMK2XU+t2hZQq6ZeVB3dNHRoaGj8Pm+OGTlHJvcD7ArpAmCjNb0Txy9itgBuqpM9cvch
        OKxxozA07RPllJB1SVIJi2SNUkfkaRjxl+jLAs5AkW46zAhYTGIc67IkHYG5iIFKrETSN4
        j7B5Do++AtovQSC52KvPbKzCsbMkwNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-XzTfXDBKOjW5cHPDf_ur3Q-1; Mon, 13 Dec 2021 19:53:51 -0500
X-MC-Unique: XzTfXDBKOjW5cHPDf_ur3Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F515593A8;
        Tue, 14 Dec 2021 00:53:49 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 91D791007607;
        Tue, 14 Dec 2021 00:53:31 +0000 (UTC)
Date:   Tue, 14 Dec 2021 08:53:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Jens Axboe <axboe@kernel.dk>, 'Christoph Hellwig' <hch@lst.de>,
        "'linux-block@vger.kernel.org'" <linux-block@vger.kernel.org>,
        Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Subject: Re: Random high CPU utilization in blk-mq with the none scheduler
Message-ID: <YbfrBpcV4hasdqQB@T590>
References: <BYAPR21MB1270C598ED214C0490F47400BF719@BYAPR21MB1270.namprd21.prod.outlook.com>
 <BYAPR21MB1270DCE17A0FE017AF3272F1BF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <b80bfe9a-bece-1f32-3d2a-fb4d94b1fa8c@kernel.dk>
 <BYAPR21MB1270B5DAD526C42C070ECB9EBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <Yba8nL4x9R6rmTYL@T590>
 <BYAPR21MB127006555030F7BFA47FDAABBF749@BYAPR21MB1270.namprd21.prod.outlook.com>
 <Ybb4X00rfsjRgHj7@T590>
 <BYAPR21MB12706DCD5ED9FC7AB3EE2EEABF759@BYAPR21MB1270.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB12706DCD5ED9FC7AB3EE2EEABF759@BYAPR21MB1270.namprd21.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 12:31:23AM +0000, Dexuan Cui wrote:
> > From: Ming Lei <ming.lei@redhat.com>
> > Sent: Sunday, December 12, 2021 11:38 PM
> 
> Ming, thanks so much for the detailed analysis!
> 
> > From the log:
> > 
> > 1) dm-mpath:
> > - queue depth: 2048
> > - busy: 848, and 62 of them are in sw queue, so run queue is often
> >   caused
> > - nr_hw_queues: 1
> > - dm-2 is in use, and dm-1/dm-3 is idle
> > - dm-2's dispatch busy is 8, that should be the reason why excessive CPU
> > usage is observed when flushing plug list without commit dc5fc361d891 in
> > which hctx->dispatch_busy is just bypassed
> > 
> > 2) iscsi
> > - dispatch_busy is 0
> > - nr_hw_queues: 1
> > - queue depth: 113
> > - busy=~33, active_queues is 3, so each LUN/iscsi host is saturated
> > - 23 active LUNs, 23 * 33 = 759 in-flight commands
> > 
> > The high CPU utilization may be caused by:
> > 
> > 1) big queue depth of dm mpath, the situation may be improved much if it
> > is reduced to 1024 or 800. The max allowed inflight commands from iscsi
> > hosts can be figured out, if dm's queue depth is much more than this number,
> > the extra commands need to dispatch, and run queue can be scheduled
> > immediately, so high CPU utilization is caused.
> 
> I think you're correct:
> with dm_mod.dm_mq_queue_depth=256, the max CPU utilization is 8%.
> with dm_mod.dm_mq_queue_depth=400, the max CPU utilization is 12%. 
> with dm_mod.dm_mq_queue_depth=800, the max CPU utilization is 88%.
> 
> The performance with queue_depth=800 is poor.
> The performance with queue_depth=400 is good.
> The performance with queue_depth=256 is also good, and there is only a 
> small drop comared with the 400 case.

That should be the reason why the issue isn't triggered in case of real
io scheduler.

So far blk-mq doesn't provide way to adjust tags queue depth
dynamically.

But not understand reason of default dm_mq_queue_depth(2048), in this
situation, each LUN can just queue 113/3 requests at most, and 3 LUNs
are attached to single iscsi host.

Mike, can you share why the default dm_mq_queue_depth is so big? And
seems it doesn't consider the underlying queue's queue depth. What is
the biggest dm rq queue depth? which need to saturate all underlying paths?

> 
> > 2) single hw queue, so contention should be big, which should be avoided
> > in big machine, nvme-tcp might be better than iscsi here
> > 
> > 3) iscsi io latency is a bit big
> > 
> > Even CPU utilization is reduced by commit dc5fc361d891, io performance
> > can't be good too with v5.16-rc, I guess.
> > 
> > Thanks,
> > Ming
> 
> Actually the I/O performance of v5.16-rc4 (commit dc5fc361d891 is included)
> is good -- it's about the same as the case where v5.16-rc4 + reverting
> dc5fc361d891 + dm_mod.dm_mq_queue_depth=400 (or 256).

The single hw queue may be the root cause of your issue, and there
is only single run_work, which can be touched by all CPUs(~200) almost, so cache
ping-pong could be very serious. 

Jens patch may improve it more or less, please test it.

Thanks,
Ming

