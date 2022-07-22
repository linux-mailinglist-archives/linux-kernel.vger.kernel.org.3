Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AC157E148
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbiGVMHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbiGVMHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:07:33 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC43BDA3E;
        Fri, 22 Jul 2022 05:07:32 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MBGsuu020972;
        Fri, 22 Jul 2022 12:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=o+BTY/uCMLQWXsj6/f4TbfVVZ0qdoDBQEnzK950VUC0=;
 b=IQD7FPF3gcg6KE7gIU6/9u9ZFLMf0cC3DH4vM5/231C859/xzYN5gZtrBfDiCqvB2dJn
 AtZaTkHXGxaQNBI4sC6VllYWQ4bNLpjMQ6LKe2mN0M1Pbujyz80vVVmCj8cQ9J4dL6iz
 P6CzMVccjkwt71XG45cOKBpwm1vrF+zEd1/F+xmjesufYtKz+ZAucdCd9ih5co1wZNl3
 97F1pCMH0Lg03Uv2evsVQY2W2qz/XJg7Z+SplprJe9oBhcSzWowsuFzRnaD6Nav0usRg
 j6keLppQqCzCAZnsoKgihu97++4k6/PXgDDlapctZM947l1jCAuHmx58LPdlf7lsSfwX fQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hftvr9f8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 12:07:05 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26MBr9xZ010882;
        Fri, 22 Jul 2022 12:07:03 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3hbmkj885a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 12:07:03 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26MC70SL23790004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 12:07:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7582242049;
        Fri, 22 Jul 2022 12:07:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8AE442041;
        Fri, 22 Jul 2022 12:06:59 +0000 (GMT)
Received: from osiris (unknown [9.145.178.215])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 22 Jul 2022 12:06:59 +0000 (GMT)
Date:   Fri, 22 Jul 2022 14:06:58 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        x86@kernel.org, Will Deacon <will@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Holger Dengler <dengler@linux.ibm.com>
Subject: Re: [PATCH v3] random: handle archrandom with multiple longs
Message-ID: <YtqS4mEVdhyAI8Ri@osiris>
References: <CAHmME9qTA90=GEr6h1GZh0CjS+6tpe5uuqkYoJVv79h0zd0w1w@mail.gmail.com>
 <20220719130207.147536-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719130207.147536-1-Jason@zx2c4.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BYpjYolDJC7Jn9NzSuNRht8fsbIWP_U-
X-Proofpoint-ORIG-GUID: BYpjYolDJC7Jn9NzSuNRht8fsbIWP_U-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_03,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=571 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207220051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 03:02:07PM +0200, Jason A. Donenfeld wrote:
> The archrandom interface was originally designed for x86, which supplies
> RDRAND/RDSEED for receiving random words into registers, resulting in
> one function to generate an int and another to generate a long. However,
> other architectures don't follow this.
> 
> On arm64, the SMCCC TRNG interface can return between 1 and 3 longs. On
> s390, the CPACF TRNG interface can return arbitrary amounts, with 32
> longs having the same cost as one. On UML, the os_getrandom() interface
> can return arbitrary amounts.
> 
> So change the api signature to take a "max_longs" parameter designating
> the maximum number of longs requested, and then return the number of
> longs generated.
> 
> Since callers need to check this return value and loop anyway, each arch
> implementation does not bother implementing its own loop to try again to
> fill the maximum number of longs. Additionally, all existing callers
> pass in a constant max_longs parameter. Taken together, these two things
> mean that the codegen doesn't really change much for one-word-at-a-time
> platforms, while performance is greatly improved on platforms such as
> s390.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/arm64/include/asm/archrandom.h   | 102 ++++++++++++--------------
>  arch/arm64/kernel/kaslr.c             |   2 +-
>  arch/powerpc/include/asm/archrandom.h |  30 ++------
>  arch/powerpc/kvm/book3s_hv.c          |   2 +-
>  arch/s390/include/asm/archrandom.h    |  29 ++------
>  arch/um/include/asm/archrandom.h      |  21 ++----
>  arch/x86/include/asm/archrandom.h     |  41 +----------
>  arch/x86/kernel/espfix_64.c           |   2 +-
>  drivers/char/random.c                 |  45 ++++++++----
>  include/asm-generic/archrandom.h      |  18 +----
>  include/linux/random.h                |  12 +--
>  11 files changed, 116 insertions(+), 188 deletions(-)

For s390:
Acked-by: Heiko Carstens <hca@linux.ibm.com>
