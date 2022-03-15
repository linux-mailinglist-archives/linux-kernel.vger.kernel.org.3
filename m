Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA724D932F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 04:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241046AbiCOD7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 23:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbiCOD7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 23:59:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345F547AE3;
        Mon, 14 Mar 2022 20:58:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHflT4PCSz4xvY;
        Tue, 15 Mar 2022 14:58:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647316709;
        bh=pwlp4jtuRFgs4Txp6CSUd4Kyak3qcyeWoQf0bgb1veM=;
        h=Date:From:To:Cc:Subject:From;
        b=TI863rkamDY5uoitr4KBzv8bvr4fFktQHJteFjAjCd/V38oV3eONtmUuAKbu8I5IY
         hXRuXc6zeTKY5jHBaI0JmyLGg7U6CiYhlGwnSjdM8QKMqcSSh4lTfefwDD2GhhU/zH
         e0EUXYvbH4BA3h+UiyuMz0ATSruXelc0FvKuomOnwzvboOezTQGT8pT9BDkWd4OJAA
         fo4JSg3a7SbkB6h1RKI8xc4APIyU2oWd82rr9YlWCnP2pb+c9laGs6HE1DH7rGM6zA
         dsQTcVrPRT8kTJwYl42+zyPcDcwZxZgvpd5dIqbSwzTrTOe43CqcACDXeh0b+UHg40
         1zDUUuEukTxvw==
Date:   Tue, 15 Mar 2022 14:58:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the ftrace tree with the nfsd tree
Message-ID: <20220315145828.413e9301@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/l6_7Qz9X_bEJrHVs=ZnrHzt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/l6_7Qz9X_bEJrHVs=ZnrHzt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ftrace tree got a conflict in:

  include/trace/trace_events.h

between commit:

  d07c9ad62247 ("tracing: Introduce helpers to safely handle dynamic-sized =
sockaddrs")

from the nfsd tree and commit:

  af6b9668e85f ("tracing: Move the defines to create TRACE_EVENTS into thei=
r own files")

from the ftrace tree.

Well, this is a pain :-(

I fixed it up (I used the latter version of this file and then added
the following merge fix patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 15 Mar 2022 14:47:18 +1100
Subject: [PATCH] fix up for "tracing: Move the defines to create TRACE_EVEN=
TS into their own files"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/trace/stages/stage1_defines.h |  6 ++++++
 include/trace/stages/stage2_defines.h | 10 ++++++++--
 include/trace/stages/stage3_defines.h |  6 ++++++
 include/trace/stages/stage4_defines.h |  6 ++++++
 include/trace/stages/stage5_defines.h |  6 ++++++
 include/trace/stages/stage6_defines.h | 18 ++++++++++++++++++
 include/trace/stages/stage7_defines.h |  2 ++
 7 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/include/trace/stages/stage1_defines.h b/include/trace/stages/s=
tage1_defines.h
index 8ab88c766d2b..a16783419687 100644
--- a/include/trace/stages/stage1_defines.h
+++ b/include/trace/stages/stage1_defines.h
@@ -29,6 +29,9 @@
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)
=20
+#undef __sockaddr
+#define __sockaddr(field, len) __dynamic_array(u8, field, len)
+
 #undef __rel_dynamic_array
 #define __rel_dynamic_array(type, item, len) u32 __rel_loc_##item;
=20
@@ -41,5 +44,8 @@
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(char, item, -1)
=20
+#undef __rel_sockaddr
+#define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
+
 #undef TP_STRUCT__entry
 #define TP_STRUCT__entry(args...) args
diff --git a/include/trace/stages/stage2_defines.h b/include/trace/stages/s=
tage2_defines.h
index 9f2341df40da..42fd1e8813ec 100644
--- a/include/trace/stages/stage2_defines.h
+++ b/include/trace/stages/stage2_defines.h
@@ -29,11 +29,14 @@
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
=20
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
=20
-#undef __string_len
-#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+#undef __sockaddr
+#define __sockaddr(field, len) __dynamic_array(u8, field, len)
=20
 #undef __rel_dynamic_array
 #define __rel_dynamic_array(type, item, len)	u32 item;
@@ -46,3 +49,6 @@
=20
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, it=
em, -1)
+
+#undef __rel_sockaddr
+#define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
diff --git a/include/trace/stages/stage3_defines.h b/include/trace/stages/s=
tage3_defines.h
index 0bc131993b7a..e3b183e9d18e 100644
--- a/include/trace/stages/stage3_defines.h
+++ b/include/trace/stages/stage3_defines.h
@@ -51,6 +51,12 @@
 		trace_print_bitmask_seq(p, __bitmask, __bitmask_size);	\
 	})
