Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71464CF0B0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 05:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiCGEfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 23:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbiCGEfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 23:35:39 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0F44B1DB;
        Sun,  6 Mar 2022 20:34:45 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KBlww0yLvz4xvN;
        Mon,  7 Mar 2022 15:34:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646627684;
        bh=HWfJl9hYqrCA2vhppH6ZZDcSjtc7J/zxpYExdR+SdmQ=;
        h=Date:From:To:Cc:Subject:From;
        b=d8JWGXAEYbcy+EmR4hA5bPntgN51NSksgKSot5gYCypdHglcWWjAG/97qj2ra3ls5
         7SanbOI0nsQvAHx2LPNeEVm4kiPq04LP4GjDvM4O2YtHsYjUig8JXMVWXe9AiVTJce
         SyXRzjjhBkv6BUtuw85ciJyFsSooDZ3y1WtL5eVSx5jrrkesl47JqoopNjXH25J327
         2ebr4BDwMJ15Lb0GLC7k8qZuEyx6UHWMxbWuDzn5v6wNo83HZZX5MqG2+cf4P2nNmW
         VcBH5uoNCvafQ3lNZj/wKWzQEfYQ1fLyOVlDBEf30fvGFE2zY1YQh8elZ1Dibvb95j
         fCiK1dZF3xyEw==
Date:   Mon, 7 Mar 2022 15:34:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Xie Yongji <xieyongji@bytedance.com>
Subject: linux-next: manual merge of the vhost tree with the block tree
Message-ID: <20220307153439.191104dd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/..Tj0Z27CqNA25MYh4AiRf.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/..Tj0Z27CqNA25MYh4AiRf.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vhost tree got a conflict in:

  drivers/block/virtio_blk.c

between commit:

  24b45e6c2517 ("virtio_blk: simplify refcounting")

from the block tree and commit:

  e030759a1ddc ("virtio-blk: Remove BUG_ON() in virtio_queue_rq()")

from the vhost tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/block/virtio_blk.c
index 5c636ca7f1a7,8c415be86732..000000000000
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@@ -69,9 -69,13 +69,6 @@@ struct virtio_blk=20
  	/* Process context for config space updates */
  	struct work_struct config_work;
 =20
- 	/* What host tells us, plus 2 for header & tailer. */
- 	unsigned int sg_elems;
 -	/*
 -	 * Tracks references from block_device_operations open/release and
 -	 * virtio_driver probe/remove so this object can be freed once no
 -	 * longer in use.
 -	 */
 -	refcount_t refs;
--
  	/* Ida index - used to track minor number allocations. */
  	int index;
 =20

--Sig_/..Tj0Z27CqNA25MYh4AiRf.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIli18ACgkQAVBC80lX
0Gy+Zwf/YHFdp30tG+TgbGJ03ZKVrT+EmEQJccSGk7Pp+8IybsN0D/kSaGdwbwn3
6h9tCNUvMSEPDLWHJIypLv7F6cOAiQygjvgKszmFq3/AC6gtmkNA/wcSfDTLVUaB
izI9RLArj4ROuH77eNNf0+PJuGspErdkQFP/fDiRDkSCCFvY5nY48CLeZ5VbfA4L
E1YiR7/6R5lm9Qb7K06h8x+D9CE+3rFixPRjJPqnEpJ0jbfyVEO6t6mN5ZDEpnHB
st7t9EQKt2aKb4pXbuRBosJDtYJWV08IOKZ8pSruUxURC6NwWPlJgZBIEUhfH/WE
yj/P2D08TPq4sFCOTR+SSlvLXtdQeQ==
=WDRH
-----END PGP SIGNATURE-----

--Sig_/..Tj0Z27CqNA25MYh4AiRf.--
