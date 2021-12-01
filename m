Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C605746529A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351540AbhLAQRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351436AbhLAQOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:14:38 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D3BC061758
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 08:11:16 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id u3so64264292lfl.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 08:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oBzgP0KvGGIkf7L7mtYLDWOh+YwNx2y+C3On+wUwxLE=;
        b=pVedjRWavPXSoybSAi4OHroeTLHMfsVttjgD+B91+vCJg43cDG1RZyhOKpzsGzxjoO
         2VxkPbEpzNb12rjgzPGO0TnPS82wVWikEOUJgJUHbH/ab2bp0V09KU3aib3n6G7q7SPL
         zFhc3S/LdFB7oeU/KLZKT5dzHUzaOR0D/xG4bfUJP/GGjrWCijXh+XiPDyNQ3bPj6NUV
         y5kjxVhAqHSyU0IZ1s7tXfUyfuBNan1bCglYUxpyVPaLG5toM8JntablgWySLilnBuY0
         mN1xM+RpEtMIaxObCMe/XvWk48uFUztcQ2WTxXsipjE/i3oitcrsUoDywykaU3OQ1wKy
         VppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oBzgP0KvGGIkf7L7mtYLDWOh+YwNx2y+C3On+wUwxLE=;
        b=J2D5UJJ545usVZBws4JsEXx+Tnhqby6yGir8RyTmzs/WITgQTp1zlTPD0aZLIzgfCQ
         P3ZPAf9lWKOmkBREuocVnqvxu1cRdgFNq8lt6U549/q1vBiC3yVyQxmkZ5FDbLfMOKfn
         9LP9yrEKDLXa/cqxSBBxnCdDmr8y8fZuEW6J3gIHgEoFAR6G2AaPFtDdw0FjypzsBRSq
         YwvpOR5bh9/EEwDZBhnrLTDegclNitnp6OkX98/n1nQnJ9Nb4OOUcWNbKKSVKgWtj2gJ
         lFuN7UnRmd/T9VvOoEqOLy/wFYNszdyAJtJ+IxqDcva7nOAwC74CT5ul/NG6NUtPFhL7
         MR9w==
X-Gm-Message-State: AOAM532FOyqPWcPfbG4VVcqM9UzCWVKIl4RDMhAIynkI+Mz9jClN4cF8
        JoZyMfFxpmiaafXRBzgikIF9xkh55BL+hlUjxhxZ2GQQee5ZIQ==
X-Google-Smtp-Source: ABdhPJzNE2PeASRcIJvKt4R/Z+HTu/qLaGAHOS35+cdWjHq2uCN4NabpKfAGsnOvR0+DlusjKZbPZCfOfDdPFgcsheA=
X-Received: by 2002:a05:6512:39c4:: with SMTP id k4mr6766856lfu.79.1638375074836;
 Wed, 01 Dec 2021 08:11:14 -0800 (PST)
MIME-Version: 1.0
References: <20211123005036.2954379-1-pbonzini@redhat.com> <20211123005036.2954379-6-pbonzini@redhat.com>
In-Reply-To: <20211123005036.2954379-6-pbonzini@redhat.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 1 Dec 2021 09:11:03 -0700
Message-ID: <CAMkAt6q==8W-GY8s2yZEn9tRKydeaV+gDncidvHnjg5T1UMGPg@mail.gmail.com>
Subject: Re: [PATCH 05/12] KVM: SEV: cleanup locking for KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 5:50 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Encapsulate the handling of the migration_in_progress flag for both VMs in
> two functions sev_lock_two_vms and sev_unlock_two_vms.  It does not matter
> if KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM locks the source struct kvm a bit
> earlier, and this change 1) keeps the cleanup chain of labels smaller 2)
> makes it possible for KVM_CAP_VM_COPY_ENC_CONTEXT_FROM to reuse the logic.
>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Gonda <pgonda@google.com>

