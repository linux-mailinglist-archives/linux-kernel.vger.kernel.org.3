Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3381E539DC8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350105AbiFAHHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345311AbiFAHHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:07:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BD5BC32
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:07:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j2-20020a2597c2000000b0064b3e54191aso696200ybo.20
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 00:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lAKGb0lSp1bNkiKuJEzypZJll/zlqvzNkWZhsUnzLII=;
        b=MxzMPjivbh8UPmat16hBsiJmsp4xusaF/0CtHPB0ALBaGfGkOMgUpY8zIaxAPzAoDw
         Zl6+3kczb7YbM1rSrTx4wP/yTeTri3Jfl5+p6nJV1gEDeVI6VWvU3mpHCdD2qdiHVpXm
         wMjcXLMd29dryni46Yc0Gyx63Fpb+y0iXkhd060EohwmCgYoMEkLyxYIdeK67AN9X+XM
         l+63h8QaBbKw5BUcgNeyC9N3gk29Mj7R7JjXJI524jDGJ0i4z+1XeFvkV9Hj2umfL3Hv
         1c4OYmI4f54F2pIxXJZY02Znx1CwOy45KNza117L8OwoHgiV4UhpRUJ5V4rcFsZP52cT
         IB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lAKGb0lSp1bNkiKuJEzypZJll/zlqvzNkWZhsUnzLII=;
        b=iAoO1kFakXwd1F8MtKY5SMRcLSRhLDqvB5UQHZH7wTo4fP00hsMgGJNMHqj5TYxvft
         J2ATyElBu8j97xHfgQnHvZvBn9+RoArb90DbYebjVCdJHfb4ekfC65m+RoDHVBeudjzQ
         ccPpKBCZIYUELA2qka+TkeFiAPZwXfLaENPDjnprfbxz/hrzWZhr/kJDHb+gMndFwA2V
         x7VGvLXCfaP/3gXpLb2HDsu1OxpUQojq2SRgk32qvy+D3412prr1W3xSiMeWyyi3oWtL
         q89QEru0OmALQy1i+lMwR3Z8Uz4J+jkbisdg75enercE+N7CXKANJPL/29YD+ybtwSNt
         Mzhw==
X-Gm-Message-State: AOAM531ZT5Ox586AK0g1Z88cd1wFmEth5Gv2Z8BprHQ/pKg1qnZcAFLu
        KCWvzJ+szTYU5zffBW9nprlZmXiw/uOw+tk=
X-Google-Smtp-Source: ABdhPJw2d0Ydq+M1EKFVKl90vlnxKPzzmDAPtejNfxeIXjemJ3M++mFT/aYs9/m2glcq1N1UFunbFqMpHF9mXvo=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f3aa:cafe:c20a:e136])
 (user=saravanak job=sendgmr) by 2002:a0d:d416:0:b0:30c:15f1:64d6 with SMTP id
 w22-20020a0dd416000000b0030c15f164d6mr23080655ywd.394.1654067240020; Wed, 01
 Jun 2022 00:07:20 -0700 (PDT)
Date:   Wed,  1 Jun 2022 00:06:59 -0700
In-Reply-To: <20220601070707.3946847-1-saravanak@google.com>
Message-Id: <20220601070707.3946847-4-saravanak@google.com>
Mime-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 3/9] net: mdio: Delete usage of driver_deferred_probe_check_state()
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
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org
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

Now that fw_devlink=on by default and fw_devlink supports interrupt
properties, the execution will never get to the point where
driver_deferred_probe_check_state() is called before the supplier has
probed successfully or before deferred probe timeout has expired.

So, delete the call and replace it with -ENODEV.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/net/mdio/fwnode_mdio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index 1c1584fca632..3e79c2c51929 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -47,9 +47,7 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
 	 * just fall back to poll mode
 	 */
 	if (rc == -EPROBE_DEFER)
-		rc = driver_deferred_probe_check_state(&phy->mdio.dev);
-	if (rc == -EPROBE_DEFER)
-		return rc;
+		rc = -ENODEV;
 
 	if (rc > 0) {
 		phy->irq = rc;
-- 
2.36.1.255.ge46751e96f-goog

