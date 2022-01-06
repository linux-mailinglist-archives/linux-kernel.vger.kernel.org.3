Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E38485E2B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 02:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344421AbiAFBgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 20:36:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46136 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1344417AbiAFBgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 20:36:13 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205NjB4V016227;
        Thu, 6 Jan 2022 01:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=q5yghDeQHt8sShVlxRUFq7DVvVeGozRb7/rcSirOcI0=;
 b=D3Mq016AF5mLSawvoX1A/APq3I6ixfc2qQj9Wks1hs/3MI1EKFiNiOl2KggCYnm+CmMS
 kpGugngko2okJu41rwNRiuEehULrrco0si8Huo5b/akL/1jp9uEBkVEFGIdcPrRnN21G
 otNVxWuH2MrPy+qCiEVgHvtlQl24+CIF8/fIjV3CFGvsJLf5E0qwMY/dGfGagovekSOv
 FQRk1fUct315eYS9XIAtXAQpDLYGRvwUSdveKSn8Vo1L8XXVrGr7HY5SI2eYrGLbLPiS
 82iYPGjz0VkAzYaBeYqfj6wfQh2uAeH0bd+c6lIrCkbFgOwjkZG33MixbWMQ2kviaa2Y 9w== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ddn99he23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 01:36:05 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2061WJJt032038;
        Thu, 6 Jan 2022 01:36:05 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02dal.us.ibm.com with ESMTP id 3ddn1xa2st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 01:36:05 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2061a4F132571678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jan 2022 01:36:04 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E11DB124055;
        Thu,  6 Jan 2022 01:36:03 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7BFF124062;
        Thu,  6 Jan 2022 01:36:03 +0000 (GMT)
Received: from localhost (unknown [9.160.191.186])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  6 Jan 2022 01:36:03 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4] powerpc/pseries: read the lpar name from the firmware
In-Reply-To: <ac208963-d334-1f46-0db2-4a8d073b2963@linux.ibm.com>
References: <20211207171109.22793-1-ldufour@linux.ibm.com>
 <25527544-b0ac-596c-3876-560493b99f6b@linux.ibm.com>
 <8735m1ixd6.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
 <ac208963-d334-1f46-0db2-4a8d073b2963@linux.ibm.com>
Date:   Wed, 05 Jan 2022 19:36:03 -0600
Message-ID: <87ee5lve64.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w6k5B5hqEdd8kytWyNlpUML8zSfwL0O-
X-Proofpoint-ORIG-GUID: w6k5B5hqEdd8kytWyNlpUML8zSfwL0O-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-05_08,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=839
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2112160000 definitions=main-2201060005
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tyrel Datwyler <tyreld@linux.ibm.com> writes:
> On 1/5/22 3:19 PM, Nathan Lynch wrote:
>> Laurent Dufour <ldufour@linux.ibm.com> writes:
>>> On 07/12/2021, 18:11:09, Laurent Dufour wrote:
>>>> The LPAR name may be changed after the LPAR has been started in the HMC.
>>>> In that case lparstat command is not reporting the updated value because it
>>>> reads it from the device tree which is read at boot time.
>>>>
>>>> However this value could be read from RTAS.
>>>>
>>>> Adding this value in the /proc/powerpc/lparcfg output allows to read the
>>>> updated value.
>>>
>>> Do you consider taking that patch soon?
>> 
>> This version prints an error on non-PowerVM guests the first time
>> lparcfg is read.
>
> I assume because QEMU doesn't implement the LPAR_NAME token for
> get_sysparm.

Correct.


>> And I still contend that having this function fall back to reporting the
>> partition name in the DT would provide a beneficial consistency in the
>> user-facing API, allowing programs to avoid hypervisor-specific branches
>> in their code. 
>
> Agreed, if the get_sysparm fails just report the lpar-name from the device tree.
>
>> I don't understand the resistance I've encountered here.
>> The fallback I'm suggesting (a root node property lookup) is certainly
>> not more complex than the RTAS call sequence you've already implemented.
>> 
>
> Is there benefit of adding a partition_name field/value pair to lparcfg? The
> lparstat utility can just as easily make the get_sysparm call via librtas.
> Further, rtas_filters allows this particular RTAS call from userspace.

The RTAS syscall is root-only, but we want the partition name (whether
supplied by RTAS or the device tree) to be available to unprivileged
programs.
