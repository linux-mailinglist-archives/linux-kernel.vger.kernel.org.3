Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95C14E43D3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238852AbiCVQFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbiCVQF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:05:29 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662456F4BD;
        Tue, 22 Mar 2022 09:04:00 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 8cec46cd286a4186; Tue, 22 Mar 2022 17:03:59 +0100
Received: from kreacher.localnet (unknown [213.134.175.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 479F566B920;
        Tue, 22 Mar 2022 17:03:58 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Subject: [PATCH v1 1/2] ACPI: CPPC: Avoid out of bounds access when parsing _CPC data
Date:   Tue, 22 Mar 2022 17:02:05 +0100
Message-ID: <4725716.31r3eYUQgx@kreacher>
In-Reply-To: <5552457.DvuYhMxLoT@kreacher>
References: <5552457.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.187
X-CLIENT-HOSTNAME: 213.134.175.187
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudeghedgkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeetgefgleetgeduheeugeeikeevudelueelvdeufeejfeffgeefjedugfetfeehhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrddujeehrddukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudejhedrudekjedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgr
 shdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopehiohhnvghlrgdrvhhoihhnvghstghusegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the NumEntries field in the _CPC return package is less than 2, do
not attempt to access the "Revision" element of that package, because
it may not be present then.

Fixes: 337aadff8e45 ("ACPI: Introduce CPU performance controls using CPPC")
BugLink: https://lore.kernel.org/lkml/20220322143534.GC32582@xsang-OptiPlex-9020/
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/cppc_acpi.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-pm/drivers/acpi/cppc_acpi.c
===================================================================
--- linux-pm.orig/drivers/acpi/cppc_acpi.c
+++ linux-pm/drivers/acpi/cppc_acpi.c
@@ -679,6 +679,11 @@ int acpi_cppc_processor_probe(struct acp
 	cpc_obj = &out_obj->package.elements[0];
 	if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
 		num_ent = cpc_obj->integer.value;
+		if (num_ent <= 1) {
+			pr_debug("Unexpected _CPC NumEntries value (%d) for CPU:%d\n",
+				 num_ent, pr->id);
+			goto out_free;
+		}
 	} else {
 		pr_debug("Unexpected entry type(%d) for NumEntries\n",
 				cpc_obj->type);



