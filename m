Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7AD494E9A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245321AbiATNHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244622AbiATNHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:07:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3E6C061574;
        Thu, 20 Jan 2022 05:07:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81271B81A74;
        Thu, 20 Jan 2022 13:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE70AC340E0;
        Thu, 20 Jan 2022 13:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642684039;
        bh=c19BuRk0Zh2oimT7UqMQr8Bit7U+S2t98zkERlbgPOk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZRgUp8RcdVCtx4Y6AA2+AVtXTE7ArUcDwOnNLRrkAfY0zDq/eO24MsDdGz9AHLGoL
         OOa4phRRwVlhJL9CHYHnEBgejovf3Wo3lloax/H/75S+aeEOpwznh+F53wp6mhTm6E
         RxkL/TPHbpJ+O8nH4+pAdeM11hMkE7mvtN8bG4LYoWBpEuuRog9tG/zRocoBydRUfS
         SXZMPcsFWrzC2R6wrg8x9xeNfGv/9iXrtMQbAh7Hx3mFWD4tycDHCqnTRJoYztzinq
         gJTDQHNU0iJJPWcDzMMRy2BPLZR/2RBczZkgtWUErtkYWtaCm+wol1jAx4PgH0VOr1
         OfKOY5nVRbi3A==
Message-ID: <abeddeee390824d261018cecf5be3f7379fe4b38.camel@kernel.org>
Subject: Re: [PATCH v3 1/2] x86/sgx: Add accounting for tracking overcommit
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 20 Jan 2022 15:07:03 +0200
In-Reply-To: <20220118175717.6922-2-kristen@linux.intel.com>
References: <20220118175717.6922-1-kristen@linux.intel.com>
         <20220118175717.6922-2-kristen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-18 at 09:57 -0800, Kristen Carlson Accardi wrote:
