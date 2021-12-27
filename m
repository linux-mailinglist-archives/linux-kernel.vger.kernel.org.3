Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1491E47FCC9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 13:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbhL0MwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 07:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbhL0MwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:52:01 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60829C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 04:52:01 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id t123so13550978pfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 04:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=9aFYPZXKzmDafO2auf3/6QRn9QC7vq8i5WcA0Y9xZ6c=;
        b=pRyt+gp3oWA47u6eHT7L7R1wOPjSAH54JQ2M5Aze4aIMLsymngl8aOnCELtOjPNDGb
         roNj1t+86vHcnZmL4oE2QACOyoGclGLCWZ4SzM3mB30keOvKOnOVTytxhMqInK77f8Ua
         PpvjzT6X/XLyRJJrMyIWuLl3qJzC4jhr1shOwGomSnOtmgwgrL+22UtLUBvwJHhByJh8
         nVB8H3uCPueHt8vjz0YZAJykx6q/8HdFvR0kGapSPFR1UcnJqNtvc3u/jLK+1PlDbD2Q
         OFUdTzuU213cKbgOyzbrF8OdnmXPJ43AEEK0W1qEA6ADyxqob7IUB3Dlu9p0mXMa1LCA
         ln1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9aFYPZXKzmDafO2auf3/6QRn9QC7vq8i5WcA0Y9xZ6c=;
        b=hbbEssy9W6f9sKuruhmUbHgMqH7rFu7SIgIpXKJMgc+IpzQPs+c0Lfpglur6Ms+15n
         k+gxBEBDs/k390Nu996zz0IERPpPhYWFlPriX0+H8klVqW5BAHyWbuHZNMYJ5D9IME+n
         TqD0YoD7Ba3a4NFe31J4eol57wXibKeEq6JlmPsuZhnCgJcmsq2ol27c2ovnveM5pM7Z
         /xzbIUB7usU32+RNsJoeEv4RqPjgTbMnaIOppDui4cLOauJgeeJurc6lQEHWaOC7dALj
         9p9q3x7Iyp/HIbkMeSmLHth8dM1Dxy8jZK4eXRNAgC1A4wl535QgdMmEpHB+6gXEHOrS
         Bo8w==
X-Gm-Message-State: AOAM532GpxbOGJdXJUElJQsqs5i3jqkTYW6wy3ynQWLnKILS1mlzEYpb
        /BSaGcn82moTu7FOKMfwB/c=
X-Google-Smtp-Source: ABdhPJx4bN/IiaNPezTWFQQgvtoj8yn9Dh1+jkgDDGKUqVrkqM2F0/V+u1pZgJW7kMOnbicEryw2Ug==
X-Received: by 2002:a63:af19:: with SMTP id w25mr15608279pge.438.1640609520971;
        Mon, 27 Dec 2021 04:52:00 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id q16sm13305049pfu.31.2021.12.27.04.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 04:52:00 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <marc.zyngier@altran.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: pxa: Fix error handling in viper_tpm_init
Date:   Mon, 27 Dec 2021 12:51:53 +0000
Message-Id: <20211227125154.3145-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tpm_device get by platform_device_alloc(), which calls device_initialize.
Call platform_device_put(tpm_device) instead of kfree(tmp_device) to
prevent memory leak.

Fixes: 352699a ("Basic support for the Arcom/Eurotech Viper SBC.")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-pxa/viper.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 3aa34e9a15d3..9a0f184dbecb 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -815,11 +815,11 @@ static void __init viper_tpm_init(void)
 					      sizeof(i2c_tpm_data))) {
 			if (platform_device_add(tpm_device)) {
 				errstr = "register TPM i2c bus";
-				goto error_free_tpm;
+				goto exit_put_device;
 			}
 		} else {
 			errstr = "allocate TPM i2c bus data";
-			goto error_free_tpm;
+			goto exit_put_device;
 		}
 	} else {
 		errstr = "allocate TPM i2c device";
@@ -827,9 +827,8 @@ static void __init viper_tpm_init(void)
 	}
 
 	return;
-
-error_free_tpm:
-	kfree(tpm_device);
+exit_put_device:
+	platform_device_put(tpm_device);
 error_tpm:
 	pr_err("viper: Couldn't %s, giving up\n", errstr);
 }
-- 
2.17.1

