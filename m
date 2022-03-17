Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51DE4DC447
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 11:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiCQKw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 06:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiCQKw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:52:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE7F1D66FC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 03:51:42 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22HA8J3j003456;
        Thu, 17 Mar 2022 10:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ek19Esc6ZZmiBAKjyETufbmdvxjoKaXqi/0i1QXhHIs=;
 b=F10U3CzA4r5vwV4tCuxHD5Xw53fV7O/hbBeai8BTvxMS+rz4QH7dxM6GH01qlfSl62GR
 5qfHUz0T+vWauy7wKa1IS1r8y416Z4GHSC+ktDPGimIk6Mz5vcnDBpN3SXQa1I4rc8k2
 YcaZ5Qkk83vnp35jXeAMBEq32hqIWBokoCKI1xQJNojRG6M33gXPxeWyfLa57rCGg8Ox
 OpKwgtG/4Z73aw7vWhkg7uygRU9prv8ckxTL0yTvre1VjOxvqpI00dAMQTcNPisSDB14
 G2Z0xecbOD2H09pFPUF/22WICCoaylB/E06Feoc7AAEAck5Effl98d+8O3W9EGVtq0V+ JA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ev04pv0sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 10:46:20 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22HA2PSP023744;
        Thu, 17 Mar 2022 10:46:20 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ev04pv0s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 10:46:20 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22HAj4Vh017094;
        Thu, 17 Mar 2022 10:46:18 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3euc6r2m6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 10:46:17 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22HAkFRT38535646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 10:46:15 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82362A4055;
        Thu, 17 Mar 2022 10:46:15 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16A5CA404D;
        Thu, 17 Mar 2022 10:46:09 +0000 (GMT)
Received: from [9.43.110.37] (unknown [9.43.110.37])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Mar 2022 10:46:08 +0000 (GMT)
Message-ID: <79d08021-699a-016e-6ff3-15b67efa895d@linux.ibm.com>
Date:   Thu, 17 Mar 2022 16:16:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 4/8] crash: generic crash hotplug support
 infrastructure
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220303162725.49640-1-eric.devolder@oracle.com>
 <20220303162725.49640-5-eric.devolder@oracle.com>
 <1b7405e4-e6a3-56ff-5068-d598ba2f2b5e@linux.ibm.com>
 <2ca17bd8-fc81-19e2-7a16-e458ce8a097e@oracle.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <2ca17bd8-fc81-19e2-7a16-e458ce8a097e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zFkJpA3B0jXEM5aAtf1ncQP4KS_WTTiN
X-Proofpoint-ORIG-GUID: 2Uc7Q0t7RxKbJLb5lsZZfxWP_uTP8JQD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-17_04,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170060
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/03/22 19:42, Eric DeVolder wrote:
>
>
> On 3/15/22 07:08, Sourabh Jain wrote:
>> Hello Eric,
>>
>> On 03/03/22 21:57, Eric DeVolder wrote:
>>> This patch introduces a generic crash hot plug/unplug infrastructure
>>> for CPU and memory changes. Upon CPU and memory changes, a generic
>>> crash_hotplug_handler() obtains the appropriate lock, does some
>>> important house keeping and then dispatches the hot plug/unplug event
>>> to the architecture specific arch_crash_hotplug_handler(), and when
>>> that handler returns, the lock is released.
>>>
>>> This patch modifies crash_core.c to implement a subsys_initcall()
>>> function that installs handlers for hot plug/unplug events. If CPU
>>> hotplug is enabled, then cpuhp_setup_state() is invoked to register a
>>> handler for CPU changes. Similarly, if memory hotplug is enabled, then
>>> register_memory_notifier() is invoked to install a handler for memory
>>> changes. These handlers in turn invoke the common generic handler
>>> crash_hotplug_handler().
>>>
>>> On the CPU side, cpuhp_setup_state_nocalls() is invoked with parameter
>>> CPUHP_AP_ONLINE_DYN. While this works, when a CPU is being unplugged,
>>> the CPU still shows up in foreach_present_cpu() during the regeneration
>>> of the new CPU list, thus the need to explicitly check and exclude the
>>> soon-to-be offlined CPU in crash_prepare_elf64_headers().
>>>
>>> On the memory side, each un/plugged memory block passes through the
>>> handler. For example, if a 1GiB DIMM is hotplugged, that generate 8
>>> memory events, one for each 128MiB memblock.
>>>
>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>> ---
>>>   include/linux/kexec.h |  16 +++++++
>>>   kernel/crash_core.c   | 108 
>>> ++++++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 124 insertions(+)
>>>
>>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>>> index d7b59248441b..b11d75a6b2bc 100644
>>> --- a/include/linux/kexec.h
>>> +++ b/include/linux/kexec.h
>>> @@ -300,6 +300,13 @@ struct kimage {
>>>       /* Information for loading purgatory */
>>>       struct purgatory_info purgatory_info;
>>> +
>>> +#ifdef CONFIG_CRASH_HOTPLUG
>>> +    bool hotplug_event;
>>> +    int offlinecpu;
>>> +    bool elf_index_valid;
>>> +    int elf_index;
>>
>> How about keeping an array to track all kexec segment index need to 
>> be updated in
>> crash hotplug handler.
>>
>> struct hp_segment {
>>     name;
>>     index;
>>     is_valid;
>>   }
>>
>> It will be helpful if architecture need to updated multiple kexec 
>> segments  for a hotplug event.
>>
>> For example, on PowerPC, we might need to update FDT and elfcorehdr 
>> on memory hot plug/unplug.
>>
>> Thanks,
>> Sourabh Jain
>
> Sourabh,
> I'm OK with that. Another idea might be if there are just two, and one 
> of them is elfcorehdr, then perhaps in addition to elf_index and 
> elf_index_valid, maybe we add an arch_index and arch_index_valid? In 
> the case of PPC, the FDT would be stored in arch_index?

Yes it seems like we might not need to keep more than two kexec indexes. 
Since this indexes are arch specific lets push them to struct 
kimage_arch (part of kimage). So for now I will push fdt_index to struct 
kimage_arch.

Thanks,
Sourabh Jain

