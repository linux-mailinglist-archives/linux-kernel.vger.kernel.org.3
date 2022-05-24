Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C4C532F53
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 18:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbiEXQ7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 12:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiEXQ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 12:59:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB76D6E8FC;
        Tue, 24 May 2022 09:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35AA36141D;
        Tue, 24 May 2022 16:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D885C34100;
        Tue, 24 May 2022 16:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653411541;
        bh=k32M5bfCUFnFygn/Z63wbfvyD3ZA27qJmNHAvBdhOyM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=stWoBtRccCMJOXIQk8cvhxCmiDYQ8Jg5g6su0ZZt1O6aJaJRgUTe6BfFATc5HJteK
         DvqteQERZVkSrORl/2pvY1MTgJSLPcisadilXQbAZ052AGAO1EusbyqR+c5Mce72mx
         dF4fYPLwuJdscrguATO5yIssTz/FN0ACONu9lSXRqCBLya1X5z/7SsulMdZfteS20c
         6IPZ0/vTpNTcVDirbIiOASzlRjv2scVA0/EEjw2C4xl5gNKM2KtPIBhj1ylHOeq0Wz
         uXLjmXIuvVNtjvlxtgndojU1QRKKVSR1WXNjee9MkmlLz5jxJQn1X17Fso4gT3Ovob
         layzTYiWShmzA==
Message-ID: <abcdf2216946f436ca21b888882863c58d517b37.camel@kernel.org>
Subject: Re: [PATCH] ceph: use correct index when encoding client supported
 features
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 24 May 2022 12:58:59 -0400
In-Reply-To: <20220524160627.20893-1-lhenriques@suse.de>
References: <20220524160627.20893-1-lhenriques@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
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

On Tue, 2022-05-24 at 17:06 +0100, Lu=EDs Henriques wrote:
> Feature bits have to be encoded into the correct locations.  This hasn't
> been an issue so far because the only hole in the feature bits was in bit
> 10 (CEPHFS_FEATURE_RECLAIM_CLIENT), which is located in the 2nd byte.  Wh=
en
> adding more bits that go beyond the this 2nd byte, the bug will show up.
>=20
> Fixes: 9ba1e224538a ("ceph: allocate the correct amount of extra bytes fo=
r the session features")
> Signed-off-by: Lu=EDs Henriques <lhenriques@suse.de>
> ---
>  fs/ceph/mds_client.c | 7 +++++--
>  fs/ceph/mds_client.h | 2 --
>  2 files changed, 5 insertions(+), 4 deletions(-)
>=20
> I hope I got this code right.  I found this issue when trying to add an
> extra feature bit that would go beyond bit 15 and that wasn't showing up
> on the MDS side.
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 1bd3e1bb0fdf..77e742b6fd30 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1220,14 +1220,17 @@ static int encode_supported_features(void **p, vo=
id *end)
>  	if (count > 0) {
>  		size_t i;
>  		size_t size =3D FEATURE_BYTES(count);
> +		unsigned long bit;
> =20
>  		if (WARN_ON_ONCE(*p + 4 + size > end))
>  			return -ERANGE;
> =20
>  		ceph_encode_32(p, size);
>  		memset(*p, 0, size);
> -		for (i =3D 0; i < count; i++)
> -			((unsigned char*)(*p))[i / 8] |=3D BIT(feature_bits[i] % 8);
> +		for (i =3D 0; i < count; i++) {
> +			bit =3D feature_bits[i];
> +			((unsigned char *)(*p))[bit / 8] |=3D BIT(bit % 8);
> +		}

I wish we could just use __set_bit/__clear_bit here. It would be a lot
easier to reason this out. Your logic looks correct to me though.


>  		*p +=3D size;
>  	} else {
>  		if (WARN_ON_ONCE(*p + 4 > end))
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 33497846e47e..12901e3a6823 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -45,8 +45,6 @@ enum ceph_feature_type {
>  	CEPHFS_FEATURE_MULTI_RECONNECT,		\
>  	CEPHFS_FEATURE_DELEG_INO,		\
>  	CEPHFS_FEATURE_METRIC_COLLECT,		\
> -						\
> -	CEPHFS_FEATURE_MAX,			\
>  }
>  #define CEPHFS_FEATURES_CLIENT_REQUIRED {}
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
