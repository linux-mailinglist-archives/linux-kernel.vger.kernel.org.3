Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E894F65C7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbiDFQnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238742AbiDFQnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:43:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97FA92CB3A2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649257337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/3Bz+6mxeokIYB8L/BSNNV23dZJu+F2jesvn+3ntwnM=;
        b=RFblemmt4yKoByv9RfTPLfnLnxRP1AW5hGbboWrViAHZqNw6LPIhkPCzRkGq7VRDnCgc6v
        i0iMNapWLCtrDOoP4fneEC4pKztCWe7egK+nFZYx1YDUSigl3opfF6f0oggAEteFBstOIN
        ZmneMNp34Hbw2fvTKfIgOG4rMr+iVE4=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-tbL6Ha74MZeqij9-oZz6Iw-1; Wed, 06 Apr 2022 11:02:16 -0400
X-MC-Unique: tbL6Ha74MZeqij9-oZz6Iw-1
Received: by mail-io1-f72.google.com with SMTP id h10-20020a05660224ca00b0064c77aa4477so1743489ioe.17
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 08:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/3Bz+6mxeokIYB8L/BSNNV23dZJu+F2jesvn+3ntwnM=;
        b=W7retb7D+EFCnH777OFVei4fmySTBDIgPTaJazj0JfgFLBgA16H+0Ye/SRerBIPwlL
         McFeNleDW+moZ8bVETlCNRUlitChOGDfi20h7WeaDzYXeRqI5U2ivSAtIo79Ies6Cd+3
         HZa7xv8fn21wbjUizz7TOHj6edbIyUm3ASruTuN6FaJOH7Z5wgOwgb6lUBt7NFo1t6hv
         ukqjIEoquH+CyMNzV9bDyaU5Y0Ugzvktjzf5jHKC3VlN+J/dOCjyIFilvtAJah7T9kw2
         f1tgQb8MIG3MAvHfFeq1Gq3tJoQlJluwCcQ4mqcwTZJp1LRSEQU/3SaS6+Nhbq1za2Hc
         XR8g==
X-Gm-Message-State: AOAM533H7PFZ4zLI9obFPC7OpKbmT8CC2+muEkrjjkN37WEAgBAbMikE
        YgMa6nNJBrljv8mkCsgpYtu33G+HnqRzDs7PEI/mtM4/LPV1xHDFHHfbFkeepB3bYoG0kbNYMOs
        U0gUOhmvpwd4wtrgYzG28UGO+
X-Received: by 2002:a6b:d10c:0:b0:641:63b2:9ef8 with SMTP id l12-20020a6bd10c000000b0064163b29ef8mr4264767iob.135.1649257335225;
        Wed, 06 Apr 2022 08:02:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwouWP4dTVYHsqZxyr/OP0EkEm2M9n4n0oS+NpczhwwZJSAFO2isyLss0cd8b+zjJfVkwDOPw==
X-Received: by 2002:a6b:d10c:0:b0:641:63b2:9ef8 with SMTP id l12-20020a6bd10c000000b0064163b29ef8mr4264750iob.135.1649257334912;
        Wed, 06 Apr 2022 08:02:14 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id y3-20020a92c983000000b002c7dce8329fsm9394700iln.72.2022.04.06.08.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 08:02:14 -0700 (PDT)
Date:   Wed, 6 Apr 2022 11:02:12 -0400
From:   Peter Xu <peterx@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kbuild-all@lists.01.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v8 15/23] mm/hugetlb: Handle pte markers in page faults
Message-ID: <Yk2rdB7SXZf+2BDF@xz-m1.local>
References: <20220405014909.14761-1-peterx@redhat.com>
 <202204062154.2txNJyaf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gQDMqriStFwDEZjG"
Content-Disposition: inline
In-Reply-To: <202204062154.2txNJyaf-lkp@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gQDMqriStFwDEZjG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Apr 06, 2022 at 09:37:00PM +0800, kernel test robot wrote:
> Hi Peter,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on hnaz-mm/master]
> [cannot apply to arnd-asm-generic/master linus/master linux/master v5.18-rc1 next-20220406]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Xu/userfaultfd-wp-Support-shmem-and-hugetlbfs/20220405-100136
> base:   https://github.com/hnaz/linux-mm master
> config: s390-randconfig-r044-20220406 (https://download.01.org/0day-ci/archive/20220406/202204062154.2txNJyaf-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/e7e7aaec811e2817cd169f0cc1d8f81bdf1f05c3
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Peter-Xu/userfaultfd-wp-Support-shmem-and-hugetlbfs/20220405-100136
>         git checkout e7e7aaec811e2817cd169f0cc1d8f81bdf1f05c3
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    mm/hugetlb.c: In function 'hugetlb_fault':
> >> mm/hugetlb.c:5678:13: error: implicit declaration of function 'huge_pte_none_mostly'; did you mean 'pte_none_mostly'? [-Werror=implicit-function-declaration]
>     5678 |         if (huge_pte_none_mostly(entry)) {
>          |             ^~~~~~~~~~~~~~~~~~~~
>          |             pte_none_mostly
>    cc1: some warnings being treated as errors

Ah, the s390 stub was forgotten again, sorry.  I hope someday s390 will
start to include asm-generic/hugetlb.h like all the rest archs, because
that's really from the gut feeling of how it should happen.. or the dir
should be renamed to asm-generic-without-s390/. :(

An expected fix patch attached (to be squashed into patch "mm: Introduce
PTE_MARKER swap entry").

Thanks,

-- 
Peter Xu

--gQDMqriStFwDEZjG
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-fixup-mm-Introduce-PTE_MARKER-swap-entry.patch"

From 8b84d7f6b86c30623208eff386b4f5169f1cb0db Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 6 Apr 2022 10:55:55 -0400
Subject: [PATCH] fixup! mm: Introduce PTE_MARKER swap entry

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/s390/include/asm/hugetlb.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index be99eda87f4d..32c3fd6e878e 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -85,6 +85,11 @@ static inline int huge_pte_none(pte_t pte)
 	return pte_none(pte);
 }
 
+static inline int huge_pte_none_mostly(pte_t pte)
+{
+	return huge_pte_none(pte);
+}
+
 static inline int huge_pte_write(pte_t pte)
 {
 	return pte_write(pte);
-- 
2.32.0


--gQDMqriStFwDEZjG--

