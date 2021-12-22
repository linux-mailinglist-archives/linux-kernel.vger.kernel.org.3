Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D08647D550
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344161AbhLVQoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 11:44:19 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:41790 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344086AbhLVQnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 11:43:24 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id 08d3c77e2aff89c7; Wed, 22 Dec 2021 17:43:22 +0100
Received: from kreacher.localnet (unknown [213.134.181.48])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 1628166AE27;
        Wed, 22 Dec 2021 17:43:21 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 04/19] ACPICA: Macros: Remove ACPI_PHYSADDR_TO_PTR
Date:   Wed, 22 Dec 2021 17:23:28 +0100
Message-ID: <3146448.aeNJFYEL58@kreacher>
In-Reply-To: <11889746.O9o76ZdvQC@kreacher>
References: <11889746.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.48
X-CLIENT-HOSTNAME: 213.134.181.48
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddruddtiedgkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefgkedtheeuheetffeuleelhefhfffgjedthedvtdefteejffevteehhedvjefgudenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvudefrddufeegrddukedurdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurdegkedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jessica Clarke <jrtc27@jrtc27.com>

ACPICA commit 52abebd410945ec55afb4dd8b7150e8a39b5c960

This macro was only ever used when stuffing pointers into physical
addresses and trying to later reconstruct the pointer, which is
implementation-defined as to whether that can be done. Now that all such
operations are gone, the macro is unused, and should be removed to avoid
such practices being reintroduced.

Link: https://github.com/acpica/acpica/commit/52abebd4
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actypes.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 700c2449e85a..83a7ee1fbd7c 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -509,7 +509,6 @@ typedef u64 acpi_integer;
 #define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, (acpi_size) (i))
 #define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
 #define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
-#define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
 #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
 
 /* Optimizations for 4-character (32-bit) acpi_name manipulation */
-- 
2.26.2




