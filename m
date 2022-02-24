Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF194C22D6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 05:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiBXECe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 23:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiBXECa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 23:02:30 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9997F16307A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 20:02:01 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id e18-20020aa78252000000b004df7a13daeaso583626pfn.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 20:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/9e1BpdB18N/h+O03rFt/auxApxhf9ck1ZQG4GiU3UM=;
        b=piKec3kie+4DnNUYnTAYNFqpevp6bwLv9gBwl5X2YzCuHC2QFmonycThgTFzxHayPX
         cDkrMKmg1cP3qaQeh7sSD4XlzzenLJkZhLxCNZfl/SyU4Ho1O12AUvRg7hbWqC6XiuYD
         jw0y8Vug/jqutE/znce2SmhYis8BVIBOpnniiCxkZEuY3m46aPt2ePKkFdlA/6APnRFv
         Izz0EZA5xp2/lzBMYlKKoR+RqM6wpfTms8wcZA7iSP37GGolY1wzC0kgT1p/cvmiZrKM
         qb7xiKC3bw6I/zH8kW9oW0HDmeeF6yiSOggDZolqRwNJAdhswLWRkcI6i2CD9ovy/Dzm
         8p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/9e1BpdB18N/h+O03rFt/auxApxhf9ck1ZQG4GiU3UM=;
        b=w3wcZEponQLs9Vh3EOTasXMUfBxaxnYk+ltlx4vceFveQ9lgcJDRkwFEdYnubYF38F
         lTao0wImcYAdzyG2MwRRGdPw7i9t0Pzl8V8m4fyEjQn/cmf+j+J5mi7PJGn7hLNZJjca
         f51an52gBIkK1S4NIuM+/8Oxp3drVEKw/mh/rxc8cl3J71wZM91fvMix2fDXRRtxDnen
         JoZeFjrcljAYBamE8qzca0Pz94D1adkTp+IXDQgrIntmvuEivQkYPizTrW6fLKW97b/b
         O1iodn2C8CtykQflHwk5NhBMsdNXRmqd+cDlixPIGkVszOciQVMQ2LShoGdDaczxg2tD
         wMQw==
X-Gm-Message-State: AOAM532o10Y9NrINv/wAFOiBE9eaiUJeLaTDkFEoUvO5Kighb2n4gb0i
        eegxJlqLU3KNYxQYoORAC9By4SOVrgVs7Q==
X-Google-Smtp-Source: ABdhPJx5XQBhtipfvGHOKjMWiAqgM+qv4WY1PGgppKx1Sv6Oro+4x0AMafffT1Gdzfns0sPsldgKqZwC98ekTA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:902:a701:b0:14d:5a15:ebaf with SMTP
 id w1-20020a170902a70100b0014d5a15ebafmr903268plq.33.1645675321064; Wed, 23
 Feb 2022 20:02:01 -0800 (PST)
Date:   Thu, 24 Feb 2022 12:01:37 +0800
Message-Id: <20220224040136.1595119-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH] firmware: google: Properly state IOMEM dependency
From:   David Gow <davidgow@google.com>
To:     Julius Werner <jwerner@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Hutchings <ben@decadent.org.uk>
Cc:     David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org
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

The Google Coreboot implementation requires IOMEM functions
(memmremap, memunmap, devm_memremap), but does not specify this is its
Kconfig. This results in build errors when IOMEM is not enabled, such as
on some UML configurations:

/usr/bin/ld: drivers/firmware/google/coreboot_table.o: in function `coreboot_table_probe':
coreboot_table.c:(.text+0x311): undefined reference to `memremap'
/usr/bin/ld: coreboot_table.c:(.text+0x34e): undefined reference to `memunmap'
/usr/bin/ld: drivers/firmware/google/memconsole-coreboot.o: in function `memconsole_probe':
memconsole-coreboot.c:(.text+0x12d): undefined reference to `memremap'
/usr/bin/ld: memconsole-coreboot.c:(.text+0x17e): undefined reference to `devm_memremap'
/usr/bin/ld: memconsole-coreboot.c:(.text+0x191): undefined reference to `memunmap'
/usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_section_destroy.isra.0':
vpd.c:(.text+0x300): undefined reference to `memunmap'
/usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_section_init':
vpd.c:(.text+0x382): undefined reference to `memremap'
/usr/bin/ld: vpd.c:(.text+0x459): undefined reference to `memunmap'
/usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_probe':
vpd.c:(.text+0x59d): undefined reference to `memremap'
/usr/bin/ld: vpd.c:(.text+0x5d3): undefined reference to `memunmap'
collect2: error: ld returned 1 exit status

Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/firmware/google/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
index 931544c9f63d..7ac866a985c6 100644
--- a/drivers/firmware/google/Kconfig
+++ b/drivers/firmware/google/Kconfig
@@ -21,7 +21,7 @@ config GOOGLE_SMI
 
 config GOOGLE_COREBOOT_TABLE
 	tristate "Coreboot Table Access"
-	depends on ACPI || OF
+	depends on IOMEM && (ACPI || OF)
 	help
 	  This option enables the coreboot_table module, which provides other
 	  firmware modules access to the coreboot table. The coreboot table
-- 
2.35.1.473.g83b2b277ed-goog