> ---
>  arch/x86/kvm/svm/sev.c | 50 ++++++++++++++++++++----------------------
>  1 file changed, 24 insertions(+), 26 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 75955beb3770..23a4877d7bdf 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -1543,28 +1543,37 @@ static bool is_cmd_allowed_from_mirror(u32 cmd_id)
>         return false;
>  }
>
> -static int sev_lock_for_migration(struct kvm *kvm)
> +static int sev_lock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
>  {
> -       struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> +       struct kvm_sev_info *dst_sev = &to_kvm_svm(dst_kvm)->sev_info;
> +       struct kvm_sev_info *src_sev = &to_kvm_svm(src_kvm)->sev_info;
>
>         /*
> -        * Bail if this VM is already involved in a migration to avoid deadlock
> -        * between two VMs trying to migrate to/from each other.
> +        * Bail if these VMs are already involved in a migration to avoid
> +        * deadlock between two VMs trying to migrate to/from each other.

Nit: This comment will be a little stale once we use this function for
clone too. Is there a generic term we could use for migration and
clone?

>          */
> -       if (atomic_cmpxchg_acquire(&sev->migration_in_progress, 0, 1))
> +       if (atomic_cmpxchg_acquire(&dst_sev->migration_in_progress, 0, 1))

Nit: I guess the same comment can be made for |migration_in_progress|.

>                 return -EBUSY;
>
> -       mutex_lock(&kvm->lock);
> +       if (atomic_cmpxchg_acquire(&src_sev->migration_in_progress, 0, 1)) {
> +               atomic_set_release(&dst_sev->migration_in_progress, 0);
> +               return -EBUSY;
> +       }
>
> +       mutex_lock(&dst_kvm->lock);
> +       mutex_lock(&src_kvm->lock);
>         return 0;
>  }
>
> -static void sev_unlock_after_migration(struct kvm *kvm)
> +static void sev_unlock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
>  {
> -       struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> +       struct kvm_sev_info *dst_sev = &to_kvm_svm(dst_kvm)->sev_info;
> +       struct kvm_sev_info *src_sev = &to_kvm_svm(src_kvm)->sev_info;
>
> -       mutex_unlock(&kvm->lock);
> -       atomic_set_release(&sev->migration_in_progress, 0);
> +       mutex_unlock(&dst_kvm->lock);
> +       mutex_unlock(&src_kvm->lock);
> +       atomic_set_release(&dst_sev->migration_in_progress, 0);
> +       atomic_set_release(&src_sev->migration_in_progress, 0);
>  }
>
>
> @@ -1665,15 +1674,6 @@ int svm_vm_migrate_from(struct kvm *kvm, unsigned int source_fd)
>         bool charged = false;
>         int ret;
>
> -       ret = sev_lock_for_migration(kvm);
> -       if (ret)
> -               return ret;
> -
> -       if (sev_guest(kvm)) {
> -               ret = -EINVAL;
> -               goto out_unlock;
> -       }
> -
>         source_kvm_file = fget(source_fd);
>         if (!file_is_kvm(source_kvm_file)) {
>                 ret = -EBADF;
> @@ -1681,13 +1681,13 @@ int svm_vm_migrate_from(struct kvm *kvm, unsigned int source_fd)
>         }
>
>         source_kvm = source_kvm_file->private_data;
> -       ret = sev_lock_for_migration(source_kvm);
> +       ret = sev_lock_two_vms(kvm, source_kvm);
>         if (ret)
>                 goto out_fput;
>
> -       if (!sev_guest(source_kvm)) {
> +       if (sev_guest(kvm) || !sev_guest(source_kvm)) {
>                 ret = -EINVAL;
> -               goto out_source;
> +               goto out_unlock;
>         }
>
>         src_sev = &to_kvm_svm(source_kvm)->sev_info;
> @@ -1727,13 +1727,11 @@ int svm_vm_migrate_from(struct kvm *kvm, unsigned int source_fd)
>                 sev_misc_cg_uncharge(cg_cleanup_sev);
>         put_misc_cg(cg_cleanup_sev->misc_cg);
>         cg_cleanup_sev->misc_cg = NULL;
> -out_source:
> -       sev_unlock_after_migration(source_kvm);
> +out_unlock:
> +       sev_unlock_two_vms(kvm, source_kvm);
>  out_fput:
>         if (source_kvm_file)
>                 fput(source_kvm_file);
> -out_unlock:
> -       sev_unlock_after_migration(kvm);
>         return ret;
>  }
>
> --
> 2.27.0
>
>
