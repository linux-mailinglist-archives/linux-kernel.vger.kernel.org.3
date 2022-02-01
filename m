Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388F14A5888
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbiBAIa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbiBAIaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:30:23 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D10C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 00:30:22 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id x23so32339864lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 00:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ul3s4D/Hp2YNz1ehPnbUO3CCYBCPQRY60603bZrCUHg=;
        b=maBdNT8Jy5fUIq8duhY9BbnAsx1koD8nEsiEJgSxO0XEpcqUFAg6vcB7HRx58kKy+g
         v2LklwjvCMyJ1vY7gIHq8Ingp2/cKFo39Uzsz1I4fc7D2Q7S2M602gEcuGtxUBmJoYyN
         8yBieWWGzUgHl7/oEhmUPM06duJsTiyvGV23N1S5CqQG2CkY1fvteCL+tjpbKvXxM0wJ
         g+3ePXlLizEmhwUT8Z5bKn21OejDfTshRhhrfuTa+Ksnn2yHLW3t1BYf5Z6ckxrfsqrE
         h5mPEv6Hu2ZzAzQtWCqvxA3NoZ1x787YQGY7RktTv2nU6IAUXVfIP44mbl2Fhyddtbym
         ufEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ul3s4D/Hp2YNz1ehPnbUO3CCYBCPQRY60603bZrCUHg=;
        b=Mk1ygOC6H4XKpJAhdjWwV2jwVi5TMQ2a6XfTxobPvmq+wPiqqQoFssdPCa8ufA+ryh
         xrXDZ7fuT+RV1UMcFRHk3EX9Nwor/ZO0ttIG5W8q0qoloBcBNKANJdKh1O6h1n9Ik636
         yHeITAsS6VGMh2Oz2N9UMzAvQgNVZ+0+jE1fECU2PwkS/VTsrKiOgl5gTK50cW/2Bdek
         t6a7+D1x5vsMohuDlu2Ve7z90kNkSJeHsbQNIJTG4HfzaARrx+6WoT7O+jwmAV78nKTA
         8W9h7OPnbd3tvFjlQdbJ21RTl+aAC9Bc0UOm5S1SXL9DxxNxoIT5SkPOzuW+QmvVsaPz
         rvvg==
X-Gm-Message-State: AOAM532oeO61aB4NxLk7XR7GuMu/PaZSTWZooo0B41zlSkKv2tgFQjYx
        3dR4bk/wJjAhI379zGtCZVs=
X-Google-Smtp-Source: ABdhPJwP0XctlY9X3lZ9b/5KRaAEWdrfxdbA8ggY+BKga62pAjY3/B0FVDE7agE1BocsoEkvbiS47w==
X-Received: by 2002:a19:6a12:: with SMTP id u18mr18232631lfu.348.1643704220935;
        Tue, 01 Feb 2022 00:30:20 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id q5sm3985122lfg.77.2022.02.01.00.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 00:30:20 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 1 Feb 2022 09:30:18 +0100
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] mm/vmalloc.c: Fix "unused function" warning
Message-ID: <YfjvmuzHtslp/Jao@pc638.lan>
References: <20220129034652.75359-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129034652.75359-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> compute_subtree_max_size() is unused, when building with
> DEBUG_AUGMENT_PROPAGATE_CHECK=y.
> 
Nit: vice versa? It is only used when DEBUG_AUGMENT_PROPAGATE_CHECK=y

> mm/vmalloc.c:785:1: warning: unused function 'compute_subtree_max_size'
> [-Wunused-function].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  mm/vmalloc.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 028ce2b9bbf9..42d37b4bd351 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -778,17 +778,6 @@ get_subtree_max_size(struct rb_node *node)
>  	return va ? va->subtree_max_size : 0;
>  }
>  
> -/*
> - * Gets called when remove the node and rotate.
> - */
> -static __always_inline unsigned long
> -compute_subtree_max_size(struct vmap_area *va)
> -{
> -	return max3(va_size(va),
> -		get_subtree_max_size(va->rb_node.rb_left),
> -		get_subtree_max_size(va->rb_node.rb_right));
> -}
> -
>  RB_DECLARE_CALLBACKS_MAX(static, free_vmap_area_rb_augment_cb,
>  	struct vmap_area, rb_node, unsigned long, subtree_max_size, va_size)
>  
> @@ -978,6 +967,17 @@ unlink_va(struct vmap_area *va, struct rb_root *root)
>  }
>  
>  #if DEBUG_AUGMENT_PROPAGATE_CHECK
> +/*
> + * Gets called when remove the node and rotate.
> + */
> +static __always_inline unsigned long
> +compute_subtree_max_size(struct vmap_area *va)
> +{
> +	return max3(va_size(va),
> +		get_subtree_max_size(va->rb_node.rb_left),
> +		get_subtree_max_size(va->rb_node.rb_right));
> +}
> +
>  static void
>  augment_tree_propagate_check(void)
>  {
> -- 
> 2.20.1.7.g153144c
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Vlad Rezki
