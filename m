Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1824B49DAFD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbiA0GvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:51:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53987 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232546AbiA0GvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643266271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jqSQKHQdKLPopsdQjpuu8crMgG7G1jlGNJ7fFdnQxRI=;
        b=ghbiFGz3x06yG1x9vTtYLH78Y2E4TAlwy0ho6q9eyFLDoJgsuVkG50qlzTjW//XAzQAJ+K
        cOQjHkC7VSSaPz9wxRxJ9hy+6sYb93HF8RMQJXOudipzD7AGegeJFreHFNYsOg4kw4k3Lt
        8x+HiIrQ4sBVMt2bB9lJ6NatYmy+Wxc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-d9F10aJ1PaODB6B2W1skog-1; Thu, 27 Jan 2022 01:51:08 -0500
X-MC-Unique: d9F10aJ1PaODB6B2W1skog-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5676343CC;
        Thu, 27 Jan 2022 06:51:05 +0000 (UTC)
Received: from localhost (ovpn-13-51.pek2.redhat.com [10.72.13.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 142095DBB9;
        Thu, 27 Jan 2022 06:51:03 +0000 (UTC)
Date:   Thu, 27 Jan 2022 14:51:01 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v3 0/6] crash: Kernel handling of CPU and memory hot
 un/plug
Message-ID: <20220127065101.GA13508@MiWiFi-R3L-srv>
References: <20220110195727.1682-1-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110195727.1682-1-eric.devolder@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 01/10/22 at 02:57pm, Eric DeVolder wrote:
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

About patch splitting, it is always a headache to me when I post
patches. Both too coarse or too small granularity are not good. But we
should obey two rules:
1) commits had better be bisectable, so that later we find out which
   commit cause issue or regression easier. Here, your patch 5/6 and 6/6 are
   obviously breaking the rule. Because crash_prepare_elf64_headers()'s
   protype has been changed, its invokation is not modified accodingly.

2) Each patch only cover one action, bad better not stack too much in
one patch. Surely, we should avoid to scatter one thing into several
patch, it's not easy to reivew. E.g in this patchset, kexec_load can be
taken out, for this we have discussed. Skipping the elfcorehdr digest
can be taken out, its code change is simple, while it's worth to tell
the reason in a patch.

So my suggestion to rearrange the patchset as below, please take it as a
reference.
1)crash: fix minor typo/bug in debug message
2)crash hp: Introduce CRASH_HOTPLUG configuration options
3)crash hp: definitions and prototype changes
  Note: this patch need cover those invokation of crash_prepare_elf64_headers.
  Otherwise it's not bisectable.
4)crash hp: introduce helper function map_crash_pages/unmap_crash_pages
5)crash hp: generic crash hotplug support infrastructure
6)crash hp: exclude elfcorehdr from the segment checksum calculation
7)crash hp: exclude hot removed cpu from cpu notes of elfcorehdr
  this includes the assigment part in crash_hotplug_handler() and 
  usage part in crash_prepare_elf64_headers().
8)crash hp/x86: add the crash hp support for x86

Above patch splitting and patch subject may not be appropriate, please
adust or change with your understanding.

