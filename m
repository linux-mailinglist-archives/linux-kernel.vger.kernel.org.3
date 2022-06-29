Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035375607C2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiF2Rv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiF2Rv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:51:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396DB1901E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:51:24 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TGvGv1025924;
        Wed, 29 Jun 2022 17:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=vBUcMt5cqEV7cz/TSthtdULowgi4k+W8CQo7rfLqebo=;
 b=Eq0sZBQPustl16esBJAhTdTrSV08N3Wm0wGaSKWORDZdZTxm05DRkc4UDIcqjUHZmZfO
 4ZKo+W8VX877eu5aE1oJIUBgY8ZK/6TFpLdQtwn34x8ce+16SwFjumC/MOqY+EtKNcsb
 QTrrtj7O2z5swF0Y3tl1cI2XcLjF6K/ReyQrlST2fplyS67PGc65ep5Hg76yjE9IplrU
 rBfOHyxsxE1syyunOH0FKxuaRp7k8yiYnUHW400+r/Wzs/YM341b40qx1APq3g94LM/G
 6MwOxoLvD2emz0IpgdZX6CNKHcsv7usSfr8Bt/mlvQDNwZT+WQ8pPDRtH5h1Xlf0Rudf iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h0tg31xwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 17:51:16 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25THK9kZ025518;
        Wed, 29 Jun 2022 17:51:16 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h0tg31xw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 17:51:16 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25THanFT009607;
        Wed, 29 Jun 2022 17:51:14 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02wdc.us.ibm.com with ESMTP id 3gwt0a1s6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 17:51:14 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25THpEAK39518712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 17:51:14 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72EE3AC05F;
        Wed, 29 Jun 2022 17:51:14 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AAFFAC05B;
        Wed, 29 Jun 2022 17:51:14 +0000 (GMT)
Received: from localhost (unknown [9.211.129.69])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Jun 2022 17:51:14 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, npiggin@gmail.com,
        brking@linux.ibm.com, srikar@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/smp: poll cpu_callin_map more aggressively in
 __cpu_up()
In-Reply-To: <87wncz3jzu.fsf@mpe.ellerman.id.au>
References: <20220125072103.70715-1-nathanl@linux.ibm.com>
 <87wncz3jzu.fsf@mpe.ellerman.id.au>
Date:   Wed, 29 Jun 2022 12:51:13 -0500
Message-ID: <87letfmk8e.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nKw5FiMra3Ixu7c9WT61jhRFZakowdmI
X-Proofpoint-GUID: M4YNkMBvAt8IExSKdOh5ZcuvBNUv3xJa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-29_18,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=543
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:

> Nathan Lynch <nathanl@linux.ibm.com> writes:
>> Replace the outdated iteration and timeout calculations here with
>> indefinite spin_until_cond()-wrapped poll of cpu_callin_map. __cpu_up()
>> already does this when waiting for the cpu to set its online bit before
>> returning, so this change is not really making the function more brittle.
>
> I'm not sure I agree that this doesn't make the code more brittle.
>
> The existing indefinite wait you mention is later in the function, and
> happens after the CPU has successfully come into the kernel.
>
> I think it's more common that a stuck/borked CPU doesn't come into the
> kernel at all, rather than comes in and then fails to online.
>
> So I think the bail out when the CPU fails to call in is useful, I would
> guess I see that "Processor x is stuck" message multiple times a year
> while debugging various things.

Yeah I can see how my claim is too strong here.

>> Removing the msleep(1) in the hotplug path here reduces the time it takes
>> to online a CPU on a P9 PowerVM LPAR from about 30ms to 1ms when exercised
>> via thaw_secondary_cpus().
>
> That is a nice improvement.
>
> Can we do something that returns quickly in the happy case and still has
> a timeout when things go wrong? Seems like a busy loop with a
> time_after() check would do the trick.

Yes, I'll rework it like that. Thanks.
