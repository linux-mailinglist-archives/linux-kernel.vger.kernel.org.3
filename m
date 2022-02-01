Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350BE4A6310
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbiBAR6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:58:13 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58358 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbiBAR6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:58:11 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id 4ac486d4d9c5cd3e; Tue, 1 Feb 2022 18:58:10 +0100
Received: from kreacher.localnet (unknown [213.134.162.64])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id B0CF566B390;
        Tue,  1 Feb 2022 18:58:09 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: [PATCH] hwtracing: coresight: Replace acpi_bus_get_device()
Date:   Tue, 01 Feb 2022 18:58:09 +0100
Message-ID: <5790600.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.162.64
X-CLIENT-HOSTNAME: 213.134.162.64
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrgeefgddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepvddufedrudefgedrudeivddrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeivddrieegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheprghlvgigrghnuggvrhdrshhhihhshhhkihhnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrthhhihgvuhdrphhoihhrihgvrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhuiihukhhirdhpohhulhhoshgvsegrrhhmrdgtohhmpdhrtghpthhtohepmhhikhgvrdhlvggrtghhsehlihhnrghrohdrohhrghdprhgtphht
 thhopehlvghordihrghnsehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace acpi_bus_get_device() that is going to be dropped with
acpi_fetch_acpi_dev().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/hwtracing/coresight/coresight-platform.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/hwtracing/coresight/coresight-platform.c
===================================================================
--- linux-pm.orig/drivers/hwtracing/coresight/coresight-platform.c
+++ linux-pm/drivers/hwtracing/coresight/coresight-platform.c
@@ -626,7 +626,7 @@ static int acpi_coresight_parse_link(str
 				     const union acpi_object *link,
 				     struct coresight_connection *conn)
 {
-	int rc, dir;
+	int dir;
 	const union acpi_object *fields;
 	struct acpi_device *r_adev;
 	struct device *rdev;
@@ -643,9 +643,9 @@ static int acpi_coresight_parse_link(str
 	    fields[3].type != ACPI_TYPE_INTEGER)
 		return -EINVAL;
 
-	rc = acpi_bus_get_device(fields[2].reference.handle, &r_adev);
-	if (rc)
-		return rc;
+	r_adev = acpi_fetch_acpi_dev(fields[2].reference.handle);
+	if (!r_adev)
+		return -ENODEV;
 
 	dir = fields[3].integer.value;
 	if (dir == ACPI_CORESIGHT_LINK_MASTER) {



