Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C917461076
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 09:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244300AbhK2IvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 03:51:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22566 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241496AbhK2ItQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 03:49:16 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AT8Rfpr029176;
        Mon, 29 Nov 2021 08:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=4UWGRR+XSLt7x3aseU8SedIXap0/dngzGhZIg/c6Il4=;
 b=SOYiJ6vZpx8akG3b3X2SJxAQMEZAejTNrb7/HQJ/zf37XmQUcTGX5ck5ltzLak0UAVMA
 Ph6RGOt/+rNHowPv7fuGgTjCc7JuBOMUdhy34ABISKh28oXT623wN4d927V/JMwF8z7H
 oqhmM4KLXluJmzBM51UT4gSxsMMTSx3Swl5xAcp12vJGq6eUDTKiikBYQVDSg7RtnHRY
 5Gw6Ibb5ArvPwSiDqgdq3VmO4eiKga+sQflUP/MWKTOPsqZx3/WBb9YcHO33lkrMXard
 Z6lEPVCYYeEl+OzhssObDpkNAHhE4u7RuuEUIAqdrzFdqOLoir/mYanZHf1jKqjo7YLq nA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cmuca8ap5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 08:45:20 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AT8agFo019389;
        Mon, 29 Nov 2021 08:45:20 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cmuca8anj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 08:45:20 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AT8c9Mi016132;
        Mon, 29 Nov 2021 08:45:18 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3ckbxjjds2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 08:45:18 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AT8jFEa1376868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 08:45:15 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE5FB11C058;
        Mon, 29 Nov 2021 08:45:15 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F401D11C04C;
        Mon, 29 Nov 2021 08:45:10 +0000 (GMT)
Received: from [9.43.63.177] (unknown [9.43.63.177])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Nov 2021 08:45:10 +0000 (GMT)
Message-ID: <46fda107-56f9-0052-892a-932875447b0a@linux.ibm.com>
Date:   Mon, 29 Nov 2021 14:15:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v1 0/8] RFC v1: Kernel handling of CPU and memory hot
 un/plug for crash
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20211118174948.37435-1-eric.devolder@oracle.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20211118174948.37435-1-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JJ-k-Jwua6DdJQgrtRE-wQlKUpDC6VoI
X-Proofpoint-GUID: jxOhCKcEeASQUBnsoWxfMGyBUaknYRXp
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_05,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 spamscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290042
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eric,

On 18/11/21 23:19, Eric DeVolder wrote:
> When the kdump service is loaded, if a CPU or memory is hot
> un/plugged, the crash elfcorehdr which describes the CPUs and memory
> in the system, must also be updated, else the resulting vmcore is
> inaccurate (eg. missing either CPU context or memory regions).
>
> The current solution utilizes udev to initiate an unload-then-reload
> of the kdump image (e. kernel, initrd, boot_params, puratory and
> elfcorehdr) by the userspace kexec utility.
>
> In the post https://lkml.org/lkml/2020/12/14/532 I outlined two
> problems with this userspace-initiated unload-then-reload approach as
> it pertains to supporting CPU and memory hot un/plug for kdump.
> (Note in that post, I erroneously called the elfcorehdr the vmcoreinfo
> structure. There is a vmcoreinfo structure, but it has a different
> purpose. So in that post substitute "elfcorehdr" for "vmcoreinfo".)
>
> The first problem being the time needed to complete the unload-then-
> reload of the kdump image, and the second being the effective race
> window that unload-then-reload effort creates.
>
> The scenario I measured was a 32GiB guest being resized to 512GiB and
> observing it took over 4 minutes for udev to "settle down" and
> complete the unload-then-reload of the resulting 3840 hot plug events.
> Empirical evidence within our fleet substantiates this problem.
>
> Each unload-then-reload creates a race window the size of which is the
> time it takes to reload the complete kdump image. Within the race
> window, kdump is not loaded and should a panic occur, the kernel halts
> rather than dumping core via kdump.
>
> This patchset significantly improves upon the current solution by
> enabling the kernel to update only the necessary items of the kdump
> image. In the case of x86_64, that is just the elfcorehdr and the
> purgatory segments. These updates occur as fast as the hot un/plug
> events and significantly reduce the size of the race window.
>
> This patchset introduces a generic crash hot un/plug handler that
> registers with the CPU and memory notifiers. Upon CPU or memory
> changes, this generic handler is invoked and performs important
> housekeeping, for example obtaining the appropriate lock, and then
> invokes an architecture specific handler to do the appropriate
> updates.
>
> In the case of x86_64, the arch specific handler generates a new
> elfcorehdr, which reflects the current CPUs and memory regions, into a
> buffer. Since purgatory also does an integrity check via hash digests
> of the loaded segments, purgatory must also be updated with the new
> digests. The arch handler also generates a new purgatory into a
> buffer, performs the hash digests of the new memory segments, and then
> patches purgatory with the new digests.  If all succeeds, then the
> elfcorehdr and purgatory buffers over write the existing buffers and
> the new kdump image is live and ready to go. No involvement with
> userspace at all.
>
> To accommodate a growing number of resources via hotplug, the
> elfcorehdr memory must be sufficiently large enough to accommodate
> changes. The CRASH_HOTPLUG_ELFCOREHDR_SZ configure item does just
> this.
>
> To realize the benefits/test this patchset, one must make a couple
> of minor changes to userspace:
>
>   - Disable the udev rule for updating kdump on hot un/plug changes
>     Eg. on RHEL: rm -f /usr/lib/udev/rules.d/98-kexec.rules
>     or other technique to neuter the rule.
>
>   - Change to the kexec_file_load for loading the kdump kernel:
>     Eg. on RHEL: in /usr/bin/kdumpctl, change to:
>      standard_kexec_args="-p -d -s"
>     which adds the -s to select kexec_file_load syscall.
>
> This work has raised the following questions for me:
>
> First and foremost, this patch only works for the kexec_file_load
> syscall path (via "kexec -s -p" utility). The reason being that, for
> x86_64 anyway, the purgatory blob provided by userspace can not be
> readily decoded in order to update the hash digest. (The
> kexec_file_load purgatory is actually a small ELF object with symbols,
> so can be patched at run time.) With no way to update purgatory, the
> integrity check will always fail and and cause purgatory to hang at
> panic time.


