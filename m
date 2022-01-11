Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C378048B168
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349756AbiAKPza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:55:30 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56576 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349717AbiAKPz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:55:29 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id 4cd268dabde6e4c3; Tue, 11 Jan 2022 16:55:27 +0100
Received: from kreacher.localnet (unknown [213.134.181.61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 6BF5C66B107;
        Tue, 11 Jan 2022 16:55:26 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>,
        Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH] ACPICA: Use uintptr_t and offsetof() in Linux kernel builds
Date:   Tue, 11 Jan 2022 16:55:25 +0100
Message-ID: <2614912.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.61
X-CLIENT-HOSTNAME: 213.134.181.61
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrudehfedgkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvvefgteeuteehkeduuedvudetleevffdtffdtjeejueekffetieekgfeigfehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrddukedurdeiudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurdeiuddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To avoid "performing pointer subtraction with a null pointer has
undefined behavior" compiler warnings, use uintptr_t and offsetof()
that are always available during Linux kernel builds to define
acpi_uintptr_t and the ACPI_TO_INTEGER() and ACPI_OFFSET() macros.

Based on earlier proposal from Arnd Bergmann.

Link: https://lore.kernel.org/linux-acpi/20210927121338.938994-1-arnd@kernel.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actypes.h          |    4 ++++
 include/acpi/platform/aclinux.h |    5 +++++
 2 files changed, 9 insertions(+)

Index: linux-pm/include/acpi/platform/aclinux.h
===================================================================
--- linux-pm.orig/include/acpi/platform/aclinux.h
+++ linux-pm/include/acpi/platform/aclinux.h
@@ -114,6 +114,11 @@
 #define acpi_raw_spinlock                   raw_spinlock_t *
 #define acpi_cpu_flags                      unsigned long
 
+#define acpi_uintptr_t                      uintptr_t
+
+#define ACPI_TO_INTEGER(p)                  ((uintptr_t)(p))
+#define ACPI_OFFSET(d, f)                   offsetof(d, f)
+
 /* Use native linux version of acpi_os_allocate_zeroed */
 
 #define USE_NATIVE_ALLOCATE_ZEROED
Index: linux-pm/include/acpi/actypes.h
===================================================================
--- linux-pm.orig/include/acpi/actypes.h
+++ linux-pm/include/acpi/actypes.h
@@ -507,8 +507,12 @@ typedef u64 acpi_integer;
 /* Pointer/Integer type conversions */
 
 #define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, (acpi_size) (i))
+#ifndef ACPI_TO_INTEGER
 #define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
+#endif
+#ifndef ACPI_OFFSET
 #define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
+#endif
 #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
 
 /* Optimizations for 4-character (32-bit) acpi_name manipulation */



