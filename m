Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4414D2708
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiCICSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 21:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiCICSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 21:18:14 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2602D4BB9F;
        Tue,  8 Mar 2022 18:16:43 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KCwmn03NQz4xdl;
        Wed,  9 Mar 2022 13:16:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646792201;
        bh=VwI//tQIQAdqCrHep6aDLdGNbxUz0LjiCk90+ut2RWM=;
        h=Date:From:To:Cc:Subject:From;
        b=SsX63T7huM3YT+oy37pD5qm1Q1EYx00qhnslhffm7+7GUrSySxjJL3VGV4PmN66R+
         F8QumgEcErLfPGXnwfrUeoyFSTZ7evwyh46h3i+nqLWAoGblQiyJmRuxEvEeN+vggR
         O2VQrd8iqt3ntE6CY0YKekjOBRnpgXcWxfXn+CN6yKlabbgTSoclXmeWeynvO4I3OV
         0R8n75+wcVoHTHJeE5emdLxaBHFZa33CYCgg7hRsJS7Zpma6YGZp8UXXKxq5SLTCf2
         ZYejDMDTMshXjCXvRl+wD49kcrMlBNc7XHohzRI68mivdP4FSpwvuMIrUb5LLJNYMl
         Dn57V8miZ8hcQ==
Date:   Wed, 9 Mar 2022 13:16:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20220309131638.26600d10@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/o1oZLvcQFRW3bb5QHtpbH6f";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/o1oZLvcQFRW3bb5QHtpbH6f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from block/blk-mq-debugfs-zoned.c:7:
block/blk-mq-debugfs.h:24:42: error: 'struct blk_mq_hw_ctx' declared inside=
 parameter list will not be visible outside of this definition or declarati=
on [-Werror]
   24 |                                   struct blk_mq_hw_ctx *hctx);
      |                                          ^~~~~~~~~~~~~
block/blk-mq-debugfs.h:25:44: error: 'struct blk_mq_hw_ctx' declared inside=
 parameter list will not be visible outside of this definition or declarati=
on [-Werror]
   25 | void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx);
      |                                            ^~~~~~~~~~~~~
block/blk-mq-debugfs.h:32:47: error: 'struct blk_mq_hw_ctx' declared inside=
 parameter list will not be visible outside of this definition or declarati=
on [-Werror]
   32 |                                        struct blk_mq_hw_ctx *hctx);
      |                                               ^~~~~~~~~~~~~
block/blk-mq-debugfs.h:33:50: error: 'struct blk_mq_hw_ctx' declared inside=
 parameter list will not be visible outside of this definition or declarati=
on [-Werror]
   33 | void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hct=
x);
      |                                                  ^~~~~~~~~~~~~
cc1: all warnings being treated as errors

I have no idea what has caused this.

I have used the block tree from next-20220308 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/o1oZLvcQFRW3bb5QHtpbH6f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIoDgYACgkQAVBC80lX
0GxK0gf+Mxo+helPcFBZ+5bzPh5oUI7iNLAI7lIz93bU4oPyOEiIOXHBjednfV5K
bZ9W2+kGlbgJggh3C2kkyQaEzPz/p5cPxABg0CSWaraQExeK6CZBldb9/dJXL4+x
Rn/TzpOVS5kJz2uX5LSvVV1w0nd9y+EKrpP0elWSnA8Apt4BJWxAIUgxsf0WLfWa
03nDaV8vzqF9LSQ0pY1BAGatlvnvEE7kR9MeergtPGqchB8U0Fi8g2M6CZCGvU9Y
zJRFYEA3dv3VfbZLcLvGWJAwV4FLCaBLOSlaW7QdUOrP+JEpEtIsIlxQtK1UoFa9
khlK4MaNlubBudUuD+KoKbGaYm1xEw==
=UwC6
-----END PGP SIGNATURE-----

--Sig_/o1oZLvcQFRW3bb5QHtpbH6f--
