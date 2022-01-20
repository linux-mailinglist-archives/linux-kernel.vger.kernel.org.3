Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0365649512C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376543AbiATPP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:15:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231292AbiATPPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:15:54 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20KEBRwB001421;
        Thu, 20 Jan 2022 15:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xqWnKTt/gEa/Nz87akvx4FuCu4zl5HS2xistTt0Ny70=;
 b=OP/v/tnqFUc506mmgYzIPIzRZDlX1G+c881/JstnxCWNQUdk7knEKlyJCSACl1h7SbYS
 fqsepqnqqa7irMS8DpUOlrBKKD9kU3IM4POenYEEUDLGEAtE3NgTc119xyH4qtWrAi8q
 Rt5lCEXP9BHHlzrFR6WdFd+lfL/Xx0tajE78+w6wz94TExOl3kXSJ1IP1D7w26FR1fKd
 9tjuNZlLSSonVDGW7vq4eANkAK7r3Bbtx8lUurTqtOZK8dxP8dbM1cHo0x9z+osP4YVp
 foG4CeseZqcTuSrag/CrhdE6JyOkcc0IzLC9U7dVvBqVtyfoalCTu4Py+Q/5HcHUWkq0 NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dq60dx3kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 15:14:24 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20KEtYlF007869;
        Thu, 20 Jan 2022 15:14:22 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dq60dx3jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 15:14:22 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20KFC5vC029507;
        Thu, 20 Jan 2022 15:14:19 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3dknw9ttab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 15:14:19 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20KFEF7D39846164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 15:14:15 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B18CE11C06C;
        Thu, 20 Jan 2022 15:14:15 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C758911C050;
        Thu, 20 Jan 2022 15:14:13 +0000 (GMT)
Received: from [9.171.13.121] (unknown [9.171.13.121])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jan 2022 15:14:13 +0000 (GMT)
Message-ID: <ff673e4e-c395-701f-f891-36ffa260c3bd@linux.ibm.com>
Date:   Thu, 20 Jan 2022 16:14:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 0/7] kvm: fix latent guest entry/exit bugs
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        aleksandar.qemu.devel@gmail.com, alexandru.elisei@arm.com,
        anup.patel@wdc.com, aou@eecs.berkeley.edu, atish.patra@wdc.com,
        bp@alien8.de, catalin.marinas@arm.com, chenhuacai@kernel.org,
        dave.hansen@linux.intel.com, frankja@linux.ibm.com,
        frederic@kernel.org, gor@linux.ibm.com, hca@linux.ibm.com,
        james.morse@arm.com, jmattson@google.com, joro@8bytes.org,
        luto@kernel.org, maz@kernel.org, mingo@redhat.com,
        nsaenzju@redhat.com, palmer@dabbelt.com, paulmck@kernel.org,
        paul.walmsley@sifive.com, peterz@infradead.org, seanjc@google.com,
        suzuki.poulose@arm.com, svens@linux.ibm.com, tglx@linutronix.de,
        tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>
References: <20220119105854.3160683-1-mark.rutland@arm.com>
 <a4a26805-3a56-d264-0a7e-60bed1ada9f3@linux.ibm.com>
 <20220119192217.GD43919@C02TD0UTHF1T.local>
 <2688b779-9cb8-b6ea-f8cc-93bc8ddf72f3@redhat.com>
 <YelPnGM4kONm7ZQa@FVFF77S0Q05N>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <YelPnGM4kONm7ZQa@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q0UZP0TDTJKVk9kCW5z43-RRjeOAOhY1
X-Proofpoint-GUID: _oC6Pqg9JmbASMFS9Pop1w8XM5troonf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_05,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=724 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 20.01.22 um 13:03 schrieb Mark Rutland:
> On Thu, Jan 20, 2022 at 12:28:09PM +0100, Paolo Bonzini wrote:
>> On 1/19/22 20:22, Mark Rutland wrote:
>>> I wonder, is the s390 guest entry/exit*preemptible*  ?
>>>
>>> If a timer IRQ can preempt in the middle of the EQS, we wouldn't balance
>>> things before a ctx-switch to the idle thread, which would then be able
>>> to hit this.
>>>
>>> I'll need to go audit the other architectures for similar.
>>
>> They don't enable interrupts in the entry/exit path so they should be okay.
> 
> True.
> 
> So it sounds like for s390 adding an explicit preempt_{disable,enable}() is the
> right thing to do. I'll add that and explanatory commentary.

That would not be trivial I guess. We do allow (and need) page faults on sie for guest
demand paging and

this piece of arch/s390/mm/fault.c

        case GMAP_FAULT:
                 if (faulthandler_disabled() || !mm)
                         goto out;
                 break;
         }

would no longer work since faulthandler_disabled checks for the preempt count.

