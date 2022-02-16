Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0818E4B84C9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiBPJuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:50:19 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiBPJuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:50:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA9A2B5221;
        Wed, 16 Feb 2022 01:49:53 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JzCqK0xb1z4y3m;
        Wed, 16 Feb 2022 20:49:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1645004989;
        bh=RqQW1V8DKTy9C7ShUItDdzAERinMToku0M0wLj72GM4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hpd5ry46a8YZV30iGEZ5ypRvBKLOIfMuTohjsxvaQ9u6nG318Gh3vNHZGZOMNZ4EU
         Q9gWPiUDxSX+elQOh3PcQ9++04uMyaI/eII2eLTxZSu+gaIWXybkb+kK2R84boXTit
         EVaAzC92vlhpDtdedd98focH/KcdN0mnUF3tODRFq6XVzkgFovP2CbenCB7RTqQ3fj
         T1pukYKUxaWQd59cAPTzTrZOkVvlPKcxuy8pVFUP8rXtrLYVIxDKurz1/o6I9uKMIT
         QAVpTtoqkv522aTlM8hzYPb7WG3VWb0DoMNU1rQh0ExBgIMRM5ErW/DDauubYmc1sD
         qHGqfrRMLt9lQ==
Date:   Wed, 16 Feb 2022 20:49:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 folio tree
Message-ID: <20220216204948.5843b45a@canb.auug.org.au>
In-Reply-To: <20220216172109.72fd0a38@canb.auug.org.au>
References: <20220215180043.23879691@canb.auug.org.au>
        <YgumpQrC+cuYe91H@casper.infradead.org>
        <20220216172109.72fd0a38@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0y5Q=JT+mePUSjYe..hvM71";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0y5Q=JT+mePUSjYe..hvM71
Content-Type: multipart/mixed; boundary="MP_/fg63Z.AD3L5FnXHQmX7svGC"

--MP_/fg63Z.AD3L5FnXHQmX7svGC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

On Wed, 16 Feb 2022 17:21:09 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> It looks like Andrew now has a new version of Hugh's patches and there
> are quite a few other conflicts as well (see my attempt at mm/gup.c).

I have attached the conflicts I get when I merge the folio tree into
today's linux-next.
--=20
Cheers,
Stephen Rothwell

--MP_/fg63Z.AD3L5FnXHQmX7svGC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=xx1

diff --cc include/linux/mm.h
index 49692a64d645,68e68d37a3d0..000000000000
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@@ -814,8 -829,15 +825,19 @@@ static inline int page_mapcount(struct=20
  	return atomic_read(&page->_mapcount) + 1;
  }
 =20
+ int folio_mapcount(struct folio *folio);
+=20
  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
++<<<<<<< HEAD
 +int total_mapcount(struct page *page);
++=3D=3D=3D=3D=3D=3D=3D
+ static inline int total_mapcount(struct page *page)
+ {
+ 	return folio_mapcount(page_folio(page));
+ }
+=20
+ int page_trans_huge_mapcount(struct page *page);
++>>>>>>> folio/for-next
  #else
  static inline int total_mapcount(struct page *page)
  {
@@@ -1103,7 -1162,32 +1149,36 @@@ static inline bool put_devmap_managed_p
  {
  	return false;
  }
++<<<<<<< HEAD
 +#endif /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
++=3D=3D=3D=3D=3D=3D=3D
+=20
+ static inline void put_devmap_managed_page(struct page *page)
+ {
+ }
+ #endif /* CONFIG_DEV_PAGEMAP_OPS */
+=20
+ static inline bool is_device_private_page(const struct page *page)
+ {
+ 	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
+ 		IS_ENABLED(CONFIG_DEVICE_PRIVATE) &&
+ 		is_zone_device_page(page) &&
+ 		page->pgmap->type =3D=3D MEMORY_DEVICE_PRIVATE;
+ }
+=20
+ static inline bool folio_is_device_private(const struct folio *folio)
+ {
+ 	return is_device_private_page(&folio->page);
+ }
+=20
+ static inline bool is_pci_p2pdma_page(const struct page *page)
+ {
+ 	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
+ 		IS_ENABLED(CONFIG_PCI_P2PDMA) &&
+ 		is_zone_device_page(page) &&
+ 		page->pgmap->type =3D=3D MEMORY_DEVICE_PCI_P2PDMA;
+ }
++>>>>>>> folio/for-next
 =20
  /* 127: arbitrary random number, small enough to assemble well */
  #define folio_ref_zero_or_close_to_overflow(folio) \
diff --cc include/linux/rmap.h
index 73cce292d32c,17230c458341..000000000000
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@@ -11,9 -11,8 +11,10 @@@
  #include <linux/rwsem.h>
  #include <linux/memcontrol.h>
  #include <linux/highmem.h>
+ #include <linux/pagemap.h>
 =20
 +#include <linux/refcount.h>
 +
  /*
   * The anon_vma heads a list of private "related" vmas, to scan if
   * an anonymous page pointing to this anon_vma needs to be unmapped:
@@@ -240,7 -261,7 +263,11 @@@ unsigned long page_address_in_vma(struc
   */
  int folio_mkclean(struct folio *);
 =20
++<<<<<<< HEAD
 +void remove_migration_ptes(struct page *old, struct page *new, bool locke=
d);
++=3D=3D=3D=3D=3D=3D=3D
+ void remove_migration_ptes(struct folio *src, struct folio *dst, bool loc=
ked);
++>>>>>>> folio/for-next
 =20
  /*
   * Called by memory-failure.c to kill processes.
diff --cc mm/gup.c
index 4ab43b4fc9bc,57bf69ac8ab4..000000000000
--- a/mm/gup.c
+++ b/mm/gup.c
@@@ -1844,84 -1783,50 +1786,128 @@@ static long check_and_migrate_movable_p
  					    struct page **pages,
  					    unsigned int gup_flags)
  {
++<<<<<<< HEAD
 +	unsigned long isolation_error_count =3D 0, i;
 +	struct page *prev_head =3D NULL;
 +	LIST_HEAD(movable_page_list);
 +	bool drain_allow =3D true;
 +	int ret =3D 0;
 +
 +	for (i =3D 0; i < nr_pages; i++) {
 +		struct page *head =3D compound_head(pages[i]);
 +
 +		if (head =3D=3D prev_head)
 +			continue;
 +		prev_head =3D head;
 +
 +		/*
 +		 * Device private pages will get faulted in during gup so it
 +		 * shouldn't be possible to see one here.
 +		 */
 +		if (WARN_ON_ONCE(is_device_private_page(head))) {
 +			ret =3D -EFAULT;
 +			goto unpin_pages;
++=3D=3D=3D=3D=3D=3D=3D
+ 	unsigned long i;
+ 	unsigned long isolation_error_count =3D 0;
+ 	bool drain_allow =3D true;
+ 	LIST_HEAD(movable_page_list);
+ 	long ret =3D 0;
+ 	struct folio *folio, *prev_folio =3D NULL;
+ 	struct migration_target_control mtc =3D {
+ 		.nid =3D NUMA_NO_NODE,
+ 		.gfp_mask =3D GFP_USER | __GFP_NOWARN,
+ 	};
+=20
+ 	for (i =3D 0; i < nr_pages; i++) {
+ 		folio =3D page_folio(pages[i]);
+ 		if (folio =3D=3D prev_folio)
+ 			continue;
+ 		prev_folio =3D folio;
+ 		/*
+ 		 * If we get a movable page, since we are going to be pinning
+ 		 * these entries, try to move them out if possible.
+ 		 */
+ 		if (!is_pinnable_page(&folio->page)) {
+ 			if (folio_test_hugetlb(folio)) {
+ 				if (!isolate_huge_page(&folio->page,
+ 							&movable_page_list))
+ 					isolation_error_count++;
+ 			} else {
+ 				if (!folio_test_lru(folio) && drain_allow) {
+ 					lru_add_drain_all();
+ 					drain_allow =3D false;
+ 				}
+=20
+ 				if (folio_isolate_lru(folio)) {
+ 					isolation_error_count++;
+ 					continue;
+ 				}
+ 				list_add_tail(&folio->lru, &movable_page_list);
+ 				node_stat_mod_folio(folio,
+ 						    NR_ISOLATED_ANON +
+ 						    folio_is_file_lru(folio),
+ 						    folio_nr_pages(folio));
+ 			}
++>>>>>>> folio/for-next
 +		}
 +
 +		/*
 +		 * Device coherent pages are managed by a driver and should not
 +		 * be pinned indefinitely as it prevents the driver moving the
 +		 * page. So when trying to pin with FOLL_LONGTERM instead try
 +		 * to migrate the page out of device memory.
 +		 */
 +		if (is_device_coherent_page(head)) {
 +			WARN_ON_ONCE(PageCompound(head));
 +
 +			/*
 +			 * Migration will fail if the page is pinned, so convert
 +			 * the pin on the source page to a normal reference.
 +			 */
 +			if (gup_flags & FOLL_PIN) {
 +				get_page(head);
 +				unpin_user_page(head);
 +			}
 +
 +			pages[i] =3D migrate_device_page(head, gup_flags);
 +			if (!pages[i]) {
 +				ret =3D -EBUSY;
 +				goto unpin_pages;
 +			}
 +			continue;
  		}
 +
 +		if (is_pinnable_page(head))
 +			continue;
 +
 +		/*
 +		 * Try to move out any movable page before pinning the range.
 +		 */
 +		if (PageHuge(head)) {
 +			if (!isolate_huge_page(head, &movable_page_list))
 +				isolation_error_count++;
 +			continue;
 +		}
 +
 +		if (!PageLRU(head) && drain_allow) {
 +			lru_add_drain_all();
 +			drain_allow =3D false;
 +		}
 +
 +		if (isolate_lru_page(head)) {
 +			isolation_error_count++;
 +			continue;
 +		}
 +		list_add_tail(&head->lru, &movable_page_list);
 +		mod_node_page_state(page_pgdat(head),
 +				    NR_ISOLATED_ANON + page_is_file_lru(head),
 +				    thp_nr_pages(head));
  	}
 =20
 +	if (!list_empty(&movable_page_list) || isolation_error_count)
 +		goto unpin_pages;
 +
  	/*
  	 * If list is empty, and no isolation errors, means that all pages are
  	 * in the correct zone.
diff --cc mm/huge_memory.c
index 09fb65a80e63,f85b04b31bd1..000000000000
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@@ -2137,6 -2114,8 +2134,11 @@@ void __split_huge_pmd(struct vm_area_st
  {
  	spinlock_t *ptl;
  	struct mmu_notifier_range range;
++<<<<<<< HEAD
++=3D=3D=3D=3D=3D=3D=3D
+ 	bool do_unlock_folio =3D false;
+ 	pmd_t _pmd;
++>>>>>>> folio/for-next
 =20
  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
  				address & HPAGE_PMD_MASK,
@@@ -2155,14 -2134,42 +2157,49 @@@
  			goto out;
  	}
 =20
 -repeat:
  	if (pmd_trans_huge(*pmd)) {
++<<<<<<< HEAD
 +		if (!page)
 +			page =3D pmd_page(*pmd);
++=3D=3D=3D=3D=3D=3D=3D
+ 		if (!folio) {
+ 			folio =3D page_folio(pmd_page(*pmd));
+ 			/*
+ 			 * An anonymous page must be locked, to ensure that a
+ 			 * concurrent reuse_swap_page() sees stable mapcount;
+ 			 * but reuse_swap_page() is not used on shmem or file,
+ 			 * and page lock must not be taken when zap_pmd_range()
+ 			 * calls __split_huge_pmd() while i_mmap_lock is held.
+ 			 */
+ 			if (folio_test_anon(folio)) {
+ 				if (unlikely(!folio_trylock(folio))) {
+ 					folio_get(folio);
+ 					_pmd =3D *pmd;
+ 					spin_unlock(ptl);
+ 					folio_lock(folio);
+ 					spin_lock(ptl);
+ 					if (unlikely(!pmd_same(*pmd, _pmd))) {
+ 						folio_unlock(folio);
+ 						folio_put(folio);
+ 						folio =3D NULL;
+ 						goto repeat;
+ 					}
+ 					folio_put(folio);
+ 				}
+ 				do_unlock_folio =3D true;
+ 			}
+ 		}
++>>>>>>> folio/for-next
  	} else if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
  		goto out;
  	__split_huge_pmd_locked(vma, pmd, range.start, freeze);
  out:
  	spin_unlock(ptl);
