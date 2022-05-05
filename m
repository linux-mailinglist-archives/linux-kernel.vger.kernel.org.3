Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8088C51B950
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345426AbiEEHoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbiEEHoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:44:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14D015FEE;
        Thu,  5 May 2022 00:40:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kv5G318bNz4xLb;
        Thu,  5 May 2022 17:40:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651736427;
        bh=IdQFe9+XKU10DJC7a/VpNCylBdCaz9iU1nuEjSmC5Yc=;
        h=Date:From:To:Cc:Subject:From;
        b=LjRnWkLZusSAOi3M4N0PGM003dn9YbykceA1nNRTNTpyKvNVxB6hhXBSFJiafMIs/
         xPV5xxgdm2+WiKKBcy2z5vntSfs/kOGh2etYdTvZ9BwYPZgg0jJtY7kQ6lBo1iITtX
         LeGBrFQ/CycbEwyPYsNnUnDsftlo98Y2UCRuShYBBDLrtemd87J6DuYdsqTegV7QlN
         2w7NMYmoQr9w6r3evvzIxf/zZNUq2E9LYFsi3MBbwAYzUQ/JxebCqx8g79yzXmsbnI
         FYiaHmG8ZKdOTHhgpUeDaynZWq+K/euGRlluWMpWhzH3vCqAEfq6RrMqF4rr+53CVt
         TM/ih/8WUiifg==
Date:   Thu, 5 May 2022 17:40:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kspp tree
Message-ID: <20220505174025.07cc9967@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/M5RX/1U.XNv/liR8=s_9veL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/M5RX/1U.XNv/liR8=s_9veL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kspp tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/misc/lkdtm/stackleak.c: In function 'check_stackleak_irqoff':
drivers/misc/lkdtm/stackleak.c:30:46: error: implicit declaration of functi=
on 'stackleak_task_low_bound' [-Werror=3Dimplicit-function-declaration]
   30 |         const unsigned long task_stack_low =3D stackleak_task_low_b=
ound(current);
      |                                              ^~~~~~~~~~~~~~~~~~~~~~=
~~
drivers/misc/lkdtm/stackleak.c:31:47: error: implicit declaration of functi=
on 'stackleak_task_high_bound'; did you mean 'stackleak_task_init'? [-Werro=
r=3Dimplicit-function-declaration]
   31 |         const unsigned long task_stack_high =3D stackleak_task_high=
_bound(current);
      |                                               ^~~~~~~~~~~~~~~~~~~~~=
~~~~
      |                                               stackleak_task_init
drivers/misc/lkdtm/stackleak.c:33:50: error: 'struct task_struct' has no me=
mber named 'lowest_stack'; did you mean 'ret_stack'?
   33 |         const unsigned long lowest_sp =3D current->lowest_stack;
      |                                                  ^~~~~~~~~~~~
      |                                                  ret_stack
drivers/misc/lkdtm/stackleak.c:74:23: error: implicit declaration of functi=
on 'stackleak_find_top_of_poison' [-Werror=3Dimplicit-function-declaration]
   74 |         poison_high =3D stackleak_find_top_of_poison(task_stack_low=
, untracked_high);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  f4cfacd92972 ("lkdtm/stackleak: rework boundary management")

or maybe commit

  cbe7edb47d3c ("stackleak: rework stack low bound handling")

CONFIG_GCC_PLUGIN_STACKLEAK is not set for this build.

I have used the kspp tree from next-20220504 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/M5RX/1U.XNv/liR8=s_9veL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJzf2kACgkQAVBC80lX
0GxSlAf/QEeNiidSGw2AWgcvsbeeicmb9sLLdgYFJ5Fe0ox7IJcemW4OdTpLq/QX
c7tMvFr1yosmrfZC/AkeKqCL4R2i2QqQVW8QDA7dw83ZFfXBn5GwrT4Ri9HLVc2n
OkQtmV5Tjiau0UQFsBNgR0EZYnLf8x6djlbMQaT74jbNm8k6gVZ+7AtX55MkfBlu
QFz+9M7Zv+fdEJDH451Yr33E0bqyMv8/R7fJwUxrG80wBU4AyeJYJyHJnTqvGkNq
HECT/rF0fMs8JG1HOZRZBGOvcOYp2tSnHWfQqKbys7mqAIifgkm1r04OJxKSnZHQ
5xYcHLkRkOKQThe48kctcjvIjOnNQA==
=G9NT
-----END PGP SIGNATURE-----

--Sig_/M5RX/1U.XNv/liR8=s_9veL--
