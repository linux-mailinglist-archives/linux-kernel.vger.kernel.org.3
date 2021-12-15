Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE8B4751A2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 05:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbhLOEdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 23:33:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230148AbhLOEdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 23:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639542826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TyEQ8cbyTEdVdLipvb0X7qHPQ22yL+x3zPzmDty6IIw=;
        b=dSHCtqGBY+gfHPllYzFATzk8oJbRFj/lOz6CwFww+vypoNV/EupM3xfWp1L2gm0lscXCyn
        bz4UwmZQqNbsQf51I+x6tMkcPi3LvqRWPfSL0E8rePE9kbg5kW62zLw/zW8j0jnV7Lfudw
        XS9rEyoJZV/xvn2yJTNOWE/tPsqXRsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-mI69tE7NOAObGe1VmJKymg-1; Tue, 14 Dec 2021 23:33:42 -0500
X-MC-Unique: mI69tE7NOAObGe1VmJKymg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C6211853028;
        Wed, 15 Dec 2021 04:33:41 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9501C2AA91;
        Wed, 15 Dec 2021 04:33:33 +0000 (UTC)
Date:   Wed, 15 Dec 2021 12:33:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
Cc:     tglx@linutronix.de, hch@lst.de, kbusch@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH] irq: consider cpus on nodes are unbalanced
Message-ID: <YblwGHAom8qkq4PW@T590>
References: <878rxdl55u.ffs@tglx>
 <20211215015711.28188-1-yamamoto.rei@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215015711.28188-1-yamamoto.rei@jp.fujitsu.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 10:57:11AM +0900, Rei Yamamoto wrote:
> On Wed, Nov 24 2021 at 20:33, Thomas Gleixner wrote:
> > Cc'ing a few people who worked on this code.
> >
> >> If cpus on a node are offline at boot time, there are
> >> difference in the number of nodes between when building affinity
> >> masks for present cpus and when building affinity masks for possible
> >> cpus.

There is always difference between the two number of nodes, the 1st is
node number covering present cpus, and the 2nd one is the node number
covering other possible cpus not spread.

>> This patch fixes 2 problems caused by the difference of the

Is there any user visible problem?

> >> number of nodes:
> >>
> >>  - If some unused vectors remain after building masks for present cpus,

We just select a new vector for starting the spread if un-allocated
vectors remains, but the number for allocation is still numvecs. We hope both
present cpus and non-present cpus can be balanced on each vector, so that each
vector may get present cpu allocated.

> >>    remained vectors are assigned for building masks for possible cpus.
> >>    Therefore "numvecs <= nodes" condition must be
> >>    "vecs_to_assign <= nodes_to_assign". Fix this problem by making this
> >>    condition appropriate.
> >>
> >>  - The routine of "numvecs <= nodes" condition can overwrite bits of
> >>    masks for present cpus in building masks for possible cpus. Fix this
> >>    problem by making CPU bits, which is not target, not changing.

'numvecs' is always the total number of vectors for assigning CPUs, if
the number is <= nodes, we just assign interested cpus in the whole
node into each vector until all interested cpus are allocated out.

 
> Do you have any comments?

Not see issues in current way, or can you explain a bit the real
user visible problem in details?

Thanks,
Ming

