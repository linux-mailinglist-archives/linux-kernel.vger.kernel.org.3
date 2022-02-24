Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DFF4C2191
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 03:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiBXCDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 21:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiBXCDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 21:03:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D926D3AF1;
        Wed, 23 Feb 2022 18:03:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96521B82353;
        Thu, 24 Feb 2022 02:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0E3C340EF;
        Thu, 24 Feb 2022 02:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645668181;
        bh=EXpllbxcrzgy7E+Zt2uuVgOjp9g+9BSyx9ZaGI0tTVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=faeUHNWaYLfZSiJ4uIY+ASRZvlhyg/uXc127ROH28PiChoKZIJSn+3GRjGVPF59sG
         Kzyfec5SbDcoKwZW+lnIIPn11eGoJ35Z7YOidN8l2wQDO8XJ619Cm2vut4cfZEMgHv
         HSKzSQEgLUuAQsGr+Sasn0Yie0k91zocR6xFEs8qdnd2zBUY2BalFU4W+E5z/HUPnL
         UqYadScjgWRJjqD+xGtsMPjqRIUUK7IBzTI6buZsrmyCNxbYrb5czNtyeTAvs9VL4F
         4jnBrMMf2tVDLlinx6h+VKthmJOa+969A+czt1Q+Ho0PS/+ABGfSYOQritsgS5z79t
         Jz6hOAnaACxtA==
Date:   Thu, 24 Feb 2022 02:02:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the folio tree with the maple tree
Message-ID: <YhbnUNKjN5SBWKwD@sirena.org.uk>
References: <20220224011653.1380557-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uiHEU8A1LLzcf4og"
Content-Disposition: inline
In-Reply-To: <20220224011653.1380557-1-broonie@kernel.org>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uiHEU8A1LLzcf4og
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 24, 2022 at 01:16:53AM +0000, broonie@kernel.org wrote:

> I have absolutely no confindence in this resolution.

Pretty sure that the resolution is bogus and I've broken boot (at least
=66rom some quick testing).  Not confirmed that this merge is the cause
though, I'll take a closer look tomorrow.  Any help from someone who's
looked at this code before would be much appreciated.

