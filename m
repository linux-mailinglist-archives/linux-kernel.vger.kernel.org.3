Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E488147854E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 07:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhLQG5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 01:57:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233522AbhLQG5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 01:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639724263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BRyUvlgriFfVhUWoEhlyazY2tNDfMhuv5Yt1ZmF/oJo=;
        b=dxx5SYzZxqPR3uGgkG7aNRbrAIz6V180/60mOpEnm5xcEtgrmQWMmwYvnPik8Gd68FgmJW
        duFS+6X9Ek/tR9HAr1NJXy3RArOuAijrPc9uouwEITmHWRJJs8kXfsjpZrPWcrce5LknbW
        PxDR+nUtCrCmfL7zT1Gm2KYATASxoBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-p4flwmoGMPWr-5SO9T_XrQ-1; Fri, 17 Dec 2021 01:57:40 -0500
X-MC-Unique: p4flwmoGMPWr-5SO9T_XrQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8739718B62A6;
        Fri, 17 Dec 2021 06:57:38 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC87410694EA;
        Fri, 17 Dec 2021 06:57:17 +0000 (UTC)
Date:   Fri, 17 Dec 2021 14:57:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
Cc:     hch@lst.de, kbusch@kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] irq: consider cpus on nodes are unbalanced
Message-ID: <Ybw0yPhi01lro7m2@T590>
References: <YblwGHAom8qkq4PW@T590>
 <20211217024805.303738-1-yamamoto.rei@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217024805.303738-1-yamamoto.rei@jp.fujitsu.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 11:48:05AM +0900, Rei Yamamoto wrote:
> On Wed, Dec 15, 2021 at 12:33, Ming Lei wrote:
> >> >> If cpus on a node are offline at boot time, there are
> >> >> difference in the number of nodes between when building affinity
> >> >> masks for present cpus and when building affinity masks for possible
> >> >> cpus.
> >
> > There is always difference between the two number of nodes, the 1st is
> > node number covering present cpus, and the 2nd one is the node number
> > covering other possible cpus not spread.
> 
> In this case, building affinity masks for possible cpus would change even
> the affinity mask bits for present cpus in the "if (numvecs <= nodes)" route.
> This is the second problem I mentioned.
> I will explain about the actual case later.
> 
> >
> >>> This patch fixes 2 problems caused by the difference of the
> >
> > Is there any user visible problem?
> 
> The panic occured in lpfc driver.
> 
> >
> >> >> number of nodes:
> >> >>
> >> >>  - If some unused vectors remain after building masks for present cpus,
> >
> > We just select a new vector for starting the spread if un-allocated
> > vectors remains, but the number for allocation is still numvecs. We hope both
> > present cpus and non-present cpus can be balanced on each vector, so that each
> > vector may get present cpu allocated.
> 
> I understood.
> I withdraw the first problem I mentioned.
> 
> >
> >> >>    remained vectors are assigned for building masks for possible cpus.
> >> >>    Therefore "numvecs <= nodes" condition must be
> >> >>    "vecs_to_assign <= nodes_to_assign". Fix this problem by making this
> >> >>    condition appropriate.
> >> >>
> >> >>  - The routine of "numvecs <= nodes" condition can overwrite bits of
> >> >>    masks for present cpus in building masks for possible cpus. Fix this
> >> >>    problem by making CPU bits, which is not target, not changing.
> >
> > 'numvecs' is always the total number of vectors for assigning CPUs, if
> > the number is <= nodes, we just assign interested cpus in the whole
> > node into each vector until all interested cpus are allocated out.
> >
> >
> >> Do you have any comments?
> >
> > Not see issues in current way, or can you explain a bit the real
> > user visible problem in details?
> 
> I experienced a panic occurred in lpfc driver with broken affinity masks.
> 
> The system had the following configuration:
> -----
> node num: cpu num
> Node #0: #0 #1 (#4 #8 #12)
> Node #1: #2 #3 (#5 #9 #13)
> Node #2: (#6 #10 #14)
> Node #3: (#7 #11 #15)
> 
> Number of CPUs: 16
> Present CPU: cpu0, cpu1, cpu2, cpu3
> Number of nodes covering present cpus: 2
> Number of nodes covering possible cpus: 4
> Number of vectors: 4
> -----
> 
> Due to the configuration above, cpumask_var_t *node_to_cpumask was as follows:
> -----
> node_to_cpumask[0] = 0x1113
> node_to_cpumask[1] = 0x222c
> node_to_cpumask[2] = 0x4440
> node_to_cpumask[3] = 0x8880
> -----
> 
> As the result of assigning vertors for present cpus, masks[].mask were as follows:
> -----
> masks[vec1].mask = 0x0004
> masks[vec2].mask = 0x0008
> masks[vec3].mask = 0x0001
> masks[vec4].mask = 0x0002
> -----
> 
> As the result of assigning vertors for possible cpus, masks[].mask were as follows:
> -----
> masks[vec1].mask = 0x1117
> masks[vec2].mask = 0x222c
> masks[vec3].mask = 0x4441
> masks[vec4].mask = 0x8882
> -----
> 
> The problem I encountered was that multiple vectors were assigned for
> a single present cpu unexpectedly.
> For example, vec1 and vec3 were assigned to cpu0.
> Due to this mask, the panic occured in lpfc driver.

OK, I can understand the issue now, and only the following part is enough
since nmsk won't be empty:


diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index f7ff8919dc9b..d2d01565d2ec 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -269,8 +269,9 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 	 */
 	if (numvecs <= nodes) {
 		for_each_node_mask(n, nodemsk) {
+			cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
 			cpumask_or(&masks[curvec].mask, &masks[curvec].mask,
-				   node_to_cpumask[n]);
+				   nmsk);
 			if (++curvec == last_affv)
 				curvec = firstvec;
 		}

Thanks,
Ming

