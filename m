Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE0547981E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 03:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhLRCJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 21:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhLRCJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 21:09:32 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55392C061574;
        Fri, 17 Dec 2021 18:09:32 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id x1-20020a17090a2b0100b001b103e48cfaso5336193pjc.0;
        Fri, 17 Dec 2021 18:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=88sLAXKbpDtuckNappVG5AxY3AxdKv0wD92jwdKYDFo=;
        b=NUrwECMo5wRr//176ypvuNcJwzdwMws77hAy68rN50243IdUlXqijNxYYgjZ/CBHdW
         V9SC9dPsvIREFD+NY8Fpl7wi1DcDLZ5/VhaeknCxTuxsb1J71doLDFfBJBwIvZLfiCTX
         dPl9oEjL8LGrO19q2PreIr0WnebmmJGQU8aRqjtShHvyQmydjuXk1RUiKWN+pF1N6PrR
         ZPNBdThKUCHDiRHuf59glurWn6xoMS6Vx2qZMZjCwqyhBL9qNfJRACp2F6IjSh8cDHPJ
         HBKMi9E92EL+C7JrKnaQ/Ac3m5yyJWgm/hLuahj4Zn0y1q4r1aoMzm1JSKnY2gawSQ+3
         JObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=88sLAXKbpDtuckNappVG5AxY3AxdKv0wD92jwdKYDFo=;
        b=GvwcqA0Rn1He+hEY+DWl4Dg7BbsaFUvbb6I2LL4DRkA0DsXFn1FJ82LsqNNKVI3CJS
         DLSOwlWxG01idjGP+DXhdy0aY40OU8HNJ1C29A67U5gD8kAVPEE9Jb8Qy1q+0k01tngD
         fyKfReehz40AmBBBscXSUd/6Y00wL0SORBgIRO0J2RYF+rbwguMncb+bfOCy9hxBWoXH
         Bgy4McUZYBk0220JkMPW1JdDDgB0YCWuuaSXfKqNx2hpb7qkheDhrXBTdvg1xO05yBNL
         8WDpKbkEJciIkunVqsNMBhthBAlkb941rPCLi/JreEiAgz5YqytCOmYGDXWIA8PmdoG/
         xvjw==
X-Gm-Message-State: AOAM531C0Eo+zdnAd1Zj5YI608spTVMMg6i3c4PKbjBjdb+NQHKsC4jU
        VwIfGg+cidPz7/9oa1JddP0=
X-Google-Smtp-Source: ABdhPJx2Au3Ajb0Yhbc6biqjKH3SIVs1XyMXKIWSWaA9YTHtB7mStvh3YfgJz7bdn9865v/FP6tT5w==
X-Received: by 2002:a17:90b:2504:: with SMTP id ns4mr8461021pjb.40.1639793371832;
        Fri, 17 Dec 2021 18:09:31 -0800 (PST)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id g1sm9287137pgm.23.2021.12.17.18.09.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Dec 2021 18:09:31 -0800 (PST)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>
Subject: [PATCH] integrity: Do not load MOK and MOKx when secure boot be disabled
Date:   Sat, 18 Dec 2021 10:09:05 +0800
Message-Id: <20211218020905.7187-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The security of Machine Owner Key (MOK) relies on secure boot. When
secure boot is disabled, EFI firmware will not verify binary code. Then
arbitrary efi binary code can modify MOK when rebooting.

This patch prevents MOK/MOKx be loaded when secure boot be disabled.

Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 security/integrity/platform_certs/load_uefi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index f290f78c3f30..08b6d12f99b4 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -6,6 +6,7 @@
 #include <linux/err.h>
 #include <linux/efi.h>
 #include <linux/slab.h>
+#include <linux/ima.h>
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
 #include "../integrity.h"
@@ -176,6 +177,10 @@ static int __init load_uefi_certs(void)
 		kfree(dbx);
 	}
 
+	/* the MOK/MOKx can not be trusted when secure boot is disabled */
+	if (!arch_ima_get_secureboot())
+		return 0;
+
 	mokx = get_cert_list(L"MokListXRT", &mok_var, &mokxsize, &status);
 	if (!mokx) {
 		if (status == EFI_NOT_FOUND)
-- 
2.26.2

