Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9209453E7B0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbiFFJkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbiFFJj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:39:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2BC880C8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:39:54 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c196so12298040pfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 02:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZoeV4tpcFdbN8cau8WOm9bOYECWG4+biTPw4i5J/3P8=;
        b=5yjzNsesxMGmNfJnJ4tpJUll04Yw4Yc9v9h+QsYbnuKONz1XVn6mc1V3WiwyBYHLOP
         qRQlBMI7alp6/Nqt3j9irOOOMAItDxCXrWXUIdSSRwnu2joAbd77aSFWaZ/If4my/P6c
         b+ujnJpXa2sobCW2MeHMQfUtkyVsJNtIDiMmu4qpvJtwK2gmuFFo2IsZwBWV4mJzY+H6
         bemXPyE2S3KomEYaIOEVnsI12GcUID5NXHRem6ilHHIQX0fxt61jHJgJnK9uy0z3n0l1
         03kxTPz96bRjKHXtKsMzDyOCw43acft+E2a7HGHpF38ZmYyMsI9rTkgnrvwKOC05sBB5
         UG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZoeV4tpcFdbN8cau8WOm9bOYECWG4+biTPw4i5J/3P8=;
        b=cllQjKX4SWXe9JH3XLRuSd2i4HrRPE8JZgLsvCks/NZdHVj2qVjfoLz59lQeukkDbA
         4FZuuE0ZkiS9K638345LvXIlPgtkAPtOx5tJl0zK7/+aR4FpcxFkif4MWJEeFbFPitL8
         zmYPVvNSnAoJKUa9ljd68p0cvQzlP3fQhzU7fmPdVcyly88NkLMoHSRLAHTruGYUmpzO
         jIR/1gGXyptO6p8Nggs9G02KYI9Zkpoq5k2Uiu338WPlWYgVjumH+/1XxAIDOY2JXlb7
         topPXALuU2vR5j0DRhp0cC6jqsIQFFxEE7OJmNRTDsa9lAvrmqKJx7T3V5CW6LF1he0Y
         D6iQ==
X-Gm-Message-State: AOAM530e0I16UrTnaeeJeAvNxHje/bLK3YECKi4H/eVYbrsZq45bwjIQ
        nQa6kaqIPAgb2ggSr3cGPi6u1abw6cUp2g==
X-Google-Smtp-Source: ABdhPJy0FzNarVYUzkqKZm1/7nlsZc28TsYmoPhH7gv+7167cTq2V4jCaUHHN5ZlL4rTv9ws4CEcHg==
X-Received: by 2002:a63:8bc7:0:b0:3fc:b8ab:c612 with SMTP id j190-20020a638bc7000000b003fcb8abc612mr20114114pge.535.1654508394026;
        Mon, 06 Jun 2022 02:39:54 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:7cb7:47eb:4eca:56f3])
        by smtp.gmail.com with ESMTPSA id o4-20020a655bc4000000b003db610ebdd0sm10095283pgr.65.2022.06.06.02.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 02:39:53 -0700 (PDT)
Date:   Mon, 6 Jun 2022 17:39:48 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        david@redhat.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v3 1/3] mm/shmem: check return value of
 shmem_init_inodecache
Message-ID: <Yp3LZKJBkE4dE0/r@FVFYT0MHHV2J.googleapis.com>
References: <20220606034530.153505-1-chenwandun@huawei.com>
 <20220606034530.153505-2-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606034530.153505-2-chenwandun@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 11:45:28AM +0800, Chen Wandun wrote:
> It will result in null pointer access if shmem_init_inodecache fail,
> so check return value of shmem_init_inodecache
> 
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> ---
>  mm/shmem.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 12d45a03f7fc..7419ab219b97 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3775,11 +3775,16 @@ static void shmem_init_inode(void *foo)
>  	inode_init_once(&info->vfs_inode);
>  }
>  
> -static void shmem_init_inodecache(void)
> +static int shmem_init_inodecache(void)
>  {
>  	shmem_inode_cachep = kmem_cache_create("shmem_inode_cache",
>  				sizeof(struct shmem_inode_info),
>  				0, SLAB_PANIC|SLAB_ACCOUNT, shmem_init_inode);

NACK, we cannot dereference a NULL pointer since SLAB_PANIC is passed
to kmem_cache_create().

> +
> +	if (!shmem_inode_cachep)
> +		return -ENOMEM;
> +
> +	return 0;
>  }
>  
>  static void shmem_destroy_inodecache(void)
> @@ -3923,7 +3928,9 @@ void __init shmem_init(void)
>  {
>  	int error;
>  
> -	shmem_init_inodecache();
> +	error = shmem_init_inodecache();
> +	if (error)
> +		goto out2;
>  
>  	error = register_filesystem(&shmem_fs_type);
>  	if (error) {
> -- 
> 2.25.1
> 
> 
