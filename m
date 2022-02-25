Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7320E4C49C3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242453AbiBYP46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237999AbiBYP44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:56:56 -0500
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237941D8A82;
        Fri, 25 Feb 2022 07:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1645804584; x=1677340584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SWyuAuqtzwMzh5dusk1nwmrFDHzqhA5gzL9zdrzlblw=;
  b=nxT/lWz5t/rOIFwsLbsG74pH+PZoN4XgwZdxmqDd8kAeax/xutL6lxDS
   cvYkqcF3LgwHR7tkop9//Ku0kzu4oEZla5Sa12XN9t9AQk4XIPZ3gMXwG
   0Rf1aaaUis3J5qQ7WInRsNFFF/2/JA/VrCVySaPUHVesqd/1WjHvJaWPC
   Y=;
X-IronPort-AV: E=Sophos;i="5.90,136,1643673600"; 
   d="scan'208";a="66236117"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-9a235a16.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP; 25 Feb 2022 15:56:06 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-9a235a16.us-east-1.amazon.com (Postfix) with ESMTPS id DEFF381488;
        Fri, 25 Feb 2022 15:56:02 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Fri, 25 Feb 2022 15:56:02 +0000
Received: from u79c5a0a55de558.ant.amazon.com (10.43.160.203) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Fri, 25 Feb 2022 15:56:00 +0000
From:   Alexander Graf <graf@amazon.com>
To:     <linux-acpi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        "Greg KH" <gregkh@linuxfoundation.org>, <ardb@kernel.org>,
        <dwmw@amazon.co.uk>
Subject: [PATCH] ACPI: bus: Match first 9 bytes of device IDs
Date:   Fri, 25 Feb 2022 16:55:52 +0100
Message-ID: <20220225155552.30636-1-graf@amazon.com>
X-Mailer: git-send-email 2.28.0.394.ge197136389
MIME-Version: 1.0
X-Originating-IP: [10.43.160.203]
X-ClientProxiedBy: EX13D16UWC004.ant.amazon.com (10.43.162.72) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We create a list of ACPI "PNP" IDs which contains _HID, _CID and CLS
entries of the respective devices. However, we squeeze them into
struct acpi_device_id which only has 9 bytes space to store the identifier
based on the ACPI spec:

"""
A _HID object evaluates to either a numeric 32-bit compressed EISA
type ID or a string. If a string, the format must be an alphanumeric
PNP or ACPI ID with no asterisk or other leading characters.
A valid PNP ID must be of the form "AAA####" where A is an uppercase
letter and # is a hex digit.
A valid ACPI ID must be of the form "NNNN####" where N is an uppercase
letter or a digit ('0'-'9') and # is a hex digit. This specification
reserves the string "ACPI" for use only with devices defined herein.
It further reserves all strings representing 4 HEX digits for
exclusive use with PCI-assigned Vendor IDs.
"""

While most people adhere to the ACPI specs, Microsoft decided that its
VM Generation Counter device [1] should only be identifiable by _CID with
an value of "VM_Gen_Counter" - longer than 9 characters.

To still allow device drivers to match identifiers that exceed the 9 byte
limit, without wasting memory for the unlikely case that you have long
identifiers, let's match only the first 9 characters of the identifier.

This patch is a prerequisite to add support for VMGenID in Linux [2].

[1] https://download.microsoft.com/download/3/1/C/31CFC307-98CA-4CA5-914C-D9772691E214/VirtualMachineGenerationID.docx
[2] https://lore.kernel.org/lkml/20220225124848.909093-1-Jason@zx2c4.com/

Signed-off-by: Alexander Graf <graf@amazon.com>

---

Alternatives to the approach above would be:

  1) Always set id[8] = '\0' in acpi_add_id()
  2) Allocate the id in struct acpi_device_id dynamically

I'm happy to explore option 1 instead if people believe it's cleaner.
Option 2 on the other hand seems overkill for the issue at hand. We don't
have a lot of devices that exceed the 8 character threshold, so chance of
collision is quite small. On the other hand, the extra overhead of
maintaining the string allocation dynamically will quickly become a
headache.

---
 drivers/acpi/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 07f604832fd6..aba93171739f 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -829,7 +829,7 @@ static bool __acpi_match_device(struct acpi_device *device,
 		/* First, check the ACPI/PNP IDs provided by the caller. */
 		if (acpi_ids) {
 			for (id = acpi_ids; id->id[0] || id->cls; id++) {
-				if (id->id[0] && !strcmp((char *)id->id, hwid->id))
+				if (id->id[0] && !strncmp((char *)id->id, hwid->id, ACPI_ID_LEN))
 					goto out_acpi_match;
 				if (id->cls && __acpi_match_device_cls(id, hwid))
 					goto out_acpi_match;
-- 
2.16.4




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



