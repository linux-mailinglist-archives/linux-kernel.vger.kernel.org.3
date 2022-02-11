Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23604B1EDC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243439AbiBKGzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:55:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiBKGzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:55:12 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA8590;
        Thu, 10 Feb 2022 22:55:12 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21B37k96026940;
        Fri, 11 Feb 2022 06:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=1HNoqDtdFPwseRAcprLdH23GDKxQDrNO8ZT4p90mUJY=;
 b=oE+FXeQW4ojGQl0Iknt3/qkPcwbotF6CEcWRGbrp17sOb57DjatWNX2dV9mRz/jhlOR1
 iwdS6WddVnMpnmM4/I7dQKcLKA37uo3tmaAGp6epdfUL9AnjLdFMMxskiivLcFvpwmCh
 T2YW3RRAFtEmZ55YoCwRUXeTB7X91js/s6Fnfezh0S9lnKuUn/09aoAXYbV/myr8MOFd
 vdCUwneS4xRO23/hFPYD0+0ggxYpz71+AcOA0Y/SHJYB7AsyZB3ohmZ0OODwq9OFvhLx
 63+Wi5F6al8zyQ3Fc5YgQP4VEKScQqot4S6NeeyN4f3AEPL9g58gDXcdcQ9sf2/lzfFS Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e58vtafnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 06:54:34 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21B6jAq7031607;
        Fri, 11 Feb 2022 06:54:33 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e58vtafnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 06:54:33 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21B6mI8t021117;
        Fri, 11 Feb 2022 06:54:30 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3e1gv9y2pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 06:54:30 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21B6sRYx44106010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 06:54:27 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84C9FAE059;
        Fri, 11 Feb 2022 06:54:27 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3A89AE045;
        Fri, 11 Feb 2022 06:54:26 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 11 Feb 2022 06:54:26 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 39/49] arch/s390: replace cpumask_weight with
 cpumask_weight_eq where appropriate
References: <20220210224933.379149-1-yury.norov@gmail.com>
        <20220210224933.379149-40-yury.norov@gmail.com>
Date:   Fri, 11 Feb 2022 07:54:26 +0100
In-Reply-To: <20220210224933.379149-40-yury.norov@gmail.com> (Yury Norov's
        message of "Thu, 10 Feb 2022 14:49:23 -0800")
Message-ID: <yt9dwni17v19.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3N1G7wcx1M61lioOOIiUVg4ncVMW3cht
X-Proofpoint-ORIG-GUID: eKNbmJzDJ7hnuvtlQPxzmEOCmCVATr1Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_02,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 adultscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 impostorscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110036
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yury,

Yury Norov <yury.norov@gmail.com> writes:

> cfset_all_start() calls cpumask_weight() to compare the weight of cpumask
> with a given number. We can do it more efficiently with
> cpumask_weight_{eq, ...} because conditional cpumask_weight may stop
> traversing the cpumask earlier, as soon as condition is (or can't be) met.
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/s390/kernel/perf_cpum_cf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
> index ee8707abdb6a..4d217f7f5ccf 100644
> --- a/arch/s390/kernel/perf_cpum_cf.c
> +++ b/arch/s390/kernel/perf_cpum_cf.c
> @@ -975,7 +975,7 @@ static int cfset_all_start(struct cfset_request *req)
>  		return -ENOMEM;
>  	cpumask_and(mask, &req->mask, cpu_online_mask);
>  	on_each_cpu_mask(mask, cfset_ioctl_on, &p, 1);
> -	if (atomic_read(&p.cpus_ack) != cpumask_weight(mask)) {
> +	if (!cpumask_weight_eq(mask, atomic_read(&p.cpus_ack))) {
>  		on_each_cpu_mask(mask, cfset_ioctl_off, &p, 1);
>  		rc = -EIO;
>  		debug_sprintf_event(cf_dbg, 4, "%s CPUs missing", __func__);

given that you're adding a bunch of these functions - gt,lt,eq and
others, i wonder whether it makes sense to also add cpumask_weight_ne(),
so one could just write:

if (cpumask_weight_ne(mask, atomic_read(&p.cpus_ack))) {
	...
}

?

/Sven
