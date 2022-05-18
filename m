Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485F652B5DC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiERJDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiERJDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:03:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4753E1238A8;
        Wed, 18 May 2022 02:03:37 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24I8isbW017356;
        Wed, 18 May 2022 09:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : subject : reply-to : in-reply-to : references : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=5b9ExFuV/mdbXBcWZ/YTWQ8xvIPBld8ClYxJkOjjqFQ=;
 b=sqwyNbO3CE+rC7+zMxgccmjhhR53iMoeId7JVnXtt0+SLjU3h7qRfvCTu7Jk3sT0muZl
 sAT3zUIm6J8WjVmY/Gph2VWo/3ZP7beHmoJ23SdNjuPItewc+k9MU0EKqexfc8XIOEJP
 ZsealRbOxzpn8c2wPDhFpYOxP3bSC270ieS/dTPYHZAp5OlDO+hnYnSodlZ3lA8BG/A3
 Or3StUKx0tvPgULlOip/Ulf+mUyR4RnUlYxOhALrqSa9pZoqP4pHbWTAea8NEZcTQzzx
 6JhHA9HQHMzGJGyYnIOEfnVie66PvHauH5w1GTQqXNpxGQPlNoDVL0ccRlAOs0na/nu1 BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4wjh8css-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 09:03:34 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24I93XcF013967;
        Wed, 18 May 2022 09:03:33 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4wjh8a9d-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 09:03:33 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24I8QeWP021832;
        Wed, 18 May 2022 08:30:32 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01dal.us.ibm.com with ESMTP id 3g242b9xhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 08:30:32 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24I8UVaS22348232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 08:30:31 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FB88112065;
        Wed, 18 May 2022 08:30:31 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05A65112063;
        Wed, 18 May 2022 08:30:31 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.10.229.42])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 18 May 2022 08:30:30 +0000 (GMT)
MIME-Version: 1.0
Date:   Wed, 18 May 2022 10:30:30 +0200
From:   Harald Freudenberger <freude@linux.ibm.com>
To:     undisclosed-recipients:;
Subject: Re: [PATCH] s390/crypto: fix scatterwalk_unmap() callers in AES-GCM
Reply-To: freude@linux.ibm.com
In-Reply-To: <YoPi5eH+oFJ2anQh@osiris>
References: <20220517143047.3054498-1-jannh@google.com>
 <YoPi5eH+oFJ2anQh@osiris>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <b07a2e97b1198007ea170a91cecbd9d1@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9EUW4Wyvf76gYoLAuzxu8q96O3eUjMhp
X-Proofpoint-ORIG-GUID: 0rNeDyJbJunPJw4CkZwJGcEECBwMHQ_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_03,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=799 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205180048
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-17 20:01, Heiko Carstens wrote:
> On Tue, May 17, 2022 at 04:30:47PM +0200, Jann Horn wrote:
>> The argument of scatterwalk_unmap() is supposed to be the void* that 
>> was
>> returned by the previous scatterwalk_map() call.
>> The s390 AES-GCM implementation was instead passing the pointer to the
>> struct scatter_walk.
>> 
>> This doesn't actually break anything because scatterwalk_unmap() only 
>> uses
>> its argument under CONFIG_HIGHMEM and ARCH_HAS_FLUSH_ON_KUNMAP.
>> 
>> Note that I have not tested this patch in any way, not even 
>> compile-tested
>> it.
>> 
>> Fixes: bf7fa038707c ("s390/crypto: add s390 platform specific aes gcm 
>> support.")
>> Signed-off-by: Jann Horn <jannh@google.com>
>> ---
>> IDK which tree this has to go through - s390 or crypto?
>> maybe s390 is better, since they can actually test it?
>> 
>>  arch/s390/crypto/aes_s390.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> This can go via the s390 tree, however I'd like to have an ACK from
> Harald, who wrote the original code.
> 
>> diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
>> index 54c7536f2482..1023e9d43d44 100644
>> --- a/arch/s390/crypto/aes_s390.c
>> +++ b/arch/s390/crypto/aes_s390.c
>> @@ -701,7 +701,7 @@ static inline void 
>> _gcm_sg_unmap_and_advance(struct gcm_sg_walk *gw,
>>  					     unsigned int nbytes)
>>  {
>>  	gw->walk_bytes_remain -= nbytes;
>> -	scatterwalk_unmap(&gw->walk);
>> +	scatterwalk_unmap(gw->walk_ptr);
>>  	scatterwalk_advance(&gw->walk, nbytes);
>>  	scatterwalk_done(&gw->walk, 0, gw->walk_bytes_remain);
>>  	gw->walk_ptr = NULL;
>> @@ -776,7 +776,7 @@ static int gcm_out_walk_go(struct gcm_sg_walk *gw, 
>> unsigned int minbytesneeded)
>>  		goto out;
>>  	}
>> 
>> -	scatterwalk_unmap(&gw->walk);
>> +	scatterwalk_unmap(gw->walk_ptr);
>>  	gw->walk_ptr = NULL;
>> 
>>  	gw->ptr = gw->buf;
>> 
>> base-commit: 42226c989789d8da4af1de0c31070c96726d990c
>> --
>> 2.36.0.550.gb090851708-goog
>> 
Ok, tests pass. Here is my Acked-by: Harald Freudenberger 
<freude@linux.ibm.com>
