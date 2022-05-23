Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624F453137D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbiEWQTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbiEWQTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:19:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAD166CAA;
        Mon, 23 May 2022 09:19:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E257B81023;
        Mon, 23 May 2022 16:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515BFC385A9;
        Mon, 23 May 2022 16:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653322769;
        bh=f7EDB1tZHHZwuHj5NBq247JOSdGsH/WOgFLSR3GIRJ8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cOo9iC6hjPhXQnOrApO6acJmmmrSyTtlvc4qA/AW3WIgsvw1i8yXhjQD+tVxD32U9
         xbrmpbjVggsrJ65S1y1caO3tQS3L/ttaqiJ6S2se7myZM5BY5gFpFrAypNbnw58Oza
         1iU0ZuP3uutfLhL7s7hKepIFHi8aPTm+U+cgpoAJwE5Op+9qVIv2jHgBhpStM8e/KA
         puIK79CJNhvogddI1661JIlYXmNdDlKUK/jUC9I5tjiW2j9nKZ7QR03OchX/iRJATk
         8v7fYstRruUXWQmMJI40wQmeTqMO1ZegiL2FBkP5wzyLyxknqtLTLTV2SzhwIB+fVw
         7vd9sMRuYmPKg==
Message-ID: <1e1f7397d516f8b9780b08763f6338cd4ce83506.camel@kernel.org>
Subject: Re: [PATCH] ceph: fix decoding of client session messages flags
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 23 May 2022 12:19:27 -0400
In-Reply-To: <20220523160951.8781-1-lhenriques@suse.de>
References: <20220523160951.8781-1-lhenriques@suse.de>
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

On Mon, 2022-05-23 at 17:09 +0100, Lu=EDs Henriques wrote:
> The cephfs kernel client started to show  the message:
>=20
>  ceph: mds0 session blocklisted
>=20
> when mounting a filesystem.  This is due to the fact that the session
> messages are being incorrectly decoded: the skip needs to take into
> account the 'len'.
>=20
> While there, fixed some whitespaces too.
>=20
> Fixes: e1c9788cb397 ("ceph: don't rely on error_string to validate blockl=
isted session.")
> Signed-off-by: Lu=EDs Henriques <lhenriques@suse.de>
> ---
>  fs/ceph/mds_client.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 00c3de177dd6..1bd3e1bb0fdf 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3375,13 +3375,17 @@ static void handle_session(struct ceph_mds_sessio=
n *session,
>  	}
> =20
>  	if (msg_version >=3D 5) {
> -		u32 flags;
> -		/* version >=3D 4, struct_v, struct_cv, len, metric_spec */
> -	        ceph_decode_skip_n(&p, end, 2 + sizeof(u32) * 2, bad);
> +		u32 flags, len;
> +
> +		/* version >=3D 4 */
> +		ceph_decode_skip_16(&p, end, bad); /* struct_v, struct_cv */
> +		ceph_decode_32_safe(&p, end, len, bad); /* len */
> +		ceph_decode_skip_n(&p, end, len, bad); /* metric_spec */
> +
>  		/* version >=3D 5, flags   */
> -                ceph_decode_32_safe(&p, end, flags, bad);
> +		ceph_decode_32_safe(&p, end, flags, bad);
>  		if (flags & CEPH_SESSION_BLOCKLISTED) {
> -		        pr_warn("mds%d session blocklisted\n", session->s_mds);
> +			pr_warn("mds%d session blocklisted\n", session->s_mds);
>  			blocklisted =3D true;
>  		}
>  	}

Good catch! Should we send this to stable too?

Reviewed-by: Jeff Layton <jlayton@kernel.org>
