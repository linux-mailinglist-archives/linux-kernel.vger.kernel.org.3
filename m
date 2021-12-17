Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10E4479026
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbhLQPm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:42:59 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:39772 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbhLQPm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:42:58 -0500
Received: by mail-oi1-f182.google.com with SMTP id bf8so4162737oib.6;
        Fri, 17 Dec 2021 07:42:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVimRKi9Mf6Nn3TIsLinkuNs4zF4imOCzYAV86XVmsg=;
        b=Zqhj+q9YaofBqSGH+Rq+TcmkGfk7y9T11rL8VqUsw1e7w74Hg6BIepiOJOxBmop2Ap
         o7MZi7kuLqiZfeL1rVZPBNZ7qIhtvKqK2rq4mj9wyZBlwj6xjOB2yA+UW3upuCFKfMOq
         u/+fwd2s6feI+8299YIg/hPRpsZC6JIXq7H3yRYc1Beb/3pGQhdpa+CqTyyLAHAE9HA8
         UR5rbcoHx06ApuypxxsXdWxTIqWPJVaxLYxaQBB8PFiDPt+NKLVeyH7CPxhvTMpcVVik
         Q1YDXinQ8epo27VED3if22js7Tw+4uCIQmKMrKc2l651AMCcHJ6hnoD6feoyZxfaoQdX
         DqfQ==
X-Gm-Message-State: AOAM5326LHHL8pjqnv+NJ+LQhYN8V3Hu5lHTa/nj9sfcYBRXQRRwfEhg
        XYika2cG4DTYUjmNQh5HLRAfxyhHWzAmXxlSEoc=
X-Google-Smtp-Source: ABdhPJzpGAU0FA05DNKXJUlmj6Hb/Am1OvUp34vAA6MDgyzGSPgZNfzZ6lQHsAscM4F62suOkRjaTBkL/jaRlfzMqRk=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr2439454oiw.154.1639755777473;
 Fri, 17 Dec 2021 07:42:57 -0800 (PST)
MIME-Version: 1.0
References: <20211214005212.20588-1-chang.seok.bae@intel.com> <20211214005212.20588-9-chang.seok.bae@intel.com>
In-Reply-To: <20211214005212.20588-9-chang.seok.bae@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Dec 2021 16:42:46 +0100
Message-ID: <CAJZ5v0gbePA+rR9gMRnaJrUGS1MwF6UQzxrFZChy5i=11tgz-A@mail.gmail.com>
Subject: Re: [PATCH v4 08/13] x86/power/keylocker: Restore internal wrapping
 key from the ACPI S3/4 sleep states
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        lalithambika.krishnakumar@intel.com,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, I would change the subject to "x86/PM/keylocker: Restore
internal wrapping key on resume from ACPI S3/S4".

On Tue, Dec 14, 2021 at 2:00 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> When the system state switches to these sleep states, the internal
> wrapping key gets reset in the CPU state.

And here I would say

"When the system enters the ACPI S3 or S4 sleep state, the internal
wrapping key is discarded."

