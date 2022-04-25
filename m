Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A87750DD05
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiDYJqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbiDYJq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:46:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA1D31934;
        Mon, 25 Apr 2022 02:43:25 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P8nCYO006745;
        Mon, 25 Apr 2022 09:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=K8Jnw31biFIMgBgXbX6gl5Fy26TlM7gij2fRmRCiJ+M=;
 b=ANHIszcNfoMF4N2cjKjDjPo9Sep5SZo4AWCX0frB2c8EqOby2bc8OQEo0euyHx90ffys
 Xi7dlySVUE5yhzs7ZxVpgvAnan9z9EAUfJCp+mbSO5odIj+HY0YqtwoeW3aIATR9M3HK
 YrqMIegYxtxY5VnAwan2+UaRhbTtdeA9cs/2ijUvJB+MR0Ujtlx7oMN0djJCxN9Qmteb
 3KPofQeAJvv54y1EluaGimkNklJ+A5q/F/6OT/4pD2jidV2YHsMrxv2Cnpo/Vm4TP5vO
 ilLPdHilDNFe4ZzGf0Fv7xCLfU9vjAnZXUtyu4TBCmAfIivtIImpnxwbR6HbKUvDgnjE Kw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fmtrtdfk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 09:43:10 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23P9RHS9026836;
        Mon, 25 Apr 2022 09:43:08 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3fm8qj25ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 09:43:08 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23P9h5jr47251918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 09:43:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A395A4054;
        Mon, 25 Apr 2022 09:43:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AC72A405C;
        Mon, 25 Apr 2022 09:43:04 +0000 (GMT)
Received: from osiris (unknown [9.145.60.82])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Apr 2022 09:43:04 +0000 (GMT)
Date:   Mon, 25 Apr 2022 11:43:03 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v6 02/17] s390: define get_cycles macro for arch-override
Message-ID: <YmZtJz4tsP6hr2H5@osiris>
References: <20220423212623.1957011-1-Jason@zx2c4.com>
 <20220423212623.1957011-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423212623.1957011-3-Jason@zx2c4.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: harGT_T1jSG4dfqmDdc7LN6q8f1D0Ueh
X-Proofpoint-ORIG-GUID: harGT_T1jSG4dfqmDdc7LN6q8f1D0Ueh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_06,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=792 priorityscore=1501 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250042
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 11:26:08PM +0200, Jason A. Donenfeld wrote:
> S390x defines a get_cycles() function, but it forgot to do the usual
> `#define get_cycles get_cycles` dance, making it impossible for generic
> code to see if an arch-specific function was defined.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/s390/include/asm/timex.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
> index 2cfce42aa7fc..ce878e85b6e4 100644
> --- a/arch/s390/include/asm/timex.h
> +++ b/arch/s390/include/asm/timex.h
> @@ -197,6 +197,7 @@ static inline cycles_t get_cycles(void)
>  {
>  	return (cycles_t) get_tod_clock() >> 2;
>  }
> +#define get_cycles get_cycles

As far as I can tell this doesn't change anything, since the
asm-generic timex.h header file is not included/used at all on s390
(and if it would, this would have resulted in a compile error).

FWIW, the compiled code also tells me that the s390 specific
get_cycles() version is already used.

Is any of your subsequent patches making sure that the asm generic
header file gets included everywhere? Otherwise I don't see the point
of this patch.
