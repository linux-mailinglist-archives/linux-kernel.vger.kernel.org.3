Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC63054C0D1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 06:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241848AbiFOEiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 00:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241085AbiFOEiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 00:38:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6377A13FA4;
        Tue, 14 Jun 2022 21:38:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LNCGb2LcBz4xYC;
        Wed, 15 Jun 2022 14:37:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655267879;
        bh=N/laHczTPkQ+hC8gb6VyKTd7kKya2vOGZ3lodxaxbDI=;
        h=Date:From:To:Cc:Subject:From;
        b=Eli9kyHv89eHWXbnbeLNKLJMmEf0YaDlusv7paSQhLxwpvE/MZx2YJCHhPE0uCrpG
         ToJ0ozuzOPMt0RLXn+cJkOKTJzvUmmsoPmucAoxN5lKXrLQB9CZuCN2T+P2CcIC4UV
         gn7jvLsCMA8rG+H1Bg6e7ifYuybRDe7pC8UpoQm4s9x6CSqqFMJbywPE+iPEhrJ20p
         hnKjhep/aVKEzMZq959tuBJAab1klwIeFeCWy/paVQlxng8+RBccsKO0Ub1I7GRjzp
         XW4Y3dIBOTXSgx9nHbibwrnHuQn//9vpznEnPOfgO0JIvTbA8neRBQzEzIw36VU+6R
         ACruV5X8AqKhg==
Date:   Wed, 15 Jun 2022 14:37:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220615143758.6139959f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/R1vv/6F8JPf43bxId6NJ8YN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/R1vv/6F8JPf43bxId6NJ8YN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1835:13: error:=
 'remove_hpo_dp_link_enc_from_ctx' defined but not used [-Werror=3Dunused-f=
unction]
 1835 | static void remove_hpo_dp_link_enc_from_ctx(struct resource_context=
 *res_ctx,=20
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  4e1db0119c64 ("Revert "drm/amdgpu/display: Protect some functions with CO=
NFIG_DRM_AMD_DC_DCN"")

That function is only used when CONFIG_DRM_AMD_DC_DCN is set.

I have reverted that commit for today.

Could you please add an x86_64 allmodconfig build to your CI?

--=20
Cheers,
Stephen Rothwell

--Sig_/R1vv/6F8JPf43bxId6NJ8YN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKpYiYACgkQAVBC80lX
0GyMUQf+I2OPb6dgTx66yB+H2kHRhl0t5PU/OTLOeB5owtJFeBHnrvEDMveXTdIx
c8w/wayux17HaLKdmJ8pdXjCS/SwPoSGH83JbGvgIuNTApTagY+es2atuULmnakA
VKlcKr+fA9VZkZynmMK3abWJmQUTs/vkvHP0lzwNvS3zdKJpeQn7nmJ3mzTqTq9W
DaIkjNR1r5ZjEdlWhZTQjxq9+qfBP+JakxZNL++rdy8CEZ54i8pUcOUYaWtYMk4j
w2XvWi67MefCCNo6LzOe2k5+NttAN+Z26+mLCagLsSHvpr2psI98aGQ0m5Borl4t
00UFDOFqqt9RtQULBpNFycqOQP1Cow==
=CsKE
-----END PGP SIGNATURE-----

--Sig_/R1vv/6F8JPf43bxId6NJ8YN--
