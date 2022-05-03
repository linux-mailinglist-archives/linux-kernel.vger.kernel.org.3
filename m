Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75295519044
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbiECVfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiECVfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:35:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0ED62F02A;
        Tue,  3 May 2022 14:32:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81182B81A99;
        Tue,  3 May 2022 21:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB6DC385B2;
        Tue,  3 May 2022 21:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651613520;
        bh=oUV5PgMCLnoqfU3So5a2m7tM/4sVepUMn+p9KajRc7Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=V3SnkDsUjFOaPhiHQKb0RBPCoZKSlMCLEd43Dgm6LRlKy+tZUmPyE8ygzHJvQtwD0
         lYCHWR4Cxz44hLEkS8YjazrKWwRUXOYsMuyOJYRfDuS3EBx1tgRb0y/dyf8XkUF21A
         zM6CqVdJXZMjtWyqZHUM5lFfNfId+5KRabM7ZNAs2eTAsK6OlbRt/6YF4+fEPS+rjv
         nPe+aIHnM/esQTQiUZ5AheF8VuZq7pe+sqHp4Dfodf6vsYR915ZVb6EjCvN37WIWB5
         b5Zu1QZfJ8+0J4ET7YIQlyp9hHpY6OO6CVBwgKHQdvVyiHAXan0B0S68ojJp0upkT6
         Ea2RwA/CBQ51g==
Message-ID: <7562f8eccd7cc0e447becfe9912179088784e3b9.camel@kernel.org>
Subject: Re: [PATCH 1/6] netfs: Eliminate Clang randstruct warning
From:   Jeff Layton <jlayton@kernel.org>
To:     Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>
Cc:     David Howells <dhowells@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Date:   Tue, 03 May 2022 17:31:57 -0400
In-Reply-To: <20220503205503.3054173-2-keescook@chromium.org>
References: <20220503205503.3054173-1-keescook@chromium.org>
         <20220503205503.3054173-2-keescook@chromium.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-03 at 13:54 -0700, Kees Cook wrote:
> Clang's structure layout randomization feature gets upset when it sees
> struct inode (which is randomized) cast to struct netfs_i_context. This
> is due to seeing the inode pointer as being treated as an array of inodes,
> rather than "something else, following struct inode".
> 
> Since netfs can't use container_of() (since it doesn't know what the
> true containing struct is), it uses this direct offset instead. Adjust
> the code to better reflect what is happening: an arbitrary pointer is
> being adjusted and cast to something else: use a "void *" for the math.
> The resulting binary output is the same, but Clang no longer sees an
> unexpected cross-structure cast:
> 
> In file included from ../fs/nfs/inode.c:50:
> In file included from ../fs/nfs/fscache.h:15:
> In file included from ../include/linux/fscache.h:18:
> ../include/linux/netfs.h:298:9: error: casting from randomized structure pointer type 'struct inode *' to 'struct netfs_i_context *'
>         return (struct netfs_i_context *)(inode + 1);
>                ^
> 1 error generated.
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/netfs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index c7bf1eaf51d5..0c33b715cbfd 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -295,7 +295,7 @@ extern void netfs_stats_show(struct seq_file *);
>   */
>  static inline struct netfs_i_context *netfs_i_context(struct inode *inode)
>  {
> -	return (struct netfs_i_context *)(inode + 1);
> +	return (void *)inode + sizeof(*inode);
>  }
>  
>  /**
> @@ -307,7 +307,7 @@ static inline struct netfs_i_context *netfs_i_context(struct inode *inode)
>   */
>  static inline struct inode *netfs_inode(struct netfs_i_context *ctx)
>  {
> -	return ((struct inode *)ctx) - 1;
> +	return (void *)ctx - sizeof(struct inode);
>  }
>  
>  /**

Looks reasonable.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