> diff --cc mm/mmap.c
> index 1b3600152f6f5,64b5985b5295c..0000000000000
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@@ -2286,32 -2780,38 +2286,37 @@@ int split_vma(struct mm_struct *mm, str
>   	return __split_vma(mm, vma, addr, new_below);
>   }
>  =20
>  -/* Munmap is split into 2 main parts -- this part which finds
>  +/*
>  + * do_mas_align_munmap() - munmap the aligned region from @start to @en=
d.
>  + * @mas: The maple_state, ideally set up to alter the correct tree loca=
tion.
>  + * @vma: The starting vm_area_struct
>  + * @mm: The mm_struct
>  + * @start: The aligned start address to munmap.
>  + * @end: The aligned end address to munmap.
>  + * @uf: The userfaultfd list_head
>  + * @downgrade: Set to true to attempt a write downgrade of the mmap_sem
>  + *
>  + * If @downgrade is true, check return code for potential release of th=
e lock.
> ++ *
> ++ * Munmap is split into 2 main parts -- this part which finds
> +  * what needs doing, and the areas themselves, which do the
> +  * work.  This now handles partial unmappings.
> +  * Jeremy Fitzhardinge <jeremy@goop.org>
>    */
>  -int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>  -		struct list_head *uf, bool downgrade)
>  -{
>  -	unsigned long end;
>  -	struct vm_area_struct *vma, *prev, *last;
>  -
>  -	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-st=
art)
>  -		return -EINVAL;
>  -
>  -	len =3D PAGE_ALIGN(len);
>  -	end =3D start + len;
>  -	if (len =3D=3D 0)
>  -		return -EINVAL;
>  -
>  -	/*
>  -	 * arch_unmap() might do unmaps itself.  It must be called
>  -	 * and finish any rbtree manipulation before this code
>  -	 * runs and also starts to manipulate the rbtree.
>  -	 */
>  -	arch_unmap(mm, start, end);
>  -
>  -	/* Find the first overlapping VMA where start < vma->vm_end */
>  -	vma =3D find_vma_intersection(mm, start, end);
>  -	if (!vma)
>  -		return 0;
>  -	prev =3D vma->vm_prev;
>  -
>  +static int
>  +do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
>  +		    struct mm_struct *mm, unsigned long start,
>  +		    unsigned long end, struct list_head *uf, bool downgrade)
>  +{
>  +	struct vm_area_struct *prev, *next;
>  +	struct maple_tree mt_detach;
>  +	int count =3D 0;
>  +	MA_STATE(mas_detach, &mt_detach, start, end - 1);
>  +	mt_init_flags(&mt_detach, MM_MT_FLAGS);
>  +	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
>  +
>  +	mas->last =3D end - 1;
>  +	prev =3D next =3D NULL;
>   	/*
>   	 * If we need to split any vma, do it now to save pain later.
>   	 *
> @@@ -3107,13 -3127,8 +3112,12 @@@ void exit_mmap(struct mm_struct *mm
>   		 * Nothing can be holding mm->mmap_lock here and the above call
>   		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
>   		 * __oom_reap_task_mm() will not block.
>  +		 *
>  +		 * This needs to be done before unlocking the VMAs in the loop
>  +		 * below which clears VM_LOCKED, otherwise the oom reaper cannot
>  +		 * reliably test it.
>   		 */
>   		(void)__oom_reap_task_mm(mm);
> -=20
>   		set_bit(MMF_OOM_SKIP, &mm->flags);
>   	}
>=20
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 2ddf1caf90488..d469555df0a21 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2373,10 +2373,8 @@ do_mas_align_munmap(struct ma_state *mas, struct v=
m_area_struct *vma,
>  		BUG_ON(next->vm_start > end);
>  #endif
>  		vma_mas_store(next, &mas_detach);
> -		if (next->vm_flags & VM_LOCKED) {
> +		if (next->vm_flags & VM_LOCKED)
>  			mm->locked_vm -=3D vma_pages(next);
> -			munlock_vma_pages_all(next);
> -		}
>  	}
> =20
>  	next =3D mas_find(mas, ULONG_MAX);
> @@ -2906,10 +2904,8 @@ static int do_brk_munmap(struct ma_state *mas, str=
uct vm_area_struct *vma,
>  	}
> =20
>  	unmap_pages =3D vma_pages(&unmap);
> -	if (vma->vm_flags & VM_LOCKED) {
> +	if (vma->vm_flags & VM_LOCKED)
>  		mm->locked_vm -=3D unmap_pages;
> -		munlock_vma_pages_range(&unmap, newbrk, oldbrk);
> -	}
> =20
>  	next =3D mas_next(mas, ULONG_MAX);
>  	mmap_write_downgrade(mm);
> @@ -3130,10 +3126,8 @@ void exit_mmap(struct mm_struct *mm)
>  	rwsem_acquire(&mm->mmap_lock.dep_map, 0, 0, _THIS_IP_);
>  	if (mm->locked_vm) {
>  		mas_for_each(&mas, vma, ULONG_MAX) {
> -			if (vma->vm_flags & VM_LOCKED) {
> +			if (vma->vm_flags & VM_LOCKED)
>  				mm->locked_vm -=3D vma_pages(vma);
> -				munlock_vma_pages_all(vma);
> -			}
>  		}
>  		mas_set(&mas, 0);
>  	}
>=20
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 2ddf1caf90488..d469555df0a21 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2373,10 +2373,8 @@ do_mas_align_munmap(struct ma_state *mas, struct v=
m_area_struct *vma,
>  		BUG_ON(next->vm_start > end);
>  #endif
>  		vma_mas_store(next, &mas_detach);
> -		if (next->vm_flags & VM_LOCKED) {
> +		if (next->vm_flags & VM_LOCKED)
>  			mm->locked_vm -=3D vma_pages(next);
> -			munlock_vma_pages_all(next);
> -		}
>  	}
> =20
>  	next =3D mas_find(mas, ULONG_MAX);
> @@ -2906,10 +2904,8 @@ static int do_brk_munmap(struct ma_state *mas, str=
uct vm_area_struct *vma,
>  	}
> =20
>  	unmap_pages =3D vma_pages(&unmap);
> -	if (vma->vm_flags & VM_LOCKED) {
> +	if (vma->vm_flags & VM_LOCKED)
>  		mm->locked_vm -=3D unmap_pages;
> -		munlock_vma_pages_range(&unmap, newbrk, oldbrk);
> -	}
> =20
>  	next =3D mas_next(mas, ULONG_MAX);
>  	mmap_write_downgrade(mm);
> @@ -3130,10 +3126,8 @@ void exit_mmap(struct mm_struct *mm)
>  	rwsem_acquire(&mm->mmap_lock.dep_map, 0, 0, _THIS_IP_);
>  	if (mm->locked_vm) {
>  		mas_for_each(&mas, vma, ULONG_MAX) {
> -			if (vma->vm_flags & VM_LOCKED) {
> +			if (vma->vm_flags & VM_LOCKED)
>  				mm->locked_vm -=3D vma_pages(vma);
> -				munlock_vma_pages_all(vma);
> -			}
>  		}
>  		mas_set(&mas, 0);
>  	}

--uiHEU8A1LLzcf4og
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIW51AACgkQJNaLcl1U
h9CDIgf+PNAZqmioo7XTL+teW4wUw6cpBd6At28RWKb62OZTTlD49gaUNvx/Dc2H
gW/dwGYy8FHZ5WskOJskcZvjDnY7sGrwcDbcxnSBqKyNyHEf6a5excVzF96dRSTM
vUDf2hcf3rM8ULNU0CyGzHuSFavMpTroQqnG3QoPl7lpHLnS1/WZ/D8Zk4y4FNPm
+pLrSsdWusWXoKjVgHcZdNs5o6orDSrZpLBG7Hnd09rm30RNdPg2JFShihfmxkga
qrC4KcpqgQ/6fI89qe4qYTfwUOZCIe/g9+NiN7sG0wOoz9oHNlZDY0MdANXOOkE1
GIAM2lVyeSgjw/MDRfd813P2sj93JA==
=olE7
-----END PGP SIGNATURE-----

--uiHEU8A1LLzcf4og--
