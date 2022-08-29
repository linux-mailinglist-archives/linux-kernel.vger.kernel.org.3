Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7495A4285
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 07:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiH2Frb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 01:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2Fr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 01:47:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821FD45F79
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 22:47:27 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T3nkUC019437;
        Mon, 29 Aug 2022 05:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=HnBwohWacgYEuPKS+IFdY3Wh7/m18PjVGtUqNP2tyuo=;
 b=g+9gXMC/IGmVeQ9uq2llE0Pj3UzOmtHZUTTqs7cCNFxwgODSuzj9O4mrWZXUivZUkLxm
 ZeZiiNn9L1MPMpkccpjMRdTRpUfqdKBblg9xVJao+c/g59JL5mLTUc+h6ZBApc3r9kLt
 9cXyoXq7Le0vR0d2eyZNI16UoFQvWWeNHUy9GK9SoljMTL0pQMVzyf6SAPDsh35QEfyR
 jC9c2c4K8UNaqOBkmNycs+9kx1QB4RmB+bhmDfqFbpXC2qQlONXylVRAIWrJk/SJOIdh
 KN3zntzb9pMjYqLmg/A+w6kujk+MRqm41clGFuElxPsJpeFUf68ox9SerGrVBMCdzIoe 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j8nw0t658-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 05:46:54 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27T5d0tD033093;
        Mon, 29 Aug 2022 05:46:54 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j8nw0t64e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 05:46:53 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27T5ZYm5026918;
        Mon, 29 Aug 2022 05:46:51 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3j7aw91uue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 05:46:51 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27T5kmhG36307308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 05:46:48 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D46C54C044;
        Mon, 29 Aug 2022 05:46:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BCAB4C040;
        Mon, 29 Aug 2022 05:46:44 +0000 (GMT)
Received: from [9.43.67.34] (unknown [9.43.67.34])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Aug 2022 05:46:43 +0000 (GMT)
Message-ID: <8c185fe0-cc43-1cd9-ea1d-0e0f34ad1828@linux.vnet.ibm.com>
Date:   Mon, 29 Aug 2022 11:16:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 01/16] powerpc: Replace unreachable() with it's builtin
 variant in WARN_ON()
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc:     "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "chenzhongjin@huawei.com" <chenzhongjin@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>
References: <20220808114908.240813-1-sv@linux.ibm.com>
 <20220808114908.240813-2-sv@linux.ibm.com>
 <43a23349-3356-3347-f395-ba31db8c6978@csgroup.eu>
From:   Sathvika Vasireddy <sv@linux.vnet.ibm.com>
In-Reply-To: <43a23349-3356-3347-f395-ba31db8c6978@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Oi5FODQRRJuBCQ0cChU3-zr7qxLHKnvx
X-Proofpoint-GUID: vwuxdR0fMFD4vVq1ltBJW9O5nqe8AWly
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_02,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290026
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 26/08/22 15:48, Christophe Leroy wrote:
>
> Le 08/08/2022 à 13:48, Sathvika Vasireddy a écrit :
>> objtool is throwing *unannotated intra-function call*
>> warnings with a few instructions that are marked
>> unreachable. Replace unreachable() with __builtin_unreachable()
>> to fix these warnings, as the codegen remains same
>> with unreachable() and __builtin_unreachable().
>>
>> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
>> ---
>>    arch/powerpc/include/asm/bug.h | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
>> index 61a4736355c2..074be1a78c56 100644
>> --- a/arch/powerpc/include/asm/bug.h
>> +++ b/arch/powerpc/include/asm/bug.h
>> @@ -99,7 +99,7 @@
>>    	__label__ __label_warn_on;				\
>>    								\
>>    	WARN_ENTRY("twi 31, 0, 0", BUGFLAG_WARNING | (flags), __label_warn_on); \
>> -	unreachable();						\
>> +	__builtin_unreachable();				\
> Should you add barrier_before_unreachable() before
> __builtin_unreachable() to avoid stack bombs ?
>
> See commit 173a3efd3edb ("bug.h: work around GCC PR82365 in BUG()")

Yes, adding barrier_before_unreachable() before __builtin_unreachable()

works around the build issues reported at 
https://lkml.org/lkml/2022/8/25/418.

I'll post a v2 with this change.

Thanks for the suggestion!

- Sathvika

