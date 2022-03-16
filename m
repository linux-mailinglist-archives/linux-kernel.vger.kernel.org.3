Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCBA4DA8C8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 04:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353438AbiCPDKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 23:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244454AbiCPDKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 23:10:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCD25B3E6;
        Tue, 15 Mar 2022 20:09:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KJFcS6qJMz4xc2;
        Wed, 16 Mar 2022 14:09:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647400169;
        bh=0OkdD+ICwgkogaQXeYirjPsob8+9uM6oN1VDwU+zFAA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VMmuO8rfwYQxzdlXwBiP/6SQYhLmIEFwri2hvoPJUKYvry/sfyMM4TfWeYhriQ5uM
         il2TPbbugIC2fSFOfSerTZDfMW75kltt+NXh5K4tHzyKzx8mnSx8/Kfz0t8A0mpkpc
         LuD6jKRJ/ASEjHQBENcHpxWe+BYYEhPOiLAO8B2idPdWM6rBR4+0hWzhSVD+oQEujV
         yJQPTNWRoWEWquHvdK8FHMN+t7Ke+lVX0RcvQ5dn2CQn25d8w4WQPpx+VD6cxbtAkl
         vw8RSmFTlfsIx0Rd7vYUImMQHWAhQcVQjzvDVjE+bRgUPc+A87Gc9N5wfOSyjz1kRJ
         WxHqat5IqFwIw==
Date:   Wed, 16 Mar 2022 14:09:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the ftrace tree with the nfsd tree
Message-ID: <20220316140924.0f4252b3@canb.auug.org.au>
In-Reply-To: <20220315145828.413e9301@canb.auug.org.au>
References: <20220315145828.413e9301@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MpA68hHysxUSBjP=HaBfZF.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MpA68hHysxUSBjP=HaBfZF.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Tue, 15 Mar 2022 14:58:28 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> However, my x86_64 allmodconfig build then failed like this:
>=20
> In file included from include/trace/define_custom_trace.h:55,
>                  from samples/trace_events/trace_custom_sched.h:95,
>                  from samples/trace_events/trace_custom_sched.c:24:
> samples/trace_events/./trace_custom_sched.h: In function 'ftrace_test_cus=
tom_probe_sched_switch':
> include/trace/trace_custom_events.h:178:42: error: passing argument 1 of =
'check_trace_callback_type_sched_switch' from incompatible pointer type [-W=
error=3Dincompatible-pointer-types]
>   178 |         check_trace_callback_type_##call(trace_custom_event_raw_e=
vent_##template); \
>       |                                          ^~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
>       |                                          |
>       |                                          void (*)(void *, bool,  =
struct task_struct *, struct task_struct *) {aka void (*)(void *, _Bool,  s=
truct task_struct *, struct task_struct *)}
> include/trace/trace_custom_events.h:34:9: note: in expansion of macro 'DE=
FINE_CUSTOM_EVENT'
>    34 |         DEFINE_CUSTOM_EVENT(name, name, PARAMS(proto), PARAMS(arg=
s));
>       |         ^~~~~~~~~~~~~~~~~~~
> samples/trace_events/./trace_custom_sched.h:21:1: note: in expansion of m=
acro 'TRACE_CUSTOM_EVENT'
>    21 | TRACE_CUSTOM_EVENT(sched_switch,
>       | ^~~~~~~~~~~~~~~~~~
> In file included from include/linux/trace_events.h:11,
>                  from samples/trace_events/trace_custom_sched.c:10:
> include/linux/tracepoint.h:279:49: note: expected 'void (*)(void *, bool,=
  unsigned int,  struct task_struct *, struct task_struct *)' {aka 'void (*=
)(void *, _Bool,  unsigned int,  struct task_struct *, struct task_struct *=
)'} but argument is of type 'void (*)(void *, bool,  struct task_struct *, =
struct task_struct *)' {aka 'void (*)(void *, _Bool,  struct task_struct *,=
 struct task_struct *)'}
>   279 |         check_trace_callback_type_##name(void (*cb)(data_proto)) =
       \
>       |                                          ~~~~~~~^~~~~~~~~~~~~~~
> include/linux/tracepoint.h:419:9: note: in expansion of macro '__DECLARE_=
TRACE'
>   419 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),       =
       \
>       |         ^~~~~~~~~~~~~~~
> include/linux/tracepoint.h:553:9: note: in expansion of macro 'DECLARE_TR=
ACE'
>   553 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
>       |         ^~~~~~~~~~~~~
> include/trace/events/sched.h:222:1: note: in expansion of macro 'TRACE_EV=
ENT'
>   222 | TRACE_EVENT(sched_switch,
>       | ^~~~~~~~~~~
>=20
> So I gave up and uses the ftrace tree from next-20220310 for today.
>=20
> I am going to need some help with this mess, please.

Thanks for the example merge.  The extra merge resolution patch ended
up this:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 16 Mar 2022 14:01:59 +1100
Subject: [PATCH] fixup for "sched/tracing: Don't re-read p->state when emit=
ting sched_switch event"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 samples/trace_events/trace_custom_sched.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/samples/trace_events/trace_custom_sched.h b/samples/trace_even=
ts/trace_custom_sched.h
index a3d14de6a2e5..9fdd8e7c2a45 100644
--- a/samples/trace_events/trace_custom_sched.h
+++ b/samples/trace_events/trace_custom_sched.h
@@ -25,10 +25,11 @@ TRACE_CUSTOM_EVENT(sched_switch,
 	 * that the custom event is using.
 	 */
 	TP_PROTO(bool preempt,
+		 unsigned int prev_state,
 		 struct task_struct *prev,
 		 struct task_struct *next),
=20
-	TP_ARGS(preempt, prev, next),
+	TP_ARGS(preempt, prev_state, prev, next),
=20
 	/*
 	 * The next fields are where the customization happens.
--=20
2.34.1

--=20
Cheers,
Stephen Rothwell

--Sig_/MpA68hHysxUSBjP=HaBfZF.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIxVOUACgkQAVBC80lX
0GynHgf/bXxlCbOdYk75HdowCWg+o9FwXrE+5Yo6GqPHBTuZMBxrnujJ95QF2uiN
nLk/INgBJ3Ocdxu1xmdACcA6lRUVa2p68BGgoyC71CdKn7lSUhZRRHeTvGhmcNqH
bXkQ7hGKnS9mUFuhxdDmlYI3Pf7FwP3zGRZiiJRYUPdPA2XszBzTf3EoLgR7k+6h
8cqgx3lIOEWaJiHE6gOz2+LEfX0ZHdRl3IrzuTFl2k4DX++DpkQH9DKN8+3/EMx4
3Ytv2AnqqK78NdTUU8LkAqh01dF5+N97H4GUq7RLu5oqk4Hn5C9pMz9HSDlU5abJ
Nz48aC5Ut9aibmLzK6CJYkm5ji6pJQ==
=IfZN
-----END PGP SIGNATURE-----

--Sig_/MpA68hHysxUSBjP=HaBfZF.--
