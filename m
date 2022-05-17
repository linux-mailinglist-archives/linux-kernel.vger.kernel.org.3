Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B103E52A9CC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351729AbiEQSBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351727AbiEQSBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:01:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342703FD82;
        Tue, 17 May 2022 11:01:24 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HHfsC1018713;
        Tue, 17 May 2022 18:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=tmdhMwxKEVX3PeaTU8UyOIcfU9EAXEHP60T3yrcx/ms=;
 b=iQ/tTXc8K7hYdk29JTAn6AdDxWpo5BFoYk8bIOK/f0jA9MdT51YH1G9DdjyU0j6bmfiX
 LsWtTYzORxsn/6W8zhouy+/+2xd37D7SNeEh73frFJlNvDX+DWnEd0CyZe4VbxbfoRuR
 xysYaaVh4VdyB2BuWD7n8Q+1LV8D0gl9PdQJGbI52gZjcQ5dCFk9DyIvwi1wUwISLDnp
 84FlcO0Oli/sjkAPOvnUwGvBt5UdlxfqONVz7N+0pFE35G5VRM4o/SEDeCagBoX5u7Lc
 lfP97ccKggdUxaOiaBs/QVIeADIkzvQZCuwoPgqN8wMsQSmRbEREnr2yFUDVyAkR73PT Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4gb28cw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 18:01:17 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24HHl8nQ017286;
        Tue, 17 May 2022 18:01:17 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4gb28cuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 18:01:17 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24HHgddO001394;
        Tue, 17 May 2022 18:01:14 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3g2429ckj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 18:01:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24HI1B1w48824672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 18:01:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30B404C046;
        Tue, 17 May 2022 18:01:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B368B4C044;
        Tue, 17 May 2022 18:01:10 +0000 (GMT)
Received: from osiris (unknown [9.145.64.16])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 17 May 2022 18:01:10 +0000 (GMT)
Date:   Tue, 17 May 2022 20:01:09 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Jann Horn <jannh@google.com>,
        Harald Freudenberger <freude@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/crypto: fix scatterwalk_unmap() callers in AES-GCM
Message-ID: <YoPi5eH+oFJ2anQh@osiris>
References: <20220517143047.3054498-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517143047.3054498-1-jannh@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D5hoV9tVBnozGV6HodEoQOPD7mxgR36h
X-Proofpoint-ORIG-GUID: olvVvJLd3dEjFcB0RK5hhMJdxWYOnVii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_03,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 spamscore=0 suspectscore=0 clxscore=1015 mlxlogscore=846 bulkscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 04:30:47PM +0200, Jann Horn wrote:
> The argument of scatterwalk_unmap() is supposed to be the void* that was
> returned by the previous scatterwalk_map() call.
> The s390 AES-GCM implementation was instead passing the pointer to the
> struct scatter_walk.
> 
> This doesn't actually break anything because scatterwalk_unmap() only uses
> its argument under CONFIG_HIGHMEM and ARCH_HAS_FLUSH_ON_KUNMAP.
> 
> Note that I have not tested this patch in any way, not even compile-tested
> it.
> 
> Fixes: bf7fa038707c ("s390/crypto: add s390 platform specific aes gcm support.")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> IDK which tree this has to go through - s390 or crypto?
> maybe s390 is better, since they can actually test it?
> 
>  arch/s390/crypto/aes_s390.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This can go via the s390 tree, however I'd like to have an ACK from
Harald, who wrote the original code.

> diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
> index 54c7536f2482..1023e9d43d44 100644
> --- a/arch/s390/crypto/aes_s390.c
> +++ b/arch/s390/crypto/aes_s390.c
> @@ -701,7 +701,7 @@ static inline void _gcm_sg_unmap_and_advance(struct gcm_sg_walk *gw,
>  					     unsigned int nbytes)
>  {
>  	gw->walk_bytes_remain -= nbytes;
> -	scatterwalk_unmap(&gw->walk);
> +	scatterwalk_unmap(gw->walk_ptr);
>  	scatterwalk_advance(&gw->walk, nbytes);
>  	scatterwalk_done(&gw->walk, 0, gw->walk_bytes_remain);
>  	gw->walk_ptr = NULL;
> @@ -776,7 +776,7 @@ static int gcm_out_walk_go(struct gcm_sg_walk *gw, unsigned int minbytesneeded)
>  		goto out;
>  	}
>  
> -	scatterwalk_unmap(&gw->walk);
> +	scatterwalk_unmap(gw->walk_ptr);
>  	gw->walk_ptr = NULL;
>  
>  	gw->ptr = gw->buf;
> 
> base-commit: 42226c989789d8da4af1de0c31070c96726d990c
> -- 
> 2.36.0.550.gb090851708-goog
> 
