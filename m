Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D13C535DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344629AbiE0JyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237129AbiE0JyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:54:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6D42C66D
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:54:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 81E2A219B6;
        Fri, 27 May 2022 09:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653645245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IK3a6PD0qoSYqo7B1aTTxeKPPO7iWEIcopk7olsL2NM=;
        b=v2JTerWqC4yHSUi50CtZG5OnScairg/z16JtWHTdB2eev72vv+WSLPPzZ2QAf9Oxt22tpG
        9zqivY2b7epDCT/7bikdFSEV2pc6wd9tWvePCDyt8XeerAWyP6bwJtq43APzrp88oKcuSf
        XFIYzUiZzfVMJHBUy+4esIxtZHyc610=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653645245;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IK3a6PD0qoSYqo7B1aTTxeKPPO7iWEIcopk7olsL2NM=;
        b=igSTmGQnXR+ufWx3xXuSQN8vj+vCSf7aqGXzm7c7BXKszDLfKuViYMBiFBJh1zLwnXHpfU
        iGIqiVfSopJuLBBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B54113A84;
        Fri, 27 May 2022 09:54:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o1SUGb2fkGJOXwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 27 May 2022 09:54:05 +0000
Message-ID: <d66a0383-cbd5-7eda-bf62-5d11e4e82ec5@suse.cz>
Date:   Fri, 27 May 2022 11:54:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: hugetlb_vmemmap: fix
 CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220527081948.68832-1-songmuchun@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220527081948.68832-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/22 10:19, Muchun Song wrote:
> The following:
> 
>   commit 47010c040dec ("mm: hugetlb_vmemmap: cleanup CONFIG_HUGETLB_PAGE_FREE_VMEMMAP*")
> 
> forgot to update CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON used in
> vmemmap_optimize_mode to CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON.
> The result is we cannot enable hugetlb_optimize_vmemmap at boot time
> when we configure CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON. Fix
> it.
> 
> Reported-by: Vlastimil Babka <vbabka@suse.cz>
> Fixes: 47010c040dec ("mm: hugetlb_vmemmap: cleanup CONFIG_HUGETLB_PAGE_FREE_VMEMMAP*")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/hugetlb_vmemmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index fcd9f7872064..1089ea8a9c98 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -33,7 +33,7 @@ DEFINE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
>  EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
>  
>  static enum vmemmap_optimize_mode vmemmap_optimize_mode =
> -	IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON);
> +	IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
>  
>  static void vmemmap_optimize_mode_switch(enum vmemmap_optimize_mode to)
>  {

