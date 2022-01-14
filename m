Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98C148ED75
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243006AbiANPzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:55:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60222 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235921AbiANPzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642175709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QtQSgpJb3DK7aVXzgJquUD2DLEoSd7wlHYUWL4mzSZU=;
        b=PZmuZvp1/hcvngUNydy3v+v2Ny1PXAKC3T38Hgf5pqF5p/hPXHO8CRcqZcx7SBFReh/sFU
        nVuSdO1gn3QoS5xYA2UxhA+9Qe35JgPHW//s3N3wRd2HfE8vWsO290Qt+OqZkTAfV5VKMy
        eygXB5ItJvHy2YPkSG5Ug6ufd1M41/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-aXejuWnFNkWw69d-tkmL7A-1; Fri, 14 Jan 2022 10:55:06 -0500
X-MC-Unique: aXejuWnFNkWw69d-tkmL7A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4A201015DA0;
        Fri, 14 Jan 2022 15:55:03 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB3117745F;
        Fri, 14 Jan 2022 15:54:53 +0000 (UTC)
Date:   Fri, 14 Jan 2022 23:54:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+4f789823c1abc5accf13@syzkaller.appspotmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        quic_neeraju@quicinc.com, frederic@kernel.org, urezki@gmail.com,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [syzbot] KASAN: use-after-free Read in srcu_invoke_callbacks
Message-ID: <YeGcyNUhYV4upRKB@T590>
References: <00000000000081b56205d54c6667@google.com>
 <20220111134324.1727-1-hdanton@sina.com>
 <20220111190500.GG947480@paulmck-ThinkPad-P17-Gen-1>
 <YeGK8gUziDoa/IYL@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeGK8gUziDoa/IYL@boqun-archlinux>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 10:38:42PM +0800, Boqun Feng wrote:
> Hi,
> 
> On Tue, Jan 11, 2022 at 11:05:00AM -0800, Paul E. McKenney wrote:
> [...]
> > > > The buggy address belongs to the object at ffff8880189b5c70
> > > >  which belongs to the cache request_queue_srcu of size 3816
> 
> This cache name drew my attention when I was trying to look into this,
> because I couldn't find it in v5.16, later on I realized the UAF was
> found in linux-next and the commit introducing the cache was merged into
> mainline if 5.17 merge window:
> 
> 	704b914f15fb blk-mq: move srcu from blk_mq_hw_ctx to request_queue
> 
> I think the UAF is actually a bug introduced by the commit, because in
> that commit srcu structure was moved from blk_mq_hw_ctx to
> request_queue, and therefore the cleanup_srcu_struct() should be moved
> from blk_mq_hw_sysfs_release() to blk_release_queue(), however the above
> commit only deleted the one in blk_mq_hw_sysfs_release() but didn't add
> a new one in blk_release_queue(). As a result when a request queue is
> freed, the srcu structure is not fully clean up, therefore the UAF.
> 
> IOW, something like below (untested) should fix this. Copy the auther
> and block maintainers.
> 
> Regards,
> Boqun
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index e20eadfcf5c8..10f59416376e 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -812,6 +812,10 @@ static void blk_release_queue(struct kobject *kobj)
>         bioset_exit(&q->bio_split);
> 
>         ida_simple_remove(&blk_queue_ida, q->id);
> +
> +       if (test_bit(QUEUE_FLAG_HAS_SRCU, &q->queue_flags)) {
> +               cleanup_srcu_struct(q->srcu);
> +       }
>         call_rcu(&q->rcu_head, blk_free_queue_rcu);
>  }

Yes, this fix has been posted days ago:

https://lore.kernel.org/linux-block/20220111123401.520192-1-ming.lei@redhat.com/T/#u


Thanks,
Ming