> 
> To realize the benefits/test this patchset, one must make a couple
> of minor changes to userspace:
> 
>  - Disable the udev rule for updating kdump on hot un/plug changes
>    Eg. on RHEL: rm -f /usr/lib/udev/rules.d/98-kexec.rules
>    or other technique to neuter the rule.
> 
>  - Change to the kexec_file_load for loading the kdump kernel:
>    Eg. on RHEL: in /usr/bin/kdumpctl, change to:
>     standard_kexec_args="-p -d -s"
>    which adds the -s to select kexec_file_load syscall.
> 
> This patchset supports kexec_load with a modified kexec userspace
> utility, and a working changeset to the kexec userspace utility
> is provided here (and to use, the above change to standard_kexec_args
> would be, for example, to append --hotplug-size=262144 instead of -s).
> 
>  diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
>  index 9826f6d..06adb7e 100644
>  --- a/kexec/arch/i386/crashdump-x86.c
>  +++ b/kexec/arch/i386/crashdump-x86.c
>  @@ -48,6 +48,7 @@
>   #include <x86/x86-linux.h>
>   
>   extern struct arch_options_t arch_options;
>  +extern unsigned long long hotplug_size;
>   
>   static int get_kernel_page_offset(struct kexec_info *UNUSED(info),
>   				  struct crash_elf_info *elf_info)
>  @@ -975,6 +976,13 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>   	} else {
>   		memsz = bufsz;
>   	}
>  +
>  +    /* If hotplug support enabled, use that size */
>  +    if (hotplug_size) {
>  +        memsz = hotplug_size;
>  +    }
>  +
>  +    info->elfcorehdr =
>   	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
>   							max_addr, -1);
>   	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
>  diff --git a/kexec/kexec.c b/kexec/kexec.c
>  index f63b36b..9569d9a 100644
>  --- a/kexec/kexec.c
>  +++ b/kexec/kexec.c
>  @@ -58,6 +58,7 @@
>   
>   unsigned long long mem_min = 0;
>   unsigned long long mem_max = ULONG_MAX;
>  +unsigned long long hotplug_size = 0;
>   static unsigned long kexec_flags = 0;
>   /* Flags for kexec file (fd) based syscall */
>   static unsigned long kexec_file_flags = 0;
>  @@ -672,6 +673,12 @@ static void update_purgatory(struct kexec_info *info)
>   		if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
>   			continue;
>   		}
>  +        /* Don't include elfcorehdr in the checksum, if hotplug
>  +         * support enabled.
>  +         */
>  +        if (hotplug_size && (info->segment[i].mem == (void *)info->elfcorehdr)) {
>  +			continue;
>  +		}
>   		sha256_update(&ctx, info->segment[i].buf,
>   			      info->segment[i].bufsz);
>   		nullsz = info->segment[i].memsz - info->segment[i].bufsz;
>  @@ -1504,6 +1511,17 @@ int main(int argc, char *argv[])
>   		case OPT_PRINT_CKR_SIZE:
>   			print_crashkernel_region_size();
>   			return 0;
>  +		case OPT_HOTPLUG_SIZE:
>  +            /* Reserved the specified size for hotplug growth */
>  +			hotplug_size = strtoul(optarg, &endptr, 0);
>  +			if (*endptr) {
>  +				fprintf(stderr,
>  +					"Bad option value in --hotplug-size=%s\n",
>  +					optarg);
>  +				usage();
>  +				return 1;
>  +			}
>  +			break;
>   		default:
>   			break;
>   		}
>  diff --git a/kexec/kexec.h b/kexec/kexec.h
>  index 595dd68..b30dda4 100644
>  --- a/kexec/kexec.h
>  +++ b/kexec/kexec.h
>  @@ -169,6 +169,7 @@ struct kexec_info {
>   	int command_line_len;
>   
>   	int skip_checks;
>  +    unsigned long elfcorehdr;
>    };
>   
>   struct arch_map_entry {
>  @@ -231,7 +232,8 @@ extern int file_types;
>   #define OPT_PRINT_CKR_SIZE	262
>   #define OPT_LOAD_LIVE_UPDATE	263
>   #define OPT_EXEC_LIVE_UPDATE	264
>  -#define OPT_MAX			265
>  +#define OPT_HOTPLUG_SIZE	265
>  +#define OPT_MAX			266
>   #define KEXEC_OPTIONS \
>   	{ "help",		0, 0, OPT_HELP }, \
>   	{ "version",		0, 0, OPT_VERSION }, \
>  @@ -258,6 +260,7 @@ extern int file_types;
>   	{ "debug",		0, 0, OPT_DEBUG }, \
>   	{ "status",		0, 0, OPT_STATUS }, \
>   	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
>  +	{ "hotplug-size",     2, 0, OPT_HOTPLUG_SIZE }, \
>   
>   #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
>  
> 
> Regards,
> eric
> ---
> v3: 10jan2022
>  - Rebasing per Baoquan He request.
>  - Changed memory notifier per David Hildenbrand.
>  - Providing example kexec userspace change in cover letter.
> 
> RFC v2: 7dec2021
>  https://lkml.org/lkml/2021/12/7/1088
>  - Acting upon Baoquan He suggestion of removing elfcorehdr from
>    the purgatory list of segments, removed purgatory code from
>    patchset, and it is signficiantly simpler now.
> 
> RFC v1: 18nov2021
>  https://lkml.org/lkml/2021/11/18/845
>  - working patchset demonstrating kernel handling of hotplug
>    updates to x86 elfcorehdr for kexec_file_load
> 
> RFC: 14dec2020
>  https://lkml.org/lkml/2020/12/14/532
>  - proposed concept of allowing kernel to handle hotplug update
>    of elfcorehdr
> ---
> 
> Eric DeVolder (6):
>   crash: fix minor typo/bug in debug message
>   crash hp: Introduce CRASH_HOTPLUG configuration options
>   crash hp: definitions and prototype changes
>   crash hp: generic crash hotplug support infrastructure
>   crash hp: kexec_file changes for crash hotplug support
>   crash hp: Add x86 crash hotplug support
> 
>  arch/x86/Kconfig        |  26 ++++++++
>  arch/x86/kernel/crash.c | 140 +++++++++++++++++++++++++++++++++++++++-
>  include/linux/kexec.h   |  21 +++++-
>  kernel/crash_core.c     | 117 +++++++++++++++++++++++++++++++++
>  kernel/kexec_file.c     |  15 ++++-
>  5 files changed, 313 insertions(+), 6 deletions(-)
> 
> -- 
> 2.27.0
> 