=20
+#undef __get_sockaddr
+#define __get_sockaddr(field)	((struct sockaddr *)__get_dynamic_array(fiel=
d))
+
+#undef __get_rel_sockaddr
+#define __get_rel_sockaddr(field)	((struct sockaddr *)__get_rel_dynamic_ar=
ray(field))
+
 #undef __print_flags
 #define __print_flags(flag, delim, flag_array...)			\
 	({								\
diff --git a/include/trace/stages/stage4_defines.h b/include/trace/stages/s=
tage4_defines.h
index 780a10fa5279..e80cdc397a43 100644
--- a/include/trace/stages/stage4_defines.h
+++ b/include/trace/stages/stage4_defines.h
@@ -41,6 +41,9 @@
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
=20
+#undef __sockaddr
+#define __sockaddr(field, len) __dynamic_array(u8, field, len)
+
 #undef __rel_dynamic_array
 #define __rel_dynamic_array(_type, _item, _len) {			\
 	.type =3D "__rel_loc " #_type "[]", .name =3D #_item,		\
@@ -55,3 +58,6 @@
=20
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, it=
em, -1)
+
+#undef __rel_sockaddr
+#define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
diff --git a/include/trace/stages/stage5_defines.h b/include/trace/stages/s=
tage5_defines.h
index fb15394aae31..7ee5931300e6 100644
--- a/include/trace/stages/stage5_defines.h
+++ b/include/trace/stages/stage5_defines.h
@@ -81,3 +81,9 @@
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, it=
em,	\
 					 __bitmask_size_in_longs(nr_bits))
+
+#undef __sockaddr
+#define __sockaddr(field, len) __dynamic_array(u8, field, len)
+
+#undef __rel_sockaddr
+#define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
diff --git a/include/trace/stages/stage6_defines.h b/include/trace/stages/s=
tage6_defines.h
index b3a1f26026be..2ac88e1a7677 100644
--- a/include/trace/stages/stage6_defines.h
+++ b/include/trace/stages/stage6_defines.h
@@ -45,6 +45,15 @@
 #define __assign_bitmask(dst, src, nr_bits)					\
 	memcpy(__get_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
=20
+#undef __sockaddr
+#define __sockaddr(field, len) __dynamic_array(u8, field, len)
+
+#undef __get_sockaddr
+#define __get_sockaddr(field)	((struct sockaddr *)__get_dynamic_array(fiel=
d))
+
+#define __assign_sockaddr(dest, src, len)					\
+	memcpy(__get_dynamic_array(dest), src, len)
+
 #undef __rel_dynamic_array
 #define __rel_dynamic_array(type, item, len)				\
 	__entry->__rel_loc_##item =3D __data_offsets.item;
@@ -76,6 +85,15 @@
 #define __assign_rel_bitmask(dst, src, nr_bits)					\
 	memcpy(__get_rel_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
=20
+#undef __rel_sockaddr
+#define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
+
+#undef __get_rel_sockaddr
+#define __get_rel_sockaddr(field)	((struct sockaddr *)__get_rel_dynamic_ar=
ray(field))
+
+#define __assign_rel_sockaddr(dest, src, len)					\
+	memcpy(__get_rel_dynamic_array(dest), src, len)
+
 #undef TP_fast_assign
 #define TP_fast_assign(args...) args
=20
diff --git a/include/trace/stages/stage7_defines.h b/include/trace/stages/s=
tage7_defines.h
index d65445328f18..8a7ec24c246d 100644
--- a/include/trace/stages/stage7_defines.h
+++ b/include/trace/stages/stage7_defines.h
@@ -13,10 +13,12 @@
 #undef __get_dynamic_array_len
 #undef __get_str
 #undef __get_bitmask
+#undef __get_sockaddr
 #undef __get_rel_dynamic_array
 #undef __get_rel_dynamic_array_len
 #undef __get_rel_str
 #undef __get_rel_bitmask
