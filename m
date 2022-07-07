Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0EF56A089
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbiGGK4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiGGK4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:56:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D930157227;
        Thu,  7 Jul 2022 03:56:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D57A622D9;
        Thu,  7 Jul 2022 10:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4410C3411E;
        Thu,  7 Jul 2022 10:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657191370;
        bh=J4GcLqcgdvmONqst266pPe1HFsLQsjfx6IIxXUc1i4U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nRloD+1YBGcuF2ESMVZ4ZJfJcXjV4xbeUop/piaSIyFeS+VC0roWW2z5QoGj5JV9Z
         o73RSDFOHJiw5/uG6biabZr2bUNqsP2MN3OUNZM2NGu/47CN7QhSgNftZvAQqWC8mp
         +UIwT7hEznL+DDpCz7DfPOsGq4O6a37RQZlZ3bc2dTifaIZ8pVlXSxTl8hyPiAX+Ao
         9yyX6V2QXNdWOtTrGLEzl9JMBpBgvvi60rklQvwLuglALOpczBPyUDHJU0jX4G7SJF
         YJuMUBeVy33gYSACaVtRZxPyUAka+DZbXwyvOYNnVcCMOOBfuwlvBtGRsGzmiEn+pt
         vn8xh2uvNC4MQ==
Message-ID: <f60dacead3da4ab78edd225749d698f8e621f577.camel@kernel.org>
Subject: Re: [PATCH v3 2/2] afs: unlock the folio when vnode is marked
 deleted
From:   Jeff Layton <jlayton@kernel.org>
To:     xiubli@redhat.com, dhowells@redhat.com, idryomov@gmail.com
Cc:     marc.dionne@auristor.com, willy@infradead.org,
        keescook@chromium.org, kirill.shutemov@linux.intel.com,
        william.kucharski@oracle.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, vshankar@redhat.com
Date:   Thu, 07 Jul 2022 06:56:08 -0400
In-Reply-To: <20220707045112.10177-3-xiubli@redhat.com>
References: <20220707045112.10177-1-xiubli@redhat.com>
         <20220707045112.10177-3-xiubli@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-07-07 at 12:51 +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
>=20
> The check_write_begin() should unlock the folio if return non-zero,
> otherwise locked.
>=20
> URL: https://tracker.ceph.com/issues/56423
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  fs/afs/file.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/afs/file.c b/fs/afs/file.c
> index afacce797fb9..b23e7b5a48ad 100644
> --- a/fs/afs/file.c
> +++ b/fs/afs/file.c
> @@ -379,7 +379,13 @@ static int afs_check_write_begin(struct file *file, =
loff_t pos, unsigned len,
>  {
>  	struct afs_vnode *vnode =3D AFS_FS_I(file_inode(file));
> =20
> -	return test_bit(AFS_VNODE_DELETED, &vnode->flags) ? -ESTALE : 0;
> +	if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
> +		folio_unlock(*folio);
> +		folio_put(*folio);

Don't you also need this?

	*folio =3D NULL;

> +		return -ESTALE;
> +	}
> +
> +	return 0;
>  }
> =20
>  static void afs_free_request(struct netfs_io_request *rreq)

--=20
Jeff Layton <jlayton@kernel.org>
