Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6788C534B71
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241025AbiEZIRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346686AbiEZIQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:16:36 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829204C7B6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:16:17 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f4dfd09d7fso8176837b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6dgEjD+4R2dKDRgscs/xv70YgyhfXrRwkUylnVTphfk=;
        b=XL1eUaOAcssMtqvMAb2JLoXAqGRiBPWRpPBJh6rTDvytgReAH+LjXHDFnDZXS9f9I2
         35g3JMRGxQZlCvxOhWMcOSoY7fmD/fBdQK3AfpTe4+KDVzo3ISAmWs2bpcJGBQMEHxn2
         XOrBvHACbTqtONiyNPB/vydyMzterA8qUwVfxsEqd+Vz+8qcEbmdk9FVpwyv4JToLFBL
         EPR58mdlFaKlltO8fCr0xZCvNvm+F4UFw5xJYUT6ue5rms9F3TPGMAGF7HdiGvNufzye
         R8r2YJjaY8RuLAuVFWX7SLMYTTkhhepWRDKwQDGC55z4gixqwa9JauWCwnOhgDgX/TTb
         SoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6dgEjD+4R2dKDRgscs/xv70YgyhfXrRwkUylnVTphfk=;
        b=iO/dDRtrRBOUjANtnwGihSK4F9PPoaLcv0PrfzBvwVVd0J8WVtvORrbrjoG3azUb0c
         CdIjAHUOOu/4YoTOQucKF545yn1Ybv2X/HSSRfK74RbuVu71l8PXfflF8ovuKz4OY7yU
         pAyPPbSSxgHuNbD1eGOTDZpo/Kr2zkWY25wRMx74Dq8r2a2ciGRSXGFpTF9wR+IY2pi2
         uKtRRLIgwW0uN4Pj4/o7tFtfNR39jKp5ijudQEV21fcU3SGLSxJoVJ/CF+IHWzKN/DZs
         8RaRLdDTzM2t79EwRz1JxIa6VmB92t1653WUaF4AfDenmay6E/xqpbYLXVnLKtqPgkoK
         cnng==
X-Gm-Message-State: AOAM533Csl1PI+/AILM7B49r7pKNre8yaA+tIFeuiA3CPazk5qWvc36L
        s91Q/mQqOkEeO66QrFwMpKOpsLzE2aQwOf0=
X-Google-Smtp-Source: ABdhPJx5hTzSS2LFu7RkqlQ7KLRzxV0Py+PZHVG9x+dcAcINC/1HXYTnTXlf9OdhjLu3DXMEHDG7SkiPohYReIE=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ff1f:a3b7:b6de:d30f])
 (user=saravanak job=sendgmr) by 2002:a25:fb12:0:b0:64d:d6fb:406a with SMTP id
 j18-20020a25fb12000000b0064dd6fb406amr34790013ybe.433.1653552977155; Thu, 26
 May 2022 01:16:17 -0700 (PDT)
Date:   Thu, 26 May 2022 01:15:47 -0700
In-Reply-To: <20220526081550.1089805-1-saravanak@google.com>
Message-Id: <20220526081550.1089805-9-saravanak@google.com>
Mime-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC PATCH v1 8/9] net: ipconfig: Force fw_devlink to unblock any
 devices that might probe
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        John Stultz <jstultz@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, iommu@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are network devices that could probe without some of their
suppliers probing and those network devices are needed for IP auto
config to work, then fw_devlink=on might break that usecase by blocking
the network devices from probing by the time IP auto config starts.

So, when IP auto config is enabled, make sure fw_devlink doesn't block
the probing of any device that has a driver by the time we get to IP
auto config.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 net/ipv4/ipconfig.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 9d41d5d5cd1e..aa7b8ba68ca6 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -1435,6 +1435,8 @@ static int __init wait_for_devices(void)
 {
 	int i;
 
+	fw_devlink_unblock_may_probe();
+
 	for (i = 0; i < DEVICE_WAIT_MAX; i++) {
 		struct net_device *dev;
 		int found = 0;
-- 
2.36.1.124.g0e6072fb45-goog

