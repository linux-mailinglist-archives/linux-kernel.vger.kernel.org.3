Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CB85574E6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiFWIIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiFWIIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:08:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F4618376
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:08:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-317765eb7ccso160036757b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0/eFU0mji1Y5TeAdS+iFtwLqEv6S9QVvc5w9MNgKvSI=;
        b=i4lCagk9B7bXzBTSvydWESPGMcIaTy587NpbP2mYAtDZ6jSJjooH6C+Y7/cK+vDe8p
         tjaVXz9Xf6G/kwdEKbckuIRmvlKQc0Isg70swEZfiBMBCe+S3DqlsKW/Vc8ddBvOPVjR
         lIvPheRYRhyuT/aqrXKaS7dyrpjaT1bLTWLtv8vqGjAQoGAdfDNhim8Pekrgn/FN48t1
         D/gMxBflHbRNNpG4enBqhdLz1PNLhMs6W1UECUryzvBYRrirEIKEhJEPYAfsSr+73pFd
         dJS6KNGeJqtSU8cTmMdAQUt0LX8fu7kIoK2f2KVE7L/935rTbDztPIh8OGI8pjdX5HBe
         1Gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0/eFU0mji1Y5TeAdS+iFtwLqEv6S9QVvc5w9MNgKvSI=;
        b=tKWTrwp1wW5WzGQQ1jR/GZVFBAzpV3HqlmA+F7TIRjyJ8W3qTfRBoNbi0s/7+hvTsM
         ECWGGoyKmHhbqhmUmD9W4ewT68uZxLhR5mgtUs3rgONHiahfMRUV9Bcv7sfJNNExlmnP
         o/D/2is/WHxJh/+zYs/o34nmDR9aUenDb+SjthYUfS9FnwlyuDMa8xTq3eAc//eB592H
         0g3iaKe/B4NWeKK7Ba501sJeCXmDVOBjqXMXR6DBHf2fwDVJLbzCZDk5+nuVPc8Ez3J6
         T/XiR7I4tW7gYXMw77bB9dzBSvBp6Kk6ZDrxA5b+cXvMzYvVZLhsB76cUlQe8vXCYPsU
         xZew==
X-Gm-Message-State: AJIora+7qN7vtKtElk0o+hn8ETWUG8XH6EwkKRfpDsuHpjS/nVV/H/r6
        I+Dn3VdkaZ245ueOPeFKeiJn3hcXIV8JGQA=
X-Google-Smtp-Source: AGRyM1tKZUYuUk4jgIOeWzWC4DuvxuYDkBy6JPSb9aejRHfp70WxuRAHiujgQUdpkfHS1fKlas2dvEUoIip4TbQ=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:8b2d:9894:73a4:8e1f])
 (user=saravanak job=sendgmr) by 2002:a81:9b97:0:b0:313:7c6f:8685 with SMTP id
 s145-20020a819b97000000b003137c6f8685mr9446552ywg.201.1655971686587; Thu, 23
 Jun 2022 01:08:06 -0700 (PDT)
Date:   Thu, 23 Jun 2022 01:03:41 -0700
Message-Id: <20220623080344.783549-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2 0/2] Fix console probe delay due to fw_devlink
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     sascha hauer <sha@pengutronix.de>, peng fan <peng.fan@nxp.com>,
        kevin hilman <khilman@kernel.org>,
        ulf hansson <ulf.hansson@linaro.org>,
        len brown <len.brown@intel.com>, pavel machek <pavel@ucw.cz>,
        joerg roedel <joro@8bytes.org>, will deacon <will@kernel.org>,
        andrew lunn <andrew@lunn.ch>,
        heiner kallweit <hkallweit1@gmail.com>,
        russell king <linux@armlinux.org.uk>,
        "david s. miller" <davem@davemloft.net>,
        eric dumazet <edumazet@google.com>,
        jakub kicinski <kuba@kernel.org>,
        paolo abeni <pabeni@redhat.com>,
        linus walleij <linus.walleij@linaro.org>,
        hideaki yoshifuji <yoshfuji@linux-ipv6.org>,
        david ahern <dsahern@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fw_devlink.strict=1 has been enabled by default. This was delaying the
probe of console devices. This series fixes that.

v1->v2:
- Added missing NULL check
- Added Tested-by tags

-Saravana

cc: sascha hauer <sha@pengutronix.de>
cc: peng fan <peng.fan@nxp.com>
cc: kevin hilman <khilman@kernel.org>
cc: ulf hansson <ulf.hansson@linaro.org>
cc: len brown <len.brown@intel.com>
cc: pavel machek <pavel@ucw.cz>
cc: joerg roedel <joro@8bytes.org>
cc: will deacon <will@kernel.org>
cc: andrew lunn <andrew@lunn.ch>
cc: heiner kallweit <hkallweit1@gmail.com>
cc: russell king <linux@armlinux.org.uk>
cc: "david s. miller" <davem@davemloft.net>
cc: eric dumazet <edumazet@google.com>
cc: jakub kicinski <kuba@kernel.org>
cc: paolo abeni <pabeni@redhat.com>
cc: linus walleij <linus.walleij@linaro.org>
cc: hideaki yoshifuji <yoshfuji@linux-ipv6.org>
cc: david ahern <dsahern@kernel.org>
cc: kernel-team@android.com
cc: linux-kernel@vger.kernel.org
cc: linux-pm@vger.kernel.org
cc: iommu@lists.linux-foundation.org
cc: netdev@vger.kernel.org
cc: linux-gpio@vger.kernel.org
Cc: kernel@pengutronix.de

Saravana Kannan (2):
  driver core: fw_devlink: Allow firmware to mark devices as best effort
  of: base: Avoid console probe delay when fw_devlink.strict=1

 drivers/base/core.c    | 3 ++-
 drivers/of/base.c      | 2 ++
 include/linux/fwnode.h | 4 ++++
 3 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.37.0.rc0.161.g10f37bed90-goog

