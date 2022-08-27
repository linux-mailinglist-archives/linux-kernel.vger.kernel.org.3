Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012F35A37EE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 15:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiH0Na5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 09:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiH0Naz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 09:30:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D934521E2E;
        Sat, 27 Aug 2022 06:30:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74B3FB8013C;
        Sat, 27 Aug 2022 13:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0384EC433D6;
        Sat, 27 Aug 2022 13:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661607050;
        bh=NMxqpqaBLhAnK0P2jMNxG42gIO1zGsISRaqGFoRIfV0=;
        h=From:To:Cc:Subject:Date:From;
        b=aUmwBrPcCYxYZJqxv/+Bc3XGD3iJ24M63V3UQ06pqJ3u8BHN+rT8jheh+8Jl9sTwF
         pqOY9ZMwPKdKahy7abjK5oC35rgVwESoqhto3TZdrbSjvgfC6cZTL5D2VY5TDMdFdK
         8YYVAmN7ZvxOAUDinn1Hba0i5x7Eg9CTWaE1QWaL6nItbS9gasitu/CHqmyPMl6Rpy
         n/5rcXA6lvO8O55+yJ8ZFqkZ3ITIBeoyvt/M2VHZmwXc8IL+sdFaPTUaPDmGs3EjQa
         zn05bc9pJsQQfFMUY1e2D8MEUXc1tpODofiOirCgGu+Vr/hGenfEplsv7jvsLBCwhh
         ltpkzVkrt3KRA==
Received: by pali.im (Postfix)
        id F2586C7A; Sat, 27 Aug 2022 15:30:46 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: dell-wmi: Add WMI event 0x0012 0x0003 to the list
Date:   Sat, 27 Aug 2022 15:30:40 +0200
Message-Id: <20220827133040.15932-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like that on Dell Latitude E6440 is WMI event 0x0012 0x0003 sent
when display changes brightness. When it happens kernel prints
"dell_wmi: Unknown WMI event type 0x12" message into dmesg.

So ignore it for now to not spam dmesg.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/platform/x86/dell/dell-wmi-base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
index e07d3ba85a3f..0a259a27459f 100644
--- a/drivers/platform/x86/dell/dell-wmi-base.c
+++ b/drivers/platform/x86/dell/dell-wmi-base.c
@@ -344,6 +344,9 @@ static const struct key_entry dell_wmi_keymap_type_0011[] = {
  * They are events with extended data
  */
 static const struct key_entry dell_wmi_keymap_type_0012[] = {
+	/* Backlight brightness change event */
+	{ KE_IGNORE, 0x0003, { KEY_RESERVED } },
+
 	/* Ultra-performance mode switch request */
 	{ KE_IGNORE, 0x000d, { KEY_RESERVED } },
 
-- 
2.20.1

