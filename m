Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AED572A97
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 03:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbiGMBC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 21:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiGMBC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 21:02:26 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3497C7490;
        Tue, 12 Jul 2022 18:02:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LjK8v2X8jz4xbn;
        Wed, 13 Jul 2022 11:02:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657674143;
        bh=b0MhNEOdsNmSaJTVBJ9a2OnhIU7B0iid+WYlZ92utW4=;
        h=Date:From:To:Cc:Subject:From;
        b=fBdqT/VaS8SIoK6NxmYADaPtrQi5mOVDi5ZoF+QBBBNAPPEzh+Ql+pYr4gbQUi3OC
         CQPjl7KgmM207IHgS171a6Emw0xukIGelV2eN7rCqPX/tHgehw4/yX6Dcn7pA4Wacm
         b2IUY+6lmBPaS4YYq9slRM0s81BCGueELkMRlRvk/Bk3qRZkFB1wCaCKbDm7E7BSnZ
         e6E8ctNRGCuHndJl+KArTDmgFptPz4KN1aOBymKilsYItJBN8wxOm+ZJr5s/3EIi23
         7Rs8bpDdGgQhxl4BNUCl2ad1yxIjf3pBkvVL8isHEEaDJBUCVvRoXE+nvg7auXxJbA
         1kmlOeYy4fUEQ==
Date:   Wed, 13 Jul 2022 11:02:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the v9fs tree
Message-ID: <20220713110222.70ca5fc5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/H9W_Cj2m2XAi5+PdQ0vFg7o";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H9W_Cj2m2XAi5+PdQ0vFg7o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the v9fs tree, today's linux-next build (x86_64
allmodconfig) failed like this:

net/9p/trans_fd.c:275:12: error: 'failme' defined but not used [-Werror=3Du=
nused-variable]
  275 | static int failme;
      |            ^~~~~~
cc1: all warnings being treated as errors

Caused by commit

  c249fb4f9193 ("9p: roll p9_tag_remove into p9_req_put")

I have used the v9fs tree from next-20220712 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/H9W_Cj2m2XAi5+PdQ0vFg7o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLOGZ4ACgkQAVBC80lX
0GxYagf/feE3ie3KMCOqpO5ijYrV9fH+krrspGuDTL1WJ30WAcHeRDWjBlDhkstA
N68En4ZfRSmxRMz6QrukPCoepr/ZvL3DFS+wxu1gYR4mb1JgENKaj9+KErBjFYQN
e/SCEDFVE2vueFX81uU6ER2uuxsS4be1b3A+BdLPGvLiQ55hfra3ZBzMYEvdlzuu
GdiPSxJF2lNYHCIogrezNc2QHIpAPG4LXp3dTruXeqFkM6JSUZsPOiQO0Y9LaHz8
cm0KAsz9lzoRwlvG0OPlqaLm+7OfV8sPiP7yzx8f15X7OHBjD0q3SUwaw6jwrFLj
UwV7Ev/HmJ93/MnZKjLQN4JZoJjhyQ==
=e5VL
-----END PGP SIGNATURE-----

--Sig_/H9W_Cj2m2XAi5+PdQ0vFg7o--
