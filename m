Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C7C48CAF9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356270AbiALS2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 13:28:21 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44696 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243657AbiALS2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:28:04 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id 2fc06adbf11031c1; Wed, 12 Jan 2022 19:28:03 +0100
Received: from kreacher.localnet (unknown [213.134.181.123])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 2CE3F66B132;
        Wed, 12 Jan 2022 19:28:02 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v1 1/2] ACPI: CPPC: Fix up I/O port access in cpc_read()
Date:   Wed, 12 Jan 2022 19:26:32 +0100
Message-ID: <5789025.lOV4Wx5bFT@kreacher>
In-Reply-To: <11905930.O9o76ZdvQC@kreacher>
References: <11905930.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.123
X-CLIENT-HOSTNAME: 213.134.181.123
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrtddugdekkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepteeggfelteegudehueegieekveduleeuledvueefjeefffegfeejudfgteefhefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddufedrudefgedrudekuddruddvfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurdduvdefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhdrtggrrhhpvghnthgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepshhtvghvvghnsehv
 rghlvhgvshhofhhtfigrrhgvrdgtohhmpdhrtghpthhtoheprhgrhidrhhhurghnghesrghmugdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The code as currently implemented does not work on big endian systems,
so fix it up.

Fixes: a2c8f92bea5f ("ACPI: CPPC: Implement support for SystemIO registers")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/linux-acpi/20220111092928.GA24968@kili/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/cppc_acpi.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/cppc_acpi.c
===================================================================
--- linux-pm.orig/drivers/acpi/cppc_acpi.c
+++ linux-pm/drivers/acpi/cppc_acpi.c
@@ -929,16 +929,18 @@ static int cpc_read(int cpu, struct cpc_
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
 		u32 width = 8 << (reg->access_width - 1);
+		u32 val_u32;
 		acpi_status status;
 
 		status = acpi_os_read_port((acpi_io_address)reg->address,
-					   (u32 *)val, width);
+					   &val_u32, width);
 		if (ACPI_FAILURE(status)) {
 			pr_debug("Error: Failed to read SystemIO port %llx\n",
 				 reg->address);
 			return -EFAULT;
 		}
 
+		*val = val_u32;
 		return 0;
 	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);



