Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FBC4AD0B3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346232AbiBHFcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346997AbiBHEmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:42:25 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA24C0401DC;
        Mon,  7 Feb 2022 20:42:23 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jt9NC5CWRz4xdJ;
        Tue,  8 Feb 2022 15:42:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644295341;
        bh=eRZDqpJm+0tjFDqYrrOiNYA5VmZuwoSbNIXNIIJXX+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uxaM8CCCfBZM0mnOeS3Quq5TurjnG5C7TbZwyIZlxjwGigL92WMnqzzoVOEUfN19l
         7xDeEKFRobiOyaAPmBMPGi4xbBA9sLULZE21T2gvMa3kCCIKypZQeMIchgQCoepFxP
         +cSXEm9MSgwsSbXqKLl2Sygo77w+/0k9LKa5ppvkpRhHLGKd+K+qeCFGD7IdNhri7V
         ky8KTZqsMQZ18GevsqZIJlBbDV8vtKKBiqmPVAQoKZchvWxYbVM9s2yPV5eO7WJjXg
         m/HrsR4/Iy1RSUP39kW3CNqMEQY+WxDqz2P0V8Rb5T/Uij74RXUYXtqRMbsuW5J28r
         IBJbX+sFIXXGQ==
Date:   Tue, 8 Feb 2022 15:42:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Michael Cyr <mikecyr@linux.vnet.ibm.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Steven Royer <seroyer@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20220208154218.14c7d414@canb.auug.org.au>
In-Reply-To: <202201241938.DA2AB1AB4@keescook>
References: <20220125142430.75c3160e@canb.auug.org.au>
        <202201241938.DA2AB1AB4@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/X1IYci1gwgb=64m5IDUZH/b";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/X1IYci1gwgb=64m5IDUZH/b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[Cc'ing the scsi maintainers.  Sorry I should have done that sooner]

