Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCB654A897
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 07:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbiFNFM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 01:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiFNFMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 01:12:25 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155F0631F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 22:12:23 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o17so6846634pla.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 22:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ufPnLDgaYxht70tLLUiqZA8dThtkFoWrcgzlo7+rnvk=;
        b=0AIe2LL5xmtOlNhSILqjHDcZU7IdvM4jPiMIDm35r8c3YaR5D6nwtugk9Fy9q8DaUu
         X5+Hq5QdkI/s+PM6o+CkuRZILKZK+iajjLH37mtBG3Q49r6Z3n8YQ6FLd2Nz7amVIvKY
         lObfW1UTUg9SFwm0tpf6nZsp7UQU4WPoHad/h1Y7EwRv91Mksa7dNc07DFQXcyz+5QMJ
         /U/sKSHAV1CkV1vmPhSFy9Fl6w0jD7jj5b5pWhZJk3WWXt8O9byk0gk/ZUa4Wy44YAG3
         FzJWusijJA7in9u6jTinz2BrlmkqabhlRDh/wlQMmCCC8mrRB+ZU+JFjs1DjFY5seG77
         BARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ufPnLDgaYxht70tLLUiqZA8dThtkFoWrcgzlo7+rnvk=;
        b=u5zbuLcEb1It6x8KAVyeTXt5y59BwC9pAICAC3xz88U5BpuHNwVGGmQ//guCtv1HXv
         0L0UIWZ2CuVujJ+Jtlex0noTe5CjwY9w5krJ0oHwIdVFpj/q0bJhnuG8IuxD667zuHKy
         L0A0yrcNkQyoLf5XKP3CG34kigNbf2XKYVzT8LO/htHt1+jvCbVLE+OAd9XsB5IMTG+W
         2/jV7vf0V0chQWYBkbXVF1+Pfmy7rfN2GcS2CxLrqz0BLD3btZci5+ZcTe33W034NKj6
         eJF6ie+zMxvN8WL4FhSpHheg+RxxcGZdxNLiA29M+T+b5mowCEIPSSWareQ2crzSGt21
         hnhQ==
X-Gm-Message-State: AJIora+TK3/POyKntSnGjgnhIVvrMyFRfmGxe1Wt5BV2T9GiwN5g97BC
        cNijQxf/9XRiq+UkjmsSym0Zsg==
X-Google-Smtp-Source: AGRyM1tQwkW+HlUIhq6W6mrhyIk2sljgLbIYjCY1xRcIjccNFw0xruYrMV4U2QVGJ3dnCRA0b3CJGA==
X-Received: by 2002:a17:902:ec92:b0:166:3502:ecb1 with SMTP id x18-20020a170902ec9200b001663502ecb1mr2498151plg.62.1655183543347;
        Mon, 13 Jun 2022 22:12:23 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id 207-20020a6215d8000000b005183434ec84sm6594630pfv.145.2022.06.13.22.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 22:12:23 -0700 (PDT)
Date:   Tue, 14 Jun 2022 13:12:19 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        linmiaohe@huawei.com
Subject: Re: [PATCH v4 1/2] mm/memory-failure: introduce "hwpoisoned-pages"
 entry
Message-ID: <YqgYs75fD019NkUd@FVFYT0MHHV2J.usts.net>
References: <20220614043830.99607-1-pizhenwei@bytedance.com>
 <20220614043830.99607-2-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614043830.99607-2-pizhenwei@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 12:38:29PM +0800, zhenwei pi wrote:
> Add a new debug entry to show the number of hwpoisoned pages. And
> use module_get/module_put to manager this kernel module, don't allow
> to remove this module unless hwpoisoned-pages is zero.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  Documentation/vm/hwpoison.rst |  4 ++++
>  mm/hwpoison-inject.c          | 19 ++++++++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/vm/hwpoison.rst b/Documentation/vm/hwpoison.rst
> index c742de1769d1..c832a8b192d4 100644
> --- a/Documentation/vm/hwpoison.rst
> +++ b/Documentation/vm/hwpoison.rst
> @@ -155,6 +155,10 @@ Testing
>  	flag bits are defined in include/linux/kernel-page-flags.h and
>  	documented in Documentation/admin-guide/mm/pagemap.rst
>  
> +  hwpoisoned-pages

A bit weird to me. IIUC, this means the number of **software** poisoned
pages instead of **hardware**. The prefix "hw" may be not suitable.  How
about "poisoned-pages" (a little simplified), "poisoned-pfns" (keep the
name consistent with "corrupt-pfn" and "unpoison-pfn") or "swpoisoned-pages"
(sw means software)?

> +	The number of hwpoisoned pages. The hwpoison kernel module can not be
> +	removed unless this count is zero.
> +
>  * Architecture specific MCE injector
>  
>    x86 has mce-inject, mce-test
> diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
> index 5c0cddd81505..9e522ecedeef 100644
> --- a/mm/hwpoison-inject.c
> +++ b/mm/hwpoison-inject.c
> @@ -10,6 +10,7 @@
>  #include "internal.h"
>  
>  static struct dentry *hwpoison_dir;
> +static atomic_t hwpoisoned_pages;
>  
>  static int hwpoison_inject(void *data, u64 val)
>  {
> @@ -49,15 +50,28 @@ static int hwpoison_inject(void *data, u64 val)
>  inject:
>  	pr_info("Injecting memory failure at pfn %#lx\n", pfn);
>  	err = memory_failure(pfn, 0);
> +	if (!err) {
> +		WARN_ON(!try_module_get(THIS_MODULE));

__module_get() is enough since we already hold a refcount at open time.
This WARN_ON() will not be triggered unless something unexpected happens.

> +		atomic_inc(&hwpoisoned_pages);
> +	}
> +
>  	return (err == -EOPNOTSUPP) ? 0 : err;
>  }
>  
>  static int hwpoison_unpoison(void *data, u64 val)
>  {
> +	int ret;
> +
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> -	return unpoison_memory(val);
> +	ret = unpoison_memory(val);
> +	if (!ret) {
> +		atomic_dec(&hwpoisoned_pages);
> +		module_put(THIS_MODULE);
> +	}
> +
> +	return ret;
>  }
>  
>  DEFINE_DEBUGFS_ATTRIBUTE(hwpoison_fops, NULL, hwpoison_inject, "%lli\n");
> @@ -99,6 +113,9 @@ static int pfn_inject_init(void)
>  	debugfs_create_u64("corrupt-filter-flags-value", 0600, hwpoison_dir,
>  			   &hwpoison_filter_flags_value);
>  
> +	debugfs_create_atomic_t("hwpoisoned-pages", 0400, hwpoison_dir,
> +			   &hwpoisoned_pages);
> +
>  #ifdef CONFIG_MEMCG
>  	debugfs_create_u64("corrupt-filter-memcg", 0600, hwpoison_dir,
>  			   &hwpoison_filter_memcg);
> -- 
> 2.20.1
> 
> 
