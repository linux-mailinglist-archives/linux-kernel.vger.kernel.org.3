Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DFE4721D5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhLMHia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:38:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50132 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230053AbhLMHi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639381107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a/bulpOGfX7Ol3Co48vHOs47RkeTbU1WRhBnHDiLHQU=;
        b=hHJr435/ex4eHp/uMHRHaykRCMMdC4x8bm8QUdX+opPyBiDDuNFIwS+FqYTytqu3krskgD
        ftVpG6Z8dF+0ek32g+2kT1FmjItenTWVOHS7Ve6GI40+yGqLaEeREiZkQ3wMksma4OO1As
        uHTwXL3McNK5vyElDeRuAKXYAonQZM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-mrNOIbXxNEa1MBVpMLU7NA-1; Mon, 13 Dec 2021 02:38:24 -0500
X-MC-Unique: mrNOIbXxNEa1MBVpMLU7NA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14169344BE;
        Mon, 13 Dec 2021 07:38:23 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4466F610A7;
        Mon, 13 Dec 2021 07:38:11 +0000 (UTC)
Date:   Mon, 13 Dec 2021 15:38:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Jens Axboe <axboe@kernel.dk>, 'Christoph Hellwig' <hch@lst.de>,
        "'linux-block@vger.kernel.org'" <linux-block@vger.kernel.org>,
        Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Random high CPU utilization in blk-mq with the none scheduler
Message-ID: <Ybb4X00rfsjRgHj7@T590>
References: <BYAPR21MB1270C598ED214C0490F47400BF719@BYAPR21MB1270.namprd21.prod.outlook.com>
 <BYAPR21MB1270DCE17A0FE017AF3272F1BF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <b80bfe9a-bece-1f32-3d2a-fb4d94b1fa8c@kernel.dk>
 <BYAPR21MB1270B5DAD526C42C070ECB9EBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <Yba8nL4x9R6rmTYL@T590>
 <BYAPR21MB127006555030F7BFA47FDAABBF749@BYAPR21MB1270.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB127006555030F7BFA47FDAABBF749@BYAPR21MB1270.namprd21.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 04:20:49AM +0000, Dexuan Cui wrote:
> > From: Ming Lei <ming.lei@redhat.com>
> >  ...
> > Can you provide the following blk-mq debugfs log?
> > 
> > (cd /sys/kernel/debug/block/dm-N && find . -type f -exec grep -aH . {} \;)
> > 
> > (cd /sys/kernel/debug/block/sdN && find . -type f -exec grep -aH . {} \;)
> > 
> > And it is enough to just collect log from one dm-mpath & one underlying iscsi
> > disk,
> > so we can understand basic blk-mq setting, such as nr_hw_queues, queue
> > depths, ...
> > 
> > Thanks,
> > Ming
> 
> Attached. I collected the logs for all the dm-* and sd* devices against
> v5.16-rc4 with the 3 commits reverted:
> b22809092c70 ("block: replace always false argument with 'false'")
> ff1552232b36 ("blk-mq: don't issue request directly in case that current is to be blocked")
> dc5fc361d891 ("block: attempt direct issue of plug list")
> 
> v5.16-rc4 does not reproduce the issue, so I'm pretty sure b22809092c70 is the
> patch that resolves the excessive CPU usage.

From the log:

1) dm-mpath:
- queue depth: 2048
- busy: 848, and 62 of them are in sw queue, so run queue is often
  caused
- nr_hw_queues: 1
- dm-2 is in use, and dm-1/dm-3 is idle
- dm-2's dispatch busy is 8, that should be the reason why excessive CPU
usage is observed when flushing plug list without commit dc5fc361d891 in
which hctx->dispatch_busy is just bypassed

2) iscsi
- dispatch_busy is 0
- nr_hw_queues: 1
- queue depth: 113
- busy=~33, active_queues is 3, so each LUN/iscsi host is saturated
- 23 active LUNs, 23 * 33 = 759 in-flight commands

The high CPU utilization may be caused by:

1) big queue depth of dm mpath, the situation may be improved much if it
is reduced to 1024 or 800. The max allowed inflight commands from iscsi
hosts can be figured out, if dm's queue depth is much more than this number,
the extra commands need to dispatch, and run queue can be scheduled
immediately, so high CPU utilization is caused.

2) single hw queue, so contention should be big, which should be avoided
in big machine, nvme-tcp might be better than iscsi here

3) iscsi io latency is a bit big

Even CPU utilization is reduced by commit dc5fc361d891, io performance
can't be good too with v5.16-rc, I guess.


Thanks,
Ming

