Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069A94EB9D9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 07:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242706AbiC3FGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 01:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbiC3FGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:06:43 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Mar 2022 22:04:57 PDT
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C30865D19
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 22:04:57 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="55896281"
X-IronPort-AV: E=Sophos;i="5.90,221,1643641200"; 
   d="scan'208";a="55896281"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 30 Mar 2022 14:03:51 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id EFFDDC68A5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:03:50 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id CC64CFD51C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:03:49 +0900 (JST)
Received: from localhost.localdomain (unknown [10.125.5.220])
        by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 5703E2026105;
        Wed, 30 Mar 2022 14:03:49 +0900 (JST)
From:   Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        yamamoto.rei@jp.fujitsu.com
Subject: Re: [PATCH v3] irq: consider cpus on nodes are unbalanced
Date:   Wed, 30 Mar 2022 13:42:54 +0900
Message-Id: <20220330044254.15712-1-yamamoto.rei@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <YgSQKvv7rL6MFPRr@T590>
References: <YgSQKvv7rL6MFPRr@T590>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 12:10:18PM +0800, Ming Lei wrote:
> On Thu, Feb 10, 2022 at 12:10:53PM +0900, Rei Yamamoto wrote:
>> If cpus on a node are offline at boot time, there are
>> difference in the number of nodes between when building affinity
>> masks for present cpus and when building affinity masks for possible
>> cpus. This patch fixes a problem caused by the difference of the
>> number of nodes:
>> 
>>  - The routine of "numvecs <= nodes" condition can overwrite bits of
>>    masks for present cpus in building masks for possible cpus. Fix this
>>    problem by making CPU bits, which is not target, not changing.
>> 
>> Signed-off-by: Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
>> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>> ---
>>  kernel/irq/affinity.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
>> index f7ff8919dc9b..d2d01565d2ec 100644
>> --- a/kernel/irq/affinity.c
>> +++ b/kernel/irq/affinity.c
>> @@ -269,8 +269,9 @@ static int __irq_build_affinity_masks(unsigned int startvec,
>>  	 */
>>  	if (numvecs <= nodes) {
>>  		for_each_node_mask(n, nodemsk) {
>> +			cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
>>  			cpumask_or(&masks[curvec].mask, &masks[curvec].mask,
>> -				   node_to_cpumask[n]);
>> +				   nmsk);
>>  			if (++curvec == last_affv)
>>  				curvec = firstvec;
>>  		}
>> -- 
>> 2.27.0
>>
> -- 
> Ming

Could you pick this patch up?

Thanks,
Rei
