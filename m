Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25D152C5F7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiERWG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiERWGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:06:00 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D741666B1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:04:16 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id i24so3376824pfa.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/nGLK4xvSVUA2aTskL7KBthCb1HFoB9NWaLdwGSmKHI=;
        b=BI2RBE7OtfruFWTCNYrgW7SluCI1Rz1x30/zpufzVOuVeQ01dyyAl9KN+supk4ojPw
         GdvQYhtBojNjCzrclI30qnVPoypBgeo9+SsWAx194EvXhdWjCbQcLBkBIc6pdUknE90J
         XxrdkfQEZ8oMyivFmEzFxb+kEYZUVIRttm6B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/nGLK4xvSVUA2aTskL7KBthCb1HFoB9NWaLdwGSmKHI=;
        b=uP4VJQKRopcPUA6rFMl0NZ4rHS0DLexGAp8AJNCnpLlaYIyVL165/EWxKWxY97DE5W
         oh/uFfxF59snsYRlHVdzlGWi7LoSl6FLR6PJxLWvB75sCuz+0n9yIbTCTwx0a5JT3uro
         Kjl7MX3D23PyNHYk33YHNbmPqxRCikQ0jimHUwx5zFtQOYnD8ouMLKREUCOarEUXajSG
         p/k+CFpBGNkccWnnNlIb1I2FTTWMZCTW2i0QzvhdlniDKF0ROpiNGzLlSUJtlsBQI4Xs
         GG9hdkpDbXU6aJ2u9y2RhHXQgACFNzzpJi+6CzB4lOQBARizD/f1sk5ZvaepdsEf7SF2
         Yd7w==
X-Gm-Message-State: AOAM532KGqfM2YEYDW57lYSeE+QL/8nDgwHRasOYvEffCfOk6JF/zX9q
        lndHiTQyQOXi4Wvx23dC4hHejA==
X-Google-Smtp-Source: ABdhPJxXorvF4EPHY4DS+gEC8RdZC65si6o5SpHebhRG0HV11EiT/ZrxUJae2tcLmaUH8cRGnpDoXg==
X-Received: by 2002:a05:6a00:1145:b0:4f6:3ebc:a79b with SMTP id b5-20020a056a00114500b004f63ebca79bmr1609722pfm.41.1652911456421;
        Wed, 18 May 2022 15:04:16 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:620e:26da:4317:c2ee])
        by smtp.gmail.com with UTF8SMTPSA id p123-20020a622981000000b0051811c2aa89sm2407750pfp.196.2022.05.18.15.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 15:04:15 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@chromium.org>,
        linux-usb@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] usb: Probe EHCI, OHCI controllers asynchronously
Date:   Wed, 18 May 2022 15:02:51 -0700
Message-Id: <20220518150150.1.Ie8ea0e945a9c15066237014be219eed60066d493@changeid>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dtor@chromium.org>

initcall_debug shows that OHCI controllers take ~60ms to probe on
Rockchip RK3399 systems:

  probe of fe3a0000.usb returned 1 after 58941 usecs

A few of these can add up to waste non-trivial amounts of time at boot.

These host controllers don't provide resources to other drivers, so
this shouldn't contribute to exposing race conditions.

Chrome OS kernels have carried this patch on some systems for a while
without issues. Similar patches have been merged for a variety of (e)MMC
host controllers for similar reasons.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
[Brian: rewrote commit message, refreshed, but retained dtor's original
 authorship ]
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/usb/host/ehci-platform.c | 1 +
 drivers/usb/host/ohci-platform.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 1115431a255d..f343967443e2 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -518,6 +518,7 @@ static struct platform_driver ehci_platform_driver = {
 		.pm	= pm_ptr(&ehci_platform_pm_ops),
 		.of_match_table = vt8500_ehci_ids,
 		.acpi_match_table = ACPI_PTR(ehci_acpi_match),
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	}
 };
 
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 4a8456f12a73..47dfbfe9e519 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -334,6 +334,7 @@ static struct platform_driver ohci_platform_driver = {
 		.name	= "ohci-platform",
 		.pm	= &ohci_platform_pm_ops,
 		.of_match_table = ohci_platform_ids,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	}
 };
 
-- 
2.36.1.124.g0e6072fb45-goog

