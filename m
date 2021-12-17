Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7AC478387
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 04:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbhLQDMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 22:12:10 -0500
Received: from esa4.hc1455-7.c3s2.iphmx.com ([68.232.139.117]:60722 "EHLO
        esa4.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229502AbhLQDMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 22:12:09 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Dec 2021 22:12:09 EST
IronPort-SDR: 59TowkBCUmJNWadjxsLUfHEz9ngB2k1R2x8KkxAOkddNhzVRLcXSJjZtuSL1mqwHijJ35HCFS8
 uy4QUvwe2NpiUmHj2pJImAHVge9OB6Kk9KSuyPR9EhReEQ52Iws5s2LC7bz0kR4nTlqQqv6tDG
 JD3CikWcnhvEEWX95FbAYUKhKSWbGj4U80yFpOc1oiJTJwoUcCVnEJosQMsoykHmDXel2q87MI
 Wv00MO6q9fGZ4yfkVUZblejo4JxHgArpVScPhwntWEYoYQTjFiGu34fx31yTilC4Grq3gnNk7L
 3nc2RAdviTRw5Xc2xscfax8C
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="56486702"
X-IronPort-AV: E=Sophos;i="5.88,213,1635174000"; 
   d="scan'208";a="56486702"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP; 17 Dec 2021 12:04:59 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2BC636CC60
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 12:04:58 +0900 (JST)
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 67763E0F98
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 12:04:57 +0900 (JST)
Received: from localhost.localdomain (unknown [10.125.5.220])
        by m3050.s.css.fujitsu.com (Postfix) with ESMTP id 38AE7A8;
        Fri, 17 Dec 2021 12:04:57 +0900 (JST)
From:   Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
To:     ming.lei@redhat.com
Cc:     hch@lst.de, kbusch@kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, tglx@linutronix.de, yamamoto.rei@jp.fujitsu.com
Subject: Re: [PATCH] irq: consider cpus on nodes are unbalanced
Date:   Fri, 17 Dec 2021 11:48:05 +0900
Message-Id: <20211217024805.303738-1-yamamoto.rei@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <YblwGHAom8qkq4PW@T590>
References: <YblwGHAom8qkq4PW@T590>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 12:33, Ming Lei wrote:
>> >> If cpus on a node are offline at boot time, there are
>> >> difference in the number of nodes between when building affinity
>> >> masks for present cpus and when building affinity masks for possible
>> >> cpus.
>
> There is always difference between the two number of nodes, the 1st is
> node number covering present cpus, and the 2nd one is the node number
> covering other possible cpus not spread.

In this case, building affinity masks for possible cpus would change even
the affinity mask bits for present cpus in the "if (numvecs <= nodes)" route.
This is the second problem I mentioned.
I will explain about the actual case later.

>
>>> This patch fixes 2 problems caused by the difference of the
>
> Is there any user visible problem?

The panic occured in lpfc driver.

>
>> >> number of nodes:
>> >>
>> >>  - If some unused vectors remain after building masks for present cpus,
>
> We just select a new vector for starting the spread if un-allocated
> vectors remains, but the number for allocation is still numvecs. We hope both
> present cpus and non-present cpus can be balanced on each vector, so that each
> vector may get present cpu allocated.

I understood.
I withdraw the first problem I mentioned.

>
>> >>    remained vectors are assigned for building masks for possible cpus.
>> >>    Therefore "numvecs <= nodes" condition must be
>> >>    "vecs_to_assign <= nodes_to_assign". Fix this problem by making this
>> >>    condition appropriate.
>> >>
>> >>  - The routine of "numvecs <= nodes" condition can overwrite bits of
>> >>    masks for present cpus in building masks for possible cpus. Fix this
>> >>    problem by making CPU bits, which is not target, not changing.
>
> 'numvecs' is always the total number of vectors for assigning CPUs, if
> the number is <= nodes, we just assign interested cpus in the whole
> node into each vector until all interested cpus are allocated out.
>
>
>> Do you have any comments?
>
> Not see issues in current way, or can you explain a bit the real
> user visible problem in details?

I experienced a panic occurred in lpfc driver with broken affinity masks.

The system had the following configuration:
-----
node num: cpu num
Node #0: #0 #1 (#4 #8 #12)
Node #1: #2 #3 (#5 #9 #13)
Node #2: (#6 #10 #14)
Node #3: (#7 #11 #15)

Number of CPUs: 16
Present CPU: cpu0, cpu1, cpu2, cpu3
Number of nodes covering present cpus: 2
Number of nodes covering possible cpus: 4
Number of vectors: 4
-----

Due to the configuration above, cpumask_var_t *node_to_cpumask was as follows:
-----
node_to_cpumask[0] = 0x1113
node_to_cpumask[1] = 0x222c
node_to_cpumask[2] = 0x4440
node_to_cpumask[3] = 0x8880
-----

As the result of assigning vertors for present cpus, masks[].mask were as follows:
-----
masks[vec1].mask = 0x0004
masks[vec2].mask = 0x0008
masks[vec3].mask = 0x0001
masks[vec4].mask = 0x0002
-----

As the result of assigning vertors for possible cpus, masks[].mask were as follows:
-----
masks[vec1].mask = 0x1117
masks[vec2].mask = 0x222c
masks[vec3].mask = 0x4441
masks[vec4].mask = 0x8882
-----

The problem I encountered was that multiple vectors were assigned for
a single present cpu unexpectedly.
For example, vec1 and vec3 were assigned to cpu0.
Due to this mask, the panic occured in lpfc driver.

>> >>  - The routine of "numvecs <= nodes" condition can overwrite bits of
>> >>    masks for present cpus in building masks for possible cpus. Fix this
>> >>    problem by making CPU bits, which is not target, not changing.

Therefore, if it uses node_to_cpumask, AND is necessary in order not to change
CPU bits of non target.

Thanks,
Rei

