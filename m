Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16ED4892FF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239730AbiAJIFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:05:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46146 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236425AbiAJIFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:05:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641801914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gnfg0zplfFWqAUnnKnBRs+j7M9pGoVZQ/DoRm2CIx6Q=;
        b=EURPqcBjgpr+81LSwT70XfHpB/rsb8KlI+RBlgi7HPc+l39tIR6hzOnI9NJcX05Zvj2Coe
        0K3lVLpl5Rfpkh3wpSQ+fsDfMnVAuN2ALMCerv+5hsN/yIs6f42CwxrAAWUJP95KmYumNf
        fm6cCwu4UBr+P2Z/twi99oiOE58uXjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-Bkc1YkIcNZqmrsSzAEc9eQ-1; Mon, 10 Jan 2022 03:05:12 -0500
X-MC-Unique: Bkc1YkIcNZqmrsSzAEc9eQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA88461246;
        Mon, 10 Jan 2022 08:05:09 +0000 (UTC)
Received: from localhost (ovpn-12-198.pek2.redhat.com [10.72.12.198])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B158570D21;
        Mon, 10 Jan 2022 08:04:59 +0000 (UTC)
Date:   Mon, 10 Jan 2022 16:04:56 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [RFC v2 0/6] crash: Kernel handling of CPU and memory hot un/plug
Message-ID: <20220110080456.GG2731@MiWiFi-R3L-srv>
References: <20211207195204.1582-1-eric.devolder@oracle.com>
 <d2d301e2-62df-512d-058a-a9b890e12dfb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2d301e2-62df-512d-058a-a9b890e12dfb@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 01/05/22 at 08:25am, Eric DeVolder wrote:
> Nudge...
> 
> Fwiw, below is a working changeset to kexec userspace utility that allows the kexec_load
> path to work similarly to the kexec_file_load path of this RFC. With both the following
> userspace kexec patch and this RFC, both kexec_load and kexec_file_load work with changes
> due to hotplug *without* unloading-then-reloading the kdump/capture kernel.

Thanks for taking a try on that, and sorry for late response because of
somethings at hand.

I will review this v2 round. When applying them, I encountered some
conflict, could you please rebase these on the ltest 5.16 and send me
a tar ball privately, or a github branch is also welcome. Thanks in
advance.


Thanks
Baoquan

> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 9826f6d..06adb7e 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -48,6 +48,7 @@
>  #include <x86/x86-linux.h>
> 
>  extern struct arch_options_t arch_options;
> +extern unsigned long long hotplug_size;
> 
>  static int get_kernel_page_offset(struct kexec_info *UNUSED(info),
>  				  struct crash_elf_info *elf_info)
> @@ -975,6 +976,13 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>  	} else {
>  		memsz = bufsz;
>  	}
> +
> +    /* If hotplug support enabled, use that size */
> +    if (hotplug_size) {
> +        memsz = hotplug_size;
> +    }
> +
> +    info->elfcorehdr =
>  	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
>  							max_addr, -1);
>  	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index f63b36b..9569d9a 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -58,6 +58,7 @@
> 
>  unsigned long long mem_min = 0;
>  unsigned long long mem_max = ULONG_MAX;
> +unsigned long long hotplug_size = 0;
>  static unsigned long kexec_flags = 0;
>  /* Flags for kexec file (fd) based syscall */
>  static unsigned long kexec_file_flags = 0;
> @@ -672,6 +673,12 @@ static void update_purgatory(struct kexec_info *info)
>  		if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
>  			continue;
>  		}
> +        /* Don't include elfcorehdr in the checksum, if hotplug
> +         * support enabled.
> +         */
> +        if (hotplug_size && (info->segment[i].mem == (void *)info->elfcorehdr)) {
> +			continue;
> +		}
>  		sha256_update(&ctx, info->segment[i].buf,
>  			      info->segment[i].bufsz);
>  		nullsz = info->segment[i].memsz - info->segment[i].bufsz;
> @@ -1504,6 +1511,17 @@ int main(int argc, char *argv[])
>  		case OPT_PRINT_CKR_SIZE:
>  			print_crashkernel_region_size();
>  			return 0;
> +		case OPT_HOTPLUG_SIZE:
> +            /* Reserved the specified size for hotplug growth */
> +			hotplug_size = strtoul(optarg, &endptr, 0);
> +			if (*endptr) {
> +				fprintf(stderr,
> +					"Bad option value in --hotplug-size=%s\n",
> +					optarg);
> +				usage();
> +				return 1;
> +			}
> +			break;
>  		default:
>  			break;
>  		}
> diff --git a/kexec/kexec.h b/kexec/kexec.h
> index 595dd68..b30dda4 100644
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -169,6 +169,7 @@ struct kexec_info {
>  	int command_line_len;
> 
>  	int skip_checks;
> +    unsigned long elfcorehdr;
>  };
> 
>  struct arch_map_entry {
> @@ -231,7 +232,8 @@ extern int file_types;
>  #define OPT_PRINT_CKR_SIZE	262
>  #define OPT_LOAD_LIVE_UPDATE	263
>  #define OPT_EXEC_LIVE_UPDATE	264
> -#define OPT_MAX			265
> +#define OPT_HOTPLUG_SIZE	265
> +#define OPT_MAX			266
>  #define KEXEC_OPTIONS \
>  	{ "help",		0, 0, OPT_HELP }, \
>  	{ "version",		0, 0, OPT_VERSION }, \
> @@ -258,6 +260,7 @@ extern int file_types;
>  	{ "debug",		0, 0, OPT_DEBUG }, \
>  	{ "status",		0, 0, OPT_STATUS }, \
>  	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
> +	{ "hotplug-size",     2, 0, OPT_HOTPLUG_SIZE }, \
> 
>  #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
> 
> 
> 
> On 12/7/21 13:51, Eric DeVolder wrote:
> > When the kdump service is loaded, if a CPU or memory is hot
> > un/plugged, the crash elfcorehdr (for x86), which describes the CPUs
> > and memory in the system, must also be updated, else the resulting
> > vmcore is inaccurate (eg. missing either CPU context or memory
> > regions).
> > 
> > The current solution utilizes udev to initiate an unload-then-reload
> > of the kdump image (e. kernel, initrd, boot_params, puratory and
> > elfcorehdr) by the userspace kexec utility. In previous posts I have
> > outlined the significant performance problems related to offloading
> > this activity to userspace.
> > 
> > This patchset introduces a generic crash hot un/plug handler that
> > registers with the CPU and memory notifiers. Upon CPU or memory
> > changes, this generic handler is invoked and performs important
> > housekeeping, for example obtaining the appropriate lock, and then
> > invokes an architecture specific handler to do the appropriate
> > updates.
> > 
> > In the case of x86_64, the arch specific handler generates a new
> > elfcorehdr, and overwrites the old one in memory. No involvement
> > with userspace needed.
> > 
> > To realize the benefits/test this patchset, one must make a couple
> > of minor changes to userspace:
> > 
> >   - Disable the udev rule for updating kdump on hot un/plug changes
> >     Eg. on RHEL: rm -f /usr/lib/udev/rules.d/98-kexec.rules
> >     or other technique to neuter the rule.
> > 
> >   - Change to the kexec_file_load for loading the kdump kernel:
> >     Eg. on RHEL: in /usr/bin/kdumpctl, change to:
> >      standard_kexec_args="-p -d -s"
> >     which adds the -s to select kexec_file_load syscall.
> > 
> > This patchset supports kexec_load with a modified kexec userspace
> > utility, on which I am current working to provide separately.
> > 
> > Regards,
> > eric
> > ---
> > RFC v2: 7dec2021
> >   - Acting upon Baoquan He suggestion of removing elfcorehdr from
> >     the purgatory list of segments, removed purgatory code from
> >     patchset, and it is signficiantly simpler now.
> > 
> > RFC v1: 18nov2021
> >   https://lkml.org/lkml/2021/11/18/845
> >   - working patchset demonstrating kernel handling of hotplug
> >     updates to x86 elfcorehdr for kexec_file_load
> > 
> > RFC: 14dec2020
> >   https://lkml.org/lkml/2020/12/14/532
> >   - proposed concept of allowing kernel to handle hotplug update
> >     of elfcorehdr
> > ---
> > 
> > 
> > Eric DeVolder (6):
> >    crash: fix minor typo/bug in debug message
> >    crash hp: Introduce CRASH_HOTPLUG configuration options
> >    crash hp: definitions and prototype changes
> >    crash hp: generic crash hotplug support infrastructure
> >    crash hp: kexec_file changes for crash hotplug support
> >    crash hp: Add x86 crash hotplug support
> > 
> >   arch/x86/Kconfig        |  26 ++++++++
> >   arch/x86/kernel/crash.c | 140 +++++++++++++++++++++++++++++++++++++++-
> >   include/linux/kexec.h   |  21 +++++-
> >   kernel/crash_core.c     | 118 +++++++++++++++++++++++++++++++++
> >   kernel/kexec_file.c     |  15 ++++-
> >   5 files changed, 314 insertions(+), 6 deletions(-)
> > 
> 

