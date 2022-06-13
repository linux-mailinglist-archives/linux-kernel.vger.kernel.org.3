Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB95548229
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239041AbiFMIdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiFMIdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:33:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5806A25ED;
        Mon, 13 Jun 2022 01:33:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 12ECB1F74A;
        Mon, 13 Jun 2022 08:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655109231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p577qqkGNM+YtsoofFUL3UzNKI8twXildO3X6IpGT8g=;
        b=oODkKERJipnIGzo/BnNlMVHmFGZlp0FnEzeqIPnFGDRFmxrF0N2CDdtwKZvzWvkUhLBRZE
        eBKqXP3z4V7hEzHliebaSsqsfMZ65cUEPWGDYSYOrxsLcsyF8J6YzOnSJDhccVR7Jea52G
        mvj+EB5TMaf/v1r5OpM3y71B0L/oBMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655109231;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p577qqkGNM+YtsoofFUL3UzNKI8twXildO3X6IpGT8g=;
        b=Hex085tRJvhzdgZf0mt9vxmsnKSEDT5rnQBlfmusPSWgC4d3G5BiYgupVBGeE/voVo8MMf
        w2XwGkzSCcsqHUAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F2DB13443;
        Mon, 13 Jun 2022 08:33:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f0MAHG72pmIwKwAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 13 Jun 2022 08:33:50 +0000
Date:   Mon, 13 Jun 2022 10:33:48 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 6/6] mm: hugetlb_vmemmap: improve hugetlb_vmemmap code
 readability
Message-ID: <Yqb2bA25HhLU/mpM@localhost.localdomain>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
 <20220613063512.17540-7-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613063512.17540-7-songmuchun@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 02:35:12PM +0800, Muchun Song wrote:
> -static __init int hugetlb_vmemmap_sysctls_init(void)
> +static int __init hugetlb_vmemmap_init(void)
>  {
> +	const struct hstate *h;
> +	bool optimizable = false;
> +
>  	/*
> -	 * If "struct page" crosses page boundaries, the vmemmap pages cannot
> -	 * be optimized.
> +	 * There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
> +	 * page structs that can be used when HVO is enabled.
>  	 */
> -	if (is_power_of_2(sizeof(struct page)))
> -		register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
> +	BUILD_BUG_ON(__NR_USED_SUBPAGE >= RESERVE_VMEMMAP_SIZE / sizeof(struct page));

I need to take another look, but from the first glance there is something
here that caught my eye.

> +
> +	for_each_hstate(h) {
> +		char buf[16];
> +		unsigned int size = 0;
> +
> +		if (hugetlb_vmemmap_optimizable(h))
> +			size = hugetlb_vmemmap_size(h) - RESERVE_VMEMMAP_SIZE;
> +		optimizable = size ? true : optimizable;

This feels weird, just use false instead of optimizable.

> +		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf,
> +				sizeof(buf));
> +		pr_info("%d KiB vmemmap can be optimized for a %s page\n",
> +			size / SZ_1K, buf);

I do not have a strong opinion but I wonder whether this brings a lot.


-- 
Oscar Salvador
SUSE Labs
