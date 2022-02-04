Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DD44A9FB1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiBDTDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiBDTCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:02:06 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54508C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:02:06 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d187so5852892pfa.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 11:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWjxjsdKmPUFg8xP67iw9xnzsV/BHi7mBAtuVyyPZZ8=;
        b=UCcz9mzX+qtR/0IyzVDPaWiYRX656OGHD6b+EqByu5Kh9BggYUfQID42Bd2M10H8pd
         e2m5ITsV2AdC+mntlY89f1RyrGjIsz9qpUwCIKRuqgDfIgRrBXK/57A7lGiB9dClz0WY
         oLSRYfqMx5ITbUZnxQDcs8/JhmE8l+MMCtpbNKl2VjTyqAhgGUR9i/dCOxdb+84y24qt
         u/En9uA8Ckvy6S06GnlaqX4WipvstPp8llQW6aQiduasUvLLa9r8BHQduMScxIO5CWXF
         WjVWaNoVCN4rHJpHSGj5A1vd3T0YA+MmujpfkxlsqBopLKpmZM/tc6RIxChjT/4zCeOL
         h9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWjxjsdKmPUFg8xP67iw9xnzsV/BHi7mBAtuVyyPZZ8=;
        b=xR5zXiLMu2lm2puaS7jnMXMM/3g7FBykx/4+D6ErQcS1fFRd37ZlcIYikeVX5ZGyK6
         JoN5QYyzFnviQMwv8tejAO3+srERkhdey9NARpvRsdN2Q+/JJdFSYCLeLpNWXYu/g9o4
         otCnN0oWOdCtRdgqZwwhtMjKHY0uUFpQ+0FXZFvxIziRbtn1XSjBh+UOMvJW4tmjGaME
         NHDQ8Bcbf4K+KD9lo/alltsKjNuDB8FbqBtq5g5k/jteOfq56Iq8Lv9Gp5wJaLBvggmo
         boQylaXz8+255j1smomuRu+4tQ9OatNQf/5miGADiQjrZL1neKQbfXXnvoZJzJbRLZ0I
         QS3g==
X-Gm-Message-State: AOAM532uwc8rs567ehIDJHODN1R874vNNpGM8P719XuGvxXFxHHoA37k
        kcIzsFeZCFEwd6aqlnrBm5CG0lJjw6cRa6HloMBB9A==
X-Google-Smtp-Source: ABdhPJyvA2sU57BzvHUn4QuHklfAKUxxt06CZAhCkTL4nKN8+5/vHv95EbkP9760Foh0GhukvQZ9ebwo6TVWlTL7mVw=
X-Received: by 2002:a63:85c6:: with SMTP id u189mr313882pgd.437.1644001325761;
 Fri, 04 Feb 2022 11:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20220127175505.851391-1-ira.weiny@intel.com> <20220127175505.851391-40-ira.weiny@intel.com>
In-Reply-To: <20220127175505.851391-40-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 4 Feb 2022 11:01:55 -0800
Message-ID: <CAPcyv4gama4a-90R486kFiztYJ5sPRYeg49TNYMyd=v3syAziw@mail.gmail.com>
Subject: Re: [PATCH V8 39/44] memremap_pages: Add memremap.pks_fault_mode
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> Some systems may be using pmem in unanticipated ways.  As such, it is
> possible an foreseen code path to violate the restrictions of the PMEM
> PKS protections.

These sentences do not parse for me. How about:

"When PKS protections for PMEM are enabled the kernel may capture
stray writes, or it may capture false positive access violations. An
example of a false positive access violation is a code path that
neglects to call kmap_{atomic,local_page}, but is otherwise a valid
access. In the false positive scenario there is no actual risk to data
integrity, but the kernel still needs to make a decision as to whether
to report the access violation and continue, or treat the violation as
fatal. That policy decision is captured in a new pks_fault_mode kernel
parameter."

>
> In order to provide a more seamless integration of the PMEM PKS feature

Not sure what "seamless integration" means in this context?

> provide a pks_fault_mode that allows for a relaxed mode should a
> previously working feature fault on the PKS protected PMEM.
>
> 2 modes are available:
>
>         'relaxed' (default) -- WARN_ONCE, removed the protections, and
>         continuing to operate.
>
>         'strict' -- BUG_ON/or fault indicating the error.  This is the
>         most protective of the PMEM memory but may be undesirable in
>         some configurations.
>
> NOTE: The typedef of pks_fault_modes is required to allow
> param_check_pks_fault() to work automatically for us.  So the typedef
> checkpatch warning is ignored.

This doesn't parse for me, why is a typedef needed for a simple
toggle? Who is "us"?

