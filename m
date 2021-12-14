Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C9847458C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbhLNOsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbhLNOsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:48:42 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75581C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 06:48:42 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id c3so24506965iob.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 06:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GLws1fv1VvQ+JdMbCyDoHLq+rkRsysRGV91MeqRMLdM=;
        b=eviPoIzpJMZdqH8yuSUhoKHalI4tyZogPyEoK8h12DRJoxZ0Ab7m31ZEODVknuaUcK
         WvUVetw7Alaz4hJSjVAWjhx7KCT5kx/lOgBR+hC0BcDwiEStS301DAsf2gy4tAmQkiB4
         WfwWMsaZHzfsY69AxbS9wLCyQZXDDni+SPH8F6ioe13dcus2bBNrG6zAVFu7RocBzMgh
         +uYvoeYFBRJReekBk/AkCZpxAXDLQPPWrxL4XoZObuiURRFgb0ZcFTgxeZDmPplF+63A
         owOfqrAQ9Fre27IS9uvk8WtFqJuHNK27IoUeVwcojxXSCUdOROipbAGl10vnihs+9rYV
         OggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLws1fv1VvQ+JdMbCyDoHLq+rkRsysRGV91MeqRMLdM=;
        b=R3UJBb5rUXD9W6XiAHnvNyUYECR64smZtEQUnn1CUyqp8Q4QJHdAgovyFfNNCAJ/k9
         E5kiIUF9gAquBhkbK91n7sC/TKf9i/416vlEWXrnjxDwmmfi7uRmv0V98gPUud8dU5Us
         x1n1UdTG5q7nG++I8HPo5ZDzFKXyBJ3srR8VVhXwO/bEOoZJOipM3mRR/kCxOuoD2z/z
         NvCSx7XgzcF/va8CrLfX7KpxK6M0GMc18YZQ6/yiXaKajuFRs0uMSHOjb4DnFGJcZpar
         r8ZEH+Ves5v8wrS1zELb2iOirwylqAwRxyKsax8ehOK03waogtIPXZBuqyZYZAuk2uUw
         I+iw==
X-Gm-Message-State: AOAM5326/3heGOVVXTUyhhmXxilSyhgicTYfLqkCMjy/PaR2HpbytU1j
        8YiiO2wybYN+OjVWUNiBa31PKOqr2yjWj5Dlm0Jsdw==
X-Google-Smtp-Source: ABdhPJwDobqQ0ytVa0HxNlcgE4bESeMZUOEn4HcyugZoluHpS2Q4fWuEd3GtI+jUITR45jghm1HTYm2iOEJoB2ew/AQ=
X-Received: by 2002:a02:6945:: with SMTP id e66mr3303073jac.620.1639493321703;
 Tue, 14 Dec 2021 06:48:41 -0800 (PST)
MIME-Version: 1.0
References: <20211201170411.1561936-1-qperret@google.com> <20211201170411.1561936-11-qperret@google.com>
In-Reply-To: <20211201170411.1561936-11-qperret@google.com>
From:   Andrew Walbran <qwandor@google.com>
Date:   Tue, 14 Dec 2021 14:48:30 +0000
Message-ID: <CA+_y_2HKwtm5839QyEY9D8PaZWky_Zvn3msrw2gcR2Z7UZgObQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] KVM: arm64: Introduce wrappers for host and hyp
 spin lock accessors
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2021 at 17:04, 'Quentin Perret' via kernel-team
<kernel-team@android.com> wrote:
>
> From: Will Deacon <will@kernel.org>
>
> In preparation for adding additional locked sections for manipulating
> page-tables at EL2, introduce some simple wrappers around the host and
> hypervisor locks so that it's a bit easier to read and bit more difficult
> to take the wrong lock (or even take them in the wrong order).
Looks good, but how does this help prevent taking locks in the wrong order?

>
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c | 32 ++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index c1a90dd022b8..757dfefe3aeb 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -27,6 +27,26 @@ static struct hyp_pool host_s2_pool;
>
>  const u8 pkvm_hyp_id = 1;
>
> +static void host_lock_component(void)
> +{
> +       hyp_spin_lock(&host_kvm.lock);
> +}
> +
> +static void host_unlock_component(void)
> +{
> +       hyp_spin_unlock(&host_kvm.lock);
> +}
> +
> +static void hyp_lock_component(void)
> +{
> +       hyp_spin_lock(&pkvm_pgd_lock);
> +}
> +
> +static void hyp_unlock_component(void)
> +{
> +       hyp_spin_unlock(&pkvm_pgd_lock);
> +}
> +
>  static void *host_s2_zalloc_pages_exact(size_t size)
>  {
>         void *addr = hyp_alloc_pages(&host_s2_pool, get_order(size));
> @@ -338,14 +358,14 @@ static int host_stage2_idmap(u64 addr)
>
>         prot = is_memory ? PKVM_HOST_MEM_PROT : PKVM_HOST_MMIO_PROT;
>
> -       hyp_spin_lock(&host_kvm.lock);
> +       host_lock_component();
>         ret = host_stage2_adjust_range(addr, &range);
>         if (ret)
>                 goto unlock;
>
>         ret = host_stage2_idmap_locked(range.start, range.end - range.start, prot);
>  unlock:
> -       hyp_spin_unlock(&host_kvm.lock);
> +       host_unlock_component();
>
>         return ret;
>  }
> @@ -369,8 +389,8 @@ int __pkvm_host_share_hyp(u64 pfn)
>         if (!addr_is_memory(addr))
>                 return -EINVAL;
>
> -       hyp_spin_lock(&host_kvm.lock);
> -       hyp_spin_lock(&pkvm_pgd_lock);
> +       host_lock_component();
> +       hyp_lock_component();
>
>         ret = kvm_pgtable_get_leaf(&host_kvm.pgt, addr, &pte, NULL);
>         if (ret)
> @@ -432,8 +452,8 @@ int __pkvm_host_share_hyp(u64 pfn)
>         BUG_ON(ret);
>
>  unlock:
> -       hyp_spin_unlock(&pkvm_pgd_lock);
> -       hyp_spin_unlock(&host_kvm.lock);
> +       hyp_unlock_component();
> +       host_unlock_component();
>
>         return ret;
>  }
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
