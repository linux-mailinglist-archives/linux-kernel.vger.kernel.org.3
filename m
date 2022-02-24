Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F154C265B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiBXIgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiBXIgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:36:53 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F7126F4D5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:36:24 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A506E21115;
        Thu, 24 Feb 2022 08:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645691782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9kxeMpmspxDnMPyUwwwglML2VZu3aREU/aXhTjOO0II=;
        b=hXnAV7FJ9LTqyCSI73ZNNagLQq/kYhrpqsSqwH3Ldqm+docdyf0SgGSo2VgrHBUNRJLSz3
        +9h7bzd8v1uzsuDevmz9FCgi3dBQ5OahEzFYrmReSJHIg9vRI5gxGV1leiCaJLC2QF+jS2
        Jo/xO+XIFuwpWw+uWxZJ1GED3vh5ClM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 65634A3B83;
        Thu, 24 Feb 2022 08:36:15 +0000 (UTC)
Date:   Thu, 24 Feb 2022 09:36:19 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, ccross@google.com,
        sumit.semwal@linaro.org, dave.hansen@intel.com,
        keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, ebiederm@xmission.com, brauner@kernel.org,
        legion@kernel.org, ran.xiaokai@zte.com.cn, sashal@kernel.org,
        chris.hyser@oracle.com, dave@stgolabs.net, pcc@google.com,
        caoxiaofeng@yulong.com, david@redhat.com, gorcunov@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/3] mm: refactor vm_area_struct::anon_vma_name usage
 code
Message-ID: <YhdDg1oPpI7bkshf@dhcp22.suse.cz>
References: <20220223153613.835563-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223153613.835563-1-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-02-22 07:36:11, Suren Baghdasaryan wrote:
> Avoid mixing strings and their anon_vma_name referenced pointers
> by using struct anon_vma_name whenever possible. This simplifies
> the code and allows easier sharing of anon_vma_name structures when
> they represent the same name.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

LGTM
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks and one minor nit below

[...]
> +static inline void free_anon_vma_name(struct vm_area_struct *vma)
>  {
> -	const char *vma_name = vma_anon_name(vma);
> +	/*
> +	 * Not using anon_vma_name because it generates a warning if vma->vm_mm
> +	 * is not held, which might be the case here.

s@vma->vm_mm@mmap_lock@

> +	 */
> +	if (!vma->vm_file)
> +		anon_vma_name_put(vma->anon_name);
> +}
>  
> -	/* either both NULL, or pointers to same string */
> -	if (vma_name == name)

-- 
Michal Hocko
SUSE Labs