++<<<<<<< HEAD
++=3D=3D=3D=3D=3D=3D=3D
+ 	if (do_unlock_folio)
+ 		folio_unlock(folio);
++>>>>>>> folio/for-next
  	/*
  	 * No need to double call mmu_notifier->invalidate_range() callback.
  	 * They are 3 cases to consider inside __split_huge_pmd_locked():
@@@ -2455,28 -2464,52 +2494,77 @@@ static void __split_huge_page(struct pa
  	}
  }
 =20
++<<<<<<< HEAD
 +int total_mapcount(struct page *page)
 +{
 +	int i, compound, nr, ret;
 +
 +	VM_BUG_ON_PAGE(PageTail(page), page);
 +
 +	if (likely(!PageCompound(page)))
 +		return atomic_read(&page->_mapcount) + 1;
 +
 +	compound =3D compound_mapcount(page);
 +	nr =3D compound_nr(page);
 +	if (PageHuge(page))
 +		return compound;
 +	ret =3D compound;
 +	for (i =3D 0; i < nr; i++)
 +		ret +=3D atomic_read(&page[i]._mapcount) + 1;
 +	/* File pages has compound_mapcount included in _mapcount */
 +	if (!PageAnon(page))
 +		return ret - compound * nr;
 +	if (PageDoubleMap(page))
 +		ret -=3D nr;
 +	return ret;
++=3D=3D=3D=3D=3D=3D=3D
+ /*
+  * This calculates accurately how many mappings a transparent hugepage
+  * has (unlike page_mapcount() which isn't fully accurate). This full
+  * accuracy is primarily needed to know if copy-on-write faults can
+  * reuse the page and change the mapping to read-write instead of
+  * copying them. At the same time this returns the total_mapcount too.
+  *
+  * The function returns the highest mapcount any one of the subpages
+  * has. If the return value is one, even if different processes are
+  * mapping different subpages of the transparent hugepage, they can
+  * all reuse it, because each process is reusing a different subpage.
+  *
+  * The total_mapcount is instead counting all virtual mappings of the
+  * subpages. If the total_mapcount is equal to "one", it tells the
+  * caller all mappings belong to the same "mm" and in turn the
+  * anon_vma of the transparent hugepage can become the vma->anon_vma
+  * local one as no other process may be mapping any of the subpages.
+  *
+  * It would be more accurate to replace page_mapcount() with
+  * page_trans_huge_mapcount(), however we only use
+  * page_trans_huge_mapcount() in the copy-on-write faults where we
+  * need full accuracy to avoid breaking page pinning, because
+  * page_trans_huge_mapcount() is slower than page_mapcount().
+  */
+ int page_trans_huge_mapcount(struct page *page)
+ {
+ 	int i, ret;
+=20
+ 	/* hugetlbfs shouldn't call it */
+ 	VM_BUG_ON_PAGE(PageHuge(page), page);
+=20
+ 	if (likely(!PageTransCompound(page)))
+ 		return atomic_read(&page->_mapcount) + 1;
+=20
+ 	page =3D compound_head(page);
+=20
+ 	ret =3D 0;
+ 	for (i =3D 0; i < thp_nr_pages(page); i++) {
+ 		int mapcount =3D atomic_read(&page[i]._mapcount) + 1;
+ 		ret =3D max(ret, mapcount);
+ 	}
+=20
+ 	if (PageDoubleMap(page))
+ 		ret -=3D 1;
+=20
+ 	return ret + compound_mapcount(page);
++>>>>>>> folio/for-next
  }
 =20
  /* Racy check whether the huge page can be split */
@@@ -3116,9 -3151,6 +3206,12 @@@ void remove_migration_pmd(struct page_v
  	else
  		page_add_file_rmap(new, vma, true);
  	set_pmd_at(mm, mmun_start, pvmw->pmd, pmde);
++<<<<<<< HEAD
 +
 +	/* No need to invalidate - it was non-present before */
++=3D=3D=3D=3D=3D=3D=3D
++>>>>>>> folio/for-next
  	update_mmu_cache_pmd(vma, address, pvmw->pmd);
 +	trace_remove_migration_pmd(address, pmd_val(pmde));
  }
  #endif
diff --cc mm/internal.h
index 7ed98955c8f4,f0e4dfac0264..000000000000
--- a/mm/internal.h
+++ b/mm/internal.h
@@@ -409,15 -417,22 +417,33 @@@ extern int mlock_future_check(struct mm
   * pte mappings of THPs, which cannot be consistently counted: a pte
   * mapping of the THP head cannot be distinguished by the page alone.
   */
++<<<<<<< HEAD
 +void mlock_page(struct page *page);
 +static inline void mlock_vma_page(struct page *page,
++=3D=3D=3D=3D=3D=3D=3D
+ void mlock_folio(struct folio *folio);
+ static inline void mlock_vma_folio(struct folio *folio,
++>>>>>>> folio/for-next
  			struct vm_area_struct *vma, bool compound)
  {
  	/* VM_IO check prevents migration from double-counting during mlock */
  	if (unlikely((vma->vm_flags & (VM_LOCKED|VM_IO)) =3D=3D VM_LOCKED) &&
++<<<<<<< HEAD
 +	    (compound || !PageTransCompound(page)))
 +		mlock_page(page);
 +}
++=3D=3D=3D=3D=3D=3D=3D
+ 	    (compound || !folio_test_large(folio)))
+ 		mlock_folio(folio);
+ }
+=20
+ static inline void mlock_vma_page(struct page *page,
+ 			struct vm_area_struct *vma, bool compound)
+ {
+ 	mlock_vma_folio(page_folio(page), vma, compound);
+ }
+=20
++>>>>>>> folio/for-next
  void munlock_page(struct page *page);
  static inline void munlock_vma_page(struct page *page,
  			struct vm_area_struct *vma, bool compound)
@@@ -717,9 -745,9 +745,16 @@@ void vunmap_range_noflush(unsigned lon
  int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
  		      unsigned long addr, int page_nid, int *flags);
 =20
++<<<<<<< HEAD
 +DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
 +
 +void free_zone_device_page(struct page *page);
 +struct page *migrate_device_page(struct page *page, unsigned int gup_flag=
s);
++=3D=3D=3D=3D=3D=3D=3D
+ /*
+  * mm/gup.c
+  */
+ struct folio *try_grab_folio(struct page *page, int refs, unsigned int fl=
ags);
++>>>>>>> folio/for-next
 =20
  #endif	/* __MM_INTERNAL_H */
diff --cc mm/khugepaged.c
index 7d45d463acf5,000825a6e086..000000000000
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@@ -1823,7 -1835,7 +1824,11 @@@ static void collapse_file(struct mm_str
  		}
 =20
  		if (page_mapped(page))
++<<<<<<< HEAD
 +			try_to_unmap(page, TTU_IGNORE_MLOCK | TTU_BATCH_FLUSH);
++=3D=3D=3D=3D=3D=3D=3D
+ 			try_to_unmap(folio, TTU_IGNORE_MLOCK | TTU_BATCH_FLUSH);
++>>>>>>> folio/for-next
 =20
  		xas_lock_irq(&xas);
  		xas_set(&xas, index);
diff --cc mm/madvise.c
index ede6affa1350,ae35d72627ef..000000000000
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@@ -554,14 -530,9 +554,20 @@@ static void madvise_cold_page_range(str
  	tlb_end_vma(tlb, vma);
  }
 =20
