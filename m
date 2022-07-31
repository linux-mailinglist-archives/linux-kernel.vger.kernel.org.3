Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E6C585FBC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbiGaQK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiGaQKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:10:54 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9E32735
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 09:10:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659283776; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=fBYjmFwCARWWi4tqpjtYoddPlEA46q4WgK+ZVld86gtIFLtXSk4cb9GHwQw9zvc+p2HVLOz6z3HSV4hMQqEapg5sVkH0EXNgzfXgONkrrUx4T9FJXKYRJJs+o/V/WBWgAH8bTF5xoVWxJM3aIuzL/zq2Ct9OfneKoO/IhPEZwXk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659283776; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=p+JGMZFOwhjpdzA/MfM1jeGfmv3RLCTVkm7iRbrSFBc=; 
        b=VhlT7zCUN6qS/5OyWREUqDA9xHj9jid+qqB4nBbeDcwRH//xXqKrPVcIRHzFSVzoCNbgqNZdijuuaXOJjhugpvwmt4C9FyQCThBMzeuv1qW70OUOnLoJ3rSUroyO6OPVWg2hfUtgO8DewAL3UA/562TocDtwUEflY1VlLMB4+UU=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659283776;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=p+JGMZFOwhjpdzA/MfM1jeGfmv3RLCTVkm7iRbrSFBc=;
        b=QCG+IqHTBXwjdGZ6SH4PHGn2+nV4YLtxp/xoOTOJ9pRCKnIia86MIRpoKx/Z+Uy+
        EvNfhi0T5ow8XmBapjFlUzGO4k6S6KIh9KNjMrOWMzgwlbO5dNwwjOvvPeGLXkslzCe
        BOmdR/GC8tPOGQeO//7Dhuwsb4ueTIVcyruKQeEY=
Received: from localhost.localdomain (43.241.144.202 [43.241.144.202]) by mx.zoho.in
        with SMTPS id 1659283774265240.75092323645038; Sun, 31 Jul 2022 21:39:34 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <20220731160913.632092-1-code@siddh.me>
Subject: [PATCH] x86/numa: Use cpumask_available instead of hardcoded NULL check
Date:   Sun, 31 Jul 2022 21:39:13 +0530
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

node_to_cpumask_map is of type cpumask_var_t[].

When CONFIG_CPUMASK_OFFSTACK is set, cpumask_var_t is typedef'd to a
pointer for dynamic allocation, else to an array of one element. The
"wicked game" can be checked on line 700 of include/linux/cpumask.h.

The lines changed in this commit were probably written by the original
authors with CONFIG_CPUMASK_OFFSTACK=3Dy (i.e. dynamic allocation) in mind,
checking if the cpumask was available via a direct NULL check.

When CONFIG_CPUMASK_OFFSTACK is not set, GCC gives the below given warning
while compiling the kernel.

Fix that by using cpumask_available(), which does the NULL check when
CONFIG_CPUMASK_OFFSTACK is set, otherwise returns true. Use it wherever
such checks are made.

Conditional definitions of cpumask_available() can be found along with
the definition of cpumask_var_t. Check the cpumask.h reference mentioned
above.

GCC warning log:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

arch/x86/mm/numa.c: In function =E2=80=98cpumask_of_node=E2=80=99:
arch/x86/mm/numa.c:916:39: warning: the comparison will always evaluate as =
=E2=80=98false=E2=80=99 for the address of =E2=80=98node_to_cpumask_map=E2=
=80=99 will never be NULL [-Waddress]
  916 |         if (node_to_cpumask_map[node] =3D=3D NULL) {
      |                                       ^~
In file included from ./include/linux/linkage.h:7,
                 from ./include/linux/kernel.h:17,
                 from ./arch/x86/include/asm/percpu.h:27,
                 from ./arch/x86/include/asm/current.h:6,
                 from ./include/linux/mutex.h:14,
                 from ./include/linux/kernfs.h:11,
                 from ./include/linux/sysfs.h:16,
                 from ./include/linux/kobject.h:20,
                 from ./include/linux/of.h:17,
                 from ./include/linux/irqdomain.h:35,
                 from ./include/linux/acpi.h:13,
                 from arch/x86/mm/numa.c:3:
arch/x86/mm/numa.c:67:15: note: =E2=80=98node_to_cpumask_map=E2=80=99 decla=
red here
   67 | EXPORT_SYMBOL(node_to_cpumask_map);
      |               ^~~~~~~~~~~~~~~~~~~
./include/linux/export.h:87:28: note: in definition of macro =E2=80=98___EX=
PORT_SYMBOL=E2=80=99
   87 |         extern typeof(sym) sym;                                    =
             \
      |                            ^~~
./include/linux/export.h:147:41: note: in expansion of macro =E2=80=98__EXP=
ORT_SYMBOL=E2=80=99
  147 | #define _EXPORT_SYMBOL(sym, sec)        __EXPORT_SYMBOL(sym, sec, "=
")
      |                                         ^~~~~~~~~~~~~~~
./include/linux/export.h:150:41: note: in expansion of macro =E2=80=98_EXPO=
RT_SYMBOL=E2=80=99
  150 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
      |                                         ^~~~~~~~~~~~~~
arch/x86/mm/numa.c:67:1: note: in expansion of macro =E2=80=98EXPORT_SYMBOL=
=E2=80=99
   67 | EXPORT_SYMBOL(node_to_cpumask_map);
      | ^~~~~~~~~~~~~

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Fixes: c032ef60d1aa ("cpumask: convert node_to_cpumask_map[] to cpumask_var=
_t")
Fixes: de2d9445f162 ("x86: Unify node_to_cpumask_map handling between 32 an=
d 64bit")

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 arch/x86/mm/numa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index e8b061557887..2aadb2019b4f 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -867,7 +867,7 @@ void debug_cpumask_set_cpu(int cpu, int node, bool enab=
le)
 =09=09return;
 =09}
 =09mask =3D node_to_cpumask_map[node];
-=09if (!mask) {
+=09if (!cpumask_available(mask)) {
 =09=09pr_err("node_to_cpumask_map[%i] NULL\n", node);
 =09=09dump_stack();
 =09=09return;
@@ -913,7 +913,7 @@ const struct cpumask *cpumask_of_node(int node)
 =09=09dump_stack();
 =09=09return cpu_none_mask;
 =09}
-=09if (node_to_cpumask_map[node] =3D=3D NULL) {
+=09if (!cpumask_available(node_to_cpumask_map[node])) {
 =09=09printk(KERN_WARNING
 =09=09=09"cpumask_of_node(%d): no node_to_cpumask_map!\n",
 =09=09=09node);
--=20
2.35.1


