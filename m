Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4B352C671
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiERWlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiERWkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:40:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B76E2FFE9;
        Wed, 18 May 2022 15:40:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L3Scy5fRDz4xYC;
        Thu, 19 May 2022 08:40:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652913650;
        bh=LJePSoYrTvtRFTlCXo4G53ZYEThsrJzQZs/OVlgyXCw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G8VKIn9uhmLRguFFhcl9A0NIbCpHQKUPOfvxNcF2YBSz0b/Q9kV1Vxnqrbblz1Z/R
         TNTyGaHtCD7MZTrkrNju8T3Hqw2XefuFkLDO4NMihc477dTWq879VrU+TQE4fsXdze
         YXWQ660qsRyP2/QHMeRvFOwnqykBGm5P/YKlc1t6y9I3ecTJSwPrdAJEymLxaLladi
         Y9qRN/mxX6i0JozcI0fJVFhrbGXwta8foatai/v5chn8V0iOVl+/YBkLRqhTIUQX3C
         ztD4k86RHV/9tiJwNaXMO+egsTklHRmdqyIX4ZGy8k96u8txqCZkUB+a8wfJdrXYiU
         5IwrbOj4qjQ/g==
Date:   Thu, 19 May 2022 08:40:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the dmaengine tree with Linus' tree
Message-ID: <20220519084049.3e5b58a8@canb.auug.org.au>
In-Reply-To: <a6df0b8a-dc42-51e4-4b7b-62d1d11c7800@intel.com>
References: <20220517153435.645a9313@canb.auug.org.au>
        <YoTcmqygoMm/gmsZ@matsya>
        <a6df0b8a-dc42-51e4-4b7b-62d1d11c7800@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iwEHLbp=h.a11iALdq4q1rV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iwEHLbp=h.a11iALdq4q1rV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Wed, 18 May 2022 10:20:59 -0700 Dave Jiang <dave.jiang@intel.com> wrote:
>
> The lock needs to go around both functions, we can move it outside the if=
().
>=20
>   + 		mutex_lock(&wq->wq_lock);
>    		if (wq->state =3D=3D IDXD_WQ_ENABLED) {
>    			idxd_wq_disable_cleanup(wq);
>   -			idxd_wq_device_reset_cleanup(wq);
>    			wq->state =3D IDXD_WQ_DISABLED;
>    		}
>   +		idxd_wq_device_reset_cleanup(wq);
>   + 		mutex_unlock(&wq->wq_lock);

Thanks for checking.  I have made that change to my merge resolution.
--=20
Cheers,
Stephen Rothwell

--Sig_/iwEHLbp=h.a11iALdq4q1rV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKFdfEACgkQAVBC80lX
0Gx5gggAmodAG7+qU+4ANAuiYo+8qcafr1zBZR0A+tMy1GXplXTnVePEYqGCg14R
LXQu4myQv0IiRPbS1NoxKSYxnpg/JHVPKD2izitbEZecCUn6bjaAVKqw7ylL25+W
0FSHB0lkXPrmEmY86+4DmnesScTL2hlWugr+STC/pbFvCxyQ/4D6pisRrVClHyxy
lJPNritZVFJL93WzurfhBw8lxMCxlovYpmZoAhCgreM95anKj487FBqK7lepemI2
epPH61EbvTQJ38TQoqzPOofDng8jZzHsKGceYhv1L8UiGh+KvFlagiTDc4mPJoWN
CbMg+N9s/6OP5S8UXcTSrhN8FU5G/g==
=B3b7
-----END PGP SIGNATURE-----

--Sig_/iwEHLbp=h.a11iALdq4q1rV--
