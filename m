Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68834C4BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243611AbiBYRW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243599AbiBYRW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:22:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE0B22320A;
        Fri, 25 Feb 2022 09:21:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0381B832AF;
        Fri, 25 Feb 2022 17:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC609C340E7;
        Fri, 25 Feb 2022 17:21:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="avzQXB0S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645809710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yyp0XBR2LBG6ybQpSRV5Mk5rlFmokNbyKi7/2GKEXSM=;
        b=avzQXB0Sz6ebvM/yT8r4bVRCQnlmoohAGQbJf/M8sVjbHOrx/UXxFZNihPoWCeeZrYWaEN
        qbk23OIlhazsFJLjUT8kd3DcEo8ZCQWTEqRFeQhZKNzBMRDCrGfLmmm5pWnfgoUXQ7LkfT
        FQxD44/UGXgZmE609kLiFcYDHelRr4E=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d56f47f5 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 25 Feb 2022 17:21:49 +0000 (UTC)
Date:   Fri, 25 Feb 2022 18:21:45 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Alexander Graf <graf@amazon.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [PATCH] ACPI: bus: Match first 9 bytes of device IDs
Message-ID: <YhkQKfE8ErtFBmSB@zx2c4.com>
References: <20220225155552.30636-1-graf@amazon.com>
 <CAMj1kXGtANm3SMoREymDSyx+wpn3L=Ex5q5mpgQigOwmEp33Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGtANm3SMoREymDSyx+wpn3L=Ex5q5mpgQigOwmEp33Lg@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 6:13 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The device subsystem side of things already deals with this properly:
> the modalias of the QEMU vmgenid device comes up as
> 'acpi:QEMUVGID:VM_GEN_COUNTER', which means it already captures the
> entire string, and exposes it in the correct way (modulo the all caps)

Ahh, so the userspace side of this won't work right. Shucks. That's what
I was concerned about.

> I don't like this hack. If we are going to accept the fact that CIDs
> could be arbitrary length strings, we should handle them properly.
>
> So what we need is a way for a module to describe its compatibility
> with such a _CID, which shouldn't be that complicated.

Can't we do something more boring and just...

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 4bb71979a8fd..5da5d990ff58 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -210,9 +210,9 @@ struct css_device_id {
 	__u8 type; /* subchannel type */
 	kernel_ulong_t driver_data;
 };
 
-#define ACPI_ID_LEN	9
+#define ACPI_ID_LEN	16
 
 struct acpi_device_id {
 	__u8 id[ACPI_ID_LEN];
 	kernel_ulong_t driver_data;


As you can see from the context, those additional 7 bytes were being
wasted on padding anyway inside the acpi_device_id struct, so it's
basically free, it would seem. This seems like the least convoluted way
of solving this issue? If we ever encounter _more_ ACPI devices with
weird names, we could revisit a fancy dynamic solution, but for now, why
don't we keep it simple?

Jason
