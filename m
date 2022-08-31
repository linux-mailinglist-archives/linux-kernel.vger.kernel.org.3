Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB845A86B8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiHaT2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiHaT2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:28:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0632CDEB6B
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=COXA0nr8/oFAjzYFNBlfqg/PG216/XGX105MCvhb76o=; b=c2R+78d5nQboEOwjI+D7fNgadm
        kOANFOyyNZaHtxf7w5U4oXxDxFwJtrijKZ0ghhTjhKdRYLR0XgZ2jIwR7U1/1ZunGTMrw7UVtTTnJ
        2CGIZXx/i3lEZvBL8iLrXVUU7CE+teYQHeOf9VSthRiAYY58leHEdeWrWW+F1YjkQkw7kr0SGEBjr
        ykIbWde2mJlgmeoGb2/XyvM3oYWq62W/rBoTD1KRNshtYM9xapcQlGaLxeMnbsCNtICbXBRa3Seaw
        7Y73cwY9+zukhORcaLFUhaD33909paXr3eO8T9f7nkYh5ZQ4kffgafRDyH5TcolvPENUGHTjCAw/a
        cp2xZ9OA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTTNW-005NTh-4E; Wed, 31 Aug 2022 19:27:58 +0000
Date:   Wed, 31 Aug 2022 20:27:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] hugetlb: use mm.h instead of mm_types.h
Message-ID: <Yw+2PrIzebUbVYQR@casper.infradead.org>
References: <20220831185739.21400-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220831185739.21400-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:57:39AM -0700, Randy Dunlap wrote:
> mm_types.h does not have zap_flags_t in it so use mm.h instead
> in hugetlb.h.

... my copy of mm_types.h has zap_flags_t in it.  Was it recently moved?
Perhaps moving it back is a better solution to this problem?

> Fixes this build error:
> 
> In file included from ../drivers/virt/nitro_enclaves/ne_misc_dev.c:16:0:
> ../include/linux/hugetlb.h:414:4: error: unknown type name ‘zap_flags_t’; did you mean ‘vm_flags_t’?
>     zap_flags_t zap_flags)
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: linux-mm@kvack.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
> Fixes: mm-hugetlb-only-drop-uffd-wp-special-pte-if-required-fix.patch
> v2: add Rev-by: Peter
>     drop the bogus S-o-b: in Cc: Peter Xu
> 
>  include/linux/hugetlb.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -2,7 +2,7 @@
>  #ifndef _LINUX_HUGETLB_H
>  #define _LINUX_HUGETLB_H
>  
> -#include <linux/mm_types.h>
> +#include <linux/mm.h>
>  #include <linux/mmdebug.h>
>  #include <linux/fs.h>
>  #include <linux/hugetlb_inline.h>
> 
