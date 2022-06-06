Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5678053E0CB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 08:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiFFFar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 01:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiFFF3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 01:29:21 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54F38CCC8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 22:29:17 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id d128so2341937qkg.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 22:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=mUDpDjKHlw04ecDTJy1YcGz6mZ4dDlGdFM8mMbI+Q/g=;
        b=GIj3P35xR57PKTSk4ZTEZCARXsfcbJ3MbXbKAXxDYMggSfPnDFuaDWpqizSQnwAmnB
         pqOZxSEri0Gge/VZv5cAmqSGRGzX/b1QkIKw87m2Cu/rMzFMUWWsAKks2B7LDnUIbUZP
         W1ARt3os5tzG5OxRWGRkLJ7R9ofG7p+Z9SsbvVlpfQJqAT4Gb5xB1tu7MUbfPkJ/2CDa
         8QK/i53zXwnio1XDUgueM7aoFrzCwO4LxzrYWJYgBZXxtccZxJBN4r5s60ZFspQH++1W
         F+2bcFfSiUYI+HbIDL4kkAGqmE4HXDyWX4eSsqvxYEizacmWDaXP6xTyRlbDtozfdGmF
         2bZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=mUDpDjKHlw04ecDTJy1YcGz6mZ4dDlGdFM8mMbI+Q/g=;
        b=meb6VB+SsQDJuk+DSCn42SYZ6JU40S7QdwVbYOVwDFIH+nSJhmfq4gQHYpJKxsGw9M
         YEaSX4VuiTHiNqrmocBdf57xiToSbtALxNzzYGcROS4NW/jcmsr7NXl23fEWlpJMtTyl
         V32fTL4HMKD3xECDKbgx0E1QKWRQJRXWXFjhQJhDK7K5YcFIzZKPMk0zfPhnaRaYjCcR
         D5ka2OGcz8s5/9B6syZbZkPevYIvKBHJhk8/BEZr3seyY9uOY2nSSKRvEmlyN7T2I6mJ
         NUGnLAkvc1HIzM1TURAJkUyY7yk0y1hkGQgE6ShvY//BQG7TBV1kCRfHjjEIXZs3tVva
         YjQA==
X-Gm-Message-State: AOAM530X0IGtGZhAdpTOJFx8uPh9y1mdrKTzJ3cLWectA1rOdl9E7YuN
        KkuwUrVtFeyPSOAp3rNYbwjfciZgS+HclQ==
X-Google-Smtp-Source: ABdhPJwj8+ocTDAD/HiagwWcIXCHTKeeZm1CBi9/WN3i86qmNo6EF7kg9H2C5AJuyU2E4ygONDfaZA==
X-Received: by 2002:ac8:5fd0:0:b0:304:bd3d:d129 with SMTP id k16-20020ac85fd0000000b00304bd3dd129mr17181074qta.685.1654489202951;
        Sun, 05 Jun 2022 21:20:02 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bl17-20020a05620a1a9100b006a693056b0dsm7895096qkb.94.2022.06.05.21.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 21:20:01 -0700 (PDT)
Date:   Sun, 5 Jun 2022 21:19:49 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Chen Wandun <chenwandun@huawei.com>
cc:     hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        david@redhat.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v3 1/3] mm/shmem: check return value of
 shmem_init_inodecache
In-Reply-To: <20220606034530.153505-2-chenwandun@huawei.com>
Message-ID: <bc6accde-cd1f-8c44-2d94-9e6131b659b3@google.com>
References: <20220606034530.153505-1-chenwandun@huawei.com> <20220606034530.153505-2-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2022, Chen Wandun wrote:

> It will result in null pointer access if shmem_init_inodecache fail,
> so check return value of shmem_init_inodecache
> 
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>

Thank you, but NAK.

It's a pity that you've been put to the trouble of sending a v3, sorry
about that: but if SLAB_PANIC no longer works, or panic() has taken to
returning, then that's what needs fixing, not shmem_init_inodecache().

Was this one supposed to be the bugfix?  And I'm afraid I don't care
for your "cleanups" in 2/3 and 3/3 either: a matter of taste, and our
tastes differ.

I'd rather not spend the time on these: maybe look for somewhere else
to change around than mm/shmem.c?  Or better, please help us all by
using your time to review the functional patches being posted.

Thanks,
Hugh

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
