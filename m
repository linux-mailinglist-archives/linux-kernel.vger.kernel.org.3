Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFD74703AB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242757AbhLJPWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239316AbhLJPWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:22:37 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2C7C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 07:19:02 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id a11so8722632ilj.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 07:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hEmjbMo0ZsJ3TjBk5kcSaZtBAj1+iwJQz9LpuHVA9P8=;
        b=adjHU3j7rH8I3KZ7nA9tqZjFgCdOCuNz8zU1VrxrHl/Dw0n5x3fQTFQk1Hn2IHGHv6
         VU0/pYHuBm8zCiPP61OLvv8YobfjZo3g9FzZNOztHOuHY0HAiOBWQd1eskYf6PYC3rJm
         p3CfbfsVfXevd7OFsjWr7SL29ZbjFW8u14n+TGlEUKk51l2Z53WO1oC3BVW3hQkOkyrr
         0A+T50X0a60nlpG73r3zaUYIJ+MSOzm8IgDfJiH2JSb+3R7ZVIlS1PUuveKw19oGbEgY
         FRie4WYQYA55XOW2dhggRoaKJYzGmctKKqplAQzgMHVffM62jgpvk6S3dzWHMpTmVSmP
         E1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hEmjbMo0ZsJ3TjBk5kcSaZtBAj1+iwJQz9LpuHVA9P8=;
        b=kS1ElxUJwgZc2Ol/kHvsdNAd0Vbekc7vOs/g0Cr3hxFvEuq4WkdK01AgF3WA+lXvss
         R8Dd8x3z0vdOzuW2Enk1CCSFBICNtG8Yh0rReMVtHLlYR75YxVfWUSECqdwWVdKu6sAG
         Z6D4mJ46KU09EzGOSm9Ax4CLUab47AsSTqPk+oo9rC+Q8H/Hk+GcRH3F2TJx6z5MR+IT
         7yYwuIaos+XOT83uBVYmiBAePbCXWH+sdNE/xOBvVkytfOVnbFdoSJvmpxU0edujuUOa
         INjTY5+CzQ32Mp4qE3Ozpq6u+nmG/JtLTEsC9+IZRrMdVTMHds+ZKBiaPxDyes2M5FyT
         pl9g==
X-Gm-Message-State: AOAM531uMGMashDkgYSdzGvKJaWcO446qczbogaSEB3MpLhJ5PKwOkg5
        urWBKQ0cMx9D7uL+EKwOMa2TqI+oIiYbdG7j1j+nyg==
X-Google-Smtp-Source: ABdhPJzfs0RYsbtxr+hNbrS5EFgoPyGeyMd247aeDfYO1cdIpTQebvlNzQ3dtI+jNUaj2c61s2HVOL8MndEGlGtfLxE=
X-Received: by 2002:a92:cd8e:: with SMTP id r14mr19222736ilb.277.1639149541371;
 Fri, 10 Dec 2021 07:19:01 -0800 (PST)
MIME-Version: 1.0
References: <20211201170411.1561936-1-qperret@google.com> <20211201170411.1561936-12-qperret@google.com>
In-Reply-To: <20211201170411.1561936-12-qperret@google.com>
From:   Andrew Walbran <qwandor@google.com>
Date:   Fri, 10 Dec 2021 15:18:50 +0000
Message-ID: <CA+_y_2FMrc=XqAPK-WVtb5No9xYXOXmaLbVE+AEGZL668YhKGQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/15] KVM: arm64: Implement do_share() helper for
 sharing memory
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

Reviewed-by: Andrew Walbran <qwandor@google.com>

