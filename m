Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EE84D4F2A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242318AbiCJQVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242457AbiCJQUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:20:42 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E4419415E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:19:13 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22AF7luo025527;
        Thu, 10 Mar 2022 16:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MHTcat8moAb8iq4vBsXHZZ+/qabywB96lnu6OHyAn0s=;
 b=cjlRUDlsJD3fBAIFwmz3GfcxZG40Zrx/sSUH7r+EpxEIBP/90w1F4Jv0F0ODT8HVnSV7
 LoGkpdDoLlWnKbiKZhyet5Emrm1fwUdvmBC6C5mM8Qt/EpARcAOJSHOA2ravJBbXGTfg
 s25mNnHsjsw6OHKst5H6NoXKP1ZYf8Aexk+yApTicO7d2f4YGTjyWxdEkr1fY6PEaFze
 pVKAt/GIhst8fo1t/RRumDSDg2CA3kVNyZ46+HDa2917MLS60R4OmhowgMEBbjSGCOHJ
 VKRgX9DtU3SMaaf7q8CbbY50urNCTFC6u0sHrI5TfbcetUeUnHvD3P6442Lf8NYw1XC2 dQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eqg9dq89x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 16:18:35 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22AGDoir007846;
        Thu, 10 Mar 2022 16:18:33 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3eqk8605bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 16:18:33 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22AGIU5o42926438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 16:18:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DE7111C04A;
        Thu, 10 Mar 2022 16:18:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A8E611C04C;
        Thu, 10 Mar 2022 16:18:30 +0000 (GMT)
Received: from [9.145.19.15] (unknown [9.145.19.15])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Mar 2022 16:18:30 +0000 (GMT)
Message-ID: <7aa780b1-3bb5-ffa1-e8f1-defc13e5580c@linux.ibm.com>
Date:   Thu, 10 Mar 2022 17:18:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH] powerpc/vdso: Fix VDSO unmap check
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
References: <20201103171336.98883-1-ldufour@linux.ibm.com>
 <375b927b-fa93-28cd-23b8-8afe264adb0c@csgroup.eu>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <375b927b-fa93-28cd-23b8-8afe264adb0c@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U5k1faMypYQ88fNecYS_Awitj6Dmu6ty
X-Proofpoint-ORIG-GUID: U5k1faMypYQ88fNecYS_Awitj6Dmu6ty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_06,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1011 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2022, 16:51:04, Christophe Leroy wrote:
> 
> 
> Le 03/11/2020 à 18:13, Laurent Dufour a écrit :
>> The check introduced by the commit 83d3f0e90c6c ("powerpc/mm: tracking vDSO
>> remap") is wrong and is missing some partial unmaps of the VDSO.
>>
>> To be complete the check needs the base and end address of the
>> VDSO. Currently only the base is available in the mm_context of a task, but
>> the end address can easily be computed because the size of VDSO is
>> constant. However, there are 2 sizes for 32 or 64 bits task and they are
>> stored in static variables in arch/powerpc/kernel/vdso.c.
>>
>> Exporting a new function called vdso_pages() to get the number of pages of
>> the VDSO based on the static variables from arch/powerpc/kernel/vdso.c.
>>
>> Fixes: 83d3f0e90c6c ("powerpc/mm: tracking vDSO remap")
>>
>> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
>> Reported-by: Thomas Gleixner <tglx@linutronix.de>
>> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> ---
>>   arch/powerpc/include/asm/mmu_context.h | 18 ++++++++++++++++--
>>   arch/powerpc/kernel/vdso.c             | 14 ++++++++++++++
>>   2 files changed, 30 insertions(+), 2 deletions(-)
> 
> This patch doesn't apply anymore.
> 
> In the meantime there's a pending series from Dmitry, so I'm wondering if
> it is worth rebasing this series or not.

I agee, the Dimitry's series looks better, addressing the issue in the
common code for all the architectures.

Laurent.