We are designing a solution for a similar problem in PowerPC. Agree that
manipulating kexec segment in the kernel for kexec_load system call is
bit complex compare to kexec_file_load system call due to SHA verification
in purgatory.

What if we have a pre-allocated memory hole for the kexec segment
and ask kexec to use that and skip the SHA verification for the same.
For example, on PowerPC, all the CPUs and memory-related info is part
of FDT. Whenever there is hotplug event we have to update the kdump
  FDT segment to provide correct details to the kdump kernel.

  One way to keep the kdump FDT up-to-date with the latest CPU and memory
is to load the kdump FDT to the pre-allocated memory hole for both 
kexec_load
and kexec_file_laod system call and let the kernel keep updating the FDT
on hotplug event.

Adapting the above solution for the kexec_file_load case is easy because
we do everything in the kernel. But what about the kexec_load system 
call? How
kexec tool will know about this pre-allocated memory hole? What will happen
to digest verification if the kernel updates the kdump FDT segment post 
kdump
load?

The kernel will expose the pre-allocated memory to userspace via a 
sysfs. When kexec
tool loads the kexec segments it will check for this pre-allocated 
memory for
kdump FDT and if available it will use it and skip the SHA verification
for the same.

  Please provide your input on the above method of handling things for 
the kexec_file system call?

  I am still reviewing your patch series.

Thanks,
Sourabh Jain

> That being said, I actually developed this against the kexec_load path
> and did have that working by making two one-line changes to userspace
> kexec utility: one change that effectively is
> CRASH_HOTPLUG_ELFCOREHDR_SZ and the other to disable the integrity
> check. But that does not seem to be a long term solution. A possible
> long term solution would be to allow the use of the kexec_file_load
> purgatory ELF object with the kexec_load path. While I believe that
> would work, I am unsure if there are any downsides to doing so.
>
> The second problem is the use of CPUHP_AP_ONLINE_DYN.  The
> cpuhp_setup_state_nocalls() is invoked with parameter
> CPUHP_AP_ONLINE_DYN. While this works, when a CPU is being unplugged,
> the CPU still shows up in foreach_present_cpu() during the
> regeneration of the elfcorehdr, thus the need to explicitly check and
> exclude the soon-to-be offlined CPU in crash_prepare_elf64_headers().
> Perhaps if value(s) new/different than CPUHP_AP_ONLINE_DYN to
> cpuhp_setup_state() was utilized, then the offline cpu would no longer
> be in foreach_present_cpu(), and this change could be eliminated. I do
> not understand cpuhp_setup_state() well enough to choose, or create,
> appropriate value(s).
>
> The third problem is the number of memory hot un/plug events.  If, for
> example, a 1GiB DIMM is hotplugged, that generate 8 memory events, one
> for each 128MiB memblock, yet the walk_system_ram_res() that is used
> to obtain the list of memory regions reports the single 1GiB; thus
> there are 7 un-necessary trips through this crash hotplug handler.
> Perhaps there is another way of handling memory events that would see
> the single 1GiB DIMM rather than each memblock?
>
> Regards,
> eric
>
> Eric DeVolder (8):
>    crash: fix minor typo/bug in debug message
>    crash hp: Introduce CRASH_HOTPLUG configuration options
>    crash hp: definitions and prototypes for crash hotplug support
>    crash hp: generic crash hotplug support infrastructure
>    crash hp: kexec_file changes for use by crash hotplug handler
>    crash hp: Add x86 crash hotplug state items to kimage
>    crash hp: Add x86 crash hotplug support for kexec_file_load
>    crash hp: Add x86 crash hotplug support for bzImage
>
>   arch/x86/Kconfig                  |  26 +++
>   arch/x86/include/asm/kexec.h      |  10 ++
>   arch/x86/kernel/crash.c           | 257 +++++++++++++++++++++++++++++-
>   arch/x86/kernel/kexec-bzimage64.c |  12 ++
>   include/linux/kexec.h             |  22 ++-
>   kernel/crash_core.c               | 118 ++++++++++++++
>   kernel/kexec_file.c               |  19 ++-
>   7 files changed, 455 insertions(+), 9 deletions(-)
>
