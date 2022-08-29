Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579A45A417B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiH2Dan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiH2Dak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:30:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F10C14D2D;
        Sun, 28 Aug 2022 20:30:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MGGD84yjBz4wgr;
        Mon, 29 Aug 2022 13:30:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661743833;
        bh=SwxvXxJuJA9Z+oOOGJETCp6d2esM5jE8cakaOn1Bw1g=;
        h=Date:From:To:Cc:Subject:From;
        b=Hp7iprsTukbWImHVbkYnXfFnuHF+DuqPkM4s3BHZSBg5q+xHBsKbJJ+xSsuxUraLf
         vVPUG3kKUKgxEUcI19uHaCTQ0puiogJRjEAfqPom0Z+cEtqw8zH5gPvE9IDSLIBrhu
         cMcasKT7aTPcPxlEHCAtwF5mQMNjBKNNU08574C79H5Kj+ZcV+LYpwxMuWfycoiQOE
         huQI1G3Q2Vc6nwBv0MsdAmYZP6ge68sYOKL4EfaSmrTma9rl7mv8lMP0ioN1uqFVLx
         ZkDCSB2Bt72mu9EqqLuJJfXuLPmC/jpM/eFxfWSzjjwiSMk3tS6icjuUn1cCmLOxWu
         i1vbvznp6DzJg==
Date:   Mon, 29 Aug 2022 13:29:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tejun Heo <tj@kernel.org>
Cc:     Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the cgroup tree
Message-ID: <20220829132951.1f175865@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sVRc+tbuG6LEAPC_rv=9xg0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sVRc+tbuG6LEAPC_rv=9xg0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the cgroup tree, today's linux-next build (x86_64
allmodconfig) failed like this:

mm/memcontrol.c: In function 'mem_cgroup_get_from_ino':
mm/memcontrol.c:5114:24: error: returning 'long int' from a function with r=
eturn type 'struct mem_cgroup *' makes pointer from integer without a cast =
[-Werror=3Dint-conversion]
 5114 |                 return PTR_ERR(cgrp);
      |                        ^~~~~~~~~~~~~

Caused by commit

  fa7e439cf90b ("cgroup: Homogenize cgroup_get_from_id() return value")

I have used the cgroup tree from next-20220826 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/sVRc+tbuG6LEAPC_rv=9xg0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMMMq8ACgkQAVBC80lX
0GwGFQgAjSm0MzWPXIJSrn7+LvJMPPrEvsDDIns09BwUhbzqBfdWvLsHIGxTWcz6
TVoAjwF+MI3ejzoskpxwAx6tsobWSjV/weTR/AqvV1QEvzhxKEcnniqEJY2R5ZIu
OyykWQ++5oyKiJ54sqH7o/ntmwGtUJum6IOnp4aBwrajF4XUWsEw7dKRNC2C/0+G
8CDdM7uZR7MEQ4CrDskkQJqWZRbZ68zAOEpOqcIc8Yr5ajYzA/doUz+3TgC1tkpK
AsDI7d8Kdw2Ij6o0XCmE25hFsEdwMC9NO9CwtihmMDr57mk4wle0n5+CuM7XRLEj
YHn0Q3xGFhttX7KzH+ZNg3eJ7WHyyw==
=kf6N
-----END PGP SIGNATURE-----

--Sig_/sVRc+tbuG6LEAPC_rv=9xg0--
