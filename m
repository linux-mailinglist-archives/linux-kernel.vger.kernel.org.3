Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADF9573CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbiGMS4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGMS4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:56:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1A418B20;
        Wed, 13 Jul 2022 11:56:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AAB761DB8;
        Wed, 13 Jul 2022 18:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A53C34114;
        Wed, 13 Jul 2022 18:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657738577;
        bh=DIuWNzcmWsNV5L5d7k1v7k7Y+satjQp3+LA8NxaoCG0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B0v6JqijEJ0TEExOz66ZMsuxX0aYtzY8Sb5bYqrAmDA6BAKnBz2PR4v2KTQ64o+ox
         zCYZRTfjBKCo7J1mYZxhAlPlWjE9+kjZA7XqFUAyx8iPELVDRcKcbAepPZ8bhahZb3
         atA+8j+IVQIYIqtPimQwYysCGUkcGZukDxgtDzqOEW/TMu+0aSyIgT3YSgy1yNvcy9
         Cdp2n5vgfpWM8ZKDQGiOj8WQkIE7gFJiLLScMHCgYc4Uc1VSmBT/wOdxoSjrOZHy/K
         o+CHga83pOBCuAulGHCmqf4akf5OznfXph8viyRnqkwob/iHEvV6EvLBHtbkBVYGNT
         JDhYypan2H0og==
Message-ID: <5edd2424465dc97e15d3e4635c7011e5c789cef1.camel@kernel.org>
Subject: Re: [PATCH] ceph: fix up test_dummy_encryption handling for new
 mount API
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org,
        idryomov@gmail.com
Cc:     vshankar@redhat.com, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
Date:   Wed, 13 Jul 2022 14:56:15 -0400
In-Reply-To: <b82c4486-42ea-cdd1-8204-6dcc95836f72@redhat.com>
References: <20220713085641.50232-1-xiubli@redhat.com>
         <c280ce5cc43474aa17767530bf280045b128e7af.camel@kernel.org>
         <b82c4486-42ea-cdd1-8204-6dcc95836f72@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-07-13 at 20:55 +0800, Xiubo Li wrote:
> Hi Jeff,
>=20
> I am rebasing the 'wip-fscrypt' branch to the 'testing', and there is=20
> one commit conflicts:
>=20
> commit 81faddddbef409bcaa1aa3d89e59606cde94dab7
> Author: Jeff Layton <jlayton@kernel.org>
> Date:=A0=A0 Wed Dec 1 09:21:39 2021 -0500
>=20
>  =A0=A0=A0 ceph: add infrastructure for file encryption and decryption
>=20
>  =A0=A0=A0 ...and allow test_dummy_encryption to bypass content encryptio=
n
>  =A0=A0=A0 if mounted with test_dummy_encryption=3Dclear.
>=20
>  =A0=A0=A0 Reviewed-by: Xiubo Li <xiubli@redhat.com>
>  =A0=A0=A0 Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> And the conflicts are:
>=20
> [xiubli@fedora ]$ cat fs/ceph/super.h.rej
> --- fs/ceph/super.h
> +++ fs/ceph/super.h
> @@ -45,6 +45,7 @@
>  =A0#define CEPH_MOUNT_OPT_NOPAGECACHE=A0=A0=A0=A0 (1<<16) /* bypass page=
cache=20
> altogether */
>  =A0#define CEPH_MOUNT_OPT_SPARSEREAD=A0=A0=A0=A0=A0 (1<<17) /* always do=
 sparse=20
> reads */
>  =A0#define CEPH_MOUNT_OPT_TEST_DUMMY_ENC=A0 (1<<18) /* enable dummy=20
> encryption (for testing) */
> +#define CEPH_MOUNT_OPT_DUMMY_ENC_CLEAR (1<<19) /* don't actually=20
> encrypt content */
>=20
>  =A0#define CEPH_MOUNT_OPT_DEFAULT=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 \
>  =A0=A0=A0=A0 (CEPH_MOUNT_OPT_DCACHE |=A0=A0=A0 =A0=A0=A0 \
>=20
> [xiubli@fedora ]$ cat fs/ceph/super.c.rej
> --- fs/ceph/super.c
> +++ fs/ceph/super.c
> @@ -1098,6 +1098,14 @@ static int ceph_set_test_dummy_encryption(struct=
=20
> super_block *sb, struct fs_cont
>  =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return -EEXIST;
>  =A0=A0=A0=A0 =A0=A0=A0 }
>=20
> +=A0=A0=A0 =A0=A0=A0 /* HACK: allow for cleartext "encryption" in files f=
or testing */
> +=A0=A0=A0 =A0=A0=A0 if (fsc->mount_options->test_dummy_encryption &&
> + !strcmp(fsc->mount_options->test_dummy_encryption, "clear")) {
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 fsopt->flags |=3D CEPH_MOUNT_OPT_DUMMY_ENC=
_CLEAR;
> + kfree(fsc->mount_options->test_dummy_encryption);
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 fsc->mount_options->test_dummy_encryption =
=3D NULL;
> +=A0=A0=A0 =A0=A0=A0 }
> +
>  =A0=A0=A0=A0 =A0=A0=A0 err =3D fscrypt_set_test_dummy_encryption(sb,
> fsc->mount_options->test_dummy_encryption,
>  =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=
 &fsc->dummy_enc_policy);
>=20
> And I have pushed the tmp patches to=20
> https://github.com/lxbsz/ceph-client/commits/lxb-wip-fscrypt3.
>=20
> Please take a look is that okay ?
>=20
> Thanks
>=20
> -- Xiubo
>=20
>=20

The result looks good to me. Thanks for fixing this up.

--=20
Jeff Layton <jlayton@kernel.org>
