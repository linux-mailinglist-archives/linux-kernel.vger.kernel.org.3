Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDE2514297
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354763AbiD2GsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354694AbiD2Gr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:47:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD0CBB092
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:44:41 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23T4XFuL012806;
        Fri, 29 Apr 2022 06:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=H1GlisjeBSGQKI4etVGVdomJpiXkB+lqDYSPiLSRBBQ=;
 b=B5CkBIZj/KYiJ4KJ5sYACdOQXFITqMWTCEIIxORYIDMrOUrC4Sao7phvjc/45hagbtC1
 jkpvTADF11qmjgNbABFmM+AX3Cs917PU+Qk9bdQa4SRgK1O1jeBnESfmFB5yA3LnVItc
 AEopiMACMp8MeV01csCB0reI0bCPnkSwdPejw+GD6dp3W1WdPppphC4koRUMEfYUFi7A
 xjpozYeX+ngHAa3WihBX0qr6V9YXbsJ9fEpg8KF+v068qN60wxmQawpjWqeH5NtHzGFA
 1SThyw5Yxd4PWCPOlCVcQ0M0XePPnxC2ADo2meujF4OMpZaQ1+2W1E060t9nj4Waaqam 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqtvxd2bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 06:42:08 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23T6g7i4029805;
        Fri, 29 Apr 2022 06:42:07 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqtvxd2ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 06:42:07 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23T6MnjB022954;
        Fri, 29 Apr 2022 06:42:05 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3fm8qj8n66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 06:42:05 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23T6g3MP52822490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 06:42:03 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18B0CA4054;
        Fri, 29 Apr 2022 06:42:03 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E01ACA405B;
        Fri, 29 Apr 2022 06:41:57 +0000 (GMT)
Received: from [9.43.116.127] (unknown [9.43.116.127])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 06:41:57 +0000 (GMT)
Message-ID: <100fa9f0-fc24-7a3f-33c6-3d4e7f6f4a93@linux.ibm.com>
Date:   Fri, 29 Apr 2022 12:11:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v7 2/8] x86/crash: Introduce new options to support cpu
 and memory hotplug
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
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-3-eric.devolder@oracle.com>
 <d90f4299-e821-f5d5-957a-1e84f16816e0@linux.ibm.com>
 <300a485c-4bc5-c58a-d34a-bacdb1fa4510@oracle.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <300a485c-4bc5-c58a-d34a-bacdb1fa4510@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pgTu7MglxuyTKy8vd5PooGgD6kUmZlll
X-Proofpoint-GUID: nWEWkH0OBaRbsrSOpvCUJ2cyuk97UxDN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_05,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290036
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/04/22 20:09, Eric DeVolder wrote:
>
>
> On 4/25/22 23:21, Sourabh Jain wrote:
>>
>> On 13/04/22 22:12, Eric DeVolder wrote:
>>> CRASH_HOTPLUG is to enable cpu and memory hotplug support of crash.
>>>
>>> CRASH_HOTPLUG_ELFCOREHDR_SZ is used to specify the maximum size of
>>> the elfcorehdr buffer/segment.
>>>
>>> This is a preparation for later usage.
>>>
>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>> Acked-by: Baoquan He <bhe@redhat.com>
>>> ---
>>>   arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
>>>   1 file changed, 26 insertions(+)
>>>
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index b0142e01002e..f7b92ee1bcc7 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -2072,6 +2072,32 @@ config CRASH_DUMP
>>>         (CONFIG_RELOCATABLE=y).
>>>         For more details see Documentation/admin-guide/kdump/kdump.rst
>>> +config CRASH_HOTPLUG
>>> +    bool "kernel updates of crash elfcorehdr"
>>> +    depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG) && 
>>> KEXEC_FILE
>>> +    help
>>> +      Enable the kernel to update the crash elfcorehdr (which contains
>>> +      the list of CPUs and memory regions) directly when hot 
>>> plug/unplug
>>> +      of CPUs or memory. Otherwise userspace must monitor these hot
>>> +      plug/unplug change notifications via udev in order to
>>> +      unload-then-reload the crash kernel so that the list of CPUs and
>>> +      memory regions is kept up-to-date. Note that the udev CPU and
>>> +      memory change notifications still occur (however, userspace 
>>> is not
>>> +      required to monitor for crash dump purposes).
>>> +
>>> +config CRASH_HOTPLUG_ELFCOREHDR_SZ
>>> +    depends on CRASH_HOTPLUG
>>> +    int
>>> +    default 131072
>>> +    help
>>> +      Specify the maximum size of the elfcorehdr buffer/segment.
>>> +      The 128KiB default is sized so that it can accommodate 2048
>>> +      Elf64_Phdr, where each Phdr represents either a CPU or a
>>> +      region of memory.
>>> +      For example, this size can accommodate a machine with up to 1024
>>> +      CPUs and up to 1024 memory regions, eg. as represented by the
>>> +      'System RAM' entries in /proc/iomem.
>>
>> Is it possible to get rid of CRASH_HOTPLUG_ELFCOREHDR_SZ?
> At the moment, I do not think so. The idea behind this value is to 
> represent the largest number of CPUs and memory regions possible in 
> the system. Today there is NR_CPUS which could be used for CPUs, but 
> there isn't a similar value for memory. I also am not aware of a 
> kernel variable that could be utilized to represent the maximum number 
> of memory regions. If there is, please let me know!
>>
>> How about finding the additional buffer space needed for future CPU 
>> and memory
>> add during the kdump load? Not sure about the feasibility of doing 
>> this in
>> kexec tool (userspace).
>
> I may not understand what you are asking, but the x86 code, for 
> kexec_file_load, does in fact allocate all the space needed (currently 
> via CRASH_HOTPLUG_ELFCOREHDR_SZ) upon kdump load.
>
> For kexec_load, I've had no problem asking the kexec tool to allocate 
> a larger piece of memory for the elfcorehdr. But it is the same 
> problem as CRASH_HOTPLUG_ELFCOREHDR_SZ; how big? In my workspace I 
> tell kexec tool how big. If there are sysfs visible values for NR_CPU 
> and memory, then we could have kexec pull those and compute.

Yeah dynamic calculation for PT_LOAD sections needed for possible memory 
may not be straightforward. But still I did not get the rational for 
limiting the possible PT_LOAD sections or memory ranges to only 1024. 
Although in kexec tool the max memory ranges for x86 is 32K.

commit 1bc7bc7649fa29d95c98f6a6d8dd2f08734a865c
Author: David Hildenbrand <david@redhat.com>
Date:   Tue Mar 23 11:01:10 2021 +0100

     crashdump/x86: increase CRASH_MAX_MEMORY_RANGES to 32k

     virtio-mem in Linux adds/removes individual memory blocks (e.g., 128 MB
     each). Linux merges adjacent memory blocks added by virtio-mem 
devices, but
     we can still end up with a very sparse memory layout when unplugging
     memory in corner cases.

     Let's increase the maximum number of crash memory ranges from ~2k 
to 32k.
     32k should be sufficient for a very long time.

     e_phnum field in the header is 16 bits wide, so we can fit a maximum of
     ~64k entries in there, shared with other entries (i.e., CPU). 
Therefore,
     using up to 32k memory ranges is fine. (if we ever need more than ~64k,

Do you see any issue if we increase the memory range count to 32K?

Thanks,
Sourabh Jain

