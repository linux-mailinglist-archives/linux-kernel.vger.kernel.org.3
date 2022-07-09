Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7402956C4D9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiGIA2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 20:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiGIA2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 20:28:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12ECE89ABE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 17:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657326482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VqagCGGOArSSKttB2fwy8srfsq7eT/Kvr2QKgNbXV6Y=;
        b=VnLrCl3T4PftH/Ghu/W3/q8QbsyhGrRGrquEg9Zc71mywd18QhJRrmDzz3AQuA3a6vpngl
        fSC2AbHIEg0UyD1a+1kgRLGFIXqgFhNZRDFfP+ShdBoPEoVl5KKpCIS0h+VgNmeO/+9pZi
        ltK1RYlVrXXr3SAUOx1Wb54+hpsnDfE=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-UmPdgMx2MXeuH9MP4_Ns9A-1; Fri, 08 Jul 2022 20:27:55 -0400
X-MC-Unique: UmPdgMx2MXeuH9MP4_Ns9A-1
Received: by mail-pg1-f197.google.com with SMTP id 196-20020a6300cd000000b0040c9c64e7e4so177164pga.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 17:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VqagCGGOArSSKttB2fwy8srfsq7eT/Kvr2QKgNbXV6Y=;
        b=2pz2juvILszKCzYqY6qT/UJVNeIPAU24998KBPeSfJ5ufd17dmcoQ8Q11j+NJ6mG7d
         DSs8kRD+aT6AIIw0ctv5gd1G9/H4hldqCi4skrhPZY6ZUh8uHhX4cPjrz1OTAXHuQCAR
         UmqFbit2Dfn+8mv69OGSYYSmltoahBryQzWL1/3EXIJi4U3KU1yyiECI+t3zjfj1lVE1
         RcunzHf6QlJsjPkvXXJI+ziNnVQYxVGL0WtD7X8X6KRTRdcXA1gEUqHlJeiyNSBMfD0F
         eXWTOyqRO3VJ1ZdRTHpip2aNZicCM/K4kzFeryUaBGy2AqHjdvL2lZZHSd+BW+pfI6/H
         2kEg==
X-Gm-Message-State: AJIora/JdtvdsywQ6ea5XVskMWGB2NbdbkbQtWE+G8zBvZOP29lDPrIv
        xkbtFxIg+JFKxWyzzLXtBi5gq2AFeS+znhMdHXbqji60Qza6KBBKOlZBpULDu/UZpC0KVmapAqb
        DGK76EI1fdT792mebkmNP0gaZ
X-Received: by 2002:a63:2c10:0:b0:411:4fd8:9fc8 with SMTP id s16-20020a632c10000000b004114fd89fc8mr5608133pgs.313.1657326471373;
        Fri, 08 Jul 2022 17:27:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vxRqN/Gl6aAva1cQn2NAPLkn1NgiDNiUrFkyIPxBfDK+V2dPkQ2tzi3aQSAe787G9ZM4cBrA==
X-Received: by 2002:a63:2c10:0:b0:411:4fd8:9fc8 with SMTP id s16-20020a632c10000000b004114fd89fc8mr5608116pgs.313.1657326471035;
        Fri, 08 Jul 2022 17:27:51 -0700 (PDT)
Received: from [10.72.12.227] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w29-20020aa79a1d000000b0052513b5d078sm184934pfj.31.2022.07.08.17.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 17:27:50 -0700 (PDT)
Subject: Re: [PATCH v4] netfs: do not unlock and put the folio twice
To:     David Howells <dhowells@redhat.com>
Cc:     idryomov@gmail.com, jlayton@kernel.org, marc.dionne@auristor.com,
        willy@infradead.org, keescook@chromium.org,
        kirill.shutemov@linux.intel.com, william.kucharski@oracle.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cachefs@redhat.com,
        vshankar@redhat.com