>
> The primary use case for the feature is bare metal dm-crypt. The key needs
> to be restored properly on wakeup, as dm-crypt does not prompt for the key
> on resume from suspend. Even the prompt it does perform for unlocking
> the volume where the hibernation image is stored, it still expects to reuse
> the key handles within the hibernation image once it is loaded. So it is
> motivated to meet dm-crypt's expectation that the key handles in the
> suspend-image remain valid after resume from an S-state.
>
> Key Locker provides a mechanism to back up the internal wrapping key in
> non-volatile storage. The kernel requests a backup right after the key is
> loaded at boot time. It is copied back to each CPU upon wakeup.
>
> While the backup may be maintained in NVM across S5 and G3 "off"
> states it is not architecturally guaranteed, nor is it expected by dm-crypt
> which expects to prompt for the key each time the volume is started.
>
> The entirety of Key Locker needs to be disabled if the backup mechanism is
> not available unless CONFIG_SUSPEND=n, otherwise dm-crypt requires the
> backup to be available.
>
> In the event of a key restore failure the kernel proceeds with an
> initialized IWKey state. This has the effect of invalidating any key
> handles that might be present in a suspend-image. When this happens
> dm-crypt will see I/O errors resulting from error returns from
> crypto_skcipher_{en,de}crypt(). While this will disrupt operations in the
> current boot, data is not at risk and access is restored at the next reboot
> to create new handles relative to the current IWKey.
>
> Manage a feature-specific flag to communicate with the crypto
> implementation. This ensures to stop using the AES instructions upon the
> key restore failure while not turning off the feature.
>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
> Changes from v3:
> * Fix the build issue with !X86_KEYLOCKER. (Eric Biggers)
>
> Changes from RFC v2:
> * Change the backup key failure handling. (Dan Williams)
>
> Changes from RFC v1:
> * Folded the warning message into the if condition check.
>   (Rafael Wysocki)
> * Rebased on the changes of the previous patches.
> * Added error code for key restoration failures.
> * Moved the restore helper.
> * Added function descriptions.
> ---
>  arch/x86/include/asm/keylocker.h |   4 +
>  arch/x86/kernel/keylocker.c      | 124 ++++++++++++++++++++++++++++++-
>  arch/x86/power/cpu.c             |   2 +
>  3 files changed, 128 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/keylocker.h b/arch/x86/include/asm/keylocker.h
> index 820ac29c06d9..c1d27fb5a1c3 100644
> --- a/arch/x86/include/asm/keylocker.h
> +++ b/arch/x86/include/asm/keylocker.h
> @@ -32,9 +32,13 @@ struct iwkey {
>  #ifdef CONFIG_X86_KEYLOCKER
>  void setup_keylocker(struct cpuinfo_x86 *c);
>  void destroy_keylocker_data(void);
> +void restore_keylocker(void);
> +extern bool valid_keylocker(void);
>  #else
>  #define setup_keylocker(c) do { } while (0)
>  #define destroy_keylocker_data() do { } while (0)
> +#define restore_keylocker() do { } while (0)
> +static inline bool valid_keylocker(void) { return false; }
>  #endif
>
>  #endif /*__ASSEMBLY__ */
> diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
> index 87d775a65716..ff0e012e3dd5 100644
> --- a/arch/x86/kernel/keylocker.c
> +++ b/arch/x86/kernel/keylocker.c
> @@ -11,11 +11,26 @@
>  #include <asm/fpu/api.h>
>  #include <asm/keylocker.h>
>  #include <asm/tlbflush.h>
> +#include <asm/msr.h>
>
>  static __initdata struct keylocker_setup_data {
> +       bool initialized;
>         struct iwkey key;
>  } kl_setup;
>
> +/*
> + * This flag is set with IWKey load. When the key restore fails, it is
> + * reset. This restore state is exported to the crypto library, then AES-KL
> + * will not be used there. So, the feature is soft-disabled with this flag.
> + */
> +static bool valid_kl;
> +
> +bool valid_keylocker(void)
> +{
> +       return valid_kl;
> +}
> +EXPORT_SYMBOL_GPL(valid_keylocker);
> +
>  static void __init generate_keylocker_data(void)
>  {
>         get_random_bytes(&kl_setup.key.integrity_key,  sizeof(kl_setup.key.integrity_key));
> @@ -25,6 +40,8 @@ static void __init generate_keylocker_data(void)
>  void __init destroy_keylocker_data(void)
>  {
>         memset(&kl_setup.key, KEY_DESTROY, sizeof(kl_setup.key));
> +       kl_setup.initialized = true;
> +       valid_kl = true;
>  }
>
>  static void __init load_keylocker(void)
> @@ -34,6 +51,27 @@ static void __init load_keylocker(void)
>         kernel_fpu_end();
>  }
>
> +/**
> + * copy_keylocker - Copy the internal wrapping key from the backup.
> + *
> + * Request hardware to copy the key in non-volatile storage to the CPU
> + * state.
> + *
> + * Returns:    -EBUSY if the copy fails, 0 if successful.
> + */
> +static int copy_keylocker(void)
> +{
> +       u64 status;
> +
> +       wrmsrl(MSR_IA32_COPY_IWKEY_TO_LOCAL, 1);
> +
> +       rdmsrl(MSR_IA32_IWKEY_COPY_STATUS, status);
> +       if (status & BIT(0))
> +               return 0;
> +       else
> +               return -EBUSY;
> +}
> +
>  /**
>   * setup_keylocker - Enable the feature.
>   * @c:         A pointer to struct cpuinfo_x86
> @@ -49,6 +87,7 @@ void __ref setup_keylocker(struct cpuinfo_x86 *c)
>
>         if (c == &boot_cpu_data) {
>                 u32 eax, ebx, ecx, edx;
> +               bool backup_available;
>
>                 cpuid_count(KEYLOCKER_CPUID, 0, &eax, &ebx, &ecx, &edx);
>                 /*
> @@ -62,10 +101,49 @@ void __ref setup_keylocker(struct cpuinfo_x86 *c)
>                         goto disable;
>                 }
>
> +               backup_available = (ebx & KEYLOCKER_CPUID_EBX_BACKUP) ? true : false;

Why not

backup_available = !!(ebx & KEYLOCKER_CPUID_EBX_BACKUP);

Apart from this it looks OK, so with the above addressed, please feel
free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to this patch.

> +               /*
> +                * The internal wrapping key in CPU state is volatile in
> +                * S3/4 states. So ensure the backup capability along with
> +                * S-states.
> +                */
> +               if (!backup_available && IS_ENABLED(CONFIG_SUSPEND)) {
> +                       pr_debug("x86/keylocker: No key backup support with possible S3/4.\n");
> +                       goto disable;
> +               }
> +
>                 generate_keylocker_data();
> -       }
> +               load_keylocker();
>
> -       load_keylocker();
> +               /* Backup an internal wrapping key in non-volatile media. */
> +               if (backup_available)
> +                       wrmsrl(MSR_IA32_BACKUP_IWKEY_TO_PLATFORM, 1);
> +       } else {
> +               int rc;
> +
> +               /*
> +                * Load the internal wrapping key directly when available
> +                * in memory, which is only possible at boot-time.
> +                *
> +                * NB: When system wakes up, this path also recovers the
> +                * internal wrapping key.
> +                */
> +               if (!kl_setup.initialized) {
> +                       load_keylocker();
> +               } else if (valid_kl) {
> +                       rc = copy_keylocker();
> +                       /*
> +                        * The boot CPU was successful but the key copy
> +                        * fails here. Then, the subsequent feature use
> +                        * will have inconsistent keys and failures. So,
> +                        * invalidate the feature via the flag.
> +                        */
> +                       if (rc) {
> +                               valid_kl = false;
> +                               pr_err_once("x86/keylocker: Invalid copy status (rc: %d).\n", rc);
> +                       }
> +               }
> +       }
>
>         pr_info_once("x86/keylocker: Enabled.\n");
>         return;
> @@ -77,3 +155,45 @@ void __ref setup_keylocker(struct cpuinfo_x86 *c)
>         /* Make sure the feature disabled for kexec-reboot. */
>         cr4_clear_bits(X86_CR4_KEYLOCKER);
>  }
> +
> +/**
> + * restore_keylocker - Restore the internal wrapping key.
> + *
> + * The boot CPU executes this while other CPUs restore it through the setup
> + * function.
> + */
> +void restore_keylocker(void)
> +{
> +       u64 backup_status;
> +       int rc;
> +
> +       if (!cpu_feature_enabled(X86_FEATURE_KEYLOCKER) || !valid_kl)
> +               return;
> +
> +       /*
> +        * The IA32_IWKEYBACKUP_STATUS MSR contains a bitmap that indicates
> +        * an invalid backup if bit 0 is set and a read (or write) error if
> +        * bit 2 is set.
> +        */
> +       rdmsrl(MSR_IA32_IWKEY_BACKUP_STATUS, backup_status);
> +       if (backup_status & BIT(0)) {
> +               rc = copy_keylocker();
> +               if (rc)
> +                       pr_err("x86/keylocker: Invalid copy state (rc: %d).\n", rc);
> +               else
> +                       return;
> +       } else {
> +               pr_err("x86/keylocker: The key backup access failed with %s.\n",
> +                      (backup_status & BIT(2)) ? "read error" : "invalid status");
> +       }
> +
> +       /*
> +        * Now the backup key is not available. Invalidate the feature via
> +        * the flag to avoid any subsequent use. But keep the feature with
> +        * zero IWKeys instead of disabling it. The current users will see
> +        * key handle integrity failure but that's because of the internal
> +        * key change.
> +        */
> +       pr_err("x86/keylocker: Failed to restore internal wrapping key.\n");
> +       valid_kl = false;
> +}
> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> index 9f2b251e83c5..1a290f529c73 100644
> --- a/arch/x86/power/cpu.c
> +++ b/arch/x86/power/cpu.c
> @@ -25,6 +25,7 @@
>  #include <asm/cpu.h>
>  #include <asm/mmu_context.h>
>  #include <asm/cpu_device_id.h>
> +#include <asm/keylocker.h>
>
>  #ifdef CONFIG_X86_32
>  __visible unsigned long saved_context_ebx;
> @@ -262,6 +263,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
>         mtrr_bp_restore();
>         perf_restore_debug_store();
>         msr_restore_context(ctxt);
> +       restore_keylocker();
>
>         c = &cpu_data(smp_processor_id());
>         if (cpu_has(c, X86_FEATURE_MSR_IA32_FEAT_CTL))
> --
> 2.17.1
>
