Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A2A47D54A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344010AbhLVQnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 11:43:37 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55366 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344059AbhLVQnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 11:43:16 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id d288c60c7e4c0bf8; Wed, 22 Dec 2021 17:43:15 +0100
Received: from kreacher.localnet (unknown [213.134.181.48])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 6CD8666AE27;
        Wed, 22 Dec 2021 17:43:14 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 07/19] ACPICA: Fix AEST Processor generic resource substructure data field byte length
Date:   Wed, 22 Dec 2021 17:28:34 +0100
Message-ID: <7326601.EvYhyI6sBW@kreacher>
In-Reply-To: <11889746.O9o76ZdvQC@kreacher>
References: <11889746.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.48
X-CLIENT-HOSTNAME: 213.134.181.48
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddruddtiedgkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefgkedtheeuheetffeuleelhefhfffgjedthedvtdefteejffevteehhedvjefgudenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvudefrddufeegrddukedurdegkeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurdegkedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>

ACPICA commit 13b9327761955f6e1e5dbf748b3112940c0dc539

The byte length of the Data field in the AEST Processor generic resource
substructure defined in ACPI for the Armv8 RAS Extensions 1.1 is 4Byte.
However, it is defined as a pointer type, and on a 64-bit machine,
it is interpreted as 8 bytes. Therefore, it is changed from a pointer
type unsigned integer 1 byte to an unsigned integer 4 bytes.

Link: https://github.com/acpica/acpica/commit/13b93277
Signed-off-by: Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 380bff6bb2fd..1b0fac6ffc3f 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -154,7 +154,7 @@ typedef struct acpi_aest_processor_tlb {
 /* 2R: Processor Generic Resource Substructure */
 
 typedef struct acpi_aest_processor_generic {
-	u8 *resource;
+	u32 resource;
 
 } acpi_aest_processor_generic;
 
-- 
2.26.2




