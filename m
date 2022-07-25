Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F2E57FE68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 13:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiGYLdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 07:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiGYLdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 07:33:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B8318B39
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:33:43 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PAgR6j032574;
        Mon, 25 Jul 2022 11:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=7WCUXtSGuqab5cIedvDULa3PGYJm6zL4h98hCb3CfKA=;
 b=Oz+bbCDk6NFlnul/tHwPd5YNwYYMlBVykkMTEjFadL0uhkV4X50vw1Qr7jLcEv3gYkYh
 w1As0XAr0MWEv5BTHqV0kHUANvvIjklcDJ9rCXXtG4iHrmNXOAMUDSUTspxNyloDLHpi
 a+DJYQTEJFk8WrCE1pRz8Ic6YfTLE4O3RMVk5MPZkajV9RP2gRLZHVAVuMZthn7BQggA
 zfkeTN4t+aZ7WKq0qBfGGOzqzkVcu2M7Hg9nWu9JPqgM+J3VlHY7Jc3NiKDceXupKgcz
 xWNw2BySENqiOC8cwNgS+sRimEsfuyz/cD+qoYRGUO5kNF/FKa8m5q0DyyVGtgSr0OZ9 bA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hhsnb1gg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 11:33:31 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26PBK6I5031738;
        Mon, 25 Jul 2022 11:33:29 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3hg94e9rpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 11:33:28 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26PBXQpq22348280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 11:33:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC2E8A404D;
        Mon, 25 Jul 2022 11:33:26 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AA46A4040;
        Mon, 25 Jul 2022 11:33:26 +0000 (GMT)
Received: from osiris (unknown [9.145.162.40])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Jul 2022 11:33:26 +0000 (GMT)
Date:   Mon, 25 Jul 2022 13:33:25 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] random: discourage use of archrandom outside of rng
Message-ID: <Yt5/hRD3V0eSzDWb@osiris>
References: <Yt5hwxC1xgvA8Asw@zx2c4.com>
 <20220725111038.720624-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725111038.720624-1-Jason@zx2c4.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kQcFvVqED34ITViZ6DVvsn9EHyuZ0wUa
X-Proofpoint-GUID: kQcFvVqED34ITViZ6DVvsn9EHyuZ0wUa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_09,2022-07-25_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=90 phishscore=0 adultscore=0
 mlxscore=90 mlxlogscore=-92 spamscore=90 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207250048
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 01:10:38PM +0200, Jason A. Donenfeld wrote:
> Borislav pointed out during the review of "random: handle archrandom
> with multiple longs" that people might actually use this function, which
> might not be good because the function has surprising semantics. This of
> course was also the case before that patch, and indeed RDSEED-like
> functions across architectures often behave surprisingly, failing often.
> While random.c has been written specifically to work with that behavior,
> not much else is well equipped for that.
> 
> So add a comment suggesting that this is not for general consumption.
> Fortunately, nobody uses this for general consumption anyway, and people
> who try quickly find themselves in trouble. But adding this comment out
> of an abundance of caution was nonetheless suggested, and it at least
> means there will be easier justification for cleaning up potential
> misuses of the function later.
> 
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/arm64/include/asm/archrandom.h   | 13 +++++++++++++
>  arch/powerpc/include/asm/archrandom.h |  8 ++++++++
>  arch/s390/include/asm/archrandom.h    |  8 ++++++++
>  arch/um/include/asm/archrandom.h      |  8 ++++++++
>  arch/x86/include/asm/archrandom.h     |  9 ++++++---
>  include/asm-generic/archrandom.h      |  8 ++++++++
>  6 files changed, 51 insertions(+), 3 deletions(-)

For s390:
Acked-by: Heiko Carstens <hca@linux.ibm.com>