++<<<<<<< HEAD
 +static inline bool can_madv_lru_non_huge_vma(struct vm_area_struct *vma)
 +{
 +	return !(vma->vm_flags & (VM_LOCKED|VM_PFNMAP));
 +}
 +
 +static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
 +{
 +	return can_madv_lru_non_huge_vma(vma) && !is_vm_hugetlb_page(vma);
++=3D=3D=3D=3D=3D=3D=3D
+ static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
+ {
+ 	return !(vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_PFNMAP));
++>>>>>>> folio/for-next
  }
 =20
  static long madvise_cold(struct vm_area_struct *vma,
diff --cc mm/memory-failure.c
index 3e404b06efdc,aa8236848949..000000000000
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@@ -1405,22 -1413,26 +1407,45 @@@ static bool hwpoison_user_mappings(stru
  	if (kill)
  		collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
 =20
++<<<<<<< HEAD
 +	if (PageHuge(hpage) && !PageAnon(hpage)) {
 +		/*
 +		 * For hugetlb pages in shared mappings, try_to_unmap
 +		 * could potentially call huge_pmd_unshare.  Because of
 +		 * this, take semaphore in write mode here and set
 +		 * TTU_RMAP_LOCKED to indicate we have taken the lock
 +		 * at this higher level.
 +		 */
 +		mapping =3D hugetlb_page_mapping_lock_write(hpage);
 +		if (mapping) {
 +			try_to_unmap(hpage, ttu|TTU_RMAP_LOCKED);
 +			i_mmap_unlock_write(mapping);
 +		} else
 +			pr_info("Memory failure: %#lx: could not lock mapping for mapped huge =
page\n", pfn);
 +	} else {
 +		try_to_unmap(hpage, ttu);
++=3D=3D=3D=3D=3D=3D=3D
+ 	if (!PageHuge(hpage)) {
+ 		try_to_unmap(folio, ttu);
+ 	} else {
+ 		if (!PageAnon(hpage)) {
+ 			/*
+ 			 * For hugetlb pages in shared mappings, try_to_unmap
+ 			 * could potentially call huge_pmd_unshare.  Because of
+ 			 * this, take semaphore in write mode here and set
+ 			 * TTU_RMAP_LOCKED to indicate we have taken the lock
+ 			 * at this higher level.
+ 			 */
+ 			mapping =3D hugetlb_page_mapping_lock_write(hpage);
+ 			if (mapping) {
+ 				try_to_unmap(folio, ttu|TTU_RMAP_LOCKED);
+ 				i_mmap_unlock_write(mapping);
+ 			} else
+ 				pr_info("Memory failure: %#lx: could not lock mapping for mapped huge=
 page\n", pfn);
+ 		} else {
+ 			try_to_unmap(folio, ttu);
+ 		}
++>>>>>>> folio/for-next
  	}
 =20
  	unmap_success =3D !page_mapped(hpage);
diff --cc mm/migrate.c
index 88b59f9f8d29,8a2f0a64f703..000000000000
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@@ -251,9 -248,6 +246,12 @@@ static bool remove_migration_pte(struc
  		}
  		if (vma->vm_flags & VM_LOCKED)
  			mlock_page_drain(smp_processor_id());
++<<<<<<< HEAD
 +
 +		trace_remove_migration_pte(pvmw.address, pte_val(pte),
 +					   compound_order(new));
++=3D=3D=3D=3D=3D=3D=3D
++>>>>>>> folio/for-next
 =20
  		/* No need to invalidate - it was non-present before */
  		update_mmu_cache(vma, pvmw.address, pvmw.pte);
@@@ -2157,6 -2135,768 +2160,771 @@@ out
  #endif /* CONFIG_NUMA_BALANCING */
  #endif /* CONFIG_NUMA */
 =20
++<<<<<<< HEAD
++=3D=3D=3D=3D=3D=3D=3D
+ #ifdef CONFIG_DEVICE_PRIVATE
+ static int migrate_vma_collect_skip(unsigned long start,
+ 				    unsigned long end,
+ 				    struct mm_walk *walk)
+ {
+ 	struct migrate_vma *migrate =3D walk->private;
+ 	unsigned long addr;
+=20
+ 	for (addr =3D start; addr < end; addr +=3D PAGE_SIZE) {
+ 		migrate->dst[migrate->npages] =3D 0;
+ 		migrate->src[migrate->npages++] =3D 0;
+ 	}
+=20
+ 	return 0;
+ }
+=20
+ static int migrate_vma_collect_hole(unsigned long start,
+ 				    unsigned long end,
+ 				    __always_unused int depth,
+ 				    struct mm_walk *walk)
+ {
+ 	struct migrate_vma *migrate =3D walk->private;
+ 	unsigned long addr;
+=20
+ 	/* Only allow populating anonymous memory. */
+ 	if (!vma_is_anonymous(walk->vma))
+ 		return migrate_vma_collect_skip(start, end, walk);
+=20
+ 	for (addr =3D start; addr < end; addr +=3D PAGE_SIZE) {
+ 		migrate->src[migrate->npages] =3D MIGRATE_PFN_MIGRATE;
+ 		migrate->dst[migrate->npages] =3D 0;
+ 		migrate->npages++;
+ 		migrate->cpages++;
+ 	}
+=20
+ 	return 0;
+ }
+=20
+ static int migrate_vma_collect_pmd(pmd_t *pmdp,
+ 				   unsigned long start,
+ 				   unsigned long end,
+ 				   struct mm_walk *walk)
+ {
+ 	struct migrate_vma *migrate =3D walk->private;
+ 	struct vm_area_struct *vma =3D walk->vma;
+ 	struct mm_struct *mm =3D vma->vm_mm;
+ 	unsigned long addr =3D start, unmapped =3D 0;
+ 	spinlock_t *ptl;
+ 	pte_t *ptep;
+=20
+ again:
+ 	if (pmd_none(*pmdp))
+ 		return migrate_vma_collect_hole(start, end, -1, walk);
+=20
+ 	if (pmd_trans_huge(*pmdp)) {
+ 		struct page *page;
+=20
+ 		ptl =3D pmd_lock(mm, pmdp);
+ 		if (unlikely(!pmd_trans_huge(*pmdp))) {
+ 			spin_unlock(ptl);
+ 			goto again;
+ 		}
+=20
+ 		page =3D pmd_page(*pmdp);
+ 		if (is_huge_zero_page(page)) {
+ 			spin_unlock(ptl);
+ 			split_huge_pmd(vma, pmdp, addr);
+ 			if (pmd_trans_unstable(pmdp))
+ 				return migrate_vma_collect_skip(start, end,
+ 								walk);
+ 		} else {
+ 			int ret;
+=20
+ 			get_page(page);
+ 			spin_unlock(ptl);
+ 			if (unlikely(!trylock_page(page)))
+ 				return migrate_vma_collect_skip(start, end,
+ 								walk);
+ 			ret =3D split_huge_page(page);
+ 			unlock_page(page);
+ 			put_page(page);
+ 			if (ret)
+ 				return migrate_vma_collect_skip(start, end,
+ 								walk);
+ 			if (pmd_none(*pmdp))
+ 				return migrate_vma_collect_hole(start, end, -1,
+ 								walk);
+ 		}
+ 	}
+=20
+ 	if (unlikely(pmd_bad(*pmdp)))
+ 		return migrate_vma_collect_skip(start, end, walk);
+=20
+ 	ptep =3D pte_offset_map_lock(mm, pmdp, addr, &ptl);
+ 	arch_enter_lazy_mmu_mode();
+=20
+ 	for (; addr < end; addr +=3D PAGE_SIZE, ptep++) {
+ 		unsigned long mpfn =3D 0, pfn;
+ 		struct page *page;
+ 		swp_entry_t entry;
+ 		pte_t pte;
+=20
+ 		pte =3D *ptep;
+=20
+ 		if (pte_none(pte)) {
+ 			if (vma_is_anonymous(vma)) {
+ 				mpfn =3D MIGRATE_PFN_MIGRATE;
+ 				migrate->cpages++;
+ 			}
+ 			goto next;
+ 		}
+=20
+ 		if (!pte_present(pte)) {
+ 			/*
+ 			 * Only care about unaddressable device page special
+ 			 * page table entry. Other special swap entries are not
+ 			 * migratable, and we ignore regular swapped page.
+ 			 */
+ 			entry =3D pte_to_swp_entry(pte);
+ 			if (!is_device_private_entry(entry))
+ 				goto next;
+=20
+ 			page =3D pfn_swap_entry_to_page(entry);
+ 			if (!(migrate->flags &
+ 				MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
+ 			    page->pgmap->owner !=3D migrate->pgmap_owner)
+ 				goto next;
+=20
+ 			mpfn =3D migrate_pfn(page_to_pfn(page)) |
+ 					MIGRATE_PFN_MIGRATE;
+ 			if (is_writable_device_private_entry(entry))
+ 				mpfn |=3D MIGRATE_PFN_WRITE;
+ 		} else {
+ 			if (!(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM))
+ 				goto next;
+ 			pfn =3D pte_pfn(pte);
+ 			if (is_zero_pfn(pfn)) {
+ 				mpfn =3D MIGRATE_PFN_MIGRATE;
+ 				migrate->cpages++;
+ 				goto next;
+ 			}
+ 			page =3D vm_normal_page(migrate->vma, addr, pte);
+ 			mpfn =3D migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
+ 			mpfn |=3D pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
+ 		}
+=20
+ 		/* FIXME support THP */
+ 		if (!page || !page->mapping || PageTransCompound(page)) {
+ 			mpfn =3D 0;
+ 			goto next;
+ 		}
+=20
+ 		/*
+ 		 * By getting a reference on the page we pin it and that blocks
+ 		 * any kind of migration. Side effect is that it "freezes" the
+ 		 * pte.
+ 		 *
+ 		 * We drop this reference after isolating the page from the lru
+ 		 * for non device page (device page are not on the lru and thus
+ 		 * can't be dropped from it).
+ 		 */
+ 		get_page(page);
+=20
+ 		/*
+ 		 * Optimize for the common case where page is only mapped once
+ 		 * in one process. If we can lock the page, then we can safely
+ 		 * set up a special migration page table entry now.
+ 		 */
+ 		if (trylock_page(page)) {
+ 			pte_t swp_pte;
+=20
+ 			migrate->cpages++;
+ 			ptep_get_and_clear(mm, addr, ptep);
+=20
+ 			/* Setup special migration page table entry */
+ 			if (mpfn & MIGRATE_PFN_WRITE)
+ 				entry =3D make_writable_migration_entry(
+ 							page_to_pfn(page));
+ 			else
+ 				entry =3D make_readable_migration_entry(
+ 							page_to_pfn(page));
+ 			swp_pte =3D swp_entry_to_pte(entry);
+ 			if (pte_present(pte)) {
+ 				if (pte_soft_dirty(pte))
+ 					swp_pte =3D pte_swp_mksoft_dirty(swp_pte);
+ 				if (pte_uffd_wp(pte))
+ 					swp_pte =3D pte_swp_mkuffd_wp(swp_pte);
+ 			} else {
+ 				if (pte_swp_soft_dirty(pte))
+ 					swp_pte =3D pte_swp_mksoft_dirty(swp_pte);
+ 				if (pte_swp_uffd_wp(pte))
+ 					swp_pte =3D pte_swp_mkuffd_wp(swp_pte);
+ 			}
+ 			set_pte_at(mm, addr, ptep, swp_pte);
+=20
+ 			/*
+ 			 * This is like regular unmap: we remove the rmap and
+ 			 * drop page refcount. Page won't be freed, as we took
+ 			 * a reference just above.
+ 			 */
+ 			page_remove_rmap(page, vma, false);
+ 			put_page(page);
+=20
+ 			if (pte_present(pte))
+ 				unmapped++;
+ 		} else {
+ 			put_page(page);
+ 			mpfn =3D 0;
+ 		}
+=20
+ next:
+ 		migrate->dst[migrate->npages] =3D 0;
+ 		migrate->src[migrate->npages++] =3D mpfn;
+ 	}
+ 	arch_leave_lazy_mmu_mode();
+ 	pte_unmap_unlock(ptep - 1, ptl);
+=20
+ 	/* Only flush the TLB if we actually modified any entries */
+ 	if (unmapped)
+ 		flush_tlb_range(walk->vma, start, end);
+=20
+ 	return 0;
+ }
+=20
+ static const struct mm_walk_ops migrate_vma_walk_ops =3D {
+ 	.pmd_entry		=3D migrate_vma_collect_pmd,
+ 	.pte_hole		=3D migrate_vma_collect_hole,
+ };
+=20
+ /*
+  * migrate_vma_collect() - collect pages over a range of virtual addresses
+  * @migrate: migrate struct containing all migration information
+  *
+  * This will walk the CPU page table. For each virtual address backed by a
+  * valid page, it updates the src array and takes a reference on the page=
, in
+  * order to pin the page until we lock it and unmap it.
+  */
+ static void migrate_vma_collect(struct migrate_vma *migrate)
+ {
+ 	struct mmu_notifier_range range;
+=20
+ 	/*
+ 	 * Note that the pgmap_owner is passed to the mmu notifier callback so
+ 	 * that the registered device driver can skip invalidating device
+ 	 * private page mappings that won't be migrated.
+ 	 */
+ 	mmu_notifier_range_init_owner(&range, MMU_NOTIFY_MIGRATE, 0,
+ 		migrate->vma, migrate->vma->vm_mm, migrate->start, migrate->end,
+ 		migrate->pgmap_owner);
+ 	mmu_notifier_invalidate_range_start(&range);
+=20
+ 	walk_page_range(migrate->vma->vm_mm, migrate->start, migrate->end,
+ 			&migrate_vma_walk_ops, migrate);
+=20
+ 	mmu_notifier_invalidate_range_end(&range);
+ 	migrate->end =3D migrate->start + (migrate->npages << PAGE_SHIFT);
+ }
+=20
+ /*
+  * migrate_vma_check_page() - check if page is pinned or not
+  * @page: struct page to check
+  *
+  * Pinned pages cannot be migrated. This is the same test as in
+  * folio_migrate_mapping(), except that here we allow migration of a
+  * ZONE_DEVICE page.
+  */
+ static bool migrate_vma_check_page(struct page *page)
+ {
+ 	/*
+ 	 * One extra ref because caller holds an extra reference, either from
+ 	 * isolate_lru_page() for a regular page, or migrate_vma_collect() for
+ 	 * a device page.
+ 	 */
+ 	int extra =3D 1;
+=20
+ 	/*
+ 	 * FIXME support THP (transparent huge page), it is bit more complex to
+ 	 * check them than regular pages, because they can be mapped with a pmd
+ 	 * or with a pte (split pte mapping).
+ 	 */
+ 	if (PageCompound(page))
+ 		return false;
+=20
+ 	/* Page from ZONE_DEVICE have one extra reference */
+ 	if (is_zone_device_page(page))
+ 		extra++;
+=20
+ 	/* For file back page */
+ 	if (page_mapping(page))
+ 		extra +=3D 1 + page_has_private(page);
+=20
+ 	if ((page_count(page) - extra) > page_mapcount(page))
+ 		return false;
+=20
+ 	return true;
+ }
+=20
+ /*
+  * migrate_vma_unmap() - replace page mapping with special migration pte =
entry
+  * @migrate: migrate struct containing all migration information
+  *
+  * Isolate pages from the LRU and replace mappings (CPU page table pte) w=
ith a
+  * special migration pte entry and check if it has been pinned. Pinned pa=
ges are
+  * restored because we cannot migrate them.
+  *
+  * This is the last step before we call the device driver callback to all=
ocate
+  * destination memory and copy contents of original page over to new page.
+  */
+ static void migrate_vma_unmap(struct migrate_vma *migrate)
+ {
+ 	const unsigned long npages =3D migrate->npages;
+ 	unsigned long i, restore =3D 0;
+ 	bool allow_drain =3D true;
+=20
+ 	lru_add_drain();
+=20
+ 	for (i =3D 0; i < npages; i++) {
+ 		struct page *page =3D migrate_pfn_to_page(migrate->src[i]);
+ 		struct folio *folio;
+=20
+ 		if (!page)
+ 			continue;
+=20
+ 		/* ZONE_DEVICE pages are not on LRU */
+ 		if (!is_zone_device_page(page)) {
+ 			if (!PageLRU(page) && allow_drain) {
+ 				/* Drain CPU's pagevec */
+ 				lru_add_drain_all();
+ 				allow_drain =3D false;
+ 			}
+=20
+ 			if (isolate_lru_page(page)) {
+ 				migrate->src[i] &=3D ~MIGRATE_PFN_MIGRATE;
+ 				migrate->cpages--;
+ 				restore++;
+ 				continue;
+ 			}
+=20
+ 			/* Drop the reference we took in collect */
+ 			put_page(page);
+ 		}
+=20
+ 		folio =3D page_folio(page);
+ 		if (folio_mapped(folio))
+ 			try_to_migrate(folio, 0);
+=20
+ 		if (page_mapped(page) || !migrate_vma_check_page(page)) {
+ 			if (!is_zone_device_page(page)) {
+ 				get_page(page);
+ 				putback_lru_page(page);
+ 			}
+=20
+ 			migrate->src[i] &=3D ~MIGRATE_PFN_MIGRATE;
+ 			migrate->cpages--;
+ 			restore++;
+ 			continue;
+ 		}
+ 	}
+=20
+ 	for (i =3D 0; i < npages && restore; i++) {
+ 		struct page *page =3D migrate_pfn_to_page(migrate->src[i]);
+ 		struct folio *folio;
+=20
+ 		if (!page || (migrate->src[i] & MIGRATE_PFN_MIGRATE))
+ 			continue;
+=20
+ 		folio =3D page_folio(page);
+ 		remove_migration_ptes(folio, folio, false);
+=20
+ 		migrate->src[i] =3D 0;
+ 		folio_unlock(folio);
+ 		folio_put(folio);
+ 		restore--;
+ 	}
+ }
+=20
+ /**
+  * migrate_vma_setup() - prepare to migrate a range of memory
+  * @args: contains the vma, start, and pfns arrays for the migration
+  *
+  * Returns: negative errno on failures, 0 when 0 or more pages were migra=
ted
+  * without an error.
+  *
+  * Prepare to migrate a range of memory virtual address range by collecti=
ng all
+  * the pages backing each virtual address in the range, saving them insid=
e the
+  * src array.  Then lock those pages and unmap them. Once the pages are l=
ocked
+  * and unmapped, check whether each page is pinned or not.  Pages that ar=
en't
+  * pinned have the MIGRATE_PFN_MIGRATE flag set (by this function) in the
+  * corresponding src array entry.  Then restores any pages that are pinne=
d, by
+  * remapping and unlocking those pages.
+  *
+  * The caller should then allocate destination memory and copy source mem=
ory to
+  * it for all those entries (ie with MIGRATE_PFN_VALID and MIGRATE_PFN_MI=
GRATE
+  * flag set).  Once these are allocated and copied, the caller must updat=
e each
+  * corresponding entry in the dst array with the pfn value of the destina=
tion
+  * page and with MIGRATE_PFN_VALID. Destination pages must be locked via
+  * lock_page().
+  *
+  * Note that the caller does not have to migrate all the pages that are m=
arked
+  * with MIGRATE_PFN_MIGRATE flag in src array unless this is a migration =
from
+  * device memory to system memory.  If the caller cannot migrate a device=
 page
+  * back to system memory, then it must return VM_FAULT_SIGBUS, which has =
severe
+  * consequences for the userspace process, so it must be avoided if at all
+  * possible.
+  *
+  * For empty entries inside CPU page table (pte_none() or pmd_none() is t=
rue) we
+  * do set MIGRATE_PFN_MIGRATE flag inside the corresponding source array =
thus
+  * allowing the caller to allocate device memory for those unbacked virtu=
al
+  * addresses.  For this the caller simply has to allocate device memory a=
nd
+  * properly set the destination entry like for regular migration.  Note t=
hat
+  * this can still fail, and thus inside the device driver you must check =
if the
+  * migration was successful for those entries after calling migrate_vma_p=
ages(),
+  * just like for regular migration.
+  *
+  * After that, the callers must call migrate_vma_pages() to go over each =
entry
+  * in the src array that has the MIGRATE_PFN_VALID and MIGRATE_PFN_MIGRAT=
E flag
+  * set. If the corresponding entry in dst array has MIGRATE_PFN_VALID fla=
g set,
+  * then migrate_vma_pages() to migrate struct page information from the s=
ource
+  * struct page to the destination struct page.  If it fails to migrate the
+  * struct page information, then it clears the MIGRATE_PFN_MIGRATE flag i=
n the
+  * src array.
+  *
+  * At this point all successfully migrated pages have an entry in the src
+  * array with MIGRATE_PFN_VALID and MIGRATE_PFN_MIGRATE flag set and the =
dst
+  * array entry with MIGRATE_PFN_VALID flag set.
+  *
+  * Once migrate_vma_pages() returns the caller may inspect which pages we=
re
+  * successfully migrated, and which were not.  Successfully migrated page=
s will
+  * have the MIGRATE_PFN_MIGRATE flag set for their src array entry.
+  *
+  * It is safe to update device page table after migrate_vma_pages() becau=
se
+  * both destination and source page are still locked, and the mmap_lock i=
s held
+  * in read mode (hence no one can unmap the range being migrated).
+  *
+  * Once the caller is done cleaning up things and updating its page table=
 (if it
+  * chose to do so, this is not an obligation) it finally calls
+  * migrate_vma_finalize() to update the CPU page table to point to new pa=
ges
+  * for successfully migrated pages or otherwise restore the CPU page tabl=
e to
+  * point to the original source pages.
+  */
+ int migrate_vma_setup(struct migrate_vma *args)
+ {
+ 	long nr_pages =3D (args->end - args->start) >> PAGE_SHIFT;
+=20
+ 	args->start &=3D PAGE_MASK;
+ 	args->end &=3D PAGE_MASK;
+ 	if (!args->vma || is_vm_hugetlb_page(args->vma) ||
+ 	    (args->vma->vm_flags & VM_SPECIAL) || vma_is_dax(args->vma))
+ 		return -EINVAL;
+ 	if (nr_pages <=3D 0)
+ 		return -EINVAL;
+ 	if (args->start < args->vma->vm_start ||
+ 	    args->start >=3D args->vma->vm_end)
+ 		return -EINVAL;
+ 	if (args->end <=3D args->vma->vm_start || args->end > args->vma->vm_end)
+ 		return -EINVAL;
+ 	if (!args->src || !args->dst)
+ 		return -EINVAL;
+=20
+ 	memset(args->src, 0, sizeof(*args->src) * nr_pages);
+ 	args->cpages =3D 0;
+ 	args->npages =3D 0;
+=20
+ 	migrate_vma_collect(args);
+=20
+ 	if (args->cpages)
+ 		migrate_vma_unmap(args);
+=20
+ 	/*
+ 	 * At this point pages are locked and unmapped, and thus they have
+ 	 * stable content and can safely be copied to destination memory that
+ 	 * is allocated by the drivers.
+ 	 */
+ 	return 0;
+=20
+ }
+ EXPORT_SYMBOL(migrate_vma_setup);
+=20
+ /*
+  * This code closely matches the code in:
+  *   __handle_mm_fault()
+  *     handle_pte_fault()
+  *       do_anonymous_page()
+  * to map in an anonymous zero page but the struct page will be a ZONE_DE=
VICE
+  * private page.
+  */
+ static void migrate_vma_insert_page(struct migrate_vma *migrate,
+ 				    unsigned long addr,
+ 				    struct page *page,
+ 				    unsigned long *src)
+ {
+ 	struct vm_area_struct *vma =3D migrate->vma;
+ 	struct mm_struct *mm =3D vma->vm_mm;
+ 	bool flush =3D false;
+ 	spinlock_t *ptl;
+ 	pte_t entry;
+ 	pgd_t *pgdp;
+ 	p4d_t *p4dp;
+ 	pud_t *pudp;
+ 	pmd_t *pmdp;
+ 	pte_t *ptep;
+=20
+ 	/* Only allow populating anonymous memory */
+ 	if (!vma_is_anonymous(vma))
+ 		goto abort;
+=20
+ 	pgdp =3D pgd_offset(mm, addr);
+ 	p4dp =3D p4d_alloc(mm, pgdp, addr);
+ 	if (!p4dp)
+ 		goto abort;
+ 	pudp =3D pud_alloc(mm, p4dp, addr);
+ 	if (!pudp)
+ 		goto abort;
+ 	pmdp =3D pmd_alloc(mm, pudp, addr);
+ 	if (!pmdp)
+ 		goto abort;
+=20
+ 	if (pmd_trans_huge(*pmdp) || pmd_devmap(*pmdp))
+ 		goto abort;
+=20
+ 	/*
+ 	 * Use pte_alloc() instead of pte_alloc_map().  We can't run
+ 	 * pte_offset_map() on pmds where a huge pmd might be created
+ 	 * from a different thread.
+ 	 *
+ 	 * pte_alloc_map() is safe to use under mmap_write_lock(mm) or when
+ 	 * parallel threads are excluded by other means.
+ 	 *
+ 	 * Here we only have mmap_read_lock(mm).
+ 	 */
+ 	if (pte_alloc(mm, pmdp))
+ 		goto abort;
+=20
+ 	/* See the comment in pte_alloc_one_map() */
+ 	if (unlikely(pmd_trans_unstable(pmdp)))
+ 		goto abort;
+=20
+ 	if (unlikely(anon_vma_prepare(vma)))
+ 		goto abort;
+ 	if (mem_cgroup_charge(page_folio(page), vma->vm_mm, GFP_KERNEL))
+ 		goto abort;
+=20
+ 	/*
+ 	 * The memory barrier inside __SetPageUptodate makes sure that
+ 	 * preceding stores to the page contents become visible before
+ 	 * the set_pte_at() write.
+ 	 */
+ 	__SetPageUptodate(page);
+=20
+ 	if (is_zone_device_page(page)) {
+ 		if (is_device_private_page(page)) {
+ 			swp_entry_t swp_entry;
+=20
+ 			if (vma->vm_flags & VM_WRITE)
+ 				swp_entry =3D make_writable_device_private_entry(
+ 							page_to_pfn(page));
+ 			else
+ 				swp_entry =3D make_readable_device_private_entry(
+ 							page_to_pfn(page));
+ 			entry =3D swp_entry_to_pte(swp_entry);
+ 		} else {
+ 			/*
+ 			 * For now we only support migrating to un-addressable
+ 			 * device memory.
+ 			 */
+ 			pr_warn_once("Unsupported ZONE_DEVICE page type.\n");
+ 			goto abort;
+ 		}
+ 	} else {
+ 		entry =3D mk_pte(page, vma->vm_page_prot);
+ 		if (vma->vm_flags & VM_WRITE)
+ 			entry =3D pte_mkwrite(pte_mkdirty(entry));
+ 	}
+=20
+ 	ptep =3D pte_offset_map_lock(mm, pmdp, addr, &ptl);
+=20
+ 	if (check_stable_address_space(mm))
+ 		goto unlock_abort;
+=20
+ 	if (pte_present(*ptep)) {
+ 		unsigned long pfn =3D pte_pfn(*ptep);
+=20
+ 		if (!is_zero_pfn(pfn))
+ 			goto unlock_abort;
+ 		flush =3D true;
+ 	} else if (!pte_none(*ptep))
+ 		goto unlock_abort;
+=20
+ 	/*
+ 	 * Check for userfaultfd but do not deliver the fault. Instead,
+ 	 * just back off.
+ 	 */
+ 	if (userfaultfd_missing(vma))
+ 		goto unlock_abort;
+=20
+ 	inc_mm_counter(mm, MM_ANONPAGES);
+ 	page_add_new_anon_rmap(page, vma, addr, false);
+ 	if (!is_zone_device_page(page))
+ 		lru_cache_add_inactive_or_unevictable(page, vma);
+ 	get_page(page);
+=20
+ 	if (flush) {
+ 		flush_cache_page(vma, addr, pte_pfn(*ptep));
+ 		ptep_clear_flush_notify(vma, addr, ptep);
+ 		set_pte_at_notify(mm, addr, ptep, entry);
+ 		update_mmu_cache(vma, addr, ptep);
+ 	} else {
+ 		/* No need to invalidate - it was non-present before */
+ 		set_pte_at(mm, addr, ptep, entry);
+ 		update_mmu_cache(vma, addr, ptep);
+ 	}
+=20
+ 	pte_unmap_unlock(ptep, ptl);
+ 	*src =3D MIGRATE_PFN_MIGRATE;
+ 	return;
+=20
+ unlock_abort:
+ 	pte_unmap_unlock(ptep, ptl);
+ abort:
+ 	*src &=3D ~MIGRATE_PFN_MIGRATE;
+ }
+=20
+ /**
+  * migrate_vma_pages() - migrate meta-data from src page to dst page
+  * @migrate: migrate struct containing all migration information
+  *
+  * This migrates struct page meta-data from source struct page to destina=
tion
+  * struct page. This effectively finishes the migration from source page =
to the
+  * destination page.
+  */
+ void migrate_vma_pages(struct migrate_vma *migrate)
+ {
+ 	const unsigned long npages =3D migrate->npages;
+ 	const unsigned long start =3D migrate->start;
+ 	struct mmu_notifier_range range;
+ 	unsigned long addr, i;
+ 	bool notified =3D false;
+=20
+ 	for (i =3D 0, addr =3D start; i < npages; addr +=3D PAGE_SIZE, i++) {
+ 		struct page *newpage =3D migrate_pfn_to_page(migrate->dst[i]);
+ 		struct page *page =3D migrate_pfn_to_page(migrate->src[i]);
+ 		struct address_space *mapping;
+ 		int r;
+=20
+ 		if (!newpage) {
+ 			migrate->src[i] &=3D ~MIGRATE_PFN_MIGRATE;
+ 			continue;
+ 		}
+=20
+ 		if (!page) {
+ 			if (!(migrate->src[i] & MIGRATE_PFN_MIGRATE))
+ 				continue;
+ 			if (!notified) {
+ 				notified =3D true;
+=20
+ 				mmu_notifier_range_init_owner(&range,
+ 					MMU_NOTIFY_MIGRATE, 0, migrate->vma,
+ 					migrate->vma->vm_mm, addr, migrate->end,
+ 					migrate->pgmap_owner);
+ 				mmu_notifier_invalidate_range_start(&range);
+ 			}
+ 			migrate_vma_insert_page(migrate, addr, newpage,
+ 						&migrate->src[i]);
+ 			continue;
+ 		}
+=20
+ 		mapping =3D page_mapping(page);
+=20
+ 		if (is_zone_device_page(newpage)) {
+ 			if (is_device_private_page(newpage)) {
+ 				/*
+ 				 * For now only support private anonymous when
+ 				 * migrating to un-addressable device memory.
+ 				 */
+ 				if (mapping) {
+ 					migrate->src[i] &=3D ~MIGRATE_PFN_MIGRATE;
+ 					continue;
+ 				}
+ 			} else {
+ 				/*
+ 				 * Other types of ZONE_DEVICE page are not
+ 				 * supported.
+ 				 */
+ 				migrate->src[i] &=3D ~MIGRATE_PFN_MIGRATE;
+ 				continue;
+ 			}
+ 		}
+=20
+ 		r =3D migrate_page(mapping, newpage, page, MIGRATE_SYNC_NO_COPY);
+ 		if (r !=3D MIGRATEPAGE_SUCCESS)
+ 			migrate->src[i] &=3D ~MIGRATE_PFN_MIGRATE;
+ 	}
+=20
+ 	/*
+ 	 * No need to double call mmu_notifier->invalidate_range() callback as
+ 	 * the above ptep_clear_flush_notify() inside migrate_vma_insert_page()
+ 	 * did already call it.
+ 	 */
+ 	if (notified)
+ 		mmu_notifier_invalidate_range_only_end(&range);
+ }
+ EXPORT_SYMBOL(migrate_vma_pages);
+=20
+ /**
+  * migrate_vma_finalize() - restore CPU page table entry
+  * @migrate: migrate struct containing all migration information
+  *
+  * This replaces the special migration pte entry with either a mapping to=
 the
+  * new page if migration was successful for that page, or to the original=
 page
+  * otherwise.
+  *
+  * This also unlocks the pages and puts them back on the lru, or drops th=
e extra
+  * refcount, for device pages.
+  */
+ void migrate_vma_finalize(struct migrate_vma *migrate)
+ {
+ 	const unsigned long npages =3D migrate->npages;
+ 	unsigned long i;
+=20
+ 	for (i =3D 0; i < npages; i++) {
+ 		struct folio *dst, *src;
+ 		struct page *newpage =3D migrate_pfn_to_page(migrate->dst[i]);
+ 		struct page *page =3D migrate_pfn_to_page(migrate->src[i]);
+=20
+ 		if (!page) {
+ 			if (newpage) {
+ 				unlock_page(newpage);
+ 				put_page(newpage);
+ 			}
+ 			continue;
+ 		}
+=20
+ 		if (!(migrate->src[i] & MIGRATE_PFN_MIGRATE) || !newpage) {
+ 			if (newpage) {
+ 				unlock_page(newpage);
+ 				put_page(newpage);
+ 			}
+ 			newpage =3D page;
+ 		}
+=20
+ 		src =3D page_folio(page);
+ 		dst =3D page_folio(newpage);
+ 		remove_migration_ptes(src, dst, false);
+ 		folio_unlock(src);
+=20
+ 		if (is_zone_device_page(page))
+ 			put_page(page);
+ 		else
+ 			putback_lru_page(page);
+=20
+ 		if (newpage !=3D page) {
+ 			unlock_page(newpage);
+ 			if (is_zone_device_page(newpage))
+ 				put_page(newpage);
+ 			else
+ 				putback_lru_page(newpage);
+ 		}
+ 	}
+ }
+ EXPORT_SYMBOL(migrate_vma_finalize);
+ #endif /* CONFIG_DEVICE_PRIVATE */
+=20
++>>>>>>> folio/for-next
  /*
   * node_demotion[] example:
   *
diff --cc mm/mlock.c
index d28e56529e5b,9858e733c29b..000000000000
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@@ -75,183 -75,183 +75,374 @@@ static struct lruvec *__mlock_page(stru
  		}
  		goto out;
  	}
++<<<<<<< HEAD
 +
 +	if (PageUnevictable(page)) {
 +		if (PageMlocked(page))
 +			page->mlock_count++;
 +		goto out;
 +	}
 +
 +	del_page_from_lru_list(page, lruvec);
 +	ClearPageActive(page);
 +	SetPageUnevictable(page);
 +	page->mlock_count =3D !!PageMlocked(page);
 +	add_page_to_lru_list(page, lruvec);
 +	__count_vm_events(UNEVICTABLE_PGCULLED, thp_nr_pages(page));
 +out:
 +	SetPageLRU(page);
 +	return lruvec;
 +}
 +
 +static struct lruvec *__mlock_new_page(struct page *page, struct lruvec *=
lruvec)
 +{
 +	VM_BUG_ON_PAGE(PageLRU(page), page);
 +
 +	lruvec =3D folio_lruvec_relock_irq(page_folio(page), lruvec);
 +
 +	/* As above, this is a little surprising, but possible */
 +	if (unlikely(page_evictable(page)))
 +		goto out;
 +
 +	SetPageUnevictable(page);
 +	page->mlock_count =3D !!PageMlocked(page);
 +	__count_vm_events(UNEVICTABLE_PGCULLED, thp_nr_pages(page));
 +out:
 +	add_page_to_lru_list(page, lruvec);
 +	SetPageLRU(page);
 +	return lruvec;
 +}
 +
 +static struct lruvec *__munlock_page(struct page *page, struct lruvec *lr=
uvec)
 +{
 +	int nr_pages =3D thp_nr_pages(page);
 +	bool isolated =3D false;
 +
 +	if (!TestClearPageLRU(page))
 +		goto munlock;
 +
 +	isolated =3D true;
 +	lruvec =3D folio_lruvec_relock_irq(page_folio(page), lruvec);
 +
 +	if (PageUnevictable(page)) {
 +		/* Then mlock_count is maintained, but might undercount */
 +		if (page->mlock_count)
 +			page->mlock_count--;
 +		if (page->mlock_count)
 +			goto out;
 +	}
 +	/* else assume that was the last mlock: reclaim will fix it if not */
 +
 +munlock:
 +	if (TestClearPageMlocked(page)) {
 +		__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
 +		if (isolated || !PageUnevictable(page))
 +			__count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
 +		else
 +			__count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
 +	}
 +
 +	/* page_evictable() has to be checked *after* clearing Mlocked */
 +	if (isolated && PageUnevictable(page) && page_evictable(page)) {
 +		del_page_from_lru_list(page, lruvec);
 +		ClearPageUnevictable(page);
 +		add_page_to_lru_list(page, lruvec);
 +		__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
 +	}
 +out:
 +	if (isolated)
 +		SetPageLRU(page);
 +	return lruvec;
 +}
 +
 +/*
 + * Flags held in the low bits of a struct page pointer on the mlock_pvec.
 + */
 +#define LRU_PAGE 0x1
 +#define NEW_PAGE 0x2
 +static inline struct page *mlock_lru(struct page *page)
 +{
 +	return (struct page *)((unsigned long)page + LRU_PAGE);
 +}
 +
 +static inline struct page *mlock_new(struct page *page)
 +{
 +	return (struct page *)((unsigned long)page + NEW_PAGE);
 +}
 +
 +/*
 + * mlock_pagevec() is derived from pagevec_lru_move_fn():
 + * perhaps that can make use of such page pointer flags in future,
 + * but for now just keep it for mlock.  We could use three separate
 + * pagevecs instead, but one feels better (munlocking a full pagevec
 + * does not need to drain mlocking pagevecs first).
 + */
 +static void mlock_pagevec(struct pagevec *pvec)
 +{
 +	struct lruvec *lruvec =3D NULL;
 +	unsigned long mlock;
 +	struct page *page;
 +	int i;
 +
 +	for (i =3D 0; i < pagevec_count(pvec); i++) {
 +		page =3D pvec->pages[i];
 +		mlock =3D (unsigned long)page & (LRU_PAGE | NEW_PAGE);
 +		page =3D (struct page *)((unsigned long)page - mlock);
 +		pvec->pages[i] =3D page;
 +
 +		if (mlock & LRU_PAGE)
 +			lruvec =3D __mlock_page(page, lruvec);
 +		else if (mlock & NEW_PAGE)
 +			lruvec =3D __mlock_new_page(page, lruvec);
 +		else
 +			lruvec =3D __munlock_page(page, lruvec);
 +	}
 +
 +	if (lruvec)
 +		unlock_page_lruvec_irq(lruvec);
 +	release_pages(pvec->pages, pvec->nr);
 +	pagevec_reinit(pvec);
 +}
 +
 +void mlock_page_drain(int cpu)
 +{
 +	struct pagevec *pvec;
 +
 +	pvec =3D &per_cpu(mlock_pvec, cpu);
 +	if (pagevec_count(pvec))
 +		mlock_pagevec(pvec);
 +}
 +
 +bool need_mlock_page_drain(int cpu)
 +{
 +	return pagevec_count(&per_cpu(mlock_pvec, cpu));
 +}
 +
 +/**
 + * mlock_page - mlock a page already on (or temporarily off) LRU
 + * @page: page to be mlocked, either a normal page or a THP head.
 + */
 +void mlock_page(struct page *page)
 +{
 +	struct pagevec *pvec =3D &get_cpu_var(mlock_pvec);
 +
 +	if (!TestSetPageMlocked(page)) {
 +		int nr_pages =3D thp_nr_pages(page);
 +
 +		mod_zone_page_state(page_zone(page), NR_MLOCK, nr_pages);
 +		__count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
 +	}
 +
 +	get_page(page);
 +	if (!pagevec_add(pvec, mlock_lru(page)) ||
 +	    PageHead(page) || lru_cache_disabled())
 +		mlock_pagevec(pvec);
 +	put_cpu_var(mlock_pvec);
 +}
 +
 +/**
 + * mlock_new_page - mlock a newly allocated page not yet on LRU
 + * @page: page to be mlocked, either a normal page or a THP head.
 + */
 +void mlock_new_page(struct page *page)
 +{
 +	struct pagevec *pvec =3D &get_cpu_var(mlock_pvec);
 +	int nr_pages =3D thp_nr_pages(page);
 +
 +	SetPageMlocked(page);
 +	mod_zone_page_state(page_zone(page), NR_MLOCK, nr_pages);
 +	__count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
 +
++	get_page(page);
++	if (!pagevec_add(pvec, mlock_new(page)) ||
++	    PageHead(page) || lru_cache_disabled())
++=3D=3D=3D=3D=3D=3D=3D
+=20
+ 	if (PageUnevictable(page)) {
+ 		if (PageMlocked(page))
+ 			page->mlock_count++;
+ 		goto out;
+ 	}
+=20
+ 	del_page_from_lru_list(page, lruvec);
+ 	ClearPageActive(page);
+ 	SetPageUnevictable(page);
+ 	page->mlock_count =3D !!PageMlocked(page);
+ 	add_page_to_lru_list(page, lruvec);
+ 	__count_vm_events(UNEVICTABLE_PGCULLED, thp_nr_pages(page));
+ out:
+ 	SetPageLRU(page);
+ 	return lruvec;
+ }
+=20
+ static struct lruvec *__mlock_new_page(struct page *page, struct lruvec *=
lruvec)
+ {
+ 	VM_BUG_ON_PAGE(PageLRU(page), page);
+=20
+ 	lruvec =3D folio_lruvec_relock_irq(page_folio(page), lruvec);
+=20
+ 	/* As above, this is a little surprising, but possible */
+ 	if (unlikely(page_evictable(page)))
+ 		goto out;
+=20
+ 	SetPageUnevictable(page);
+ 	page->mlock_count =3D !!PageMlocked(page);
+ 	__count_vm_events(UNEVICTABLE_PGCULLED, thp_nr_pages(page));
+ out:
+ 	add_page_to_lru_list(page, lruvec);
+ 	SetPageLRU(page);
+ 	return lruvec;
+ }
+=20
+ static struct lruvec *__munlock_page(struct page *page, struct lruvec *lr=
uvec)
+ {
+ 	int nr_pages =3D thp_nr_pages(page);
+ 	bool isolated =3D false;
+=20
+ 	if (!TestClearPageLRU(page))
+ 		goto munlock;
+=20
+ 	isolated =3D true;
+ 	lruvec =3D folio_lruvec_relock_irq(page_folio(page), lruvec);
+=20
+ 	if (PageUnevictable(page)) {
+ 		/* Then mlock_count is maintained, but might undercount */
+ 		if (page->mlock_count)
+ 			page->mlock_count--;
+ 		if (page->mlock_count)
+ 			goto out;
+ 	}
+ 	/* else assume that was the last mlock: reclaim will fix it if not */
+=20
+ munlock:
+ 	if (TestClearPageMlocked(page)) {
+ 		__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
+ 		if (isolated || !PageUnevictable(page))
+ 			__count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
+ 		else
+ 			__count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
+ 	}
+=20
+ 	/* page_evictable() has to be checked *after* clearing Mlocked */
+ 	if (isolated && PageUnevictable(page) && page_evictable(page)) {
+ 		del_page_from_lru_list(page, lruvec);
+ 		ClearPageUnevictable(page);
+ 		add_page_to_lru_list(page, lruvec);
+ 		__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
+ 	}
+ out:
+ 	if (isolated)
+ 		SetPageLRU(page);
+ 	return lruvec;
+ }
+=20
+ /*
+  * Flags held in the low bits of a struct page pointer on the mlock_pvec.
+  */
+ #define LRU_PAGE 0x1
+ #define NEW_PAGE 0x2
+ static inline struct page *mlock_lru(struct page *page)
+ {
+ 	return (struct page *)((unsigned long)page + LRU_PAGE);
+ }
+=20
+ static inline struct page *mlock_new(struct page *page)
+ {
+ 	return (struct page *)((unsigned long)page + NEW_PAGE);
+ }
+=20
+ /*
+  * mlock_pagevec() is derived from pagevec_lru_move_fn():
+  * perhaps that can make use of such page pointer flags in future,
+  * but for now just keep it for mlock.  We could use three separate
+  * pagevecs instead, but one feels better (munlocking a full pagevec
+  * does not need to drain mlocking pagevecs first).
+  */
+ static void mlock_pagevec(struct pagevec *pvec)
+ {
+ 	struct lruvec *lruvec =3D NULL;
+ 	unsigned long mlock;
+ 	struct page *page;
+ 	int i;
+=20
+ 	for (i =3D 0; i < pagevec_count(pvec); i++) {
+ 		page =3D pvec->pages[i];
+ 		mlock =3D (unsigned long)page & (LRU_PAGE | NEW_PAGE);
+ 		page =3D (struct page *)((unsigned long)page - mlock);
+ 		pvec->pages[i] =3D page;
+=20
+ 		if (mlock & LRU_PAGE)
+ 			lruvec =3D __mlock_page(page, lruvec);
+ 		else if (mlock & NEW_PAGE)
+ 			lruvec =3D __mlock_new_page(page, lruvec);
+ 		else
+ 			lruvec =3D __munlock_page(page, lruvec);
+ 	}
+=20
+ 	if (lruvec)
+ 		unlock_page_lruvec_irq(lruvec);
+ 	release_pages(pvec->pages, pvec->nr);
+ 	pagevec_reinit(pvec);
+ }
+=20
+ void mlock_page_drain(int cpu)
+ {
+ 	struct pagevec *pvec;
+=20
+ 	pvec =3D &per_cpu(mlock_pvec, cpu);
+ 	if (pagevec_count(pvec))
+ 		mlock_pagevec(pvec);
+ }
+=20
+ bool need_mlock_page_drain(int cpu)
+ {
+ 	return pagevec_count(&per_cpu(mlock_pvec, cpu));
+ }
+=20
+ /**
+  * mlock_folio - mlock a folio already on (or temporarily off) LRU
+  * @page: folio to be mlocked.
+  */
+ void mlock_folio(struct folio *folio)
+ {
+ 	struct pagevec *pvec =3D &get_cpu_var(mlock_pvec);
+=20
+ 	if (!folio_test_set_mlocked(folio)) {
+ 		int nr_pages =3D folio_nr_pages(folio);
+=20
+ 		zone_stat_mod_folio(folio, NR_MLOCK, nr_pages);
+ 		__count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
+ 	}
+=20
+ 	folio_get(folio);
+ 	if (!pagevec_add(pvec, mlock_lru(&folio->page)) ||
+ 	    folio_test_large(folio) || lru_cache_disabled())
++>>>>>>> folio/for-next
+ 		mlock_pagevec(pvec);
+ 	put_cpu_var(mlock_pvec);
+ }
+=20
+ /**
++<<<<<<< HEAD
++ * munlock_page - munlock a page
++ * @page: page to be munlocked, either a normal page or a THP head.
++ */
++void munlock_page(struct page *page)
++{
++	struct pagevec *pvec =3D &get_cpu_var(mlock_pvec);
++=3D=3D=3D=3D=3D=3D=3D
+  * mlock_new_page - mlock a newly allocated page not yet on LRU
+  * @page: page to be mlocked, either a normal page or a THP head.
+  */
+ void mlock_new_page(struct page *page)
+ {
+ 	struct pagevec *pvec =3D &get_cpu_var(mlock_pvec);
+ 	int nr_pages =3D thp_nr_pages(page);
+=20
+ 	SetPageMlocked(page);
+ 	mod_zone_page_state(page_zone(page), NR_MLOCK, nr_pages);
+ 	__count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
+=20
  	get_page(page);
  	if (!pagevec_add(pvec, mlock_new(page)) ||
  	    PageHead(page) || lru_cache_disabled())
@@@ -266,6 -266,6 +457,7 @@@
  void munlock_page(struct page *page)
  {
  	struct pagevec *pvec =3D &get_cpu_var(mlock_pvec);
++>>>>>>> folio/for-next
 =20
  	/*
  	 * TestClearPageMlocked(page) must be left to __munlock_page(),
@@@ -296,7 -296,7 +488,11 @@@ static int mlock_pte_range(pmd_t *pmd,=20
  			goto out;
  		page =3D pmd_page(*pmd);
  		if (vma->vm_flags & VM_LOCKED)
++<<<<<<< HEAD
 +			mlock_page(page);
++=3D=3D=3D=3D=3D=3D=3D
+ 			mlock_folio(page_folio(page));
++>>>>>>> folio/for-next
  		else
  			munlock_page(page);
  		goto out;
@@@ -312,7 -312,7 +508,11 @@@
  		if (PageTransCompound(page))
  			continue;
  		if (vma->vm_flags & VM_LOCKED)
++<<<<<<< HEAD
 +			mlock_page(page);
++=3D=3D=3D=3D=3D=3D=3D
+ 			mlock_folio(page_folio(page));
++>>>>>>> folio/for-next
  		else
  			munlock_page(page);
  	}
diff --cc mm/rmap.c
index a13487385820,5470c8de2ec0..000000000000
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@@ -106,10 -104,10 +106,10 @@@ static inline struct anon_vma *anon_vma
 =20
  static inline void anon_vma_free(struct anon_vma *anon_vma)
  {
 -	VM_BUG_ON(atomic_read(&anon_vma->refcount));
 +	VM_BUG_ON(refcount_read(&anon_vma->refcount));
 =20
  	/*
- 	 * Synchronize against page_lock_anon_vma_read() such that
+ 	 * Synchronize against folio_lock_anon_vma_read() such that
  	 * we can safely hold the lock without the anon_vma getting
  	 * freed.
  	 *
@@@ -815,9 -810,9 +812,15 @@@ static bool folio_referenced_one(struc
  		address =3D pvmw.address;
 =20
  		if ((vma->vm_flags & VM_LOCKED) &&
++<<<<<<< HEAD
 +		    (!PageTransCompound(page) || !pvmw.pte)) {
 +			/* Restore the mlock which got missed */
 +			mlock_vma_page(page, vma, !pvmw.pte);
++=3D=3D=3D=3D=3D=3D=3D
+ 		    (!folio_test_large(folio) || !pvmw.pte)) {
+ 			/* Restore the mlock which got missed */
+ 			mlock_vma_folio(folio, vma, !pvmw.pte);
++>>>>>>> folio/for-next
  			page_vma_mapped_walk_done(&pvmw);
  			pra->vm_flags |=3D VM_LOCKED;
  			return false; /* To break the loop */
@@@ -1469,24 -1454,25 +1462,40 @@@ static bool try_to_unmap_one(struct fol
 =20
  	while (page_vma_mapped_walk(&pvmw)) {
  		/* Unexpected PMD-mapped THP? */
++<<<<<<< HEAD
 +		VM_BUG_ON_PAGE(!pvmw.pte, page);
 +
 +		/*
 +		 * If the page is in an mlock()d vma, we must not swap it out.
++=3D=3D=3D=3D=3D=3D=3D
+ 		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
+=20
+ 		/*
+ 		 * If the folio is in an mlock()d vma, we must not swap it out.
++>>>>>>> folio/for-next
  		 */
  		if (!(flags & TTU_IGNORE_MLOCK) &&
  		    (vma->vm_flags & VM_LOCKED)) {
  			/* Restore the mlock which got missed */
++<<<<<<< HEAD
 +			mlock_vma_page(page, vma, false);
++=3D=3D=3D=3D=3D=3D=3D
+ 			mlock_vma_folio(folio, vma, false);
++>>>>>>> folio/for-next
  			page_vma_mapped_walk_done(&pvmw);
  			ret =3D false;
  			break;
  		}
 =20
++<<<<<<< HEAD
 +		subpage =3D page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
++=3D=3D=3D=3D=3D=3D=3D
+ 		subpage =3D folio_page(folio,
+ 					pte_pfn(*pvmw.pte) - folio_pfn(folio));
++>>>>>>> folio/for-next
  		address =3D pvmw.address;
 =20
- 		if (PageHuge(page) && !PageAnon(page)) {
+ 		if (folio_test_hugetlb(folio) && !folio_test_anon(folio)) {
  			/*
  			 * To call huge_pmd_unshare, i_mmap_rwsem must be
  			 * held in write mode.  Caller needs to explicitly
@@@ -1590,31 -1577,8 +1600,36 @@@
  			}
 =20
  			/* MADV_FREE page check */
++<<<<<<< HEAD
 +			if (!PageSwapBacked(page)) {
 +				int ref_count, map_count;
 +
 +				/*
 +				 * Synchronize with gup_pte_range():
 +				 * - clear PTE; barrier; read refcount
 +				 * - inc refcount; barrier; read PTE
 +				 */
 +				smp_mb();
 +
 +				ref_count =3D page_count(page);
 +				map_count =3D page_mapcount(page);
 +
 +				/*
 +				 * Order reads for page refcount and dirty flag;
 +				 * see __remove_mapping().
 +				 */
 +				smp_rmb();
 +
 +				/*
 +				 * The only page refs must be from the isolation
 +				 * plus one or more rmap's (dropped by discard:).
 +				 */
 +				if ((ref_count =3D=3D 1 + map_count) &&
 +				    !PageDirty(page)) {
++=3D=3D=3D=3D=3D=3D=3D
+ 			if (!folio_test_swapbacked(folio)) {
+ 				if (!folio_test_dirty(folio)) {
++>>>>>>> folio/for-next
  					/* Invalidate as we cleared the pte */
  					mmu_notifier_invalidate_range(mm,
  						address, address + PAGE_SIZE);
@@@ -1683,10 -1648,10 +1699,17 @@@ discard
  		 *
  		 * See Documentation/vm/mmu_notifier.rst
  		 */
++<<<<<<< HEAD
 +		page_remove_rmap(subpage, vma, PageHuge(page));
 +		if (vma->vm_flags & VM_LOCKED)
 +			mlock_page_drain(smp_processor_id());
 +		put_page(page);
++=3D=3D=3D=3D=3D=3D=3D
+ 		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
+ 		if (vma->vm_flags & VM_LOCKED)
+ 			mlock_page_drain(smp_processor_id());
+ 		folio_put(folio);
++>>>>>>> folio/for-next
  	}
 =20
  	mmu_notifier_invalidate_range_end(&range);
@@@ -1852,8 -1815,8 +1873,13 @@@ static bool try_to_migrate_one(struct f
  		/* Update high watermark before we lower rss */
  		update_hiwater_rss(mm);
 =20
++<<<<<<< HEAD
 +		if (is_device_private_page(page)) {
 +			unsigned long pfn =3D page_to_pfn(page);
++=3D=3D=3D=3D=3D=3D=3D
+ 		if (folio_is_zone_device(folio)) {
+ 			unsigned long pfn =3D folio_pfn(folio);
++>>>>>>> folio/for-next
  			swp_entry_t entry;
  			pte_t swp_pte;
 =20
@@@ -1891,11 -1852,11 +1917,15 @@@
  			 * changed when hugepage migrations to device private
  			 * memory are supported.
  			 */
++<<<<<<< HEAD
 +			subpage =3D page;
++=3D=3D=3D=3D=3D=3D=3D
+ 			subpage =3D &folio->page;
++>>>>>>> folio/for-next
  		} else if (PageHWPoison(subpage)) {
  			pteval =3D swp_entry_to_pte(make_hwpoison_entry(subpage));
- 			if (PageHuge(page)) {
- 				hugetlb_count_sub(compound_nr(page), mm);
+ 			if (folio_test_hugetlb(folio)) {
+ 				hugetlb_count_sub(folio_nr_pages(folio), mm);
  				set_huge_swap_pte_at(mm, address,
  						     pvmw.pte, pteval,
  						     vma_mmu_pagesize(vma));
@@@ -1963,10 -1922,10 +1993,17 @@@
  		 *
  		 * See Documentation/vm/mmu_notifier.rst
  		 */
++<<<<<<< HEAD
 +		page_remove_rmap(subpage, vma, PageHuge(page));
 +		if (vma->vm_flags & VM_LOCKED)
 +			mlock_page_drain(smp_processor_id());
 +		put_page(page);
++=3D=3D=3D=3D=3D=3D=3D
+ 		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
+ 		if (vma->vm_flags & VM_LOCKED)
+ 			mlock_page_drain(smp_processor_id());
+ 		folio_put(folio);
++>>>>>>> folio/for-next
  	}
 =20
  	mmu_notifier_invalidate_range_end(&range);
@@@ -1999,8 -1958,7 +2036,12 @@@ void try_to_migrate(struct folio *folio
  					TTU_SYNC)))
  		return;
 =20
++<<<<<<< HEAD
 +	if (is_zone_device_page(page) &&
 +	    (!is_device_private_page(page) && !is_device_coherent_page(page)))
++=3D=3D=3D=3D=3D=3D=3D
+ 	if (folio_is_zone_device(folio) && !folio_is_device_private(folio))
++>>>>>>> folio/for-next
  		return;
 =20
  	/*
@@@ -2015,9 -1973,9 +2056,13 @@@
  		rwc.invalid_vma =3D invalid_migration_vma;
 =20
  	if (flags & TTU_RMAP_LOCKED)
- 		rmap_walk_locked(page, &rwc);
+ 		rmap_walk_locked(folio, &rwc);
  	else
++<<<<<<< HEAD
 +		rmap_walk(page, &rwc);
++=3D=3D=3D=3D=3D=3D=3D
+ 		rmap_walk(folio, &rwc);
++>>>>>>> folio/for-next
  }
 =20
  #ifdef CONFIG_DEVICE_PRIVATE
diff --cc mm/vmscan.c
index 5f471c1e279f,7db5d0237333..000000000000
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@@ -986,12 -985,23 +986,12 @@@ static inline int is_page_cache_freeabl
  	 * that isolated the page, the page cache and optional buffer
  	 * heads at page->private.
  	 */
- 	int page_cache_pins =3D thp_nr_pages(page);
- 	return page_count(page) - page_has_private(page) =3D=3D 1 + page_cache_p=
ins;
+ 	return folio_ref_count(folio) - folio_test_private(folio) =3D=3D
+ 		1 + folio_nr_pages(folio);
  }
 =20
 -static int may_write_to_inode(struct inode *inode)
 -{
 -	if (current->flags & PF_SWAPWRITE)
 -		return 1;
 -	if (!inode_write_congested(inode))
 -		return 1;
 -	if (inode_to_bdi(inode) =3D=3D current->backing_dev_info)
 -		return 1;
 -	return 0;
 -}
 -
  /*
-  * We detected a synchronous write error writing a page out.  Probably
+  * We detected a synchronous write error writing a folio out.  Probably
   * -ENOSPC.  We need to propagate that into the address_space for a subse=
quent
   * fsync(), msync() or close().
   *
@@@ -1191,8 -1201,10 +1191,8 @@@ static pageout_t pageout(struct folio *
  	}
  	if (mapping->a_ops->writepage =3D=3D NULL)
  		return PAGE_ACTIVATE;
 -	if (!may_write_to_inode(mapping->host))
 -		return PAGE_KEEP;
 =20
- 	if (clear_page_dirty_for_io(page)) {
+ 	if (folio_clear_dirty_for_io(folio)) {
  		int res;
  		struct writeback_control wbc =3D {
  			.sync_mode =3D WB_SYNC_NONE,
@@@ -1365,19 -1383,19 +1371,24 @@@ enum page_references=20
  	PAGEREF_ACTIVATE,
  };
 =20
- static enum page_references page_check_references(struct page *page,
+ static enum page_references folio_check_references(struct folio *folio,
  						  struct scan_control *sc)
  {
- 	int referenced_ptes, referenced_page;
+ 	int referenced_ptes, referenced_folio;
  	unsigned long vm_flags;
 =20
- 	referenced_ptes =3D page_referenced(page, 1, sc->target_mem_cgroup,
- 					  &vm_flags);
- 	referenced_page =3D TestClearPageReferenced(page);
+ 	referenced_ptes =3D folio_referenced(folio, 1, sc->target_mem_cgroup,
+ 					   &vm_flags);
+ 	referenced_folio =3D folio_test_clear_referenced(folio);
 =20
  	/*
++<<<<<<< HEAD
 +	 * The supposedly reclaimable page was found to be in a VM_LOCKED vma.
 +	 * Let the page, now marked Mlocked, be moved to the unevictable list.
++=3D=3D=3D=3D=3D=3D=3D
+ 	 * The supposedly reclaimable folio was found to be in a VM_LOCKED vma.
+ 	 * Let the folio, now marked Mlocked, be moved to the unevictable list.
++>>>>>>> folio/for-next
  	 */
  	if (vm_flags & VM_LOCKED)
  		return PAGEREF_ACTIVATE;
@@@ -1566,8 -1586,10 +1579,15 @@@ retry
  		 * end of the LRU a second time.
  		 */
  		mapping =3D page_mapping(page);
++<<<<<<< HEAD
 +		if (writeback && PageReclaim(page))
 +			stat->nr_congested++;
++=3D=3D=3D=3D=3D=3D=3D
+ 		if (((dirty || writeback) && mapping &&
+ 		     inode_write_congested(mapping->host)) ||
+ 		    (writeback && PageReclaim(page)))
+ 			stat->nr_congested +=3D nr_pages;
++>>>>>>> folio/for-next
 =20
  		/*
  		 * If a page at the tail of the LRU is under writeback, there
@@@ -1716,9 -1738,9 +1736,15 @@@
  				/* Adding to swap updated mapping */
  				mapping =3D page_mapping(page);
  			}
++<<<<<<< HEAD
 +		} else if (unlikely(PageTransHuge(page))) {
 +			/* Split file/lazyfree THP */
 +			if (split_huge_page_to_list(page, page_list))
++=3D=3D=3D=3D=3D=3D=3D
+ 		} else if (PageSwapBacked(page) && PageTransHuge(page)) {
+ 			/* Split shmem THP */
+ 			if (split_folio_to_list(folio, page_list))
++>>>>>>> folio/for-next
  				goto keep_locked;
  		}
 =20

--MP_/fg63Z.AD3L5FnXHQmX7svGC--

--Sig_/0y5Q=JT+mePUSjYe..hvM71
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIMyLwACgkQAVBC80lX
0GyAHgf8DDbSyjwVdnHgdOMOZW/eCO3QAOQA2qoge8kedbbLdWCZ5PUmvo8X6Uhd
tynbbn7YO3JXD/VUAGFwoVvy9nSg1FbDTFKarZCAd2Lk+5PAtm1FqYDAuDalpFDT
BjXPC6EE3I33+hUFElApFACbLJf6OGSfjwS6iKEPXKClGrIYGHmho8qF6vMliJCl
gzkFFciz/0ss/CANOopfk8MSm6fYYvfH0s8N10AVJpO5WrpuWhYeAdsicTNh8IQC
XHA5xRvqsv89rnr6j/MkWB/qjmapdSipQHyksS6fz/0MSTXqw2OAmvHs+c0eaYwL
amtSBnlsgW+vrJKJitsznxTvk1VGOQ==
=NeqO
-----END PGP SIGNATURE-----

--Sig_/0y5Q=JT+mePUSjYe..hvM71--
