Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7464C48ED82
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbiANP6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:58:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32721 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235921AbiANP6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642175926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uZ14TVzFHCECx2/NyTysZQWNrSdUQMA6ifi8dj0u3MY=;
        b=OfG4I78QoXP9N4toFKjevh+R2CoDebkLRaIlf7bBj9UP84YwoXglBeWl81clxUlpAMDXXi
        SiQ1AQ0azPi4sriLYpnCBM8K729Uf1Bo6ers62yxImBOUdWfPqqqQ1YCGgHCSM/qWopfNE
        OjiZvSAuschKzaL+esjHu8n0/sJtbg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-UnoLiFXwPFuxfx4oQqg4NQ-1; Fri, 14 Jan 2022 10:58:41 -0500
X-MC-Unique: UnoLiFXwPFuxfx4oQqg4NQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04FDD18C8C02;
        Fri, 14 Jan 2022 15:58:39 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6EA78588C;
        Fri, 14 Jan 2022 15:58:29 +0000 (UTC)
Date:   Fri, 14 Jan 2022 23:58:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+4f789823c1abc5accf13@syzkaller.appspotmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        quic_neeraju@quicinc.com, frederic@kernel.org, urezki@gmail.com,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [syzbot] KASAN: use-after-free Read in srcu_invoke_callbacks
Message-ID: <YeGdoAFYGhg3viPZ@T590>
References: <00000000000081b56205d54c6667@google.com>
 <20220111134324.1727-1-hdanton@sina.com>
 <20220111190500.GG947480@paulmck-ThinkPad-P17-Gen-1>
 <YeGK8gUziDoa/IYL@boqun-archlinux>
 <20220114152752.GU947480@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114152752.GU947480@paulmck-ThinkPad-P17-Gen-1>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 07:27:52AM -0800, Paul E. McKenney wrote:
> On Fri, Jan 14, 2022 at 10:38:42PM +0800, Boqun Feng wrote:
> > Hi,
> > 
> > On Tue, Jan 11, 2022 at 11:05:00AM -0800, Paul E. McKenney wrote:
> > [...]
> > > > > The buggy address belongs to the object at ffff8880189b5c70
> > > > >  which belongs to the cache request_queue_srcu of size 3816
> > 
> > This cache name drew my attention when I was trying to look into this,
> > because I couldn't find it in v5.16, later on I realized the UAF was
> > found in linux-next and the commit introducing the cache was merged into
> > mainline if 5.17 merge window:
> > 
> > 	704b914f15fb blk-mq: move srcu from blk_mq_hw_ctx to request_queue
> > 
> > I think the UAF is actually a bug introduced by the commit, because in
> > that commit srcu structure was moved from blk_mq_hw_ctx to
> > request_queue, and therefore the cleanup_srcu_struct() should be moved
> > from blk_mq_hw_sysfs_release() to blk_release_queue(), however the above
> > commit only deleted the one in blk_mq_hw_sysfs_release() but didn't add
> > a new one in blk_release_queue(). As a result when a request queue is
> > freed, the srcu structure is not fully clean up, therefore the UAF.
> > 
> > IOW, something like below (untested) should fix this. Copy the auther
> > and block maintainers.
> 
> One question for the author and block maintainers...  Why not simply have
> a single srcu_struct for all of the queues?  Or is there some situation
> where you need one queue's reader to avoid blocking other queues' SRCU
> grace periods?

Because srcu_struct is too fat, and only few drivers need it, and
most block drivers needn't it.


Thanks,
Ming

