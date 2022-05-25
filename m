Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775A553401E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240574AbiEYPOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbiEYPOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:14:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6FEAF32C
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:14:32 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PEDi2e006422;
        Wed, 25 May 2022 15:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=0DjzLnvXS5m4J+knrVU4+eYeKMRxzRvBJCrI0+BLOEk=;
 b=NCxFnU4JW3DKRstIcl7Y9WrBXZCNM1uDwfIHasQIg8ffLNUC05ejFSPKgdEquAz9Hu2j
 ydUivPhpkAn46TwRTPQ/iz1H5osHLLqEIPCcU8ccT1A86mS8X2oj/k/YLWQteyD1UyHt
 7vWIMa8BUsjq7Yi3TMpStBx+3uWdaSMJDD3lGcFYzCk2pJ07sOAcv2YHN0kgWMVoogni
 OHD4a9mZoNhFgC/2+CeZDoFRJkxzhkrIGRQ7WyY/aiEoTU8lQ0dwKNQy2fWqdAaxBCmS
 6EGSvcj92I56CUyrVrxj2NyK7fHDm82vhfEIEQltjZeP5nXd1ainijszg8LLjhSTWAfv Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g9p1k1cw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 15:14:09 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24PEYLHm026557;
        Wed, 25 May 2022 15:14:08 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g9p1k1cvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 15:14:08 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24PFCNAB029478;
        Wed, 25 May 2022 15:14:06 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3g93uw9c4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 15:14:06 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24PFE41O16515506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 15:14:04 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C31552050;
        Wed, 25 May 2022 15:14:04 +0000 (GMT)
Received: from [9.43.97.219] (unknown [9.43.97.219])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EA0CB5204E;
        Wed, 25 May 2022 15:13:58 +0000 (GMT)
Message-ID: <311b0834-c675-fd15-8184-82b122f4a9cc@linux.ibm.com>
Date:   Wed, 25 May 2022 20:43:57 +0530
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
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20220505184603.1548-1-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6038ib21Rvf4za0EmcR7D5OGLrrgp5HG
X-Proofpoint-ORIG-GUID: Tu2hJ9EDPatzne2PGr8OnG6cIi89npRg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_04,2022-05-25_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205250079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eric,

On 06/05/22 00:15, Eric DeVolder wrote:
> When the kdump service is loaded, if a CPU or memory is hot
> un/plugged, the crash elfcorehdr (for x86), which describes the CPUs
> and memory in the system, must also be updated, else the resulting
> vmcore is inaccurate (eg. missing either CPU context or memory
> regions).
>
> The current solution utilizes udev to initiate an unload-then-reload
> of the kdump image (e. kernel, initrd, boot_params, puratory and
> elfcorehdr) by the userspace kexec utility. In previous posts I have
> outlined the significant performance problems related to offloading
> this activity to userspace.
>
> This patchset introduces a generic crash hot un/plug handler that
> registers with the CPU and memory notifiers. Upon CPU or memory
> changes, this generic handler is invoked and performs important
> housekeeping, for example obtaining the appropriate lock, and then
> invokes an architecture specific handler to do the appropriate
> updates.
>
> In the case of x86_64, the arch specific handler generates a new
> elfcorehdr, and overwrites the old one in memory. No involvement
> with userspace needed.
>
> To realize the benefits/test this patchset, one must make a couple
> of minor changes to userspace:
>
>   - Disable the udev rule for updating kdump on hot un/plug changes.
>     Add the following as the first two lines to the udev rule file
>     /usr/lib/udev/rules.d/98-kexec.rules:

If we can have a sysfs attribute to advertise this feature then userspace
utilities (kexec tool/udev rules) can take action accordingly. In short, 
it will
help us maintain backward compatibility.

kexec tool can use the new sysfs attribute and allocate additional 
buffer space
for elfcorehdr accordingly. Similarly, the checksum-related changes can come
under this check.

Udev rule can use this sysfs file to decide kdump service reload is 
required or not.

Thanks,
Sourabh Jain

