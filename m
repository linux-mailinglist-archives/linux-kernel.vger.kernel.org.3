Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C1950EFBE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 06:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243692AbiDZEZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 00:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243595AbiDZEZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 00:25:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E33403F9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 21:22:04 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q4LQBU005345;
        Tue, 26 Apr 2022 04:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2/fQk89JEXb6HOl2nGgxcVh3NB6YIdzwBY+8gIMWyeo=;
 b=iw+pOWiKeYF0A3/BN3klPg3Zk7yip41mxPwFDUETk3n+663NdmM/f1JwilazycNCLMSA
 PAJP80M5+FHeRv6pjLcU6hIgSPY+nK0F5KCosJBem5+Nf4T21wOqL51DdWw+cli4qObZ
 HW3a+j60khedpE0IyQOs1G09k2YJDd0PUG24UjNsEsWDmPK8SkqSQqjeuuXOdTFmXz26
 LBZJx7ORycgib1ZkPJvdUTqZlZkg04F4D/JP25ctas98lOmNKz6yMB9SoXTy9Dg3/0ds
 i9crqN+KAYLuyRDlE8VOVH0HGQMqi1yLbVw7QZkha/ApMDsPTSPn+nEkYatMWmvrluId aA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fp9mm8043-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 04:21:38 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23Q4Lb5w005953;
        Tue, 26 Apr 2022 04:21:37 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fp9mm803k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 04:21:37 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23Q4CPrc004097;
        Tue, 26 Apr 2022 04:21:34 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3fm938uct7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 04:21:34 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23Q4LWJU38142228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 04:21:32 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22D9511C050;
        Tue, 26 Apr 2022 04:21:32 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BE5011C04A;
        Tue, 26 Apr 2022 04:21:26 +0000 (GMT)
Received: from [9.43.122.72] (unknown [9.43.122.72])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Apr 2022 04:21:26 +0000 (GMT)
Message-ID: <d90f4299-e821-f5d5-957a-1e84f16816e0@linux.ibm.com>
Date:   Tue, 26 Apr 2022 09:51:25 +0530
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
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20220413164237.20845-3-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wh0nQsxbRbPAkwSyU9n48PrHg-nXTkAv
X-Proofpoint-GUID: FQjg4weKQ7XQzy3NHMM8WmWqZhoqU_pA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_01,2022-04-25_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260024
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/04/22 22:12, Eric DeVolder wrote:
> CRASH_HOTPLUG is to enable cpu and memory hotplug support of crash.
>
> CRASH_HOTPLUG_ELFCOREHDR_SZ is used to specify the maximum size of
> the elfcorehdr buffer/segment.
>
> This is a preparation for later usage.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>   arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index b0142e01002e..f7b92ee1bcc7 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2072,6 +2072,32 @@ config CRASH_DUMP
>   	  (CONFIG_RELOCATABLE=y).
>   	  For more details see Documentation/admin-guide/kdump/kdump.rst
>   
> +config CRASH_HOTPLUG
> +	bool "kernel updates of crash elfcorehdr"
> +	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG) && KEXEC_FILE
> +	help
> +	  Enable the kernel to update the crash elfcorehdr (which contains
> +	  the list of CPUs and memory regions) directly when hot plug/unplug
> +	  of CPUs or memory. Otherwise userspace must monitor these hot
> +	  plug/unplug change notifications via udev in order to
> +	  unload-then-reload the crash kernel so that the list of CPUs and
> +	  memory regions is kept up-to-date. Note that the udev CPU and
> +	  memory change notifications still occur (however, userspace is not
> +	  required to monitor for crash dump purposes).
> +
> +config CRASH_HOTPLUG_ELFCOREHDR_SZ
> +	depends on CRASH_HOTPLUG
> +	int
> +	default 131072
> +	help
> +	  Specify the maximum size of the elfcorehdr buffer/segment.
> +	  The 128KiB default is sized so that it can accommodate 2048
> +	  Elf64_Phdr, where each Phdr represents either a CPU or a
> +	  region of memory.
> +	  For example, this size can accommodate a machine with up to 1024
> +	  CPUs and up to 1024 memory regions, eg. as represented by the
> +	  'System RAM' entries in /proc/iomem.

Is it possible to get rid of CRASH_HOTPLUG_ELFCOREHDR_SZ?

How about finding the additional buffer space needed for future CPU and memory
add during the kdump load? Not sure about the feasibility of doing this in
kexec tool (userspace).

Thanks,
Sourabh Jain

  

