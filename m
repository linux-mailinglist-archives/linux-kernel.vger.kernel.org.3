Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268D65574E8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiFWII3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiFWIIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:08:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD7E2656F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:08:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j2-20020a2597c2000000b0064b3e54191aso16637124ybo.20
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s9ND+o/2c+yLLqaQvSasSfGJRux3sdgC6yXqcCSmvC4=;
        b=ZChn5ahWF9VYjMaZyt75gRGdRRm9LYwWwkstPyFagKQEAyvitoOq9K9PtewRoCDhSM
         tAkvp8C+6vLvaAyusyWYI21A6zVjKa5/J8gAEms2VIQwhv3yjw+3NCR2DEx9uxGeN2QJ
         rS/zNPMzlbhn4YaJRa/lxLtaxH9A7m6NK3ZdXGOgoyyBfWLvx+PDntcmTJFeXZvqRilJ
         IYZVG4M+dhM5VQEV4SPScrfViR40Ehpl3D5iBw+7OCCiUX0dCoDDiuZRzruyfOzLI4Ou
         MQ3GXEQicXFecGuaW/OqF2wd1VI2EawxBbtZm4yAP8J1jKc/GtvpSLqNqDM4p5NK5zZS
         759w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s9ND+o/2c+yLLqaQvSasSfGJRux3sdgC6yXqcCSmvC4=;
        b=EPYra8M2CrOWdisAzi3uuY/JAwk5Ibt0didfYuLVSuzwmHzrik9rdogYZeEUPmPoSl
         Jh3Dj93rvuVMtY2EZPDvd8Lj3ZSFycjdojunplPUjJJ5D3NQR1KdqEm9M3qslJ2MNg/Z
         /Gf5UslXF0FaYr9sE/DhePAns8JkDN2+AM/rk/Y6wyIXTPgvlQdxTE4Nm20HO/FSeS5h
         yzmlSa8DjZnf0aZ+BAoRikpLLRAM4ku6kZVUG5nMyPjaTqMJL6i08uIXvz8WRzl4+YjL
         vw4GgNFTkaDuNiiOkvb9vCUKGdu8CExDPDXcdsYfSJRSP5hJBqhGujQ3Q4Tbaskjy3vP
         DZyA==
X-Gm-Message-State: AJIora9oRQ6cu79MLGSOjclN8Bla1PzoeJGgQNnAwhMMtBI4zB/283JD
        ElJIhKB6aUgokNyQBGuS/hznTTY/XQYMBNo=
X-Google-Smtp-Source: AGRyM1sE5BByBONr09uTGuYvikqMrbKKy57XSWWEHEYrg9GZbQPbgu/DImBH3QXHzvbDpX1ROMvYGcf5ilhwWN4=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:8b2d:9894:73a4:8e1f])
 (user=saravanak job=sendgmr) by 2002:a81:7007:0:b0:317:912a:32a3 with SMTP id
 l7-20020a817007000000b00317912a32a3mr9395945ywc.194.1655971692862; Thu, 23
 Jun 2022 01:08:12 -0700 (PDT)
Date:   Thu, 23 Jun 2022 01:03:43 -0700
In-Reply-To: <20220623080344.783549-1-saravanak@google.com>
Message-Id: <20220623080344.783549-3-saravanak@google.com>
Mime-Version: 1.0
References: <20220623080344.783549-1-saravanak@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2 2/2] of: base: Avoid console probe delay when fw_devlink.strict=1
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 71066545b48e ("driver core: Set fw_devlink.strict=1 by default")
enabled iommus and dmas dependency enforcement by default. On some
systems, this caused the console device's probe to get delayed until the
deferred_probe_timeout expires.

We need consoles to work as soon as possible, so mark the console device
node with FWNODE_FLAG_BEST_EFFORT so that fw_delink knows not to delay
the probe of the console device for suppliers without drivers. The
driver can then make the decision on where it can probe without those
suppliers or defer its probe.

Fixes: 71066545b48e ("driver core: Set fw_devlink.strict=1 by default")
Reported-by: Sascha Hauer <sha@pengutronix.de>
Reported-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
Tested-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/of/base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index d4f98c8469ed..a19cd0c73644 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1919,6 +1919,8 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 			of_property_read_string(of_aliases, "stdout", &name);
 		if (name)
 			of_stdout = of_find_node_opts_by_path(name, &of_stdout_options);
+		if (of_stdout)
+			of_stdout->fwnode.flags |= FWNODE_FLAG_BEST_EFFORT;
 	}
 
 	if (!of_aliases)
-- 
2.37.0.rc0.161.g10f37bed90-goog

