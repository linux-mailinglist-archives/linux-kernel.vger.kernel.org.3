Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10354D4A99
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 15:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346032AbiCJOma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343903AbiCJOb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:31:28 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D0BCE93C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:27:54 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id s42so5292465pfg.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=16EU2uI6HLb48Q8DPOmV0IEu22CGFD8PTEoVAJ0C+vI=;
        b=MJLSKq6bfU6/V52yn0yrCkMUEwMPeIOu/yVvV4CGcjEh7AgaUVKzBE5Xebhe63n9AQ
         JQZ40GFhuqW/V5e+Ckjc0yYOs8CDYsnt4w9eVrEP8WiR/j1UxG/mQ/9q28SNF18ZlLfT
         r6uPigrlFFRGuX6w3RP//cYobkm5GzYGy/vI+kDkCHMQ7/jVjW5Rj86Ex0/b4Drk1CgT
         Z6vhvN3dTDFqM/fj27DqvwtqxhDjg8/SdL4uDqcuaV5/lwjdiJeDt7WAsvUrRQmVNW0/
         XYuw+aRqwPqz9D/3HVC0qb4T8tFNicykprUv4FG4Rwi8nfm80z9QSIz1MEOm6KV82E36
         rqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=16EU2uI6HLb48Q8DPOmV0IEu22CGFD8PTEoVAJ0C+vI=;
        b=WRX+fj7VNWGdtgPGDXpCLjQDr9bFkmylMYmXwS+KWdRdLov4caZhszvy2UXsq5IFpP
         msPkHQlEEbYN/Vr2Yx5+QxSTrID26n+BnHazrV/90Qs7Q0GUZxUZxJnQMh9zHnwVQU2d
         vY62w7H/uFkhfk/slBAhXBF9GQknlp/PzaN1rVlZ6tmVQhIrvOvIXPgYBzsQapir5bGw
         TYU2JcG1w2MnjzCVuNw8OZKwIk0nT4vjZ820GsvjpN5Vg1HvRx6F51U5IbabSKUr+DH4
         KNQeo4f1B78KeFmd3tju1l+N5kOWS9NlSo54qbWRlnRuVTtrb7UOjJcq/kJQxMFFMY3X
         1cVg==
X-Gm-Message-State: AOAM533POA+Yz8ku5I46tALRVxw3rTOwPOD8sdKjoJ7/TdBayxhuMs+f
        28hZGC81z0oP0ou++WIwXwA=
X-Google-Smtp-Source: ABdhPJzkKQdxFr3T2QClmS9N46NLM89+ekMz8n1zW7S/7WCn6Gr9MgNHt5tcMLGOno8j/eYNhESrIQ==
X-Received: by 2002:a63:87c2:0:b0:380:9259:e10e with SMTP id i185-20020a6387c2000000b003809259e10emr4156169pge.521.1646922474362;
        Thu, 10 Mar 2022 06:27:54 -0800 (PST)
Received: from odroid ([114.29.23.97])
        by smtp.gmail.com with ESMTPSA id j22-20020a17090a7e9600b001bc67215a52sm6054680pjl.56.2022.03.10.06.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 06:27:53 -0800 (PST)
Date:   Thu, 10 Mar 2022 14:27:47 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     sxwjean@me.com
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        longman@redhat.com, guro@fb.com, willy@infradead.org,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: Re: [PATCH v2 1/2] mm: slab: Delete unused SLAB_DEACTIVATED flag
Message-ID: <20220310142747.GA1166219@odroid>
References: <20220310140701.87908-1-sxwjean@me.com>
 <20220310140701.87908-2-sxwjean@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310140701.87908-2-sxwjean@me.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 10:07:00PM +0800, sxwjean@me.com wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> Since commit 9855609bde03 ("mm: memcg/slab: use a single set of
> kmem_caches for all accounted allocations") deleted all SLAB_DEACTIVATED
> users, therefore this flag is not needed any more, let's delete it.
> 

Looks nice!

Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  include/linux/slab.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 37bde99b74af..b6b3eed6c7c4 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -117,9 +117,6 @@
>  #define SLAB_RECLAIM_ACCOUNT	((slab_flags_t __force)0x00020000U)
>  #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */
>  
> -/* Slab deactivation flag */
> -#define SLAB_DEACTIVATED	((slab_flags_t __force)0x10000000U)
> -
>  /*
>   * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
>   *
> -- 
> 2.30.2
> 
> 
