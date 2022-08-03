Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44D0588F8E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbiHCPmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236797AbiHCPmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:42:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7432118B0A;
        Wed,  3 Aug 2022 08:42:02 -0700 (PDT)
Date:   Wed, 03 Aug 2022 15:41:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659541320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xwsm6IFGQeK6Zq/4c1VwtMBheV506aRwxZVfJrfwMCo=;
        b=A7wgwKiLeByPywwz2Y2ObapQswfqv6eE/VZi0pxJgh5VdJZWRX8mklbRazNHHsZCSs3kl4
        qNJLsAZpIKgllFi+VRrcz2W3n6XfCQ9wNg4YgLRJLEi1I2KIb4S6nMEICzcsOI1yoEbz0j
        bt+9EYfI4w9tVc1tTXdJdVGvEZEARrIUy0PWq0cVbX5rht/bjJpR5+edFJLesD68D18xgF
        1rogghI9MD00GKRT9qyrlumBlbxCtrrgWBV2jcagN5LTNqVN5Lfj5MixpvVWf5D5QBXOSV
        spYRE3NbpUsrLMaZAtPvXndOWZAl8sx0TN2aQ3IxSL5eg/Q066cBb+ZuK4x+4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659541320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xwsm6IFGQeK6Zq/4c1VwtMBheV506aRwxZVfJrfwMCo=;
        b=vfv6m6TBE5c6KCa/aasRR6uRNGpTPE9FG0cXJxMIBvrTTKDrrNvvuq+AJtNlFYzrN5PmoT
        Iv1q68J/69dGFPBA==
From:   "tip-bot2 for Siddh Raman Pant" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/numa: Use cpumask_available instead of
 hardcoded NULL check
Cc:     Siddh Raman Pant <code@siddh.me>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220731160913.632092-1-code@siddh.me>
References: <20220731160913.632092-1-code@siddh.me>
MIME-Version: 1.0
Message-ID: <165954131875.15455.15679349125656470840.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     625395c4a0f4775e0fe00f616888d2e6c1ba49db
Gitweb:        https://git.kernel.org/tip/625395c4a0f4775e0fe00f616888d2e6c1b=
a49db
Author:        Siddh Raman Pant <code@siddh.me>
AuthorDate:    Sun, 31 Jul 2022 21:39:13 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Aug 2022 11:44:57 +02:00

x86/numa: Use cpumask_available instead of hardcoded NULL check

GCC-12 started triggering a new warning:

  arch/x86/mm/numa.c: In function =E2=80=98cpumask_of_node=E2=80=99:
  arch/x86/mm/numa.c:916:39: warning: the comparison will always evaluate as =
=E2=80=98false=E2=80=99 for the address of =E2=80=98node_to_cpumask_map=E2=80=
=99 will never be NULL [-Waddress]
    916 |         if (node_to_cpumask_map[node] =3D=3D NULL) {
        |                                       ^~

node_to_cpumask_map is of type cpumask_var_t[].

When CONFIG_CPUMASK_OFFSTACK is set, cpumask_var_t is typedef'd to a
pointer for dynamic allocation, else to an array of one element. The
"wicked game" can be checked on line 700 of include/linux/cpumask.h.

The original code in debug_cpumask_set_cpu() and cpumask_of_node() were
probably written by the original authors with CONFIG_CPUMASK_OFFSTACK=3Dy
(i.e. dynamic allocation) in mind, checking if the cpumask was available
via a direct NULL check.

When CONFIG_CPUMASK_OFFSTACK is not set, GCC gives the above warning
while compiling the kernel.

Fix that by using cpumask_available(), which does the NULL check when
CONFIG_CPUMASK_OFFSTACK is set, otherwise returns true. Use it wherever
such checks are made.

Conditional definitions of cpumask_available() can be found along with
the definition of cpumask_var_t. Check the cpumask.h reference mentioned
above.

Fixes: c032ef60d1aa ("cpumask: convert node_to_cpumask_map[] to cpumask_var_t=
")
Fixes: de2d9445f162 ("x86: Unify node_to_cpumask_map handling between 32 and =
64bit")
Signed-off-by: Siddh Raman Pant <code@siddh.me>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220731160913.632092-1-code@siddh.me
---
 arch/x86/mm/numa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index e8b0615..2aadb20 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -867,7 +867,7 @@ void debug_cpumask_set_cpu(int cpu, int node, bool enable)
 		return;
 	}
 	mask =3D node_to_cpumask_map[node];
-	if (!mask) {
+	if (!cpumask_available(mask)) {
 		pr_err("node_to_cpumask_map[%i] NULL\n", node);
 		dump_stack();
 		return;
@@ -913,7 +913,7 @@ const struct cpumask *cpumask_of_node(int node)
 		dump_stack();
 		return cpu_none_mask;
 	}
-	if (node_to_cpumask_map[node] =3D=3D NULL) {
+	if (!cpumask_available(node_to_cpumask_map[node])) {
 		printk(KERN_WARNING
 			"cpumask_of_node(%d): no node_to_cpumask_map!\n",
 			node);
