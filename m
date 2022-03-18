Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599284DDF38
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbiCRQmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbiCRQmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:42:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703DE1D418D;
        Fri, 18 Mar 2022 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r8zGlravb2AzK2K7gBcn8VO4FQqoRtf4pFqGmaBVArs=; b=2qokbIvjL36AIwDMyafPopbgvt
        lE10XLrJYrqq817MejuOaAPSZmZ2Mg0CgT3Z4P727hr0d5Y2fwZcSNmHacDmQCIdh3ZwjeeLHA3rl
        aC9uuWzvY6Yjp4T8pjKTJQ37v6/z4Q55st2IM2RYc+v1yqsWpJ56M3voCv1I/ztwr1/EDDXR5/v9e
        EbRhBOifwi09xLwDeaCVFdTKVIpVqg2DQFwSMqYILnfOqydu48pOkRfDQIs19IG1sSu4GvnchghL2
        8bfd013D7INfQnufiz3GK0+4r7JJFVKGjS7I88vEXpx2QcBBUEXKWsaVtnzowSdFjwKLCxPkLZ9dy
        +YWb+9SA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nVFeY-002QHy-Q2; Fri, 18 Mar 2022 16:40:38 +0000
Date:   Fri, 18 Mar 2022 09:40:38 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v4 1/4] mm: hugetlb_vmemmap: introduce
 STRUCT_PAGE_SIZE_IS_POWER_OF_2
Message-ID: <YjS2BiqKlDrPYslc@bombadil.infradead.org>
References: <20220318100720.14524-1-songmuchun@bytedance.com>
 <20220318100720.14524-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318100720.14524-2-songmuchun@bytedance.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 06:07:17PM +0800, Muchun Song wrote:

You can add Suggested-by tag here.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  Kbuild                           | 12 ++++++++++++
>  fs/Kconfig                       |  2 +-
>  include/linux/mm_types.h         |  2 ++
>  mm/Kconfig                       |  3 +++
>  mm/hugetlb_vmemmap.c             |  6 ------
>  mm/struct_page_size.c            | 19 +++++++++++++++++++
>  scripts/check_struct_page_po2.sh | 11 +++++++++++
>  7 files changed, 48 insertions(+), 7 deletions(-)
>  create mode 100644 mm/struct_page_size.c
>  create mode 100755 scripts/check_struct_page_po2.sh
> 
> diff --git a/Kbuild b/Kbuild
> index fa441b98c9f6..6bb97d348d62 100644
> --- a/Kbuild
> +++ b/Kbuild
> @@ -14,6 +14,18 @@ $(bounds-file): kernel/bounds.s FORCE
>  	$(call filechk,offsets,__LINUX_BOUNDS_H__)
>  
>  #####
> +# Generate struct_page_size.h. Must follows bounds.h.
> +
> +struct_page_size-file := include/generated/struct_page_size.h
> +
> +always-y := $(struct_page_size-file)
> +targets := mm/struct_page_size.s
> +
> +$(struct_page_size-file): mm/struct_page_size.s FORCE
> +	$(call filechk,offsets,__LINUX_STRUCT_PAGE_SIZE_H__)
> +	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
> +
> +#####

Shouldn't this go into mm/Makefile instead?

> diff --git a/mm/Kconfig b/mm/Kconfig
> index 034d87953600..9314bd34f49e 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -2,6 +2,9 @@
>  
>  menu "Memory Management options"
>  
> +config STRUCT_PAGE_SIZE_IS_POWER_OF_2
> +	def_bool $(success,test "$(shell, $(srctree)/scripts/check_struct_page_po2.sh)" = 1)
> +
>  config SELECT_MEMORY_MODEL
>  	def_bool y
>  	depends on ARCH_SELECT_MEMORY_MODEL
> new file mode 100755
> index 000000000000..9547ad3aca05
> --- /dev/null
> +++ b/scripts/check_struct_page_po2.sh
> @@ -0,0 +1,11 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Check if the size of "struct page" is power of 2
> +
> +file="include/generated/struct_page_size.h"
> +if [ ! -f "$file" ]; then

Does this really work if one is workig off of a very clean build
like make mrproper and then make menuconfig or or mrproper followed
by a defconfig file ? Have you tried it for both cases po2 and npo2?

Because isn't include/generated/struct_page_size.h generated? At
which point does it get generated and why would the condition hole
true that the file exists at a new 'make menuconfig' time?

  Luis
