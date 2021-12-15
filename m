Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A784750F0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 03:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbhLOCVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 21:21:19 -0500
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253]:21284 "EHLO
        esa8.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234824AbhLOCVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 21:21:18 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Dec 2021 21:21:18 EST
IronPort-SDR: y9Y4djH2ydE9Zo1JtGq0TLNEN86meSkWNXPAiikKhfyc87YJsOZnm7Ho4UDcliWxg1tiT9eC8U
 VHknRg0fuUcTiswS9/EjKviSvaZ6Hc/bo8/geatjGl0Jk1PJpHsiiAoj7RXqWS1ZJpGKwBFLrU
 WegXkMzbkpYmitIfAE6FrsiCb3WUMJtJq63fO9q4mNmZSYU/5ivEsr90riX0aeMAeWgV/b+jJo
 mL6nnJ5nCY8urQ/iC6mwhK/ErJMkDHDF487m4yxjjqX3V+vJ3VP7tbuzpKLMLRWRyz3p2daX7t
 NouAZRvv8iTghRTpSJSrvHme
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="44319798"
X-IronPort-AV: E=Sophos;i="5.88,207,1635174000"; 
   d="scan'208";a="44319798"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 15 Dec 2021 11:14:08 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 24A5EE07EC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:14:08 +0900 (JST)
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 5F8F5D9989
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:14:07 +0900 (JST)
Received: from localhost.localdomain (unknown [10.125.5.220])
        by m3050.s.css.fujitsu.com (Postfix) with ESMTP id 1F67EB1;
        Wed, 15 Dec 2021 11:14:07 +0900 (JST)
From:   Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
To:     tglx@linutronix.de
Cc:     hch@lst.de, kbusch@kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, ming.lei@redhat.com, yamamoto.rei@jp.fujitsu.com
Subject: Re: [PATCH] irq: consider cpus on nodes are unbalanced
Date:   Wed, 15 Dec 2021 10:57:11 +0900
Message-Id: <20211215015711.28188-1-yamamoto.rei@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <878rxdl55u.ffs@tglx>
References: <878rxdl55u.ffs@tglx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24 2021 at 20:33, Thomas Gleixner wrote:
> Cc'ing a few people who worked on this code.
>
>> If cpus on a node are offline at boot time, there are
>> difference in the number of nodes between when building affinity
>> masks for present cpus and when building affinity masks for possible
>> cpus. This patch fixes 2 problems caused by the difference of the
>> number of nodes:
>>
>>  - If some unused vectors remain after building masks for present cpus,
>>    remained vectors are assigned for building masks for possible cpus.
>>    Therefore "numvecs <= nodes" condition must be
>>    "vecs_to_assign <= nodes_to_assign". Fix this problem by making this
>>    condition appropriate.
>>
>>  - The routine of "numvecs <= nodes" condition can overwrite bits of
>>    masks for present cpus in building masks for possible cpus. Fix this
>>    problem by making CPU bits, which is not target, not changing.
>>
>> Signed-off-by: Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
>> ---
>>  kernel/irq/affinity.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
>> index f7ff8919dc9b..1cdf89e5e2fb 100644
>> --- a/kernel/irq/affinity.c
>> +++ b/kernel/irq/affinity.c
>> @@ -267,10 +267,16 @@ static int __irq_build_affinity_masks(unsigned int startvec,
>>  	 * If the number of nodes in the mask is greater than or equal the
>>  	 * number of vectors we just spread the vectors across the nodes.
>>  	 */
>> -	if (numvecs <= nodes) {
>> +	if (numvecs - (curvec - firstvec) <= nodes) {
>>  		for_each_node_mask(n, nodemsk) {
>> +			unsigned int ncpus;
>> +
>> +			cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
>> +			ncpus = cpumask_weight(nmsk);
>> +			if (!ncpus)
>> +				continue;
>>  			cpumask_or(&masks[curvec].mask, &masks[curvec].mask,
>> -				   node_to_cpumask[n]);
>> +				   nmsk);
>>  			if (++curvec == last_affv)
>>  				curvec = firstvec;
>>  		}

Do you have any comments?

Rei
