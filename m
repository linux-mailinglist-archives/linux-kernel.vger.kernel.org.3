Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C50548191
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238839AbiFMIKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239585AbiFMIKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:10:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34431E3DD;
        Mon, 13 Jun 2022 01:10:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3E03D1FAC2;
        Mon, 13 Jun 2022 08:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655107810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3gX01sey3U8CCSAGhSSb8DIikXknEWnqb+fuJzKhhcI=;
        b=xNzQJkhAxH68lbQ2fQKbUYQvw520KSkP1h5NHyYCvL/KKAqw0MQahh3QfTERcAu2lEiYZN
        ekxMgOXq41YFXsdwvcCIcIce9fxCLI7BY5tz+yRtkkFBFfzUAyJK/gKmXmzC81itEskvIb
        SShkxuSAMaGEuuz/4HODB/F5vQ37/dI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655107810;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3gX01sey3U8CCSAGhSSb8DIikXknEWnqb+fuJzKhhcI=;
        b=gLycz0xHDPt69/IdsWDlUKNzvabkzQy77VT/mTBzD2gVzeK0QyI+Te3W3864W5XbO9ah8X
        gU8uwyP/hlV7ajAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B331613443;
        Mon, 13 Jun 2022 08:10:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R5r+KOHwpmJMIgAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 13 Jun 2022 08:10:09 +0000
Date:   Mon, 13 Jun 2022 10:10:08 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/6] mm: hugetlb_vmemmap: optimize vmemmap_optimize_mode
 handling
Message-ID: <Yqbw4IYwtLQaoarB@localhost.localdomain>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
 <20220613063512.17540-3-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613063512.17540-3-songmuchun@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 02:35:08PM +0800, Muchun Song wrote:
> We hold an another reference to hugetlb_optimize_vmemmap_key when
> making vmemmap_optimize_mode on, because we use static_key to tell
> memory_hotplug that memory_hotplug.memmap_on_memory should be
> overridden.  However, this rule has gone when we have introduced
> SECTION_CANNOT_OPTIMIZE_VMEMMAP.  Therefore, we could simplify
> vmemmap_optimize_mode handling by not holding an another reference
> to hugetlb_optimize_vmemmap_key.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

LGTM, and it looks way nicer, so

Reviewed-by: Oscar Salvador <osalvador@suse.de>

One question below though

> -static enum vmemmap_optimize_mode vmemmap_optimize_mode =
> +static bool vmemmap_optimize_enabled =
>  	IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);

So, by default vmemmap_optimize_enabled will be on if we have
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON, but we can always override that
via cmdline, as below, right?


>  
> -static void vmemmap_optimize_mode_switch(enum vmemmap_optimize_mode to)
> -{
> -	if (vmemmap_optimize_mode == to)
> -		return;
> -
> -	if (to == VMEMMAP_OPTIMIZE_OFF)
> -		static_branch_dec(&hugetlb_optimize_vmemmap_key);
> -	else
> -		static_branch_inc(&hugetlb_optimize_vmemmap_key);
> -	WRITE_ONCE(vmemmap_optimize_mode, to);
> -}
> -
>  static int __init hugetlb_vmemmap_early_param(char *buf)
>  {
> -	bool enable;
> -	enum vmemmap_optimize_mode mode;
> -
> -	if (kstrtobool(buf, &enable))
> -		return -EINVAL;
> -
> -	mode = enable ? VMEMMAP_OPTIMIZE_ON : VMEMMAP_OPTIMIZE_OFF;
> -	vmemmap_optimize_mode_switch(mode);
> -
> -	return 0;
> +	return kstrtobool(buf, &vmemmap_optimize_enabled);
>  }
>  early_param("hugetlb_free_vmemmap", hugetlb_vmemmap_early_param);
>  
> @@ -103,7 +76,7 @@ static unsigned int optimizable_vmemmap_pages(struct hstate *h,
>  	unsigned long pfn = page_to_pfn(head);
>  	unsigned long end = pfn + pages_per_huge_page(h);
>  
> -	if (READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
> +	if (!READ_ONCE(vmemmap_optimize_enabled))
>  		return 0;
>  
>  	for (; pfn < end; pfn += PAGES_PER_SECTION) {
> @@ -155,7 +128,6 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>  
>  	if (!is_power_of_2(sizeof(struct page))) {
>  		pr_warn_once("cannot optimize vmemmap pages because \"struct page\" crosses page boundaries\n");
> -		static_branch_disable(&hugetlb_optimize_vmemmap_key);
>  		return;
>  	}
>  
> @@ -176,36 +148,13 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>  }
>  
>  #ifdef CONFIG_PROC_SYSCTL
> -static int hugetlb_optimize_vmemmap_handler(struct ctl_table *table, int write,
> -					    void *buffer, size_t *length,
> -					    loff_t *ppos)
> -{
> -	int ret;
> -	enum vmemmap_optimize_mode mode;
> -	static DEFINE_MUTEX(sysctl_mutex);
> -
> -	if (write && !capable(CAP_SYS_ADMIN))
> -		return -EPERM;
> -
> -	mutex_lock(&sysctl_mutex);
> -	mode = vmemmap_optimize_mode;
> -	table->data = &mode;
> -	ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
> -	if (write && !ret)
> -		vmemmap_optimize_mode_switch(mode);
> -	mutex_unlock(&sysctl_mutex);
> -
> -	return ret;
> -}
> -
>  static struct ctl_table hugetlb_vmemmap_sysctls[] = {
>  	{
>  		.procname	= "hugetlb_optimize_vmemmap",
> -		.maxlen		= sizeof(enum vmemmap_optimize_mode),
> +		.data		= &vmemmap_optimize_enabled,
> +		.maxlen		= sizeof(int),
>  		.mode		= 0644,
> -		.proc_handler	= hugetlb_optimize_vmemmap_handler,
> -		.extra1		= SYSCTL_ZERO,
> -		.extra2		= SYSCTL_ONE,
> +		.proc_handler	= proc_dobool,
>  	},
>  	{ }
>  };
> -- 
> 2.11.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
