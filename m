Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB5B50A770
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390932AbiDURxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390907AbiDURxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:53:51 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD1E49CAE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:51:00 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q7so103308wrm.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=M22h9UQjwXBYuhzU3iIzL65vslAk4PsiNxWDwMZ8FAo=;
        b=hEECmpUnpB3qCAOGX3uyF12IUPH1WwYzm/Tv+tRwA2dyTdlvn18OlYA1n9edNZF9jH
         Ci+i2S7I7ii5aaDUHP8i2cdgue9/jbgG2rvA+jU4zhZXdgUO4M8JGOgsAIB+9CtsAMxM
         xiynn++9MRLsCGD9cPamO/O1MHYoRMPeXgiY3uy00vhonh76G8CS1aB6NcOw7AvL6TnQ
         R0Ltzup4dT2T0mx6g7sYEab4LmX7jrTdMn7iKnnt4hrwi+kHFzhDgZ4vd8JkVBDjX6hW
         5UeRkn4GlXT7c1UDq1QMzJpwglAcBUYi+yGXrPAz4c+U9lW5Wh4x7odRIJ1tSnan+S8Z
         /zTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M22h9UQjwXBYuhzU3iIzL65vslAk4PsiNxWDwMZ8FAo=;
        b=LDCgD3L1nUr+IiCroxp25ro57I+RYMLB9XjrCJ0wLZbZfVHsDzosDNXwaylt13sfPL
         qaMZHLEmlXZkH+h1aREluObYJjXjFgZjdWHEENTiB9mlqT0skqaY/cxix0XlP60dXpjC
         gaKeoNT9iSYhqs8+gZV6xt+YwyFU+yQ7AosunpcFicj4rFN/uoZCkWUuw2ZcsT11yNVX
         PpPyE2ZFn6MSrxOKD7zMmt7fQNG9J95En2Cfqq7QuaTC/fBinxyux5IOdBaKRekZ3D9x
         Xb2j7teZkaTmfHBs6Tph2BVuiJ9RdjhLjAhvKdTkN9CKoKrVoK99byN3Afj2QUDUmbeo
         TZbw==
X-Gm-Message-State: AOAM533K68L/Dr4qCNl5om3dqFRJw8A8BJoItNdL5A2AAvztPlURaB40
        2EQa+qSbeDnxrkoRH913LtE=
X-Google-Smtp-Source: ABdhPJy90JiQaRGbP3+RdlApAiy5FRq5lCRQKdFczqp+z85MecKOuuhtXHTPf64gmnZmmiXjGp8Uhw==
X-Received: by 2002:a05:6000:1f97:b0:20a:bb9d:c82d with SMTP id bw23-20020a0560001f9700b0020abb9dc82dmr656649wrb.302.1650563459174;
        Thu, 21 Apr 2022 10:50:59 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id a18-20020adffb92000000b00207a257d47asm2798931wrr.95.2022.04.21.10.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:50:57 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] mm/highmem: Fix kernel-doc warnings in highmem*.h
Date:   Thu, 21 Apr 2022 19:50:56 +0200
Message-ID: <12321324.iMDcRRXYNz@leap>
In-Reply-To: <20220418175638.30018-1-fmdefrancesco@gmail.com>
References: <20220418175638.30018-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=C3=AC 18 aprile 2022 19:56:38 CEST Fabio M. De Francesco wrote:
> `scripts/kernel-doc -none include/linux/highmem*` reports the following
> warnings:
>=20
> include/linux/highmem.h:160: warning: expecting prototype for=20
kunmap_atomic(). Prototype was for nr_free_highpages() instead
> include/linux/highmem-internal.h:256: warning: Function parameter or=20
member '__addr' not described in 'kunmap_atomic'
> include/linux/highmem-internal.h:256: warning: Excess function parameter=
=20
'addr' description in 'kunmap_atomic'
>=20
> Fix these warnings by (1) move the kernel-doc comments from highmem.h to
> highmem-internal.h (which is the file were the kunmap_atomic() macro is
> actually defined), (2) merge it with the comment which already was in
> highmem-internal.h, and (3) use correct parameter names.
>=20
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>=20
> v1->v2: Re-word the last sentence of the commit message and add a missing
> 	number to the second entry in the fixes list. Add Mike Rapoport's
> 	"Acked-by:" tag (thanks!).
>=20
>  include/linux/highmem-internal.h | 14 +++++++++++---
>  include/linux/highmem.h          | 13 +------------
>  2 files changed, 12 insertions(+), 15 deletions(-)
>=20
> diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-
internal.h
> index a77be5630209..7307de391288 100644
> --- a/include/linux/highmem-internal.h
> +++ b/include/linux/highmem-internal.h
> @@ -236,9 +236,17 @@ static inline unsigned long totalhigh_pages(void) {=
=20
return 0UL; }
> =20
>  #endif /* CONFIG_HIGHMEM */
> =20
> -/*
> - * Prevent people trying to call kunmap_atomic() as if it were kunmap()
> - * kunmap_atomic() should get the return value of kmap_atomic, not the=20
page.
> +/**
> + * kunmap_atomic - Unmap the virtual address mapped by kmap_atomic()
> + * @__addr:       Virtual address to be unmapped
> + *
> + * Counterpart to kmap_atomic().
> + *
> + * Effectively a wrapper around kunmap_local() which additionally undoes
> + * the side effects of kmap_atomic(), i.e. reenabling pagefaults and
> + * preemption. Prevent people trying to call kunmap_atomic() as if it
> + * were kunmap() because kunmap_atomic() should get the return value of
> + * kmap_atomic(), not its argument which is a pointer to struct page.
>   */
>  #define kunmap_atomic(__addr)				=09
\
>  do {							=09
\
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 39bb9b47fa9c..0a7a89721e5d 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -37,7 +37,7 @@ static inline void *kmap(struct page *page);
> =20
>  /**
>   * kunmap - Unmap the virtual address mapped by kmap()
> - * @addr:	Virtual address to be unmapped
> + * @page:	Virtual address to be unmapped
>   *
>   * Counterpart to kmap(). A NOOP for CONFIG_HIGHMEM=3Dn and for mappings=
=20
of
>   * pages in the low memory area.
> @@ -145,17 +145,6 @@ static inline void *kmap_local_folio(struct folio=20
*folio, size_t offset);
>   */
>  static inline void *kmap_atomic(struct page *page);
> =20
> -/**
> - * kunmap_atomic - Unmap the virtual address mapped by kmap_atomic()
> - * @addr:	Virtual address to be unmapped
> - *
> - * Counterpart to kmap_atomic().
> - *
> - * Effectively a wrapper around kunmap_local() which additionally undoes
> - * the side effects of kmap_atomic(), i.e. reenabling pagefaults and
> - * preemption.
> - */
> -
>  /* Highmem related interfaces for management code */
>  static inline unsigned int nr_free_highpages(void);
>  static inline unsigned long totalhigh_pages(void);
> --=20
> 2.34.1
>=20
Dear Maintainers,

Please drop this patch because it has been reworked and inserted as part of=
=20
a new series whose subject is "Extend and reorganize Highmem's=20
documentation" and which is about to be submitted.

Thanks,

=46abio M. De Francesco




