Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CE4485DF6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 02:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344224AbiAFBRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 20:17:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18370 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344220AbiAFBRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 20:17:34 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205NVlLs001469;
        Thu, 6 Jan 2022 01:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MSu7P95KUe2+do0Z5QqDv8iSkSRNdJJOnTr+wVNm0yo=;
 b=en3ZQFk0EqCAEiELdVD3C7Miyhufli/2P/7nkQasWSVFuMaPRTIL6/mq75QHYe5p0Pz6
 V7V+52T/zYiaKllLJmwC4Je2YUUIKL7Rsrt0dYbw+yGP1JzbQfhayMioeMOV1zsqw62v
 hG44+9U804lrFGUgJpIwWRPmk93/UmliDYvqsdEWq9Zqt6vG/1sgHCwGrtibjGJokgX7
 HUmyurtv4hGM+eoK6mgZPesMnCKzaeC6MpRpi9svszjE2J/eY7Tr+ZpvIVGpnCPh0cVJ
 UItMxwN4fVX3YiHrlrY+fStwmLzCLYCbQbW/0CbkWM8kwQwchgd69uHAasXUlkds4hKL 3w== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ddn37he3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 01:17:24 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2061Cs8N020045;
        Thu, 6 Jan 2022 01:17:23 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 3ddnhwrue7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 01:17:23 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2061HM2t9372442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jan 2022 01:17:23 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6AA328059;
        Thu,  6 Jan 2022 01:17:22 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29B742805E;
        Thu,  6 Jan 2022 01:17:22 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.160.94.20])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  6 Jan 2022 01:17:21 +0000 (GMT)
Subject: Re: [PATCH v4] powerpc/pseries: read the lpar name from the firmware
To:     Nathan Lynch <nathanl@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20211207171109.22793-1-ldufour@linux.ibm.com>
 <25527544-b0ac-596c-3876-560493b99f6b@linux.ibm.com>
 <8735m1ixd6.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
Message-ID: <ac208963-d334-1f46-0db2-4a8d073b2963@linux.ibm.com>
Date:   Wed, 5 Jan 2022 17:17:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8735m1ixd6.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dh03Jz4YVogVaZATfC3TlnJCn01gpkMT
X-Proofpoint-ORIG-GUID: dh03Jz4YVogVaZATfC3TlnJCn01gpkMT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-05_08,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 clxscore=1011
 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060002
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/22 3:19 PM, Nathan Lynch wrote:
> Laurent Dufour <ldufour@linux.ibm.com> writes:
>> On 07/12/2021, 18:11:09, Laurent Dufour wrote:
>>> The LPAR name may be changed after the LPAR has been started in the HMC.
>>> In that case lparstat command is not reporting the updated value because it
>>> reads it from the device tree which is read at boot time.
>>>
>>> However this value could be read from RTAS.
>>>
>>> Adding this value in the /proc/powerpc/lparcfg output allows to read the
>>> updated value.
>>
>> Do you consider taking that patch soon?
> 
> This version prints an error on non-PowerVM guests the first time
> lparcfg is read.

I assume because QEMU doesn't implement the LPAR_NAME token for get_sysparm.

> 
> And I still contend that having this function fall back to reporting the
> partition name in the DT would provide a beneficial consistency in the
> user-facing API, allowing programs to avoid hypervisor-specific branches
> in their code. 

Agreed, if the get_sysparm fails just report the lpar-name from the device tree.

I don't understand the resistance I've encountered here.
> The fallback I'm suggesting (a root node property lookup) is certainly
> not more complex than the RTAS call sequence you've already implemented.
> 

Is there benefit of adding a partition_name field/value pair to lparcfg? The
lparstat utility can just as easily make the get_sysparm call via librtas.
Further, rtas_filters allows this particular RTAS call from userspace.

-Tyrel

