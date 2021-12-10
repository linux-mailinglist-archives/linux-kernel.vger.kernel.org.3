Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF21947037F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242675AbhLJPMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbhLJPMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:12:22 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2EAC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 07:08:47 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id 15so8711377ilq.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 07:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IqGfMFMGzZuu2Hv/uD9rOzDxJvikzGWBAyGek2h55DE=;
        b=lW1C+rDjLspw7SVQAt0vSMM28+yVbcX5DDOIAMj81eboyg8FUcvBswACi9kzsCZ1H9
         5LYkmAl+ripLpLeA1JYjDfRVYOfnjhZ6POVxyIYR4Lum49RLzZ5RWdIcix2V6olLEP/9
         gzbS+aFMeFov/O7/Ut1NTNm3Ha9UNky/dDQ9C4caEsTOP7NocNO5oh3X+wrXcgjMnJZQ
         T81e6QY9941LqW4DIbK2SAlUbGXIxVpWGWtuWKb/QIycyTmpcjNGtegCxvoq4MRi7lL+
         cGcQirooM0N9R5XJPxNK6aimO3w+ibnOuRqK/8HTRPz7XKrzXhGUhqnTxmOH+0yVdhsE
         Nd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IqGfMFMGzZuu2Hv/uD9rOzDxJvikzGWBAyGek2h55DE=;
        b=F3yCsHjKL9m/fDr47qTOHVz3OLhaFrkBF5Ed/aplA6mymLmPR1GFYF/cWDEQ8yoL8g
         LXTLbYiFZdBSXd9BaKSg65o0EhOyYoaO33tKzXNCy7pvMM75hP5raX920qh1fxwluu0f
         9BbH6aQBIPqziXiQ3MmAd6r7M8HPCujrGcfNkF/RYfJTtcOwsT5JcM3r2DYNuuuJarR8
         A+/JHVhL3EWULA2ckCX11f89xUZPRmAS1AtQmHNku7TSgj0ZD3L3b3hra9ExHAiS1N4q
         p/2rXhJRapHHqBh9f5NYkRfyUjLtGgfBcX4gRIkD12Ps2VuSJ2LRv45IKyl6tnNd1Sa4
         0J8w==
X-Gm-Message-State: AOAM530RF9UmCbdussrQbsW7utwmevR4wFAwUMaLWpYrQODXD0JXy63n
        8d6ooubyM8Tiyv0ZzzVfvxRp4VoFcdORft4G/jfDnjpEvmI=
X-Google-Smtp-Source: ABdhPJzVz6WZmrdfRJ0Qz3kVSX2BxRgBQX2vMBYg/p29dzxXYwaz2Oo90oQFzDWBPjHZ1KZSzvLtG/aQF2JhEXs/8M4=
X-Received: by 2002:a05:6e02:1a2c:: with SMTP id g12mr23925538ile.22.1639148926706;
 Fri, 10 Dec 2021 07:08:46 -0800 (PST)
MIME-Version: 1.0
References: <20211201170411.1561936-1-qperret@google.com> <20211201170411.1561936-14-qperret@google.com>
In-Reply-To: <20211201170411.1561936-14-qperret@google.com>
From:   Andrew Walbran <qwandor@google.com>
Date:   Fri, 10 Dec 2021 15:08:31 +0000
Message-ID: <CA+_y_2F0KF6WH+uTa4k3p72mCqeDuN1uzPKTx2u2E4bGUGaPJA@mail.gmail.com>
Subject: Re: [PATCH v3 13/15] KVM: arm64: Implement do_unshare() helper for
 unsharing memory
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


