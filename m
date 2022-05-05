Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3C551BCA8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354951AbiEEKDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354948AbiEEKDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:03:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAA2515AB
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 02:59:59 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2459Link023224;
        Thu, 5 May 2022 09:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4f9TCyJmfwhNz86GUhIMUr/Inn9YarjHOEI/su76mao=;
 b=ZLW02lBYxh0XF5/T8M+8+/bqKF7JXFjb9gAIzEAYUoyfBcSTRPqks7rVSKZYtWdnHmLe
 ImHAdvAdcWgJbaRIMhfENEtXlB8GkTGV1LUsL5+JrG57mtRjzR1mKo1sO7K3eyhbrgyq
 Cbnc1e5zEDK6ll6sHxXFdW2AzWh63jfoeiLzNWh456xgQiI9PajEhXMkORkl/IbXl+rp
 S6OLTMGSueYwbkHttpfs4VWMujAPctbH4ZNw21rryhIbqo+9fl1B4B6p8Ez1+c6NLLkH
 RYF8Vwjnk8Kex1Nl3aoFlkpfUddckXVXnSFHqsPrsd35rSsg2+iXtvi4AfsM4ijwrowc hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fvbvq8jx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 09:59:32 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2459jmEK015866;
        Thu, 5 May 2022 09:59:32 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fvbvq8jwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 09:59:31 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2459v8Cu021832;
        Thu, 5 May 2022 09:59:29 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3ftp7fuukm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 09:59:29 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2459xQmd58720518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 May 2022 09:59:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B82ADAE051;
        Thu,  5 May 2022 09:59:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 369A1AE04D;
        Thu,  5 May 2022 09:59:21 +0000 (GMT)
Received: from [9.43.97.174] (unknown [9.43.97.174])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 May 2022 09:59:20 +0000 (GMT)
Message-ID: <e677f11b-32f9-0c89-9592-b987b00c4353@linux.ibm.com>
Date:   Thu, 5 May 2022 15:29:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v7 4/8] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-5-eric.devolder@oracle.com>
 <YleK3J/4HNuFioIh@MiWiFi-R3L-srv>
 <4eea2373-32f3-9960-cbec-21dc1a428807@oracle.com>
 <6f3a6cbb-0ac4-f178-fc17-18f9594da319@linux.ibm.com>
 <YmeBjrChOHsIYG3e@MiWiFi-R3L-srv>
 <f2dbd4fe-6201-b5c4-2725-dec9c3dbf13e@linux.ibm.com>
 <YnNkgfnHlUTky0lt@MiWiFi-R3L-srv>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <YnNkgfnHlUTky0lt@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: riO467bZk1GEKDvNY0gtA-uIMYYmnSVN
X-Proofpoint-GUID: 0FFMLvnEDNQ88y31Gu4q-c3ooFWEbZsg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_03,2022-05-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=724 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205050063
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/05/22 11:15, Baoquan He wrote:
> On 04/28/22 at 10:48am, Sourabh Jain wrote:
>> Hi Baoquan,
>>
>> On 26/04/22 10:52, Baoquan He wrote:
>>> On 04/26/22 at 09:36am, Sourabh Jain wrote:
>>>> On 15/04/22 03:59, Eric DeVolder wrote:
> ......
>
>>>>>>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>>>>>>> +static int crash_memhp_notifier(struct notifier_block *nb,
>>>>>>> +    unsigned long val, void *v)
>>>>>>> +{
>>>>>>> +    struct memory_notify *mhp = v;
>>>>>>> +
>>>>>>> +    switch (val) {
>>>>>>> +    case MEM_ONLINE:
>>>>>>> +        crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY, -1U);
>>>>>> We don't differentiate the memory add/remove, cpu add, except of cpu
>>>>>> remove. Means the hp_action only differentiate cpu remove from the other
>>>>>> action. Maybe only making two types?
>>>>>>
>>>>>> #define KEXEC_CRASH_HP_REMOVE_CPU   0
>>>>>> #define KEXEC_CRASH_HP_UPDATE_OTHER      1
>>>>>>
>>>>> Sourabh Jain's work with PPC uses REMOVE_CPU, REMOVE_MEMORY, and
>>>>> ADD_MEMORY.
>>>>> Do you still want to consolidate these?
>>>> On PowerPC different actions are needed for CPU add and memory add/remove.
>>>> For CPU add case only FDT is updated whereas for the memory hotplug we will
>>>> be
>>>> updating FDT and elfcorehdr.
>>> I don't understand. For elfcorehdr updating, we only need regenerate it.
>>> Do you update them different for memory add/remove?
>> We have different actions for cpu remove, CPU add and memory add/remove
>> case.
>>
>> CPU remove: no action
>> CPU add: update flattened device tree (FDT)
>> memory add/remove: update FDT and regenerate/update elfcorehdr
>>
>> Since memory add/remove action is same we can have common hp_action for
>> them.
> For memory hot add/remove, we need rengereate elfcorehdr, and add the
> new elfcorehdr into fdt. Except of this, FDT need to know the hp_action
> and the hot added/removed memory region, namely the start and end, e.g
> [start, end]?
>
> I checked arm64 kexec code, seems we only need to know if mem hotplug
> event happened, then regenerate elfcorehdr and embed the new elfcorehdr
> into fdt. Then we don't know pass the [start, end] info into the
> handler. Please tell if ppc is different or I missed anything.

Yes we don't need start and end info as such but we expect arch
handler to have info about which hotplug action is performed.
It is just that I don't see an significant advantage of consolidation of
CPU ADD, memory ADD and Memory REMOVE in one hp_action as
KEXEC_CRASH_HP_UPDATE_OTHER.

> If I am right, I would like the handler interface as Boris has made
> in his draft patch.
>
> void __weak arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action,
>                                             unsigned int cpu)
>
> static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
The above template works fine for PowerPC as long we have four different 
hp_action
to indicate CPU add/remove and memory add/remove.

Thanks,
Sourabh Jain
