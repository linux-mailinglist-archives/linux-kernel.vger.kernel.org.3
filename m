Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B3D4CC141
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbiCCPaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiCCPaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:30:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D3AAA6440
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646321369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rNBuw1+Xpa+FBkyiSrIPjNNtAQwJlv38EX2K9FS9w6I=;
        b=TDG5hyDI6H3umCwA5zCqaQNGxyyz/+AU48jNOmDv1WJpW0ewJhW03vyRjuxpizsQpwEnKd
        Yi6PnvooXwX9PuaEDq9UouZncYj+LQIN/Bx3wXzX9oyIOAnCVQaVZtTIX+7pGbhl/AdN3l
        s9QDzlFIIpLFx5s16QfUrq/BN7xz3CQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-HRfv_pLRMFGubELwX2CEbA-1; Thu, 03 Mar 2022 10:29:24 -0500
X-MC-Unique: HRfv_pLRMFGubELwX2CEbA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8169824FA7;
        Thu,  3 Mar 2022 15:29:22 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EBC2106D5B0;
        Thu,  3 Mar 2022 15:29:22 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 2C3A34168B84; Thu,  3 Mar 2022 11:33:50 -0300 (-03)
Date:   Thu, 3 Mar 2022 11:33:50 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, frederic@kernel.org, tglx@linutronix.de,
        mgorman@suse.de, linux-rt-users@vger.kernel.org, vbabka@suse.cz,
        cl@linux.com, paulmck@kernel.org, willy@infradead.org
Subject: Re: [PATCH 1/2] mm/page_alloc: Access lists in 'struct
 per_cpu_pages' indirectly
Message-ID: <YiDRzgYkYV51TAGJ@fuller.cnet>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
 <20220208100750.1189808-2-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208100750.1189808-2-nsaenzju@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 11:07:49AM +0100, Nicolas Saenz Julienne wrote:
> In preparation to adding remote per-cpu page list drain support, let's
> bundle 'struct per_cpu_pages's' page lists and page count into a new
> structure: 'struct pcplists', and have all code access it indirectly
> through a pointer. It'll be used by upcoming patches in order to
> maintain multiple instances of 'pcplists' and switch the pointer
> atomically.
> 
> The 'struct pcplists' instance lives inside 'struct per_cpu_pages', and
> shouldn't be accessed directly. It is setup as such since these
> structures are used during early boot when no memory allocation is
> possible and to simplify memory hotplug code paths.
> 
> free_pcppages_bulk() and __rmqueue_pcplist()'s function signatures
> change a bit so as to accommodate these changes without affecting
> performance.
> 
> No functional change intended.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> ---
> 
> Changes since RFC:
>  - Add more info in commit message.
>  - Removed __private attribute, in hindsight doesn't really fit what
>    we're doing here.
>  - Use raw_cpu_ptr() where relevant to avoid warnings.
> 
>  include/linux/mmzone.h | 10 +++--
>  mm/page_alloc.c        | 87 +++++++++++++++++++++++++-----------------
>  mm/vmstat.c            |  6 +--
>  3 files changed, 62 insertions(+), 41 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 3fff6deca2c0..b4cb85d9c6e8 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -381,7 +381,6 @@ enum zone_watermarks {
>  
>  /* Fields and list protected by pagesets local_lock in page_alloc.c */
>  struct per_cpu_pages {
> -	int count;		/* number of pages in the list */
>  	int high;		/* high watermark, emptying needed */
>  	int batch;		/* chunk size for buddy add/remove */
>  	short free_factor;	/* batch scaling factor during free */
> @@ -389,8 +388,13 @@ struct per_cpu_pages {
>  	short expire;		/* When 0, remote pagesets are drained */
>  #endif
>  
> -	/* Lists of pages, one per migrate type stored on the pcp-lists */
> -	struct list_head lists[NR_PCP_LISTS];
> +	struct pcplists *lp;
> +	struct pcplists {
> +		/* Number of pages in the pcplists */
> +		int count;
> +		/* Lists of pages, one per migrate type stored on the pcp-lists */
> +		struct list_head lists[NR_PCP_LISTS];
> +	} __pcplists; /* Do not access directly */
>  };

Perhaps its useful to add something like: "should be acessed through ..."

Looks good otherwise.

