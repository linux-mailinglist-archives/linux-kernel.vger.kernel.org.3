Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60DA4A64AC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242334AbiBATKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:10:05 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55632 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiBATKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:10:03 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id 00adadc5ffba56da; Tue, 1 Feb 2022 20:10:02 +0100
Received: from kreacher.localnet (unknown [213.134.162.64])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id D9E7066B3BC;
        Tue,  1 Feb 2022 20:10:01 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     Khuong Dinh <khuong@os.amperecomputing.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] perf: Replace acpi_bus_get_device()
Date:   Tue, 01 Feb 2022 20:10:01 +0100
Message-ID: <10025610.nUPlyArG6x@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.162.64
X-CLIENT-HOSTNAME: 213.134.162.64
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrgeefgdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepvddufedrudefgedrudeivddrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeivddrieegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopehkhhhuohhnghesohhsrdgrmhhpvghrvggtohhmphhuthhinhhgrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggt
 phhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace acpi_bus_get_device() that is going to be dropped with
acpi_fetch_acpi_dev().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/perf/thunderx2_pmu.c |    6 ++----
 drivers/perf/xgene_pmu.c     |    6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/perf/thunderx2_pmu.c
===================================================================
--- linux-pm.orig/drivers/perf/thunderx2_pmu.c
+++ linux-pm/drivers/perf/thunderx2_pmu.c
@@ -887,13 +887,11 @@ static struct tx2_uncore_pmu *tx2_uncore
 static acpi_status tx2_uncore_pmu_add(acpi_handle handle, u32 level,
 				    void *data, void **return_value)
 {
+	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
 	struct tx2_uncore_pmu *tx2_pmu;
-	struct acpi_device *adev;
 	enum tx2_uncore_type type;
 
-	if (acpi_bus_get_device(handle, &adev))
-		return AE_OK;
-	if (acpi_bus_get_status(adev) || !adev->status.present)
+	if (!adev || acpi_bus_get_status(adev) || !adev->status.present)
 		return AE_OK;
 
 	type = get_tx2_pmu_type(adev);
Index: linux-pm/drivers/perf/xgene_pmu.c
===================================================================
--- linux-pm.orig/drivers/perf/xgene_pmu.c
+++ linux-pm/drivers/perf/xgene_pmu.c
@@ -1549,14 +1549,12 @@ static const struct acpi_device_id *xgen
 static acpi_status acpi_pmu_dev_add(acpi_handle handle, u32 level,
 				    void *data, void **return_value)
 {
+	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
 	const struct acpi_device_id *acpi_id;
 	struct xgene_pmu *xgene_pmu = data;
 	struct xgene_pmu_dev_ctx *ctx;
-	struct acpi_device *adev;
 
-	if (acpi_bus_get_device(handle, &adev))
-		return AE_OK;
-	if (acpi_bus_get_status(adev) || !adev->status.present)
+	if (!adev || acpi_bus_get_status(adev) || !adev->status.present)
 		return AE_OK;
 
 	acpi_id = xgene_pmu_acpi_match_type(xgene_pmu_acpi_type_match, adev);



