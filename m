Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FB857D599
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbiGUVNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGUVND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:13:03 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5260F4E61D;
        Thu, 21 Jul 2022 14:13:01 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A6DDB6D9;
        Thu, 21 Jul 2022 21:13:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A6DDB6D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1658437980; bh=A/45P4qm24EYhkCZPmUzYfgAKicEoO+XAjAAD6wsy54=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LKAzyduD57zhWdrHjbl/08ggRiW0DJJ74HGrZBsBSgkQAAQGO/Z8rckxN5B/J73pD
         BNNXDRZltmJp7lnEYN/69uKuG0QoIUnaqvlm6AjHNTVZty2SBgHYrKq8bODNoyunHn
         2iiVemdhPyaDt5BYUqJB8Sr6FhxIb41ZkHeo99XLEK/i5j4DrNvhImOlwMLf1n/Vel
         VFhImekkYi7ZDTPxsERfxR2E2n19qtOeOpA66iHTRZxZbcxr0sT5bpU3lzVII5jJDg
         3lDWLZeQ/F9KBEdS+AxlrpccFVJQf/cuw44u4c0IEG2q1ajGrGbOfBlTV2aHvPaOgP
         w7oWUNhzopvTw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/7] Documentation/mm: Don't kmap*() pages which can't
 come from HIGHMEM
In-Reply-To: <20220721210206.13774-4-fmdefrancesco@gmail.com>
References: <20220721210206.13774-1-fmdefrancesco@gmail.com>
 <20220721210206.13774-4-fmdefrancesco@gmail.com>
Date:   Thu, 21 Jul 2022 15:13:00 -0600
Message-ID: <87czdykw4j.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Fabio M. De Francesco" <fmdefrancesco@gmail.com> writes:

> There is no need to kmap*() pages which are guaranteed to come from
> ZONE_NORMAL (or lower). Linux has currently several call sites of
> kmap{,_atomic,_local_page}() on pages allocated, for instance, with
> alloc_page(GFP_NOFS) and other similar allocations.
>
> Therefore, add a paragraph to highmem.rst, to explain better that a
> plain page_address() should be used for getting the address of pages
> which cannot come from ZONE_HIGHMEM.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  Documentation/vm/highmem.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
> index c9887f241c6c..f266354c82ab 100644
> --- a/Documentation/vm/highmem.rst
> +++ b/Documentation/vm/highmem.rst
> @@ -71,6 +71,12 @@ list shows them in order of preference of use.
>    kmap_local_page() always returns a valid virtual address and it is assumed
>    that kunmap_local() will never fail.
>  
> +  On CONFIG_HIGHMEM=n kernels and for low memory pages this returns the
> +  virtual address of the direct mapping. Only real highmem pages are
> +  temporarily mapped. Therefore, users should instead call a plain
> +  page_address() for getting the address of memory pages which, depending
> +  on the GFP_* flags, cannot come from ZONE_HIGHMEM.
> +

Is this good advice?  First, it requires developers to worry about
whether their pages might be in highmem, which is kind of like worrying
about having coins in your pocket in case you need a payphone.  But it
would also run afoul of other semantics for kmap*(), such as PKS, should
that ever be merged:

  https://lwn.net/Articles/894531/

Thanks,

jon
