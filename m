Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A66047D54C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344112AbhLVQoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 11:44:10 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61750 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344068AbhLVQnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 11:43:20 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id db6a7191d4d6a45e; Wed, 22 Dec 2021 17:43:19 +0100
Received: from kreacher.localnet (unknown [213.134.181.48])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 8C64D66AE27;
        Wed, 22 Dec 2021 17:43:17 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 06/19] ACPICA: iASL/Disassembler: Additional support for NHLT table
Date:   Wed, 22 Dec 2021 17:25:40 +0100
Message-ID: <2168161.iZASKD2KPV@kreacher>
In-Reply-To: <11889746.O9o76ZdvQC@kreacher>
References: <11889746.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.48
X-CLIENT-HOSTNAME: 213.134.181.48
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddruddtiedgkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefgkedtheeuheetffeuleelhefhfffgjedthedvtdefteejffevteehhedvjefgudenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvudefrddufeegrddukedurdegkeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurdegkedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 0420852ffc520b81960e877852703b739c16025c

Added support for Vendor-defined microphone arrays and SNR
(signal-to-noise) extension.

Link: https://github.com/acpica/acpica/commit/0420852f
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 72 +++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 71ca090fd61b..380bff6bb2fd 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1495,12 +1495,10 @@ struct acpi_nhlt_device_specific_config_a {
 
 /* Values for Config Type above */
 
-#define ACPI_NHLT_TYPE_MIC_ARRAY            0x01
-#define ACPI_NHLT_TYPE_GENERIC              0x00
-
-/* Mask for Extension field of array_type */
-
-#define ACPI_NHLT_ARRAY_TYPE_MASK           0x10
+#define ACPI_NHLT_CONFIG_TYPE_GENERIC              0x00
+#define ACPI_NHLT_CONFIG_TYPE_MIC_ARRAY            0x01
+#define ACPI_NHLT_CONFIG_TYPE_RENDER_FEEDBACK      0x03
+#define ACPI_NHLT_CONFIG_TYPE_RESERVED             0x04	/* 4 and above are reserved */
 
 struct acpi_nhlt_device_specific_config_b {
 	u32 capabilities_size;
@@ -1511,6 +1509,11 @@ struct acpi_nhlt_device_specific_config_c {
 	u8 virtual_slot;
 };
 
+struct acpi_nhlt_render_device_specific_config {
+	u32 capabilities_size;
+	u8 virtual_slot;
+};
+
 struct acpi_nhlt_wave_extensible {
 	u16 format_tag;
 	u16 channel_count;
@@ -1573,17 +1576,22 @@ struct acpi_nhlt_mic_device_specific_config {
 
 /* Values for array_type_ext above */
 
-#define SMALL_LINEAR_2ELEMENT               0x0A
-#define BIG_LINEAR_2ELEMENT                 0x0B
-#define FIRST_GEOMETRY_LINEAR_4ELEMENT      0x0C
-#define PLANAR_LSHAPED_4ELEMENT             0x0D
-#define SECOND_GEOMETRY_LINEAR_4ELEMENT     0x0E
-#define VENDOR_DEFINED                      0x0F
-#define ARRAY_TYPE_MASK                     0x0F
-#define ARRAY_TYPE_EXT_MASK                 0x10
+#define ACPI_NHLT_ARRAY_TYPE_RESERVED               0x09	// 9 and below are reserved
+#define ACPI_NHLT_SMALL_LINEAR_2ELEMENT             0x0A
+#define ACPI_NHLT_BIG_LINEAR_2ELEMENT               0x0B
+#define ACPI_NHLT_FIRST_GEOMETRY_LINEAR_4ELEMENT    0x0C
+#define ACPI_NHLT_PLANAR_LSHAPED_4ELEMENT           0x0D
+#define ACPI_NHLT_SECOND_GEOMETRY_LINEAR_4ELEMENT   0x0E
+#define ACPI_NHLT_VENDOR_DEFINED                    0x0F
+#define ACPI_NHLT_ARRAY_TYPE_MASK                   0x0F
+#define ACPI_NHLT_ARRAY_TYPE_EXT_MASK               0x10
+
+#define ACPI_NHLT_NO_EXTENSION                      0x0
+#define ACPI_NHLT_MIC_SNR_SENSITIVITY_EXT           (1<<4)
 
-#define NO_EXTENSION                        0x0
-#define MIC_SNR_SENSITIVITY_EXT             0x1
+struct acpi_nhlt_vendor_mic_count {
+	u8 microphone_count;
+};
 
 struct acpi_nhlt_vendor_mic_config {
 	u8 type;
@@ -1603,22 +1611,25 @@ struct acpi_nhlt_vendor_mic_config {
 
 /* Values for Type field above */
 
-#define MIC_OMNIDIRECTIONAL                 0
-#define MIC_SUBCARDIOID                     1
-#define MIC_CARDIOID                        2
-#define MIC_SUPER_CARDIOID                  3
-#define MIC_HYPER_CARDIOID                  4
-#define MIC_8_SHAPED                        5
-#define MIC_VENDOR_DEFINED                  7
+#define ACPI_NHLT_MIC_OMNIDIRECTIONAL       0
+#define ACPI_NHLT_MIC_SUBCARDIOID           1
+#define ACPI_NHLT_MIC_CARDIOID              2
+#define ACPI_NHLT_MIC_SUPER_CARDIOID        3
+#define ACPI_NHLT_MIC_HYPER_CARDIOID        4
+#define ACPI_NHLT_MIC_8_SHAPED              5
+#define ACPI_NHLT_MIC_RESERVED6             6	// 6 is reserved
+#define ACPI_NHLT_MIC_VENDOR_DEFINED        7
+#define ACPI_NHLT_MIC_RESERVED              8	// 8 and above are reserved
 
 /* Values for Panel field above */
 
-#define MIC_TOP                             0
-#define MIC_BOTTOM                          1
-#define MIC_LEFT                            2
-#define MIC_RIGHT                           3
-#define MIC_FRONT                           4
-#define MIC_REAR                            5
+#define ACPI_NHLT_MIC_POSITION_TOP          0
+#define ACPI_NHLT_MIC_POSITION_BOTTOM       1
+#define ACPI_NHLT_MIC_POSITION_LEFT         2
+#define ACPI_NHLT_MIC_POSITION_RIGHT        3
+#define ACPI_NHLT_MIC_POSITION_FRONT        4
+#define ACPI_NHLT_MIC_POSITION_BACK         5
+#define ACPI_NHLT_MIC_POSITION_RESERVED     6	// 6 and above are reserved
 
 struct acpi_nhlt_vendor_mic_device_specific_config {
 	struct acpi_nhlt_mic_device_specific_config mic_array_device_config;
@@ -1633,8 +1644,9 @@ struct acpi_nhlt_mic_snr_sensitivity_extension {
 	u32 sensitivity;
 };
 
+/* Render device with feedback */
+
 struct acpi_nhlt_render_feedback_device_specific_config {
-	struct acpi_nhlt_device_specific_config device_config;
 	u8 feedback_virtual_slot;	// render slot in case of capture
 	u16 feedback_channels;	// informative only
 	u16 feedback_valid_bits_per_sample;
-- 
2.26.2




