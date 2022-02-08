Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5228A4AD673
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349525AbiBHLZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356080AbiBHKIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:08:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55842C03FEC1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 02:08:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 153041F387;
        Tue,  8 Feb 2022 10:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644314896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XmeLDl/J1mI/gB/JKUMLSDJLLe4Hs7OYJYeo3mn+Cmo=;
        b=sYr9Pb3vAIjysu0Gm3KSChFAGbSZSqkT7xOWY8lnVfmkZthFwQeVDxxct8ApVYiHXP/Ron
        Kl3aLSviu8BGN3MebxRLSLixqmv4tFfTqVkUIDZW1yO1XKBrDriZTDBW8kXv7//MLDzU5S
        ibq1U/gYGz9x46QcZpElNY5m4iKjduI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644314896;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XmeLDl/J1mI/gB/JKUMLSDJLLe4Hs7OYJYeo3mn+Cmo=;
        b=8/yfyyoBZtUZan7cTCKmjuo9j2pfwo4S01jcmj6XnTqkd5KCQ8Ll/aAt7VvvYh+GLa8RLB
        z7h5IlXS9frz3LCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B68C513BF9;
        Tue,  8 Feb 2022 10:08:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lw8HKQ9BAmJ0cAAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 08 Feb 2022 10:08:15 +0000
Date:   Tue, 8 Feb 2022 11:08:13 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm/memory_hotplug: clean up try_offline_node
Message-ID: <YgJBDaMf/lW2DCOS@localhost.localdomain>
References: <20220207133643.23427-1-linmiaohe@huawei.com>
 <20220207133643.23427-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207133643.23427-4-linmiaohe@huawei.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 09:36:42PM +0800, Miaohe Lin wrote:
> We can use helper macro node_spanned_pages to check whether node spans
> pages. And we can change the parameter of check_cpu_on_node to nid as
> that's what it really cares. Thus we can further get rid of the local
> variable pgdat and improve the readability a bit.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/memory_hotplug.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 140809e60e9a..4b9eef861ee4 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -2008,12 +2008,12 @@ static int get_nr_vmemmap_pages_cb(struct memory_block *mem, void *arg)
>  	return mem->nr_vmemmap_pages;
>  }
>  
> -static int check_cpu_on_node(pg_data_t *pgdat)
> +static int check_cpu_on_node(int nid)
>  {
>  	int cpu;
>  
>  	for_each_present_cpu(cpu) {
> -		if (cpu_to_node(cpu) == pgdat->node_id)
> +		if (cpu_to_node(cpu) == nid)
>  			/*
>  			 * the cpu on this node isn't removed, and we can't
>  			 * offline this node.
> @@ -2047,7 +2047,6 @@ static int check_no_memblock_for_node_cb(struct memory_block *mem, void *arg)
>   */
>  void try_offline_node(int nid)
>  {
> -	pg_data_t *pgdat = NODE_DATA(nid);
>  	int rc;
>  
>  	/*
> @@ -2055,7 +2054,7 @@ void try_offline_node(int nid)
>  	 * offline it. A node spans memory after move_pfn_range_to_zone(),
>  	 * e.g., after the memory block was onlined.
>  	 */
> -	if (pgdat->node_spanned_pages)
> +	if (node_spanned_pages(nid))
>  		return;
>  
>  	/*
> @@ -2067,7 +2066,7 @@ void try_offline_node(int nid)
>  	if (rc)
>  		return;
>  
> -	if (check_cpu_on_node(pgdat))
> +	if (check_cpu_on_node(nid))
>  		return;
>  
>  	/*
> -- 
> 2.23.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
