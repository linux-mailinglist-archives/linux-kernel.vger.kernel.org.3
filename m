Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B353749D2AF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244523AbiAZTsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:48:53 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61572 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiAZTsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:48:52 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id 83b28c23bf1a1938; Wed, 26 Jan 2022 20:48:51 +0100
Received: from kreacher.localnet (unknown [213.134.162.63])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9AD6666B306;
        Wed, 26 Jan 2022 20:48:50 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] sound: Replace acpi_bus_get_device()
Date:   Wed, 26 Jan 2022 20:48:49 +0100
Message-ID: <2828205.e9J7NaK4W3@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.162.63
X-CLIENT-HOSTNAME: 213.134.162.63
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrfedugdduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepvddufedrudefgedrudeivddrieefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeivddrieefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtohepthhifigrihesshhushgvrdgtohhmpdhrtghpthhtoheprghlshgrqdguvghvvghlsegrlhhsrgdqphhrohhjvggtthdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpihgvrhhr
 vgdqlhhouhhishdrsghoshhsrghrtheslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace acpi_bus_get_device() that is going to be dropped with
acpi_fetch_acpi_dev().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 sound/hda/intel-sdw-acpi.c |    7 +++----
 sound/soc/soc-acpi.c       |    7 ++-----
 2 files changed, 5 insertions(+), 9 deletions(-)

Index: linux-pm/sound/hda/intel-sdw-acpi.c
===================================================================
--- linux-pm.orig/sound/hda/intel-sdw-acpi.c
+++ linux-pm/sound/hda/intel-sdw-acpi.c
@@ -50,11 +50,11 @@ static bool is_link_enabled(struct fwnod
 static int
 sdw_intel_scan_controller(struct sdw_intel_acpi_info *info)
 {
-	struct acpi_device *adev;
+	struct acpi_device *adev = acpi_fetch_acpi_dev(info->handle);
 	int ret, i;
 	u8 count;
 
-	if (acpi_bus_get_device(info->handle, &adev))
+	if (!adev)
 		return -EINVAL;
 
 	/* Found controller, find links supported */
@@ -119,7 +119,6 @@ static acpi_status sdw_intel_acpi_cb(acp
 				     void *cdata, void **return_value)
 {
 	struct sdw_intel_acpi_info *info = cdata;
-	struct acpi_device *adev;
 	acpi_status status;
 	u64 adr;
 
@@ -127,7 +126,7 @@ static acpi_status sdw_intel_acpi_cb(acp
 	if (ACPI_FAILURE(status))
 		return AE_OK; /* keep going */
 
-	if (acpi_bus_get_device(handle, &adev)) {
+	if (!acpi_fetch_acpi_dev(handle)) {
 		pr_err("%s: Couldn't find ACPI handle\n", __func__);
 		return AE_NOT_FOUND;
 	}
Index: linux-pm/sound/soc/soc-acpi.c
===================================================================
--- linux-pm.orig/sound/soc/soc-acpi.c
+++ linux-pm/sound/soc/soc-acpi.c
@@ -55,16 +55,13 @@ EXPORT_SYMBOL_GPL(snd_soc_acpi_find_mach
 static acpi_status snd_soc_acpi_find_package(acpi_handle handle, u32 level,
 					     void *context, void **ret)
 {
-	struct acpi_device *adev;
+	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
 	acpi_status status;
 	struct snd_soc_acpi_package_context *pkg_ctx = context;
 
 	pkg_ctx->data_valid = false;
 
-	if (acpi_bus_get_device(handle, &adev))
-		return AE_OK;
-
-	if (adev->status.present && adev->status.functional) {
+	if (adev && adev->status.present && adev->status.functional) {
 		struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
 		union acpi_object  *myobj = NULL;
 



