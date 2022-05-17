Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23BA52AD01
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353044AbiEQUxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbiEQUxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:53:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B495251E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:53:48 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l14so6368pjk.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=F9ssLLexXjwDOPMl1uyDEcAvLZJX1HagvO9Hhxuuadw=;
        b=gb5DzCqmDDdu8Px5YRJDKHnTdUfkUa6/7qtgjPeu5QerkVYQkCngax3Kc2KoI5tonQ
         ZkZRqG5xaK1hpsXoI4gI2mJgd7mg8Ftv0weZrd2nzh8Xy7a7c8OnMAmuxr2Ow4cBf/v1
         Zo0rZEZc5/N3aKiZnOhhop34AiJtzX/M8Gtzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=F9ssLLexXjwDOPMl1uyDEcAvLZJX1HagvO9Hhxuuadw=;
        b=mdtz8oU/5oVpnW++9SeufcMKAO8tXo7RcQSEt/qkML+vRIqfYmtcdz4/yFBdFyoFZB
         kATcQIdIjGjeQ7nobkCTxzeli/aqcgK2IeOHYnYL8ROnOcle4X4Fy5PruQP17o1O5T5b
         hgGlmqUdEE/HgHU0uuemnv/z0JUuAnuKsf+PPm9xp3cDI+dKjsGnIcAFTgYV0U+WZILv
         Svbse5lSZ8JTV2I65wTAM3VJh8A0XKKAm1rX6Gxa8IOqAK02Qyyk2FTVm0fO71zwlxwf
         cWS+/SeWcpT2jo3hBbq5ooMVlq0/E5qG5okLK2s0WBcnU8tAkS/COaZmZx85PTYHfmKq
         zqgg==
X-Gm-Message-State: AOAM531I1iPoN9zMri6pqI5q8TERAlJDJNHImStgtp4N6xId+viwayzu
        FxFOdKySoqI4TJXniCREC8qoXQ==
X-Google-Smtp-Source: ABdhPJyYa48COfypHdG9ohFVs88YX0S0lGQ1nyZosE8HbUmfXM/DmSrTgkR/JwIIAAqz1eC002GRAQ==
X-Received: by 2002:a17:903:2286:b0:161:afab:f47d with SMTP id b6-20020a170903228600b00161afabf47dmr3624522plh.113.1652820827316;
        Tue, 17 May 2022 13:53:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p46-20020a056a0026ee00b00512e4b5af0fsm155723pfw.174.2022.05.17.13.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 13:53:46 -0700 (PDT)
Date:   Tue, 17 May 2022 13:53:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: new __write_overflow_field compiler warning
Message-ID: <202205171327.78B12807@keescook>
References: <d2ad3a3d7bdd794c6efb562d2f2b655fb67756b9.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2ad3a3d7bdd794c6efb562d2f2b655fb67756b9.camel@kernel.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 02:03:52PM -0400, Jeff Layton wrote:
> Hi Kees,

Hi!

> I'm hoping you can help with this. I recently updated to Fedora 36,
> which has gcc v12, and I've started seeing this warning pop up when
> compiling the ceph.ko:
> 
> In file included from ./include/linux/string.h:253,
>                  from ./include/linux/ceph/ceph_debug.h:7,
>                  from fs/ceph/inode.c:2:
> In function ‘fortify_memset_chk’,
>     inlined from ‘netfs_i_context_init’ at ./include/linux/netfs.h:326:2,
>     inlined from ‘ceph_alloc_inode’ at fs/ceph/inode.c:463:2:
> ./include/linux/fortify-string.h:242:25: warning: call to ‘__write_overflow_field’ declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
>   242 |                         __write_overflow_field(p_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This doesn't seem to happen with gcc v11. It looks like the code is
> doing the right thing. Is there something we need to fix how the netfs
> context gets initialized or is this a compiler problem?
> 
> FWIW: I'm using:
> 
>     gcc (GCC) 12.1.1 20220507 (Red Hat 12.1.1-1)

Yeah, GCC 12 got "smarter" about how deeply it can analyze object sizes.
Usually, this has been helpful. Other times, it's a bit weirder, like
here.

So this is resolving to:

static inline void netfs_i_context_init(struct inode *inode,
                                        const struct netfs_request_ops *ops)
{
        struct netfs_i_context *ctx = netfs_i_context(inode);

        memset(ctx, 0, sizeof(*ctx));
...

In the sense that the compiler is having trouble understanding this
object, it's due to the same "unexpected" manipulations that manifest in
other areas (randstruct) which got fixed recently:
https://lore.kernel.org/lkml/20220503205503.3054173-2-keescook@chromium.org/

But it seems randstruct is happy to look the other way here after the
(void *) cast, where as __builtin_object_size() (the work-horse of the
memcpy checking) is not. Hmpf.

Ignoring the linked change above (which doesn't change the warning
here), GCC is effectively seeing:

static inline void netfs_i_context_init(struct inode *inode,
                                        const struct netfs_request_ops *ops)
{
	struct netfs_i_context *ctx = (struct netfs_i_context *)(inode + 1);

	if (__builtin_object_size(ctx, 1) < sizeof(*ctx))
		__write_overflow_field(...)

And __builtin_object_size() see "ctx" as pointing past the end of a single
"struct inode" (i.e. there are zero bytes left in the original
structure).

However, I think we can solve both the FORTIFY and the randstruct
concerns by wrapping the conversions in container_of(). This passes for
me with -next (i.e. on top of the above linked change):

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 0c33b715cbfd..cce5a9b53a8a 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -286,6 +286,17 @@ extern void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 				 bool was_async, enum netfs_sreq_ref_trace what);
 extern void netfs_stats_show(struct seq_file *);
 
+/*
+ * The struct netfs_i_context instance must always follow the VFS inode,
+ * but existing users want to avoid a substructure name space, so just
+ * use this internally to perform the needed container_of() offset
+ * casting, which will keep both FORTIFY_SOURCE and randstruct happy.
+ */
+struct netfs_i_c_pair {
+	struct inode inode;
+	struct netfs_i_context ctx;
+};
+
 /**
  * netfs_i_context - Get the netfs inode context from the inode
  * @inode: The inode to query
@@ -295,7 +306,7 @@ extern void netfs_stats_show(struct seq_file *);
  */
 static inline struct netfs_i_context *netfs_i_context(struct inode *inode)
 {
-	return (void *)inode + sizeof(*inode);
+	return &container_of(inode, struct netfs_i_c_pair, inode)->ctx;
 }
 
 /**
@@ -307,7 +318,7 @@ static inline struct netfs_i_context *netfs_i_context(struct inode *inode)
  */
 static inline struct inode *netfs_inode(struct netfs_i_context *ctx)
 {
-	return (void *)ctx - sizeof(struct inode);
+	return &container_of(ctx, struct netfs_i_c_pair, ctx)->inode;
 }
 
 /**






-- 
Kees Cook