>
> NOTE: There was some debate about if a 3rd mode called 'silent' should
> be available.  'silent' would be the same as 'relaxed' but not print any
> output.  While 'silent' is nice for admins to reduce console/log output
> it would result in less motivation to fix invalid access to the
> protected pmem pages.  Therefore, 'silent' is left out.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> ---
> Changes for V8
>         Use pks_update_exception() instead of abandoning the pkey.
>         Split out pgmap_protection_flag_invalid() into a separate patch
>                 for clarity.
>         From Rick Edgecombe
>                 Fix sysfs_streq() checks
>         From Randy Dunlap
>                 Fix Documentation closing parans
>
> Changes for V7
>         Leverage Rick Edgecombe's fault callback infrastructure to relax invalid
>                 uses and prevent crashes
>         From Dan Williams
>                 Use sysfs_* calls for parameter
>                 Make pgmap_disable_protection inline
>                 Remove pfn from warn output
>         Remove silent parameter option
> ---
>  .../admin-guide/kernel-parameters.txt         | 14 ++++
>  arch/x86/mm/pkeys.c                           |  4 ++
>  include/linux/mm.h                            |  3 +
>  mm/memremap.c                                 | 67 +++++++++++++++++++
>  4 files changed, 88 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f5a27f067db9..3e70a6194831 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4158,6 +4158,20 @@
>         pirq=           [SMP,APIC] Manual mp-table setup
>                         See Documentation/x86/i386/IO-APIC.rst.
>
> +       memremap.pks_fault_mode=        [X86] Control the behavior of page map
> +                       protection violations.  Violations may not be an actual
> +                       use of the memory but simply an attempt to map it in an
> +                       incompatible way.
> +                       (depends on CONFIG_DEVMAP_ACCESS_PROTECTION)
> +
> +                       Format: { relaxed | strict }
> +
> +                       relaxed - Print a warning, disable the protection and
> +                                 continue execution.
> +                       strict - Stop kernel execution via BUG_ON or fault
> +
> +                       default: relaxed
> +
>         plip=           [PPT,NET] Parallel port network link
>                         Format: { parport<nr> | timid | 0 }
>                         See also Documentation/admin-guide/parport.rst.
> diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
> index fa71037c1dd0..e864a9b7828a 100644
> --- a/arch/x86/mm/pkeys.c
> +++ b/arch/x86/mm/pkeys.c
> @@ -6,6 +6,7 @@
>  #include <linux/debugfs.h>             /* debugfs_create_u32()         */
>  #include <linux/mm_types.h>             /* mm_struct, vma, etc...       */
>  #include <linux/pkeys.h>                /* PKEY_*                       */
> +#include <linux/mm.h>                   /* fault callback               */
>  #include <uapi/asm-generic/mman-common.h>
>
>  #include <asm/cpufeature.h>             /* boot_cpu_has, ...            */
> @@ -243,6 +244,9 @@ static const pks_key_callback pks_key_callbacks[PKS_KEY_NR_CONSUMERS] = {
>  #ifdef CONFIG_PKS_TEST
>         [PKS_KEY_TEST]          = pks_test_fault_callback,
>  #endif
> +#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
> +       [PKS_KEY_PGMAP_PROTECTION]   = pgmap_pks_fault_callback,
> +#endif
>  };
>
>  static bool pks_call_fault_callback(struct pt_regs *regs, unsigned long address,
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 60044de77c54..e900df563437 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1193,6 +1193,9 @@ static inline void pgmap_mk_noaccess(struct page *page)
>
>  bool pgmap_protection_available(void);
>
> +bool pgmap_pks_fault_callback(struct pt_regs *regs, unsigned long address,
> +                             bool write);
> +
>  #else
>
>  static inline void __pgmap_mk_readwrite(struct dev_pagemap *pgmap) { }
> diff --git a/mm/memremap.c b/mm/memremap.c
> index b75c4f778c59..783b1cd4bb42 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -96,6 +96,73 @@ static void devmap_protection_disable(void)
>         static_branch_dec(&dev_pgmap_protection_static_key);
>  }
>
> +/*
> + * Ignore the checkpatch warning because the typedef allows

Why document forever in perpetuity to ignore a checkpatch warning for
something that is no longer a patch once it is upstream?

> + * param_check_pks_fault_modes to automatically check the passed value.
> + */
> +typedef enum {
> +       PKS_MODE_STRICT  = 0,
> +       PKS_MODE_RELAXED = 1,
> +} pks_fault_modes;
> +
> +pks_fault_modes pks_fault_mode = PKS_MODE_RELAXED;
> +
> +static int param_set_pks_fault_mode(const char *val, const struct kernel_param *kp)
> +{
> +       int ret = -EINVAL;
> +
> +       if (sysfs_streq(val, "relaxed")) {
> +               pks_fault_mode = PKS_MODE_RELAXED;
> +               ret = 0;
> +       } else if (sysfs_streq(val, "strict")) {
> +               pks_fault_mode = PKS_MODE_STRICT;
> +               ret = 0;
> +       }
> +
> +       return ret;
> +}
> +
> +static int param_get_pks_fault_mode(char *buffer, const struct kernel_param *kp)
> +{
> +       int ret = 0;
> +
> +       switch (pks_fault_mode) {
> +       case PKS_MODE_STRICT:
> +               ret = sysfs_emit(buffer, "strict\n");
> +               break;
> +       case PKS_MODE_RELAXED:
> +               ret = sysfs_emit(buffer, "relaxed\n");
> +               break;
> +       default:
> +               ret = sysfs_emit(buffer, "<unknown>\n");
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static const struct kernel_param_ops param_ops_pks_fault_modes = {
> +       .set = param_set_pks_fault_mode,
> +       .get = param_get_pks_fault_mode,
> +};
> +
> +#define param_check_pks_fault_modes(name, p) \
> +       __param_check(name, p, pks_fault_modes)
> +module_param(pks_fault_mode, pks_fault_modes, 0644);

Is the complexity to change this at runtime necessary? It seems
sufficient to make this read-only via sysfs and only rely on command
line toggles to override the default policy.

> +
> +bool pgmap_pks_fault_callback(struct pt_regs *regs, unsigned long address,
> +                             bool write)
> +{
> +       /* In strict mode just let the fault handler oops */
> +       if (pks_fault_mode == PKS_MODE_STRICT)
> +               return false;
> +
> +       WARN_ONCE(1, "Page map protection being disabled");
> +       pks_update_exception(regs, PKS_KEY_PGMAP_PROTECTION, 0);
> +       return true;
> +}
> +EXPORT_SYMBOL_GPL(pgmap_pks_fault_callback);
> +
>  void __pgmap_mk_readwrite(struct dev_pagemap *pgmap)
>  {
>         if (!current->pgmap_prot_count++)
> --
> 2.31.1
>