> When the system runs out of enclave memory, SGX can reclaim EPC pages
> by swapping to normal RAM. This normal RAM is allocated via a
> per-enclave shared memory area. The shared memory area is not mapped
> into the enclave or the task mapping it, which makes its memory use
> opaque (including to the OOM killer). Having lots of hard to find
> memory around is problematic, especially when there is no limit.
>=20
> Introduce a global counter that can be used to limit the number of
> pages
> that enclaves are able to consume for backing storage.=C2=A0 This
> parameter
> is a percentage value that is used in conjunction with the number of
> EPC pages in the system to set a cap on the amount of backing RAM
> that
> can be consumed.
>=20
> The default for this value is 150, which limits the total number of
> shared memory pages that may be consumed by all enclaves as backing
> pages to 1.5X of EPC pages on the system. For example, on an SGX
> system that has 128MB of EPC, this default would cap the amount of
> normal RAM that SGX consumes for its shared memory areas at 192MB.
> The value of 1.5x the number of EPC pages was chosen because it
> should
> handle the most common case of a few enclaves that don't need much
> overcommit without any impact to user space. In the less common case
> where there are many enclaves, or a few large enclaves which need
> a lot of overcommit due to large EPC memory requirements, the
> reclaimer may fail to allocate a backing page for swapping if the
> limit has been reached. In this case, the page will not be able
> to allocate any new EPC pages. Any ioctl or call to add new EPC
> pages will get -ENOMEM, so for example, new enclaves will fail to
> load, and new EPC pages will not be able to be added.
>=20
> The SGX overcommit_percent works differently than the core VM
> overcommit
> limit. Enclaves request backing pages one page at a time, and the
> number
> of in use backing pages that are allowed is a global resource that is
> limited for all enclaves.
>=20
> Introduce a pair of functions which can be used by callers when
> requesting
> backing RAM pages. These functions are responsible for accounting the
> page charges. A request may return an error if the request will cause
> the
> counter to exceed the backing page cap.
>=20
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> =C2=A0arch/x86/kernel/cpu/sgx/main.c | 45
> ++++++++++++++++++++++++++++++++++
> =C2=A0arch/x86/kernel/cpu/sgx/sgx.h=C2=A0 |=C2=A0 2 ++
> =C2=A02 files changed, 47 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/sgx/main.c
> b/arch/x86/kernel/cpu/sgx/main.c
> index 2857a49f2335..261e3702aef9 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -43,6 +43,45 @@ static struct sgx_numa_node *sgx_numa_nodes;
> =C2=A0
> =C2=A0static LIST_HEAD(sgx_dirty_page_list);
> =C2=A0
> +/*
> + * Limits the amount of normal RAM that SGX can consume for EPC
> + * overcommit to the total EPC pages * sgx_overcommit_percent / 100
> + */
> +static int sgx_overcommit_percent =3D 150;
> +
> +/* The number of pages that can be allocated globally for backing
> storage. */
> +static atomic_long_t sgx_nr_available_backing_pages;
> +
> +/**
> + * sgx_charge_mem() - charge for a page used for backing storage
> + *
> + * Backing storage usage is capped by the
> sgx_nr_available_backing_pages.
> + * If the backing storage usage is over the overcommit limit,
> + * return an error.
> + *
> + * Return:
> + * 0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0The pag=
e requested does not exceed the limit
> + * -ENOMEM:=C2=A0=C2=A0=C2=A0=C2=A0The page requested exceeds the overco=
mmit limit
> + */
> +int sgx_charge_mem(void)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!atomic_long_add_unless(&s=
gx_nr_available_backing_pages,
> -1, 0))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return -ENOMEM;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> +}
> +
> +/**
> + * sgx_uncharge_mem() - uncharge a page previously used for backing
> storage
> + *
> + * When backing storage is no longer in use, increment the
> + * sgx_nr_available_backing_pages counter.
> + */
> +void sgx_uncharge_mem(void)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0atomic_long_inc(&sgx_nr_availa=
ble_backing_pages);
> +}
> +
> =C2=A0/*
> =C2=A0 * Reset post-kexec EPC pages to the uninitialized state. The pages
> are removed
> =C2=A0 * from the input list, and made available for the page allocator.
> SECS pages
> @@ -783,6 +822,8 @@ static inline u64 __init
> sgx_calc_section_metric(u64 low, u64 high)
> =C2=A0static bool __init sgx_page_cache_init(void)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 eax, ebx, ecx, edx, t=
ype;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 available_backing_bytes;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 total_epc_bytes =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 pa, size;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int nid;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i;
> @@ -830,6 +871,7 @@ static bool __init sgx_page_cache_init(void)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0sgx_epc_sections[i].node =3D=C2=A0 &sgx_numa_nodes[=
nid];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0sgx_numa_nodes[nid].size +=3D size;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0total_epc_bytes +=3D size;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0sgx_nr_epc_sections++;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> @@ -839,6 +881,9 @@ static bool __init sgx_page_cache_init(void)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return false;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0available_backing_bytes =3D to=
tal_epc_bytes *
> (sgx_overcommit_percent / 100);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0atomic_long_set(&sgx_nr_availa=
ble_backing_pages,
> available_backing_bytes >> PAGE_SHIFT);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return true;
> =C2=A0}
> =C2=A0
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h
> b/arch/x86/kernel/cpu/sgx/sgx.h
> index 0f17def9fe6f..3507a9983fc1 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -89,6 +89,8 @@ void sgx_free_epc_page(struct sgx_epc_page *page);
> =C2=A0void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
> =C2=A0int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
> =C2=A0struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
> +int sgx_charge_mem(void);
> +void sgx_uncharge_mem(void);
> =C2=A0
> =C2=A0#ifdef CONFIG_X86_SGX_KVM
> =C2=A0int __init sgx_vepc_init(void);

For me this looks cool. I also found out where the charge keyword comes
from while looking at shmem code for doing patches to add the checks that
Dave suggested (shmem_charge(), shmem_uncharge()).

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
