Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BE152AE2D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiEQWco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiEQWck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:32:40 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B0D3E0F5;
        Tue, 17 May 2022 15:32:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BD640CE1D34;
        Tue, 17 May 2022 22:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AEFC385B8;
        Tue, 17 May 2022 22:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652826756;
        bh=+fGT+G+Sm41/oPKm1sHP2aDVVweBeZsmQEMpw6vMTw8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UH6jExUv2g5GqaSWS8bUWObiI+Xs5uLSeLchUYhu8G1EzG9xlniD/mDnX8sID2yxm
         fVsZKryGCdxYWNmqx+FguvXBUQ0irzLgXPZnfEozx2VEr6D8TA7r/n02nTJMA/vORV
         dqlzSi1KS6vTncbRKqn0oueyq5G+ymPMJ1HwT//kdljLvbnOOtRr1KJ25akxgbReqR
         pfCOoDRyT5xrOaZFDfV5qryEeQ+FCazthltaVald3RPHQoGPwygrI2sN3HCJxt9O7r
         0dxgy8RXVPRbxmQEIsE6aR8lK3wZPdhxR3qEYcXhav90pahYH1+l+nHslpKwKw3OID
         r2CLjKW5kKx2Q==
Message-ID: <4bbdac4563817326cc5777aa6ec5fcb366235492.camel@kernel.org>
Subject: Re: [PATCH] netfs: Use container_of() for offset casting
From:   Jeff Layton <jlayton@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Date:   Tue, 17 May 2022 18:32:34 -0400
In-Reply-To: <20220517210230.864239-1-keescook@chromium.org>
References: <20220517210230.864239-1-keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-17 at 14:02 -0700, Kees Cook wrote:
> While randstruct was satisfied with using an open-coded "void *" offset
> cast for the netfs_i_context <-> inode casting, __builtin_object_size()
> as used by FORTIFY_SOURCE was not as easily fooled. Switch to using
> an internally defined netfs_i_context/inode struct for doing a full
> container_of() casting. This keeps both randstruct and __bos() happy
> under GCC 12. Silences:
>=20
> In file included from ./include/linux/string.h:253,
>                  from ./include/linux/ceph/ceph_debug.h:7,
>                  from fs/ceph/inode.c:2:
> In function =E2=80=98fortify_memset_chk=E2=80=99,
>     inlined from =E2=80=98netfs_i_context_init=E2=80=99 at ./include/linu=
x/netfs.h:326:2,
>     inlined from =E2=80=98ceph_alloc_inode=E2=80=99 at fs/ceph/inode.c:46=
3:2:
> ./include/linux/fortify-string.h:242:25: warning: call to =E2=80=98__writ=
e_overflow_field=E2=80=99 declared with attribute warning:
> detected write beyond size of field (1st parameter); maybe use struct_gro=
up()? [-Wattribute-warning]
>   242 |                         __write_overflow_field(p_size_field, size=
);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
>=20
> Reported-by: Jeff Layton <jlayton@kernel.org>
> Link: https://lore.kernel.org/lkml/d2ad3a3d7bdd794c6efb562d2f2b655fb67756=
b9.camel@kernel.org
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> If this looks good I can add it to my hardening tree, or if you want to
> carry it, I can respin this without the earlier randstruct changes and
> drop that patch from my tree?
> ---
>  include/linux/netfs.h | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 0c33b715cbfd..cce5a9b53a8a 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -286,6 +286,17 @@ extern void netfs_put_subrequest(struct netfs_io_sub=
request *subreq,
>  				 bool was_async, enum netfs_sreq_ref_trace what);
>  extern void netfs_stats_show(struct seq_file *);
> =20
> +/*
> + * The struct netfs_i_context instance must always follow the VFS inode,
> + * but existing users want to avoid a substructure name space, so just
> + * use this internally to perform the needed container_of() offset
> + * casting, which will keep both FORTIFY_SOURCE and randstruct happy.
> + */
> +struct netfs_i_c_pair {
> +	struct inode inode;
> +	struct netfs_i_context ctx;
> +};
> +
>  /**
>   * netfs_i_context - Get the netfs inode context from the inode
>   * @inode: The inode to query
> @@ -295,7 +306,7 @@ extern void netfs_stats_show(struct seq_file *);
>   */
>  static inline struct netfs_i_context *netfs_i_context(struct inode *inod=
e)
>  {
> -	return (void *)inode + sizeof(*inode);
> +	return &container_of(inode, struct netfs_i_c_pair, inode)->ctx;
>  }
> =20
>  /**
> @@ -307,7 +318,7 @@ static inline struct netfs_i_context *netfs_i_context=
(struct inode *inode)
>   */
>  static inline struct inode *netfs_inode(struct netfs_i_context *ctx)
>  {
> -	return (void *)ctx - sizeof(struct inode);
> +	return &container_of(ctx, struct netfs_i_c_pair, ctx)->inode;
>  }
> =20
>  /**

This patch didn't apply cleanly for me to a recent tree, but I was able
to wiggle it into place and it seemed to work.

Tested-by: Jeff Layton <jlayton@kernel.org>
