Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D567507AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346005AbiDSURA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbiDSUQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:16:59 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302344162A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:14:14 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id d19so6559560qko.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oLvHe9n2/nj2a8wY36w2VEl3LeaDii/qgVkhGjkxKas=;
        b=RoHB3j5Nv13SUMS7P1IzyUQdv9WtzeW1R8P8OztRG/RfhVZOAyIF7HwVjf7bQMSzGg
         BtFp6tp+zPvTC3pgwr8sI+kE3UT1X5QyCdYGwXsu2mDW4ZHPLBgRQqLIItkS2LqHx0jr
         540ag+YZWhjsFN4YgxQm7eXU7rnQHJSLNOqnR24AB90j6l8msqT0eyIwiWGwPCgFPMr/
         pisdfh2KMM5FnH6xtXipRLpvKq9/dAXPZoBaqSu87Zv56WqzuJ2lTENJLU1d5t0vrxfU
         G/CB1FAXTjNOr5T7atzD2i6IrRacNsL2qDf5//p0bKOLdzIVlYVFhag7+rb8DfbxGdmb
         glxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oLvHe9n2/nj2a8wY36w2VEl3LeaDii/qgVkhGjkxKas=;
        b=hZY3zva4ULd1oPsFDJff+W0uUdzl4YYIeApZmc1wjIkC7sDTMuAbO0HijOLAg1Bjia
         Le1nKmtR+MDFgYRLUS1BnLlgCF/zq11vjScIgtLGKJxW4WNf06vX9HQYVTF1UMnpN9fs
         srFj82ENbKeyJbwCazj6ZIxXOArWAvqBVAyMG4AS43QFH80Iklh+/iVPAEjtZzxVugRq
         8RdezxGjYwv0tLxAWR04drsWnez9K76v3U0JNWLJsRmmQo3MiLVq+bZxix1wqbLpvJBF
         6MSzVrQXfDbeKFz0hOfvXr2UD9c8p5yIfzawDy/qz2KVIsD9Ccdyz9K5N6OaB5F77DiI
         L6vg==
X-Gm-Message-State: AOAM530WzMYC7niZkMpxhU+SEEQZord9Az0g4XL7O0SQfdENjyaPmDWn
        JL9cZhllmpH0/Wpfrzl14XjOUw==
X-Google-Smtp-Source: ABdhPJx1mGv/eHLonuW3eQByOlAjMhWCbUuxa3hAZle2cs9dLK+AepHuL88dYTAOWJqj4DIneiQWxw==
X-Received: by 2002:a05:620a:4311:b0:67e:8a0f:4cd5 with SMTP id u17-20020a05620a431100b0067e8a0f4cd5mr10728082qko.363.1650399253390;
        Tue, 19 Apr 2022 13:14:13 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id t72-20020a37464b000000b0067ec1c9dcaesm495044qka.44.2022.04.19.13.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 13:14:12 -0700 (PDT)
Date:   Tue, 19 Apr 2022 16:14:11 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
Subject: Re: [PATCH v8 22/23] mm: Enable PTE markers by default
Message-ID: <Yl8YE+w+OWz5RNOL@cmpxchg.org>
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014929.15158-1-peterx@redhat.com>
 <Yl7RrKV5mXtNAAzi@cmpxchg.org>
 <Yl8UmWQodLX+JkZ7@xz-m1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl8UmWQodLX+JkZ7@xz-m1.local>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Apr 19, 2022 at 03:59:21PM -0400, Peter Xu wrote:
> @@ -910,16 +910,16 @@ config ANON_VMA_NAME
>  	  difference in their name.
>  
>  config PTE_MARKER
> -	bool "Marker PTEs support"
> -	default y
> +	bool
>  
>  	help
>  	  Allows to create marker PTEs for file-backed memory.
>
>  config PTE_MARKER_UFFD_WP
> -	bool "Marker PTEs support for userfaultfd write protection"
> +	bool "Userfaultfd write protection support for shmem/hugetlbfs"
>  	default y
> -	depends on PTE_MARKER && HAVE_ARCH_USERFAULTFD_WP
> +	depends on HAVE_ARCH_USERFAULTFD_WP
> +	select PTE_MARKER

This is much easier to understand, thanks!

Btw, this doesn't do much without userfaultfd being enabled in
general, right? Would it make sense to have it next to 'config
USERFAULTFD' as a sub-option?