On Wed, 1 Dec 2021 at 17:05, 'Quentin Perret' via kernel-team
<kernel-team@android.com> wrote:
>
> From: Will Deacon <will@kernel.org>
>
> Tearing down a previously shared memory region results in the borrower
> losing access to the underlying pages and returning them to the "owned"
> state in the owner.
>
> Implement a do_unshare() helper, along the same lines as do_share(), to
> provide this functionality for the host-to-hyp case.
>
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c | 115 ++++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 1282cbd6b9b3..43b25e2de780 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -485,6 +485,16 @@ static int host_request_owned_transition(u64 *completer_addr,
>         return __host_check_page_state_range(addr, size, PKVM_PAGE_OWNED);
>  }
>
> +static int host_request_unshare(u64 *completer_addr,
> +                               const struct pkvm_mem_transition *tx)
> +{
> +       u64 size = tx->nr_pages * PAGE_SIZE;
> +       u64 addr = tx->initiator.addr;
> +
> +       *completer_addr = tx->initiator.host.completer_addr;
> +       return __host_check_page_state_range(addr, size, PKVM_PAGE_SHARED_OWNED);
> +}
> +
>  static int host_initiate_share(u64 *completer_addr,
>                                const struct pkvm_mem_transition *tx)
>  {
> @@ -495,6 +505,16 @@ static int host_initiate_share(u64 *completer_addr,
>         return __host_set_page_state_range(addr, size, PKVM_PAGE_SHARED_OWNED);
>  }
>
> +static int host_initiate_unshare(u64 *completer_addr,
> +                                const struct pkvm_mem_transition *tx)
> +{
> +       u64 size = tx->nr_pages * PAGE_SIZE;
> +       u64 addr = tx->initiator.addr;
> +
> +       *completer_addr = tx->initiator.host.completer_addr;
> +       return __host_set_page_state_range(addr, size, PKVM_PAGE_OWNED);
> +}
> +
>  static enum pkvm_page_state hyp_get_page_state(kvm_pte_t pte)
>  {
>         if (!kvm_pte_valid(pte))
> @@ -535,6 +555,17 @@ static int hyp_ack_share(u64 addr, const struct pkvm_mem_transition *tx,
>         return __hyp_check_page_state_range(addr, size, PKVM_NOPAGE);
>  }
>
> +static int hyp_ack_unshare(u64 addr, const struct pkvm_mem_transition *tx)
> +{
> +       u64 size = tx->nr_pages * PAGE_SIZE;
> +
> +       if (__hyp_ack_skip_pgtable_check(tx))
> +               return 0;
> +
> +       return __hyp_check_page_state_range(addr, size,
> +                                           PKVM_PAGE_SHARED_BORROWED);
> +}
> +
>  static int hyp_complete_share(u64 addr, const struct pkvm_mem_transition *tx,
>                               enum kvm_pgtable_prot perms)
>  {
> @@ -545,6 +576,14 @@ static int hyp_complete_share(u64 addr, const struct pkvm_mem_transition *tx,
>         return pkvm_create_mappings_locked(start, end, prot);
>  }
>
> +static int hyp_complete_unshare(u64 addr, const struct pkvm_mem_transition *tx)
> +{
> +       u64 size = tx->nr_pages * PAGE_SIZE;
> +       int ret = kvm_pgtable_hyp_unmap(&pkvm_pgtable, addr, size);
> +
> +       return (ret != size) ? -EFAULT : 0;
> +}
> +
>  static int check_share(struct pkvm_mem_share *share)
>  {
>         const struct pkvm_mem_transition *tx = &share->tx;
> @@ -621,6 +660,82 @@ static int do_share(struct pkvm_mem_share *share)
>         return WARN_ON(__do_share(share));
>  }
>
> +static int check_unshare(struct pkvm_mem_share *share)
> +{
> +       const struct pkvm_mem_transition *tx = &share->tx;
> +       u64 completer_addr;
> +       int ret;
> +
> +       switch (tx->initiator.id) {
> +       case PKVM_ID_HOST:
> +               ret = host_request_unshare(&completer_addr, tx);
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
> +               ret = hyp_ack_unshare(completer_addr, tx);
> +               break;
> +       default:
> +               ret = -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
> +static int __do_unshare(struct pkvm_mem_share *share)
> +{
> +       const struct pkvm_mem_transition *tx = &share->tx;
> +       u64 completer_addr;
> +       int ret;
> +
> +       switch (tx->initiator.id) {
> +       case PKVM_ID_HOST:
> +               ret = host_initiate_unshare(&completer_addr, tx);
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
> +               ret = hyp_complete_unshare(completer_addr, tx);
> +               break;
> +       default:
> +               ret = -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
> +/*
> + * do_unshare():
> + *
> + * The page owner revokes access from another component for a range of
> + * pages which were previously shared using do_share().
> + *
> + * Initiator: SHARED_OWNED     => OWNED
> + * Completer: SHARED_BORROWED  => NOPAGE
> + */
> +static int do_unshare(struct pkvm_mem_share *share)
> +{
> +       int ret;
> +
> +       ret = check_unshare(share);
> +       if (ret)
> +               return ret;
> +
> +       return WARN_ON(__do_unshare(share));
> +}
> +
>  int __pkvm_host_share_hyp(u64 pfn)
>  {
>         int ret;
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
