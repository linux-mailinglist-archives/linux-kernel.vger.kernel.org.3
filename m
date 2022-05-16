Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4530E528271
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbiEPKoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242854AbiEPKnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:43:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C99E248EC;
        Mon, 16 May 2022 03:43:02 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GAV3F7011810;
        Mon, 16 May 2022 10:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ncD54g7wkJHCvpdHQtNwcfU/ssypel9ss6Wqx7eG4kA=;
 b=rDqgfOIb6ptjKyB9fwPyp+U8anFbeSilSlfmfcnzqDeOiHNCF8MXO+fjZQvxUEzfFQ/T
 J2S0Agj3xj1LlU8tn5XqjQLranNVCU9kDVGzDJIzUh8dOuNc5AhttlkAVYPz7TA8jni4
 3K+NJqzEh1gfk8eVz2h+KxXeSs0T6LwAhGyAfHuE88eQouPI85JsaW5WSnmDp3kTn9zj
 MAdUC89LG26MrlZlbMNhjWqc5UIHK6/pxMmFPT1SIMQ0eumdnTPvDEElLfPQqgJlqNxc
 3mKtyXRanqBSnY061mdnxMnHPTXohu8Xj9LgiSIBDt9FxR/myClqwbd1Z0RxnRmKU280 nA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3mx98576-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 10:42:59 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24GAWIQY015146;
        Mon, 16 May 2022 10:42:58 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3mx9856n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 10:42:58 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24GAcNvP011722;
        Mon, 16 May 2022 10:42:56 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3g2428sx3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 10:42:56 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24GAgLMi30802186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 10:42:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F02154C040;
        Mon, 16 May 2022 10:42:51 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17E2F4C04A;
        Mon, 16 May 2022 10:42:51 +0000 (GMT)
Received: from [9.145.43.21] (unknown [9.145.43.21])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 16 May 2022 10:42:51 +0000 (GMT)
Message-ID: <5bdad86b-3ab5-a1c2-7dcd-8c45c7aa4555@linux.vnet.ibm.com>
Date:   Mon, 16 May 2022 12:42:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 4/8] s390/entry: workaround llvm's IAS limitations
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20220511120532.2228616-1-hca@linux.ibm.com>
 <20220511120532.2228616-5-hca@linux.ibm.com>
 <YnvynSZfF/8I8vmT@dev-arch.thelio-3990X> <Yn1CyTcrZk1Kgvoq@osiris>
 <YoIUX864ULCwu4pz@tuxmaker.boeblingen.de.ibm.com> <YoIlQaWNy1wu39ak@osiris>
From:   Jonas Paulsson <paulsson@linux.vnet.ibm.com>
In-Reply-To: <YoIlQaWNy1wu39ak@osiris>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kZqrCQfQy1VPDZ6Jutw2xP3BAwUz6_mQ
X-Proofpoint-ORIG-GUID: fk-BFvK2Jv0N16rbrVKGs8mJnqN5C1YU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_06,2022-05-16_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205160062
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will try to get a patch for clang ready soon... /Jonas

On 2022-05-16 12:19 em, Heiko Carstens wrote:
> On Mon, May 16, 2022 at 11:07:43AM +0200, Alexander Gordeev wrote:
>>> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
>>> index a6b45eaa3450..f2f30bfba1e9 100644
>>> --- a/arch/s390/kernel/entry.S
>>> +++ b/arch/s390/kernel/entry.S
>>> @@ -172,9 +172,19 @@ _LPP_OFFSET	= __LC_LPP
>>>   	lgr	%r14,\reg
>>>   	larl	%r13,\start
>>>   	slgr	%r14,%r13
>>> -	lghi	%r13,\end - \start
>>> -	clgr	%r14,%r13
>>> +#ifdef CONFIG_AS_IS_LLVM
>>> +	clgfrl	%r14,.Lrange_size\@
>>> +#else
>>> +	clgfi	%r14,\end - \start
>>> +#endif
>>>   	jhe	\outside_label
>>> +#ifdef CONFIG_CC_IS_CLANG
>>> +	.section .rodata, "a"
>>> +	.align 4
>>> +.Lrange_size\@:
>>> +	.long	\end - \start
>> Isn't the machine check handler refers to this memory before checking
>> unrecoverable storage errors (with CHKSTG macro) as result of this change?
> Yes, indeed. However implementing this without another register will
> be quite of a challenge. So what I would prefer in any case: just
> assume that this minimal set of memory accesses work. Actually I'd
> seriously like to go a bit further, and even move the checks for
> storage errors back to C for two reasons:
>
> - this would make the machine check handler entry code easier again
> - it would also allow to enter the machine check handler with DAT on
>
> After all we rely anyway on the fact that at least the local lowcore +
> the page(s) which contain text are still accessible. Assuming that a
> couple of page tables also work won't make this much worse, but the
> code much easier.
>
> So I'd suggest: leave this code as is, and at some later point move
> "rework" the early machine check handler code.
>
> What do you think?