+#undef __get_rel_sockaddr
 #undef __print_array
 #undef __print_hex_dump
=20
--=20
2.34.1

However, my x86_64 allmodconfig build then failed like this:

In file included from include/trace/define_custom_trace.h:55,
                 from samples/trace_events/trace_custom_sched.h:95,
                 from samples/trace_events/trace_custom_sched.c:24:
samples/trace_events/./trace_custom_sched.h: In function 'ftrace_test_custo=
m_probe_sched_switch':
include/trace/trace_custom_events.h:178:42: error: passing argument 1 of 'c=
heck_trace_callback_type_sched_switch' from incompatible pointer type [-Wer=
ror=3Dincompatible-pointer-types]
  178 |         check_trace_callback_type_##call(trace_custom_event_raw_eve=
nt_##template); \
      |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
      |                                          |
      |                                          void (*)(void *, bool,  st=
ruct task_struct *, struct task_struct *) {aka void (*)(void *, _Bool,  str=
uct task_struct *, struct task_struct *)}
include/trace/trace_custom_events.h:34:9: note: in expansion of macro 'DEFI=
NE_CUSTOM_EVENT'
   34 |         DEFINE_CUSTOM_EVENT(name, name, PARAMS(proto), PARAMS(args)=
);
      |         ^~~~~~~~~~~~~~~~~~~
samples/trace_events/./trace_custom_sched.h:21:1: note: in expansion of mac=
ro 'TRACE_CUSTOM_EVENT'
   21 | TRACE_CUSTOM_EVENT(sched_switch,
      | ^~~~~~~~~~~~~~~~~~
In file included from include/linux/trace_events.h:11,
                 from samples/trace_events/trace_custom_sched.c:10:
include/linux/tracepoint.h:279:49: note: expected 'void (*)(void *, bool,  =
unsigned int,  struct task_struct *, struct task_struct *)' {aka 'void (*)(=
void *, _Bool,  unsigned int,  struct task_struct *, struct task_struct *)'=
} but argument is of type 'void (*)(void *, bool,  struct task_struct *, st=
ruct task_struct *)' {aka 'void (*)(void *, _Bool,  struct task_struct *, s=
truct task_struct *)'}
  279 |         check_trace_callback_type_##name(void (*cb)(data_proto))   =
     \
      |                                          ~~~~~~~^~~~~~~~~~~~~~~
include/linux/tracepoint.h:419:9: note: in expansion of macro '__DECLARE_TR=
ACE'
  419 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),         =
     \
      |         ^~~~~~~~~~~~~~~
include/linux/tracepoint.h:553:9: note: in expansion of macro 'DECLARE_TRAC=
E'
  553 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |         ^~~~~~~~~~~~~
include/trace/events/sched.h:222:1: note: in expansion of macro 'TRACE_EVEN=
T'
  222 | TRACE_EVENT(sched_switch,
      | ^~~~~~~~~~~

So I gave up and uses the ftrace tree from next-20220310 for today.

I am going to need some help with this mess, please.
--=20
Cheers,
Stephen Rothwell

--Sig_/l6_7Qz9X_bEJrHVs=ZnrHzt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIwDuQACgkQAVBC80lX
0Gz7uAf+MNebB+0qCJ2+JNA0CMSPLfv3C6x1IjiaMqGL6TGm9/h43IZWVtlFzwLc
dnRxVlCHE35Q1WnQqzWmxQZoOiVQGUm1TRYzoWJic9AiiReXRpc430JXw7U0TaCP
O4r9GR7p6mOYZ7yeGM1qv2UCPj8DkcqhSQl404BB83gYQPVHIRaZ2+tlcLMSSWOD
V8cY97zLF0+HAtNKgrJyE6qHTBO4fXb736u//jmNr1vOihERc4UDTdgWSSwHR/NQ
eGKcjd0S36cTPrqmURrtLVO/n1o4/PpOegVJBmidPHr0zY9AxPhWyv2Sir2XDbun
X6vl8fH7enrcOUT3fJqwtDjk3B/0lg==
=C/Pt
-----END PGP SIGNATURE-----

--Sig_/l6_7Qz9X_bEJrHVs=ZnrHzt--
