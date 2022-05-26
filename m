Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4077E535019
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244883AbiEZNkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiEZNkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:40:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F46B5E767
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:40:18 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QDbvCI023751;
        Thu, 26 May 2022 13:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5HJ5s9o+3hDPq2NWvfxUbVJWO2R6/Udu9Xp3AxQBuyI=;
 b=UOH2tJMZGkY6fAD5PGn9FTj+HRSOCiXTeZzUftSCF7vCnrSejTG70G7ED5vyK1X/YZoi
 cg/YnM2a7L9/l389kYreLXpPHd4Vqll3iweRq5Gz/wL7V+l3T0bcoRLFCwQOY4kllje7
 v4FP72P43V99QUFx9tcp0u3xonTw6FTfY6AvrSBnzNltIbEhh0nDk5Qysnu6BpUZzKpP
 gCtNya0JCGc3YNtojKV9cldT9gu5wPFKl8K2oulgtnc6lnk5wN5zndbhi2n8QTwA/FVn
 uMIba1PMHPhKCWNQuewSSi7c3ofy6M4ed8LMWBMK0JgSVXfeybF++c5Eyo6wqEQ9X/k7 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gaakug0kj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 May 2022 13:39:37 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24QDdEs4026426;
        Thu, 26 May 2022 13:39:36 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gaakug0k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 May 2022 13:39:36 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24QDUGXf026642;
        Thu, 26 May 2022 13:39:34 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3g94g3a3ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 May 2022 13:39:34 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24QDdWuO28443022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 May 2022 13:39:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E8114C040;
        Thu, 26 May 2022 13:39:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6ECE04C044;
        Thu, 26 May 2022 13:39:26 +0000 (GMT)
Received: from [9.43.96.50] (unknown [9.43.96.50])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 May 2022 13:39:26 +0000 (GMT)
Message-ID: <94fba107-a425-7cf6-2a7b-0562c2dcfce4@linux.ibm.com>
Date:   Thu, 26 May 2022 19:09:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v8 0/7] crash: Kernel handling of CPU and memory hot
 un/plug
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
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <311b0834-c675-fd15-8184-82b122f4a9cc@linux.ibm.com>
 <bffb3d9e-1946-f4b6-d58c-9c44bc0bee26@oracle.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <bffb3d9e-1946-f4b6-d58c-9c44bc0bee26@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TMtScjGuOPJarKMyIiuaNDW2sNZ9NxBR
X-Proofpoint-ORIG-GUID: byNRdpRpU3U4J37GkwzqvFC2PANKnG4v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-26_07,2022-05-25_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205260066
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eric,

On 26/05/22 18:46, Eric DeVolder wrote:
>
>
> On 5/25/22 10:13, Sourabh Jain wrote:
>> Hello Eric,
>>
>> On 06/05/22 00:15, Eric DeVolder wrote:
>>> When the kdump service is loaded, if a CPU or memory is hot
>>> un/plugged, the crash elfcorehdr (for x86), which describes the CPUs
>>> and memory in the system, must also be updated, else the resulting
>>> vmcore is inaccurate (eg. missing either CPU context or memory
>>> regions).
>>>
>>> The current solution utilizes udev to initiate an unload-then-reload
>>> of the kdump image (e. kernel, initrd, boot_params, puratory and
>>> elfcorehdr) by the userspace kexec utility. In previous posts I have
>>> outlined the significant performance problems related to offloading
>>> this activity to userspace.
>>>
>>> This patchset introduces a generic crash hot un/plug handler that
>>> registers with the CPU and memory notifiers. Upon CPU or memory
>>> changes, this generic handler is invoked and performs important
>>> housekeeping, for example obtaining the appropriate lock, and then
>>> invokes an architecture specific handler to do the appropriate
>>> updates.
>>>
>>> In the case of x86_64, the arch specific handler generates a new
>>> elfcorehdr, and overwrites the old one in memory. No involvement
>>> with userspace needed.
>>>
>>> To realize the benefits/test this patchset, one must make a couple
>>> of minor changes to userspace:
>>>
>>>   - Disable the udev rule for updating kdump on hot un/plug changes.
>>>     Add the following as the first two lines to the udev rule file
>>>     /usr/lib/udev/rules.d/98-kexec.rules:
>>
>> If we can have a sysfs attribute to advertise this feature then 
>> userspace
>> utilities (kexec tool/udev rules) can take action accordingly. In 
>> short, it will
>> help us maintain backward compatibility.
>>
>> kexec tool can use the new sysfs attribute and allocate additional 
>> buffer space
>> for elfcorehdr accordingly. Similarly, the checksum-related changes 
>> can come
>> under this check.
>>
>> Udev rule can use this sysfs file to decide kdump service reload is 
>> required or not.
>
> Great idea. I've been working on the corresponding udev and 
> kexec-tools changes and your input/idea here is quite timely.
>
> I have boolean "crash_hotplug" as a core_param(), so it will show up as:
>
> # cat /sys/module/kernel/parameters/crash_hotplug
> N

How about using 0-1 instead Y/N?
0 = crash hotplug not supported
1 = crash hotplug supported

Also how about keeping sysfs here instead?
/sys/kernel/kexec_crash_hotplug

Thanks,
Souabh Jain

