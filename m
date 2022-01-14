Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C649B48E27E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 03:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238830AbiANCWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 21:22:18 -0500
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137]:26747 "EHLO
        esa11.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229863AbiANCWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 21:22:18 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Jan 2022 21:22:17 EST
IronPort-SDR: 3LdSUnYvd/bET1wZtDG+Z44AIEfSAAcXmtcJJPDVw5toGq2gvja7t0rm/xVSfUPxJ/whlz7JTn
 1SAKUY27/7EER52ztRZ90uoID/6eQFujnZMeDBm3X6oex+YCEg/N+/ELZZ3jaG3zWjs0AA7nYl
 zmn7lTrEgQMwun8qPTf+FNf1yh3xyxCIQLmCX3WBdWWPnXJbySDhUU5oJ9GGo1noyXreRfDXBg
 2iKI9Gl9QfXB/OGF+hnOOw7aGTsjDIF1etBoPN2Z8Hw3YIPTwR31JyQ+XLD8aQY4Jy9HOhh/jP
 eVhFNtVVh4SzFkKKGjyKTNYU
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="38714703"
X-IronPort-AV: E=Sophos;i="5.88,287,1635174000"; 
   d="scan'208";a="38714703"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 14 Jan 2022 11:15:07 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7BB866DAE6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 11:15:06 +0900 (JST)
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com [10.134.21.209])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7B8CED506B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 11:15:05 +0900 (JST)
Received: from localhost.localdomain (unknown [10.125.5.220])
        by m3051.s.css.fujitsu.com (Postfix) with ESMTP id 4FF6291;
        Fri, 14 Jan 2022 11:15:05 +0900 (JST)
From:   Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
To:     tglx@linutronix.de
Cc:     hch@lst.de, kbusch@kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, ming.lei@redhat.com, yamamoto.rei@jp.fujitsu.com
Subject: Re: [PATCH v2] irq: consider cpus on nodes are unbalanced
Date:   Fri, 14 Jan 2022 10:58:30 +0900
Message-Id: <20220114015830.369730-1-yamamoto.rei@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <Ybx8zqja/UoCzVO3@T590>
References: <Ybx8zqja/UoCzVO3@T590>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 20:04, Ming Lei wrote:
> On Fri, Dec 17, 2021 at 07:44:07PM +0900, Rei Yamamoto wrote:
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
>
> Looks fine,
>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thank you for your review.
Does anyone else have a comment?

Thanks,
Rei

