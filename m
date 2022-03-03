Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4559D4CB884
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiCCIQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiCCIP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:15:58 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B6F49F98;
        Thu,  3 Mar 2022 00:15:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K8P1C5yfpz4xbw;
        Thu,  3 Mar 2022 19:15:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646295312;
        bh=BtdJqVuVd43Das0uo/afMz52u+vwfaauQP5KU6Dm1sE=;
        h=Date:From:To:Cc:Subject:From;
        b=T+qH2QvHpoZEwHVJoAkmbdZASY9b6AdH+akmRtlvtWWRPynUb3RJc3RrLLY3KfumY
         Vm7QM6uqPAntNba3taTZUCr8AnunbhMdUtmoOhdfwIEPAemhaPwtmSif721jIOtdyv
         Xq2T5kSQH2nvsrOxqrS+zS6NRi6W7McTHkATkrbb9ukm+PJ49/glG7iadPBV+312gc
         tdhNMHXgvQtxUgnIZAa64cHKuljS68yZWz9D/xb+IlX824Ks1EkuYA+cUJ6M48lN0i
         tf9YyqGTgdnOpBj0V7Zn6h7J76As5A0Ut7anZSJ935L5X1M+N9KUHjxZOCxb+iw2ja
         1GeCKudW2dI3A==
Date:   Thu, 3 Mar 2022 19:15:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next: manual merge of the akpm-current tree with the kspp
 tree
Message-ID: <20220303191511.7bcd2272@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SwUCjVtYvOhP=MyNboy3Y+L";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SwUCjVtYvOhP=MyNboy3Y+L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  mm/Kconfig

between commit:

  2792d84e6da5 ("usercopy: Check valid lifetime via stack depth")

from the kspp tree and commit:

  29c91f123969 ("mm: generalize ARCH_HAS_FILTER_PGPROT")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/Kconfig
index 4b7663a91f18,67998bd3352e..000000000000
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@@ -747,15 -750,9 +753,18 @@@ config IDLE_PAGE_TRACKIN
  config ARCH_HAS_CACHE_LINE_SIZE
  	bool
 =20
 +config ARCH_HAS_CURRENT_STACK_POINTER
 +	bool
 +	help
 +	  In support of HARDENED_USERCOPY performing stack variable lifetime
 +	  checking, an architecture-agnostic way to find the stack pointer
 +	  is needed. Once an architecture defines an unsigned long global
 +	  register alias named "current_stack_pointer", this config can be
 +	  selected.
 +
+ config ARCH_HAS_FILTER_PGPROT
+ 	bool
+=20
  config ARCH_HAS_PTE_DEVMAP
  	bool
 =20

--Sig_/SwUCjVtYvOhP=MyNboy3Y+L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIgeQ8ACgkQAVBC80lX
0Gwk3wf+It4CaOTx0vHC4yIXHfDjut2H9H+hGXGZRniVP+igcZZqq1WqCxrlf8/1
qpDSP7ho1rXEhP7ojgAUxo5Urn5KZRoak6VigAF4mCypCxX0+refLqu4NetnAVd9
Yg1Zfq7tlGHsK6aZEGYQcTRznczLhGl7f+o6sogDcoXZandMI06+KbHEFTpj4Tar
3sdc1FUSALQ2M7gAoOH7CbB9sTNzjlhinvz7JVfHacNn/asWmBxyc0bAcXGgvxcu
kOCXiULfFA+cllejOCLBJz3K6eFVCLfKneWiUvzVwQlH2wmZnqxrnxryBV4/adAQ
TG/rJ9saFvXRTq0DjiIA2sUULuDw4g==
=VdrC
-----END PGP SIGNATURE-----

--Sig_/SwUCjVtYvOhP=MyNboy3Y+L--
