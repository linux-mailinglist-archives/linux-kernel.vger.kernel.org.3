Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145CA494D98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiATMD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:03:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232748AbiATMDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:03:54 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20KBZ0f2016646;
        Thu, 20 Jan 2022 12:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=k5o6ODXwuLUj4i7YdvLA0ynpqLCOuB0YKgzZpKET9f4=;
 b=Dxoi/O51zVP7/OFIYcCK0BvBuJubQUmEEWcu8ZxtgojlPBjfyBs3I8SMrSkhvapLfbyp
 1kFdNWtNxpsU/Jqe75dIlVBGNGIs0rj0PaDSTY0lbQGvsawoCtyJLA7gpg3pC9LGCC1O
 1VLkGCWz3zUjyiK/TRPQZlPak/Cd2WPxYCdEbTHCw/BH3s1kCGKsWRcjnVubXjijqZoL
 eJxwAyaUu//tbseC6hsVB58j8O1MYO5Du5tbRNaWs5lzJ3eGHNLuBbHMiump/7/CeX4n
 KIxkkOA2UfiMlpi8p23YHbEAtEFq9wc8XDpHtQFuuHca3aHHaaYk4Y/rIGQnJ1UHFp5/ oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dq1mgq4fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 12:02:16 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20KBlxYu030083;
        Thu, 20 Jan 2022 12:02:15 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dq1mgq4ep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 12:02:15 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20KC264g009570;
        Thu, 20 Jan 2022 12:02:12 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3dnm6rr24u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 12:02:12 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20KBqlVA22282656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 11:52:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F154611C06C;
        Thu, 20 Jan 2022 12:02:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AB3411C052;
        Thu, 20 Jan 2022 12:02:07 +0000 (GMT)
Received: from [9.171.13.121] (unknown [9.171.13.121])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jan 2022 12:02:07 +0000 (GMT)
Message-ID: <25fae2b8-e71e-e97f-a08b-b88a1ae608de@linux.ibm.com>
Date:   Thu, 20 Jan 2022 13:02:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 0/7] kvm: fix latent guest entry/exit bugs
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
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
 <0654e667-1cfa-5147-6661-b3b63288be0b@linux.ibm.com>
 <YelOGjuRsMfUb3e7@FVFF77S0Q05N>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <YelOGjuRsMfUb3e7@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WNzbkVsveAGBzNlLtgH6K8X7aHqWWHTF
X-Proofpoint-GUID: MI0AoZPoXEFhVoUPnFbrFyPiFxjeKY2D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_04,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=897
 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 20.01.22 um 12:57 schrieb Mark Rutland:
> On Wed, Jan 19, 2022 at 08:30:17PM +0100, Christian Borntraeger wrote:
>>
>>
>> Am 19.01.22 um 20:22 schrieb Mark Rutland:
>>> On Wed, Jan 19, 2022 at 07:25:20PM +0100, Christian Borntraeger wrote:
>>>> Am 19.01.22 um 11:58 schrieb Mark Rutland:
>>>>
>>>>
>>>> CCing new emails for Anup and Atish so that they are aware of this thread.
>>>
>>> Ah; whoops. I'd meant to fix the Ccs on the patches.
>>>
>>> Thanks!
>>>
>>> [...]
>>>
>>>> I just gave this a spin on s390 with debugging on and I got the following:
>>>>
>>>> [  457.151295] ------------[ cut here ]------------
>>>> [  457.151311] WARNING: CPU: 14 PID: 0 at kernel/rcu/tree.c:613 rcu_eqs_enter.constprop.0+0xf8/0x118
>>>
>>> Hmm, so IIUC that's:
>>>
>>> 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
>>>
>>> ... and we're clearly in the idle thread here.
>>>
>>> I wonder, is the s390 guest entry/exit *preemptible* ?
>>
>> Looks like debug_defconfig is indeed using preemption:
>>
>> CONFIG_PREEMPT_BUILD=y
>> # CONFIG_PREEMPT_NONE is not set
>> # CONFIG_PREEMPT_VOLUNTARY is not set
>> CONFIG_PREEMPT=y
>> CONFIG_PREEMPT_COUNT=y
>> CONFIG_PREEMPTION=y
>> CONFIG_PREEMPT_RCU=y
>> CONFIG_PREEMPT_NOTIFIERS=y
>> CONFIG_DEBUG_PREEMPT=y
>> CONFIG_PREEMPTIRQ_TRACEPOINTS=y
>> CONFIG_TRACE_PREEMPT_TOGGLE=y
>> CONFIG_PREEMPT_TRACER=y
>> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> 
> Thanks for confirming!
> 
> Could you try with CONFIG_PROVE_RCU=y ? That can't be selected directly, but
> selecting PROVE_LOCKING=y will enable it.

PROVE_LOCKING was enabled in my runs as well as PROVE_RCU.
