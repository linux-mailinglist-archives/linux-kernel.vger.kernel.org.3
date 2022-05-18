Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D97552BC34
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbiEROJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbiEROJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:09:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BA8187DAB;
        Wed, 18 May 2022 07:09:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5345B820E3;
        Wed, 18 May 2022 14:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CB2C385A9;
        Wed, 18 May 2022 14:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652882939;
        bh=wzcmu1G8koPCKQdM0ZCd6UshnHAiOZecGxolrNIwL74=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uonAdrzpNQs0HZTXpIpLdX8qhNybyA2I8BAjHtcgbCyjVTtckOyeozTcDn1EY7/bm
         EE/uctpitm3Z9adKxutnMwDfIG3hKVSWZnOLqV/JbKTZzmcE7HF1klsCju0kZvFLPc
         6DPnrgwgeGbXPGYG4Z1k/4YyfPhHhgQgaYey7n0JfRGjVjxPGm74IXbzm1z2NNEP5o
         VG536SGup0BqYbwN2l34VYRv4eK6qGIY9Ec0eihbTfw69qSQUMRQFSx1dv9H16d/IQ
         FFt/nYUnjIrYM3XGtIH4xql59GfB+5Iac79oAPws0W57zli3jYH8xXWfRXibcwgSlg
         f3WaOR57tA88Q==
Message-ID: <9e6761899e81c8b7d91091403b5aab6e628e605a.camel@kernel.org>
Subject: Re: [PATCH] ceph: remove redundant variable ino
From:   Jeff Layton <jlayton@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 May 2022 10:08:57 -0400
In-Reply-To: <20220518085508.509104-1-colin.i.king@gmail.com>
References: <20220518085508.509104-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-18 at 09:55 +0100, Colin Ian King wrote:
> Variable ino is being assigned a value that is never read. The variable
> and assignment are redundant, remove it.
>=20
> Cleans up clang scan build warning:
> warning: Although the value stored to 'ino' is used in the enclosing
> expression, the value is never actually read from 'ino'
> [deadcode.DeadStores]
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  fs/ceph/mds_client.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 00c3de177dd6..20197f05faec 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -437,7 +437,7 @@ static int ceph_parse_deleg_inos(void **p, void *end,
>  	ceph_decode_32_safe(p, end, sets, bad);
>  	dout("got %u sets of delegated inodes\n", sets);
>  	while (sets--) {
> -		u64 start, len, ino;
> +		u64 start, len;
> =20
>  		ceph_decode_64_safe(p, end, start, bad);
>  		ceph_decode_64_safe(p, end, len, bad);
> @@ -449,7 +449,7 @@ static int ceph_parse_deleg_inos(void **p, void *end,
>  			continue;
>  		}
>  		while (len--) {
> -			int err =3D xa_insert(&s->s_delegated_inos, ino =3D start++,
> +			int err =3D xa_insert(&s->s_delegated_inos, start++,
>  					    DELEGATED_INO_AVAILABLE,
>  					    GFP_KERNEL);
>  			if (!err) {

Reviewed-by: Jeff Layton <jlayton@kernel.org>
