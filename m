Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F4057C172
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 02:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiGUAI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 20:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiGUAIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 20:08:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E46A74E2B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 17:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658362087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbv739AZyL6A/AebD7p566yrz0K8D+GAOYHa2HePZks=;
        b=iTMrGMr2ZxtLRxVWJIplnK8nl6JCMX3G495GCCsSJqGcZo6j5ZCTO30q0KgmGOu5WdF1It
        7jP6WUgUWMGUPSj1zxQBeNiVtb0JEyuA3yXNln20WUa3PT7pjQ3Mrqg8XaA5Wh3WOwpx8J
        irRSgzy4BaxXjwld1JUt1fOCeLJYQ/A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-Y4xVkeU7OOyM1LvB2ElfTA-1; Wed, 20 Jul 2022 20:08:04 -0400
X-MC-Unique: Y4xVkeU7OOyM1LvB2ElfTA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A116880029D;
        Thu, 21 Jul 2022 00:08:03 +0000 (UTC)
Received: from localhost (ovpn-12-68.pek2.redhat.com [10.72.12.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 49B13492C3B;
        Thu, 21 Jul 2022 00:08:01 +0000 (UTC)
Date:   Thu, 21 Jul 2022 08:07:57 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v9 0/7] crash: Kernel handling of CPU and memory hot
 un/plug
Message-ID: <YtiY3SI0UWAUBr9F@MiWiFi-R3L-srv>
References: <20220613224240.79400-1-eric.devolder@oracle.com>
 <51e85040-5622-dae2-dc28-f167660184f0@oracle.com>
 <YsTiUXjVL1ativXJ@MiWiFi-R3L-srv>
 <176bd603-05e9-2235-4052-dcca446098d7@oracle.com>
 <4ec347fb-0f1b-868d-d8a2-bc88a9f2ad54@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ec347fb-0f1b-868d-d8a2-bc88a9f2ad54@oracle.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/22 at 02:08pm, Eric DeVolder wrote:
> Baoquan,
> I believe I've addressed all feedback, just checking to see if you agree.
> I have the next patch set ready in the event you think it a good idea to post it.
> Thanks!

Thanks for the effort. Please post them for reviewing. The newly made
change in this rounds looks good to me, esp the sysfs adding is very
great.

> 
> 
> On 7/7/22 08:05, Eric DeVolder wrote:
> > 
> > 
> > On 7/5/22 20:16, Baoquan He wrote:
> > > On 07/05/22 at 10:17am, Eric DeVolder wrote:
> > > > Nudge...
> > > > Thanks!
> > > 
> > > Seems DavidH has concern and rasied it after you posted v9. Is that
> > > solved?
> > 
> > In looking at David's comments on v8:
> > - [PATCH v8 2/7] crash: prototype change for crash_prepare_elf64_headers
> >    I adjusted per feedback and responded as such. He provided an Acked-by.
> > 
> > - [PATCH v8 3/7] crash: add generic infrastructure for crash hotplug support
> >    He says do not use WARN* on expected error paths. I instead used WARN_ONCE(),
> >    but I didn't consider this an error path. Nonetheless, I'll remove the
> >    message altogether in v11.
> > 
> > - [PATCH v8 0/7] crash: Kernel handling of CPU and memory hot un/plug
> >    David muses about a better name, but that was in response to Sourabh's
> >    and I exchange on the sysfs attributes to use to report the presence
> >    of this feature. In the end, I used something altogether different, as
> >    presented in v10 (and the corresponding udev solution/change that goes
> >    hand in hand with it).
> > 
> > Let me know if I've missed anything else? Sourabh points out a build problem
> > for architectures without this feature support, so a v11 is warranted. But I'll
> > wait to post that until I hear that I've addressed the previous questions.
> > 
> > Thanks,
> > eric
> > 
> > 
> > > 
> > > > 
> > > > On 6/13/22 17:42, Eric DeVolder wrote:
> > > > > When the kdump service is loaded, if a CPU or memory is hot
> > > > > un/plugged, the crash elfcorehdr (for x86), which describes the CPUs
> > > > > and memory in the system, must also be updated, else the resulting
> > > > > vmcore is inaccurate (eg. missing either CPU context or memory
> > > > > regions).
> > > > > 
> > > > > The current solution utilizes udev to initiate an unload-then-reload
> > > > > of the kdump image (e. kernel, initrd, boot_params, puratory and
> > > > > elfcorehdr) by the userspace kexec utility. In previous posts I have
> > > > > outlined the significant performance problems related to offloading
> > > > > this activity to userspace.
> > > > > 
> > > > > This patchset introduces a generic crash hot un/plug handler that
> > > > > registers with the CPU and memory notifiers. Upon CPU or memory
> > > > > changes, this generic handler is invoked and performs important
> > > > > housekeeping, for example obtaining the appropriate lock, and then
> > > > > invokes an architecture specific handler to do the appropriate
> > > > > updates.
> > > > > 
> > > > > In the case of x86_64, the arch specific handler generates a new
> > > > > elfcorehdr, and overwrites the old one in memory. No involvement
> > > > > with userspace needed.
> > > > > 
> > > > > To realize the benefits/test this patchset, one must make a couple
> > > > > of minor changes to userspace:
> > > > > 
> > > > >    - Prevent udev from updating kdump crash kernel on hot un/plug changes.
> > > > >      Add the following as the first lines to the udev rule file
> > > > >      /usr/lib/udev/rules.d/98-kexec.rules:
> > > > > 
> > > > >      # The kernel handles updates to crash elfcorehdr for cpu and memory changes
> > > > >      SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
> > > > >      SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
> > > > > 
> > > > >      These lines will cause cpu and memory hot un/plug events to be
> > > > >      skipped within this rule file, if the kernel has these changes
> > > > >      enabled.
> > > > > 
> > > > >    - Change to the kexec_file_load for loading the kdump kernel:
> > > > >      Eg. on RHEL: in /usr/bin/kdumpctl, change to:
> > > > >       standard_kexec_args="-p -d -s"
> > > > >      which adds the -s to select kexec_file_load syscall.
> > > > > 
> > > > > This patchset supports kexec_load with a modified kexec userspace
> > > > > utility, and a working changeset to the kexec userspace utility
> > > > > is provided here (and to use, the above change to standard_kexec_args
> > > > > would be, for example, to append --hotplug instead of -s).
> > > > > 
> > > > >     diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> > > > >     index 9826f6d..4ed395a 100644
> > > > >     --- a/kexec/arch/i386/crashdump-x86.c
> > > > >     +++ b/kexec/arch/i386/crashdump-x86.c
> > > > >     @@ -48,6 +48,7 @@
> > > > >      #include <x86/x86-linux.h>
> > > > >      extern struct arch_options_t arch_options;
> > > > >     +extern int do_hotplug;
> > > > >      static int get_kernel_page_offset(struct kexec_info *UNUSED(info),
> > > > >                        struct crash_elf_info *elf_info)
> > > > >     @@ -975,6 +976,14 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
> > > > >          } else {
> > > > >              memsz = bufsz;
> > > > >          }
> > > > >     +
> > > > >     +    /* If hotplug support enabled, use larger size to accomodate changes */
> > > > >     +    if (do_hotplug) {
> > > > >     +        long int nr_cpus = get_nr_cpus();
> > > > >     +        memsz = (nr_cpus + CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);
> > > > >     +    }
> > > > >     +
> > > > >     +    info->elfcorehdr =
> > > > >          elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
> > > > >                                  max_addr, -1);
> > > > >          dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
> > > > >     diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
> > > > >     index b8bb686..5e29f7a 100644
> > > > >     --- a/kexec/crashdump-elf.c
> > > > >     +++ b/kexec/crashdump-elf.c
> > > > >     @@ -43,11 +43,7 @@ int FUNC(struct kexec_info *info,
> > > > >          int (*get_note_info)(int cpu, uint64_t *addr, uint64_t *len);
> > > > >          long int count_cpu;
> > > > >     -    if (xen_present())
> > > > >     -        nr_cpus = xen_get_nr_phys_cpus();
> > > > >     -    else
> > > > >     -        nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
> > > > >     -
> > > > >     +    nr_cpus = get_nr_cpus();
> > > > >          if (nr_cpus < 0) {
> > > > >              return -1;
> > > > >          }
> > > > >     diff --git a/kexec/crashdump.h b/kexec/crashdump.h
> > > > >     index 18bd691..28d3278 100644
> > > > >     --- a/kexec/crashdump.h
> > > > >     +++ b/kexec/crashdump.h
> > > > >     @@ -57,7 +57,6 @@ unsigned long phys_to_virt(struct crash_elf_info *elf_info,
> > > > >                     unsigned long long paddr);
> > > > >      unsigned long xen_architecture(struct crash_elf_info *elf_info);
> > > > >     -int xen_get_nr_phys_cpus(void);
> > > > >      int xen_get_note(int cpu, uint64_t *addr, uint64_t *len);
> > > > >      int xen_get_crashkernel_region(uint64_t *start, uint64_t *end);
> > > > >     diff --git a/kexec/kexec-xen.h b/kexec/kexec-xen.h
> > > > >     index 70fb576..f54a2dd 100644
> > > > >     --- a/kexec/kexec-xen.h
> > > > >     +++ b/kexec/kexec-xen.h
> > > > >     @@ -83,5 +83,6 @@ extern int __xc_interface_close(xc_interface *xch);
> > > > >      #endif
> > > > >      int xen_get_kexec_range(int range, uint64_t *start, uint64_t *end);
> > > > >     +int xen_get_nr_phys_cpus(void);
> > > > >      #endif /* KEXEC_XEN_H */
> > > > >     diff --git a/kexec/kexec.c b/kexec/kexec.c
> > > > >     index 829a6ea..3668b73 100644
> > > > >     --- a/kexec/kexec.c
> > > > >     +++ b/kexec/kexec.c
> > > > >     @@ -58,6 +58,7 @@
> > > > >      unsigned long long mem_min = 0;
> > > > >      unsigned long long mem_max = ULONG_MAX;
> > > > >     +int do_hotplug = 0;
> > > > >      static unsigned long kexec_flags = 0;
> > > > >      /* Flags for kexec file (fd) based syscall */
> > > > >      static unsigned long kexec_file_flags = 0;
> > > > >     @@ -489,6 +490,17 @@ static int add_backup_segments(struct kexec_info *info,
> > > > >          return 0;
> > > > >      }
> > > > >     +long int get_nr_cpus(void)
> > > > >     +{
> > > > >     +    long int nr_cpus;
> > > > >     +
> > > > >     +    if (xen_present())
> > > > >     +        nr_cpus = xen_get_nr_phys_cpus();
> > > > >     +    else
> > > > >     +        nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
> > > > >     +    return nr_cpus;
> > > > >     +}
> > > > >     +
> > > > >      static char *slurp_fd(int fd, const char *filename, off_t size, off_t *nread)
> > > > >      {
> > > > >          char *buf;
> > > > >     @@ -672,6 +684,14 @@ static void update_purgatory(struct kexec_info *info)
> > > > >              if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
> > > > >                  continue;
> > > > >              }
> > > > >     +
> > > > >     +        /* Don't include elfcorehdr in the checksum, if hotplug
> > > > >     +         * support enabled.
> > > > >     +         */
> > > > >     +        if (do_hotplug && (info->segment[i].mem == (void *)info->elfcorehdr)) {
> > > > >     +            continue;
> > > > >     +        }
> > > > >     +
> > > > >              sha256_update(&ctx, info->segment[i].buf,
> > > > >                        info->segment[i].bufsz);
> > > > >              nullsz = info->segment[i].memsz - info->segment[i].bufsz;
> > > > >     @@ -1565,6 +1585,9 @@ int main(int argc, char *argv[])
> > > > >              case OPT_PRINT_CKR_SIZE:
> > > > >                  print_crashkernel_region_size();
> > > > >                  return 0;
> > > > >     +        case OPT_HOTPLUG:
> > > > >     +            do_hotplug = 1;
> > > > >     +            break;
> > > > >              default:
> > > > >                  break;
> > > > >              }
> > > > >     diff --git a/kexec/kexec.h b/kexec/kexec.h
> > > > >     index 0f97a97..b0428cc 100644
> > > > >     --- a/kexec/kexec.h
> > > > >     +++ b/kexec/kexec.h
> > > > >     @@ -169,6 +169,7 @@ struct kexec_info {
> > > > >          int command_line_len;
> > > > >          int skip_checks;
> > > > >     +    unsigned long elfcorehdr;
> > > > >      };
> > > > >      struct arch_map_entry {
> > > > >     @@ -231,7 +232,8 @@ extern int file_types;
> > > > >      #define OPT_PRINT_CKR_SIZE    262
> > > > >      #define OPT_LOAD_LIVE_UPDATE    263
> > > > >      #define OPT_EXEC_LIVE_UPDATE    264
> > > > >     -#define OPT_MAX            265
> > > > >     +#define OPT_HOTPLUG        265
> > > > >     +#define OPT_MAX        266
> > > > >      #define KEXEC_OPTIONS \
> > > > >          { "help",        0, 0, OPT_HELP }, \
> > > > >          { "version",        0, 0, OPT_VERSION }, \
> > > > >     @@ -258,6 +260,7 @@ extern int file_types;
> > > > >          { "debug",        0, 0, OPT_DEBUG }, \
> > > > >          { "status",        0, 0, OPT_STATUS }, \
> > > > >          { "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
> > > > >     +    { "hotplug",        0, 0, OPT_HOTPLUG }, \
> > > > >      #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
> > > > >     @@ -290,6 +293,8 @@ extern unsigned long add_buffer_phys_virt(struct kexec_info *info,
> > > > >          int buf_end, int phys);
> > > > >      extern void arch_reuse_initrd(void);
> > > > >     +extern long int get_nr_cpus(void);
> > > > >     +
> > > > >      extern int ifdown(void);
> > > > >      extern char purgatory[];
> > > > > 
> > > > > Regards,
> > > > > eric
> > > > > ---
> > > > > 
> > > > > v9: 13jun2022
> > > > >    - Rebased to 5.18.0
> > > > >    - Per Sourabh, moved crash_prepare_elf64_headers() into common
> > > > >      crash_core.c to avoid compile issues with kexec_load only path.
> > > > >    - Per David Hildebrand, replaced mutex_trylock() with mutex_lock().
> > > > >    - Changed the __weak arch_crash_handle_hotplug_event() to utilize
> > > > >      WARN_ONCE() instead of WARN(). Fix some formatting issues.
> > > > >    - Per Sourabh, introduced sysfs attribute crash_hotplug for memory
> > > > >      and CPUs; for use by userspace (udev) to determine if the kernel
> > > > >      performs crash hot un/plug support.
> > > > >    - Per Sourabh, moved the code detecting the elfcorehdr segment from
> > > > >      arch/x86 into crash_core:handle_hotplug_event() so both kexec_load
> > > > >      and kexec_file_load can benefit.
> > > > >    - Updated userspace kexec-tools kexec utility to reflect change to
> > > > >      using CRASH_MAX_MEMORY_RANGES and get_nr_cpus().
> > > > > 
> > > > > v8: 5may2022
> > > > >    https://lkml.org/lkml/2022/5/5/1133
> > > > >    - Per Borislav Petkov, eliminated CONFIG_CRASH_HOTPLUG in favor
> > > > >      of CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG, ie a new define
> > > > >      is not needed. Also use of IS_ENABLED() rather than #ifdef's.
> > > > >      Renamed crash_hotplug_handler() to handle_hotplug_event().
> > > > >      And other corrections.
> > > > >    - Per Baoquan, minimized the parameters to the arch_crash_
> > > > >      handle_hotplug_event() to hp_action and cpu.
> > > > >    - Introduce KEXEC_CRASH_HP_INVALID_CPU definition, per Baoquan.
> > > > >    - Per Sourabh Jain, renamed and repurposed CRASH_HOTPLUG_ELFCOREHDR_SZ
> > > > >      to CONFIG_CRASH_MAX_MEMORY_RANGES, mirroring kexec-tools change
> > > > >      by David Hildebrand. Folded this patch into the x86
> > > > >      kexec_file_load support patch.
> > > > > 
> > > > > v7: 13apr2022
> > > > >    https://lkml.org/lkml/2022/4/13/850
> > > > >    - Resolved parameter usage to crash_hotplug_handler(), per Baoquan.
> > > > > 
> > > > > v6: 1apr2022
> > > > >    https://lkml.org/lkml/2022/4/1/1203
> > > > >    - Reword commit messages and some comment cleanup per Baoquan.
> > > > >    - Changed elf_index to elfcorehdr_index for clarity.
> > > > >    - Minor code changes per Baoquan.
> > > > > 
> > > > > v5: 3mar2022
> > > > >    https://lkml.org/lkml/2022/3/3/674
> > > > >    - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
> > > > >      David Hildenbrand.
> > > > >    - Refactored slightly a few patches per Baoquan recommendation.
> > > > > 
> > > > > v4: 9feb2022
> > > > >    https://lkml.org/lkml/2022/2/9/1406
> > > > >    - Refactored patches per Baoquan suggestsions.
> > > > >    - A few corrections, per Baoquan.
> > > > > 
> > > > > v3: 10jan2022
> > > > >    https://lkml.org/lkml/2022/1/10/1212
> > > > >    - Rebasing per Baoquan He request.
> > > > >    - Changed memory notifier per David Hildenbrand.
> > > > >    - Providing example kexec userspace change in cover letter.
> > > > > 
> > > > > RFC v2: 7dec2021
> > > > >    https://lkml.org/lkml/2021/12/7/1088
> > > > >    - Acting upon Baoquan He suggestion of removing elfcorehdr from
> > > > >      the purgatory list of segments, removed purgatory code from
> > > > >      patchset, and it is signficiantly simpler now.
> > > > > 
> > > > > RFC v1: 18nov2021
> > > > >    https://lkml.org/lkml/2021/11/18/845
> > > > >    - working patchset demonstrating kernel handling of hotplug
> > > > >      updates to x86 elfcorehdr for kexec_file_load
> > > > > 
> > > > > RFC: 14dec2020
> > > > >    https://lkml.org/lkml/2020/12/14/532
> > > > >    - proposed concept of allowing kernel to handle hotplug update
> > > > >      of elfcorehdr
> > > > > ---
> > > > > 
> > > > > 
> > > > > Eric DeVolder (7):
> > > > >     crash: move crash_prepare_elf64_headers
> > > > >     crash: prototype change for crash_prepare_elf64_headers
> > > > >     crash: add generic infrastructure for crash hotplug support
> > > > >     kexec: exclude elfcorehdr from the segment digest
> > > > >     kexec: exclude hot remove cpu from elfcorehdr notes
> > > > >     crash: memory and cpu hotplug sysfs attributes
> > > > >     x86/crash: Add x86 crash hotplug support
> > > > > 
> > > > >    .../admin-guide/mm/memory-hotplug.rst         |   8 +
> > > > >    Documentation/core-api/cpu_hotplug.rst        |  18 ++
> > > > >    arch/arm64/kernel/machine_kexec_file.c        |   6 +-
> > > > >    arch/powerpc/kexec/file_load_64.c             |   2 +-
> > > > >    arch/x86/Kconfig                              |  11 +
> > > > >    arch/x86/kernel/crash.c                       | 119 ++++++++-
> > > > >    drivers/base/cpu.c                            |  13 +
> > > > >    drivers/base/memory.c                         |  13 +
> > > > >    include/linux/crash_core.h                    |  12 +
> > > > >    include/linux/kexec.h                         |  14 +-
> > > > >    kernel/crash_core.c                           | 241 ++++++++++++++++++
> > > > >    kernel/kexec_file.c                           | 105 +-------
> > > > >    12 files changed, 456 insertions(+), 106 deletions(-)
> > > > > 
> > > > 
> > > 