On Wed, 1 Dec 2021 at 17:04, 'Quentin Perret' via kernel-team
<kernel-team@android.com> wrote:
>
> From: Will Deacon <will@kernel.org>
>
> By default, protected KVM isolates memory pages so that they are
> accessible only to their owner: be it the host kernel, the hypervisor
> at EL2 or (in future) the guest. Establishing shared-memory regions
> between these components therefore involves a transition for each page
> so that the owner can share memory with a borrower under a certain set
> of permissions.
>
> Introduce a do_share() helper for safely sharing a memory region between
> two components. Currently, only host-to-hyp sharing is implemented, but
> the code is easily extended to handle other combinations and the
> permission checks for each component are reusable.
>
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c | 237 ++++++++++++++++++++++++++
>  1 file changed, 237 insertions(+)
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 757dfefe3aeb..74ca4043b08a 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -471,3 +471,240 @@ void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt)
>         ret = host_stage2_idmap(addr);
>         BUG_ON(ret && ret != -EAGAIN);
>  }
> +
> +/* This corresponds to locking order */
> +enum pkvm_component_id {
> +       PKVM_ID_HOST,
> +       PKVM_ID_HYP,
> +};
> +
> +struct pkvm_mem_transition {
> +       u64                             nr_pages;
> +
> +       struct {
> +               enum pkvm_component_id  id;
> +               /* Address in the initiator's address space */
> +               u64                     addr;
> +
> +               union {
> +                       struct {
> +                               /* Address in the completer's address space */
> +                               u64     completer_addr;
> +                       } host;
> +               };
> +       } initiator;
> +
> +       struct {
> +               enum pkvm_component_id  id;
> +       } completer;
> +};
> +
> +struct pkvm_mem_share {
> +       const struct pkvm_mem_transition        tx;
> +       const enum kvm_pgtable_prot             prot;
It would be helpful to add a comment documenting what this is used for
(i.e. whether it is for the initiator or completer). Or even rename it
to something like completer_prot to make that clear.

> +};
> +
> +struct check_walk_data {
> +       enum pkvm_page_state    desired;
> +       enum pkvm_page_state    (*get_page_state)(kvm_pte_t pte);
> +};
> +
> +static int __check_page_state_visitor(u64 addr, u64 end, u32 level,
> +                                     kvm_pte_t *ptep,
> +                                     enum kvm_pgtable_walk_flags flag,
> +                                     void * const arg)
> +{
> +       struct check_walk_data *d = arg;
> +       kvm_pte_t pte = *ptep;
> +
> +       if (kvm_pte_valid(pte) && !addr_is_memory(kvm_pte_to_phys(pte)))
> +               return -EINVAL;
> +
> +       return d->get_page_state(pte) == d->desired ? 0 : -EPERM;
> +}
> +
> +static int check_page_state_range(struct kvm_pgtable *pgt, u64 addr, u64 size,
> +                                 struct check_walk_data *data)
> +{
> +       struct kvm_pgtable_walker walker = {
> +               .cb     = __check_page_state_visitor,
> +               .arg    = data,
> +               .flags  = KVM_PGTABLE_WALK_LEAF,
> +       };
> +
> +       return kvm_pgtable_walk(pgt, addr, size, &walker);
> +}
> +
> +static enum pkvm_page_state host_get_page_state(kvm_pte_t pte)
> +{
> +       if (!kvm_pte_valid(pte) && pte)
> +               return PKVM_NOPAGE;
> +
> +       return pkvm_getstate(kvm_pgtable_stage2_pte_prot(pte));
> +}
> +
> +static int __host_check_page_state_range(u64 addr, u64 size,
> +                                        enum pkvm_page_state state)
> +{
> +       struct check_walk_data d = {
> +               .desired        = state,
> +               .get_page_state = host_get_page_state,
> +       };
> +
> +       hyp_assert_lock_held(&host_kvm.lock);
> +       return check_page_state_range(&host_kvm.pgt, addr, size, &d);
> +}
> +
> +static int __host_set_page_state_range(u64 addr, u64 size,
> +                                      enum pkvm_page_state state)
> +{
> +       enum kvm_pgtable_prot prot = pkvm_mkstate(PKVM_HOST_MEM_PROT, state);
> +
> +       return host_stage2_idmap_locked(addr, size, prot);
> +}
> +
> +static int host_request_owned_transition(u64 *completer_addr,
> +                                        const struct pkvm_mem_transition *tx)
> +{
> +       u64 size = tx->nr_pages * PAGE_SIZE;
> +       u64 addr = tx->initiator.addr;
> +
> +       *completer_addr = tx->initiator.host.completer_addr;
> +       return __host_check_page_state_range(addr, size, PKVM_PAGE_OWNED);
> +}
> +
> +static int host_initiate_share(u64 *completer_addr,
> +                              const struct pkvm_mem_transition *tx)
> +{
> +       u64 size = tx->nr_pages * PAGE_SIZE;
> +       u64 addr = tx->initiator.addr;
> +
> +       *completer_addr = tx->initiator.host.completer_addr;
> +       return __host_set_page_state_range(addr, size, PKVM_PAGE_SHARED_OWNED);
> +}
> +
> +static enum pkvm_page_state hyp_get_page_state(kvm_pte_t pte)
> +{
> +       if (!kvm_pte_valid(pte))
> +               return PKVM_NOPAGE;
> +
> +       return pkvm_getstate(kvm_pgtable_stage2_pte_prot(pte));
> +}
> +
> +static int __hyp_check_page_state_range(u64 addr, u64 size,
> +                                       enum pkvm_page_state state)
> +{
> +       struct check_walk_data d = {
> +               .desired        = state,
> +               .get_page_state = hyp_get_page_state,
> +       };
> +
> +       hyp_assert_lock_held(&pkvm_pgd_lock);
> +       return check_page_state_range(&pkvm_pgtable, addr, size, &d);
> +}
> +
> +static bool __hyp_ack_skip_pgtable_check(const struct pkvm_mem_transition *tx)
> +{
> +       return !(IS_ENABLED(CONFIG_NVHE_EL2_DEBUG) ||
> +                tx->initiator.id != PKVM_ID_HOST);
> +}
> +
> +static int hyp_ack_share(u64 addr, const struct pkvm_mem_transition *tx,
> +                        enum kvm_pgtable_prot perms)
> +{
> +       u64 size = tx->nr_pages * PAGE_SIZE;
> +
> +       if (perms != PAGE_HYP)
> +               return -EPERM;
> +
> +       if (__hyp_ack_skip_pgtable_check(tx))
> +               return 0;
> +
> +       return __hyp_check_page_state_range(addr, size, PKVM_NOPAGE);
> +}
> +
> +static int hyp_complete_share(u64 addr, const struct pkvm_mem_transition *tx,
> +                             enum kvm_pgtable_prot perms)
> +{
> +       void *start = (void *)addr, *end = start + (tx->nr_pages * PAGE_SIZE);
> +       enum kvm_pgtable_prot prot;
> +
> +       prot = pkvm_mkstate(perms, PKVM_PAGE_SHARED_BORROWED);
> +       return pkvm_create_mappings_locked(start, end, prot);
> +}
> +
> +static int check_share(struct pkvm_mem_share *share)
> +{
> +       const struct pkvm_mem_transition *tx = &share->tx;
> +       u64 completer_addr;
> +       int ret;
> +
> +       switch (tx->initiator.id) {
> +       case PKVM_ID_HOST:
> +               ret = host_request_owned_transition(&completer_addr, tx);
> +               break;
> +       default:
> +               ret = -EINVAL;
> +       }
> +
> +       if (ret)
> +               return ret;
> +
> +       switch (tx->completer.id) {
> +       case PKVM_ID_HYP:
> +               ret = hyp_ack_share(completer_addr, tx, share->prot);
> +               break;
> +       default:
> +               ret = -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
> +static int __do_share(struct pkvm_mem_share *share)
> +{
> +       const struct pkvm_mem_transition *tx = &share->tx;
> +       u64 completer_addr;
> +       int ret;
> +
> +       switch (tx->initiator.id) {
> +       case PKVM_ID_HOST:
> +               ret = host_initiate_share(&completer_addr, tx);
> +               break;
> +       default:
> +               ret = -EINVAL;
> +       }
> +
> +       if (ret)
> +               return ret;
> +
> +       switch (tx->completer.id) {
> +       case PKVM_ID_HYP:
> +               ret = hyp_complete_share(completer_addr, tx, share->prot);
> +               break;
> +       default:
> +               ret = -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
> +/*
> + * do_share():
> + *
> + * The page owner grants access to another component with a given set
> + * of permissions.
> + *
> + * Initiator: OWNED    => SHARED_OWNED
> + * Completer: NOPAGE   => SHARED_BORROWED
> + */
> +static int do_share(struct pkvm_mem_share *share)
> +{
> +       int ret;
> +
> +       ret = check_share(share);
> +       if (ret)
> +               return ret;
> +
> +       return WARN_ON(__do_share(share));
> +}
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