On Mon, 24 Jan 2022 19:43:44 -0800 Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jan 25, 2022 at 02:24:30PM +1100, Stephen Rothwell wrote:
> >=20
> > After merging the kspp tree, today's linux-next build (powerpc
> > allyesconfig) failed like this:
> >=20
> >=20
> > drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function 'ibmvscsis_send_m=
essages':
> > drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1934:44: error: array subscrip=
t 'struct viosrp_crq[0]' is partly outside array bounds of 'u64[1]' {aka 'l=
ong long unsigned int[1]'} [-Werror=3Darray-bounds]
> >  1934 |                                         crq->valid =3D VALID_CM=
D_RESP_EL;
> >       |                                            ^~
> > drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1875:13: note: while referenci=
ng 'msg_hi'
> >  1875 |         u64 msg_hi =3D 0;
> >       |             ^~~~~~
> > drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1935:44: error: array subscrip=
t 'struct viosrp_crq[0]' is partly outside array bounds of 'u64[1]' {aka 'l=
ong long unsigned int[1]'} [-Werror=3Darray-bounds]
> >  1935 |                                         crq->format =3D cmd->rs=
p.format;
> >       |                                            ^~
> > drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1875:13: note: while referenci=
ng 'msg_hi'
> >  1875 |         u64 msg_hi =3D 0;
> >       |             ^~~~~~
> > drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1938:52: error: array subscrip=
t 'struct viosrp_crq[0]' is partly outside array bounds of 'u64[1]' {aka 'l=
ong long unsigned int[1]'} [-Werror=3Darray-bounds]
> >  1938 |                                                 crq->status =3D=
 VIOSRP_ADAPTER_FAIL;
> >       |                                                    ^~
> > drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1875:13: note: while referenci=
ng 'msg_hi'
> >  1875 |         u64 msg_hi =3D 0;
> >       |             ^~~~~~
> > drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1940:44: error: array subscrip=
t 'struct viosrp_crq[0]' is partly outside array bounds of 'u64[1]' {aka 'l=
ong long unsigned int[1]'} [-Werror=3Darray-bounds]
> >  1940 |                                         crq->IU_length =3D cpu_=
to_be16(cmd->rsp.len);
> >       |                                            ^~
> > drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1875:13: note: while referenci=
ng 'msg_hi'
> >  1875 |         u64 msg_hi =3D 0;
> >       |             ^~~~~~
> >=20
> > Exposed by commit
> >=20
> >   4ba545781e20 ("Makefile: Enable -Warray-bounds")
> >=20
> > Probably introduced by commit
> >=20
> >   88a678bbc34c ("ibmvscsis: Initial commit of IBM VSCSI Tgt Driver")
> >=20
> > I applied the following hack for now:
> >=20
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Tue, 25 Jan 2022 14:18:36 +1100
> > Subject: [PATCH] scsi: hack for building with -Warray-bounds
> >=20
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ib=
mvscsi_tgt/ibmvscsi_tgt.c
> > index 61f06f6885a5..89fcf98c61c3 100644
> > --- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> > +++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> > @@ -1872,11 +1872,11 @@ static void srp_snd_msg_failed(struct scsi_info=
 *vscsi, long rc)
> >   */
> >  static void ibmvscsis_send_messages(struct scsi_info *vscsi)
> >  {
> > -	u64 msg_hi =3D 0;
> > +	u64 msg_hi[2] =3D { };
> >  	/* note do not attempt to access the IU_data_ptr with this pointer
> >  	 * it is not valid
> >  	 */
> > -	struct viosrp_crq *crq =3D (struct viosrp_crq *)&msg_hi;
> > +	struct viosrp_crq *crq =3D (struct viosrp_crq *)msg_hi;
> >  	struct ibmvscsis_cmd *cmd, *nxt;
> >  	long rc =3D ADAPT_SUCCESS;
> >  	bool retry =3D false;
> > @@ -1940,7 +1940,7 @@ static void ibmvscsis_send_messages(struct scsi_i=
nfo *vscsi)
> >  					crq->IU_length =3D cpu_to_be16(cmd->rsp.len);
> > =20
> >  					rc =3D h_send_crq(vscsi->dma_dev->unit_address,
> > -							be64_to_cpu(msg_hi),
> > +							be64_to_cpu(msg_hi[0]),
> >  							be64_to_cpu(cmd->rsp.tag));
> > =20
> >  					dev_dbg(&vscsi->dev, "send_messages: cmd %p, tag 0x%llx, rc %ld\n=
", =20
>=20
> This looks correct to me. struct viosrp_crq is 16 bytes wide. The only
> suggestion I might make would be either avoid the bare '2':
>=20
> 	u64 msg_hi[sizeof(struct viosrp_crq) / sizeof(u64)] =3D { };
>=20
> or adjust struct viosrp_crq so the casting isn't needed at all:
>=20
>=20
> truct viosrp_crq {
> 	union {
> 		u64 hi;
> 		struct {
> 		        u8 valid;               /* used by RPA */
> 		        u8 format;              /* SCSI vs out-of-band */
> 		        u8 reserved;
> 		        u8 status;              /* non-scsi failure? (e.g. DMA failure)=
 */
> 		        __be16 timeout;         /* in seconds */
> 		        __be16 IU_length;       /* in bytes */
> 		};
> 	};
>         __be64 IU_data_ptr;     /* the TCE for transferring data */
> };
>=20
> 	struct viosrp_crq crq =3D { };
> 	...
>  			rc =3D h_send_crq(vscsi->dma_dev->unit_address,
> 					be64_to_cpu(crq.hi),
> 					be64_to_cpu(cmd->rsp.tag));
>=20
>=20
>=20

Has there been any progress on this?

Commit 88a678bbc34c mentioned above was merged in v4.8-rc1.

--=20
Cheers,
Stephen Rothwell

--Sig_/X1IYci1gwgb=64m5IDUZH/b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIB9KoACgkQAVBC80lX
0Gy4+gf+LvPnEiqI43W8ZSDYyqqJ1VpI3frGGWp+CtEtsVR/7zK9TflTyHYttcZN
7UIkxsarFucQdOdJa5uozVExqDMYQT438j8aeBIqWyFN3n/k9ICsemPTVQcD7g2U
umLPMVoeJwRA3KQNOtipjuS1M5Fbvjx8cCSDTPWcBlJ/oepRWFRQY6SeKmRMr5OA
AQ/dxdWgcdqVc9u8kHDeeS66RNrm/6oi5H4FvCLNPbc2mqcXkALuo04k6P6++Ivl
8P3JuUIuooatVRPoo9jmOLVC3pgd3FqLP/2bhmLHi9Wq8Hx+LT7FM75zXMd/BzvT
rA/BiuyNLVe9CKaSKS9IF8WBXAlSlA==
=t8Li
-----END PGP SIGNATURE-----

--Sig_/X1IYci1gwgb=64m5IDUZH/b--