References: <20220707045112.10177-1-xiubli@redhat.com>
 <2520851.1657200105@warthog.procyon.org.uk>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <4597bdc0-b7bf-c30f-ea4a-41599adeed86@redhat.com>
Date:   Sat, 9 Jul 2022 08:27:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2520851.1657200105@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/7/22 9:21 PM, David Howells wrote:
> Here's my take on this.  I've made the error: path handle folio == NULL, so
> you don't need to split that error case.  I've also changed
> ->check_write_begin() so that it returns 0, not -EAGAIN, if we drop the folio;
> the process is retried then if the folio pointer got cleared.
>
> As a result, you don't have to discard the page if you want to return an error
> and thus don't need the additional afs patch
>
> David
> ---
> commit 8489c89f6a186272593ab5e3fffbd47ea21185b7
> Author: Xiubo Li <xiubli@redhat.com>
> Date:   Thu Jul 7 12:51:11 2022 +0800
>
>      netfs: do not unlock and put the folio twice
>      
>      check_write_begin() will unlock and put the folio when return
>      non-zero.  So we should avoid unlocking and putting it twice in
>      netfs layer.
>      
>      Change the way ->check_write_begin() works in the following two ways:
>      
>       (1) Pass it a pointer to the folio pointer, allowing it to unlock and put
>           the folio prior to doing the stuff it wants to do, provided it clears
>           the folio pointer.
>      
>       (2) Change the return values such that 0 with folio pointer set means
>           continue, 0 with folio pointer cleared means re-get and all error
>           codes indicating an error (no special treatment for -EAGAIN).
>      
>      Link: https://tracker.ceph.com/issues/56423
>      Link: https://lore.kernel.org/r/20220707045112.10177-2-xiubli@redhat.com/
>      Signed-off-by: Xiubo Li <xiubli@redhat.com>
>      Co-developed-by: David Howells <dhowells@redhat.com>
>      Signed-off-by: David Howells <dhowells@redhat.com>
>
> diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
> index 4d19b19bcc08..89085e1c22db 100644
> --- a/Documentation/filesystems/netfs_library.rst
> +++ b/Documentation/filesystems/netfs_library.rst
> @@ -301,7 +301,7 @@ through which it can issue requests and negotiate::
>   		void (*issue_read)(struct netfs_io_subrequest *subreq);
>   		bool (*is_still_valid)(struct netfs_io_request *rreq);
>   		int (*check_write_begin)(struct file *file, loff_t pos, unsigned len,
> -					 struct folio *folio, void **_fsdata);
> +					 struct folio **_folio, void **_fsdata);
>   		void (*done)(struct netfs_io_request *rreq);
>   	};
>   
> @@ -381,8 +381,10 @@ The operations are as follows:
>      allocated/grabbed the folio to be modified to allow the filesystem to flush
>      conflicting state before allowing it to be modified.
>   
> -   It should return 0 if everything is now fine, -EAGAIN if the folio should be
> -   regrabbed and any other error code to abort the operation.
> +   It may unlock and discard the folio it was given and set the caller's folio
> +   pointer to NULL.  It should return 0 if everything is now fine (*_folio
> +   left set) or the op should be retried (*_folio cleared) and any other error
> +   code to abort the operation.
>   
>    * ``done``
>   
> diff --git a/fs/afs/file.c b/fs/afs/file.c
> index 42118a4f3383..afacce797fb9 100644
> --- a/fs/afs/file.c
> +++ b/fs/afs/file.c
> @@ -375,7 +375,7 @@ static int afs_begin_cache_operation(struct netfs_io_request *rreq)
>   }
>   
>   static int afs_check_write_begin(struct file *file, loff_t pos, unsigned len,
> -				 struct folio *folio, void **_fsdata)
> +				 struct folio **folio, void **_fsdata)
>   {
>   	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
>   
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 6dee88815491..ab070a24ca23 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -63,7 +63,7 @@
>   	 (CONGESTION_ON_THRESH(congestion_kb) >> 2))
>   
>   static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, unsigned int len,
> -					struct folio *folio, void **_fsdata);
> +					struct folio **folio, void **_fsdata);
>   
>   static inline struct ceph_snap_context *page_snap_context(struct page *page)
>   {
> @@ -1288,18 +1288,19 @@ ceph_find_incompatible(struct page *page)
>   }
>   
>   static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, unsigned int len,
> -					struct folio *folio, void **_fsdata)
> +					struct folio **folio, void **_fsdata)
>   {
>   	struct inode *inode = file_inode(file);
>   	struct ceph_inode_info *ci = ceph_inode(inode);
>   	struct ceph_snap_context *snapc;
>   
> -	snapc = ceph_find_incompatible(folio_page(folio, 0));
> +	snapc = ceph_find_incompatible(folio_page(*folio, 0));
>   	if (snapc) {
>   		int r;
>   
> -		folio_unlock(folio);
> -		folio_put(folio);
> +		folio_unlock(*folio);
> +		folio_put(*folio);
> +		*folio = NULL;
>   		if (IS_ERR(snapc))
>   			return PTR_ERR(snapc);
>   
> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> index 42f892c5712e..69bbf1c25cf4 100644
> --- a/fs/netfs/buffered_read.c
> +++ b/fs/netfs/buffered_read.c
> @@ -319,8 +319,9 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
>    * conflicting writes once the folio is grabbed and locked.  It is passed a
>    * pointer to the fsdata cookie that gets returned to the VM to be passed to
>    * write_end.  It is permitted to sleep.  It should return 0 if the request
> - * should go ahead; unlock the folio and return -EAGAIN to cause the folio to
> - * be regot; or return an error.
> + * should go ahead or it may return an error.  It may also unlock and put the
> + * folio, provided it sets *_folio to NULL, in which case a return of 0 will
> + * cause the folio to be re-got and the process to be retried.
>    *
>    * The calling netfs must initialise a netfs context contiguous to the vfs
>    * inode before calling this.
> @@ -348,13 +349,13 @@ int netfs_write_begin(struct netfs_inode *ctx,
>   
>   	if (ctx->ops->check_write_begin) {
>   		/* Allow the netfs (eg. ceph) to flush conflicts. */
> -		ret = ctx->ops->check_write_begin(file, pos, len, folio, _fsdata);
> +		ret = ctx->ops->check_write_begin(file, pos, len, &folio, _fsdata);
>   		if (ret < 0) {
>   			trace_netfs_failure(NULL, NULL, ret, netfs_fail_check_write_begin);
> -			if (ret == -EAGAIN)
> -				goto retry;
>   			goto error;
>   		}
> +		if (!folio)
> +			goto retry;
>   	}
>   
>   	if (folio_test_uptodate(folio))
> @@ -416,8 +417,10 @@ int netfs_write_begin(struct netfs_inode *ctx,
>   error_put:
>   	netfs_put_request(rreq, false, netfs_rreq_trace_put_failed);
>   error:
> -	folio_unlock(folio);
> -	folio_put(folio);
> +	if (folio) {
> +		folio_unlock(folio);
> +		folio_put(folio);
> +	}
>   	_leave(" = %d", ret);
>   	return ret;
>   }
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 1773e5df8e65..6ab5d56dac74 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -214,7 +214,7 @@ struct netfs_request_ops {
>   	void (*issue_read)(struct netfs_io_subrequest *subreq);
>   	bool (*is_still_valid)(struct netfs_io_request *rreq);
>   	int (*check_write_begin)(struct file *file, loff_t pos, unsigned len,
> -				 struct folio *folio, void **_fsdata);
> +				 struct folio **_folio, void **_fsdata);
>   	void (*done)(struct netfs_io_request *rreq);
>   };
>   
>
This version looks good to me.

Thanks David!


