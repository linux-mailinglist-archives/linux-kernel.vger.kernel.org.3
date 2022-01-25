Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA7249B98C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346475AbiAYRCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354779AbiAYRAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:00:20 -0500
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Jan 2022 09:00:18 PST
Received: from mail.sf-mail.de (mail.sf-mail.de [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E7DC06174E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:00:17 -0800 (PST)
Received: (qmail 10734 invoked from network); 25 Jan 2022 16:52:27 -0000
Received: from p200300cf0713e20076d435fffeb7be92.dip0.t-ipconnect.de ([2003:cf:713:e200:76d4:35ff:feb7:be92]:48794 HELO eto.sf-tec.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.38dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
        for <linux-mm@kvack.org>; Tue, 25 Jan 2022 17:52:27 +0100
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        akpm@linux-foundation.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org
Subject: Re: [RFC V1 21/31] parisc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Tue, 25 Jan 2022 17:53:27 +0100
Message-ID: <11909976.O9o76ZdvQC@eto.sf-tec.de>
In-Reply-To: <1643029028-12710-22-git-send-email-anshuman.khandual@arm.com>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com> <1643029028-12710-22-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5535662.DvuYhMxLoT"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5535662.DvuYhMxLoT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Anshuman Khandual wrote:
> This defines and exports a platform specific custom vm_get_page_prot() via
> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
> macros can be dropped which are no longer needed.
> 
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/parisc/Kconfig               |  1 +
>  arch/parisc/include/asm/pgtable.h | 20 ---------------
>  arch/parisc/mm/init.c             | 41 +++++++++++++++++++++++++++++++
>  3 files changed, 42 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index 43c1c880def6..de512f120b50 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -10,6 +10,7 @@ config PARISC
>  	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
> +	select ARCH_HAS_VM_GET_PAGE_PROT
>  	select ARCH_NO_SG_CHAIN
>  	select ARCH_SUPPORTS_HUGETLBFS if PA20
>  	select ARCH_SUPPORTS_MEMORY_FAILURE
> diff --git a/arch/parisc/include/asm/pgtable.h
> b/arch/parisc/include/asm/pgtable.h index 3e7cf882639f..80d99b2b5913 100644
> --- a/arch/parisc/include/asm/pgtable.h
> +++ b/arch/parisc/include/asm/pgtable.h
> @@ -269,26 +269,6 @@ extern void __update_cache(pte_t pte);
>   * pages.
>   */
> 
> -	 /*xwr*/
> -#define __P000  PAGE_NONE
> -#define __P001  PAGE_READONLY
> -#define __P010  __P000 /* copy on write */
> -#define __P011  __P001 /* copy on write */
> -#define __P100  PAGE_EXECREAD
> -#define __P101  PAGE_EXECREAD
> -#define __P110  __P100 /* copy on write */
> -#define __P111  __P101 /* copy on write */
> -
> -#define __S000  PAGE_NONE
> -#define __S001  PAGE_READONLY
> -#define __S010  PAGE_WRITEONLY
> -#define __S011  PAGE_SHARED
> -#define __S100  PAGE_EXECREAD
> -#define __S101  PAGE_EXECREAD
> -#define __S110  PAGE_RWX
> -#define __S111  PAGE_RWX
> -
> -
>  extern pgd_t swapper_pg_dir[]; /* declared in init_task.c */
> 
>  /* initial page tables for 0-8MB for kernel */
> diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
> index 1ae31db9988f..c8316e97e1a2 100644
> --- a/arch/parisc/mm/init.c
> +++ b/arch/parisc/mm/init.c
> @@ -866,3 +866,44 @@ void flush_tlb_all(void)
>  	spin_unlock(&sid_lock);
>  }
>  #endif
> +
> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
> +{
> +	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
> +	case VM_NONE:
> +		return PAGE_NONE;
> +	case VM_READ:
> +		return PAGE_READONLY;
> +	case VM_WRITE:
> +		return PAGE_NONE;
> +	case VM_READ | VM_WRITE:
> +		return PAGE_READONLY;

This looks extremely strange. It probably is correct when it comes to CoW, how 
about including the comment that was in the original definitions for the cases 
where CoW is expected?

> +	case VM_EXEC:
> +		return PAGE_EXECREAD;
> +	case VM_EXEC | VM_READ:
> +		return PAGE_EXECREAD;
> +	case VM_EXEC | VM_WRITE:
> +		return PAGE_EXECREAD;
> +	case VM_EXEC | VM_READ | VM_WRITE:
> +		return PAGE_EXECREAD;
> +	case VM_SHARED:
> +		return PAGE_NONE;
> +	case VM_SHARED | VM_READ:
> +		return PAGE_READONLY;
> +	case VM_SHARED | VM_WRITE:
> +		return PAGE_WRITEONLY;
> +	case VM_SHARED | VM_READ | VM_WRITE:
> +		return PAGE_SHARED;
> +	case VM_SHARED | VM_EXEC:
> +		return PAGE_EXECREAD;
> +	case VM_SHARED | VM_EXEC | VM_READ:
> +		return PAGE_EXECREAD;
> +	case VM_SHARED | VM_EXEC | VM_WRITE:
> +		return PAGE_RWX;
> +	case VM_SHARED | VM_EXEC | VM_READ | VM_WRITE:
> +		return PAGE_RWX;
> +	default:
> +		BUILD_BUG();
> +	}
> +}
> +EXPORT_SYMBOL(vm_get_page_prot);


--nextPart5535662.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCYfArBwAKCRBcpIk+abn8
Tn3fAJ9mCiqlAWz0LSE02l6g56q9bKoqEgCfTTU/KTI/Xf7FeIAR89tBwIQgI/A=
=Hgfz
-----END PGP SIGNATURE-----

--nextPart5535662.DvuYhMxLoT--



