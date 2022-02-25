Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9050B4C4B85
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243392AbiBYQ6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbiBYQ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:58:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4D05BD26;
        Fri, 25 Feb 2022 08:57:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 454BC61CF5;
        Fri, 25 Feb 2022 16:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEACBC340E7;
        Fri, 25 Feb 2022 16:57:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TDxbmhnd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645808249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oko4i9ycomsYP38wIRGd+bBjhb7N3Fz+ZbyUitFcD8A=;
        b=TDxbmhndZjIrUUsXHOnhjPRFR5G9gl/zqx7Y50i1YTdSz/jOqQPEdwI5b0wOhAeQ4B4yh6
        LB7xD4sZkNj4K9P1b9V3yjLOcpJfXy6cWMK4FAh1HFfgaahkAW0yEWMa+2xrpT//4NZtEq
        zSBteWtG1sBoEE7b1/A2US6AP8hw8Bs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ecbf4e30 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 25 Feb 2022 16:57:28 +0000 (UTC)
Date:   Fri, 25 Feb 2022 17:57:23 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Alexander Graf <graf@amazon.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, ardb@kernel.org,
        dwmw@amazon.co.uk
Subject: Re: [PATCH] ACPI: bus: Match first 9 bytes of device IDs
Message-ID: <YhkKc2fa8dSTA9pc@zx2c4.com>
References: <20220225155552.30636-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220225155552.30636-1-graf@amazon.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Thanks for this.

I tested this out with the vmgenid driver, and I found a bug in this v1:

On Fri, Feb 25, 2022 at 04:55:52PM +0100, Alexander Graf wrote:
> -				if (id->id[0] && !strcmp((char *)id->id, hwid->id))
> +				if (id->id[0] && !strncmp((char *)id->id, hwid->id, ACPI_ID_LEN))

This only worked once I made that `ACPI_ID_LEN - 1`, because that length
includes the null terminator. The below patch works fine. If you adjust
that and send a quick v2 follow-up, I'm happy to ack it.

Regards,
Jason

--------8<--------------------------

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 07f604832fd6..f179ebf16f21 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -829,7 +829,7 @@ static bool __acpi_match_device(struct acpi_device *device,
 		/* First, check the ACPI/PNP IDs provided by the caller. */
 		if (acpi_ids) {
 			for (id = acpi_ids; id->id[0] || id->cls; id++) {
-				if (id->id[0] && !strcmp((char *)id->id, hwid->id))
+				if (id->id[0] && !strncmp((char *)id->id, hwid->id, ACPI_ID_LEN - 1))
 					goto out_acpi_match;
 				if (id->cls && __acpi_match_device_cls(id, hwid))
 					goto out_acpi_match;
diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index b503c210c2d7..04751fc1d365 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -78,8 +78,7 @@ static void vmgenid_acpi_notify(struct acpi_device *device, u32 event)
 }

 static const struct acpi_device_id vmgenid_ids[] = {
-	{ "QEMUVGID", 0 },	/* QEMU */
-	{ "VMGENID", 0 },	/* Firecracker */
+	{ "VM_GEN_C", 0 }, /* Truncated "VM_Gen_Counter" */
 	{ },
 };
