Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD2649F792
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347873AbiA1Kt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245635AbiA1Ktz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:49:55 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C987C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 02:49:55 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id x23so11058027lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 02:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=oxpnsh/OUctFb6T79J0flVx8GBK6w+VDMjJn6kjBEBU=;
        b=dmHlUM8ZeNPTS9fNp72+MzkocS55sCGHtUFThTZ6ux65eaSH3bNFHf/tAzzIyEMPat
         GQf2mDUA0RQCNnN3grDOB4FkHFdE1+eaJ91Ms0qPgrBrklgrvQmxeCMCvW0WqZf5VBE5
         WiKzBxjnS4QCXB3T1ExKCioEvIC6rQh4KRhLXpZCSAEZZ5MPDUFV9MFX9Mp2ngLv7rqh
         etGQ/dCWHChDysjiLhvxb3mzxD2aj4CaOOeY33rNRlijN/DcIu9zp9v4khHfMBZOMFg0
         FKOuMqigudwM9Fvy2c+U7oyueUmfU2OHbTXmfm6ZETgqN9fYKY2k7LTjE0qBwexK4qnr
         jkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=oxpnsh/OUctFb6T79J0flVx8GBK6w+VDMjJn6kjBEBU=;
        b=tKU88M+EyymP3y4A9puvNTaf0f2fFdeM5zslJzTqV87xH0LjYXIz7B7IFDk6XQ81X9
         e3naMRqLKAow/xuA37XrAgUS5LKE5FCCMEcCfo5VsZACpaOBlZX5iLLL+b081skHOa3s
         IpCAPLR9b0qsJDELIPqZcjwdvS9mIiHRlY5ChZnrozbxVLU5u5XNvYXBOuDs01kZ/Cxl
         xEIZyaIf2o60WuJLsKTcIyz1UDjIXcXXIBWLJOlRjkoCAgD61ZLENwMUPlVak8NmwUqi
         CTY3R0fc1OufJPndeFezaF6Iozd20bGJkDuzY89olL5obZemjlsfRjewLQLoAAjMCD2T
         oiVQ==
X-Gm-Message-State: AOAM531jAoMfHlXJeiv4RoLBf2J5E5VX88VkRW8VFN2uubwUL6TRbj6K
        Y0VWb1aQnpnS4BbfBUaMSxkHzQ==
X-Google-Smtp-Source: ABdhPJwDRpUxlnB9lHsjOwDBsDTd1U5eE1VFJdpKW6Hn6w5fr1gv4ge/x0ZaMXjlAe7tkhU3qJwWsA==
X-Received: by 2002:a05:6512:49b:: with SMTP id v27mr5864291lfq.396.1643366993419;
        Fri, 28 Jan 2022 02:49:53 -0800 (PST)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id v29sm1931347ljv.72.2022.01.28.02.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 02:49:53 -0800 (PST)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 2/2] net: dsa: mv88e6xxx: Improve indirect addressing performance
Date:   Fri, 28 Jan 2022 11:49:38 +0100
Message-Id: <20220128104938.2211441-3-tobias@waldekranz.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128104938.2211441-1-tobias@waldekranz.com>
References: <20220128104938.2211441-1-tobias@waldekranz.com>
MIME-Version: 1.0
Organization: Westermo
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this change, both the read and write callback would start out
by asserting that the chip's busy flag was cleared. However, both
callbacks also made sure to wait for the clearing of the busy bit
before returning - making the initial check superfluous. The only
time that would ever have an effect was if the busy bit was initially
set for some reason.

With that in mind, make sure to perform an initial check of the busy
bit, after which both read and write can rely the previous operation
to have waited for the bit to clear.

This cuts the number of operations on the underlying MDIO bus by 25%

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/chip.h |  1 +
 drivers/net/dsa/mv88e6xxx/smi.c  | 24 ++++++++++++++----------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 8271b8aa7b71..438cee853d07 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -392,6 +392,7 @@ struct mv88e6xxx_chip {
 struct mv88e6xxx_bus_ops {
 	int (*read)(struct mv88e6xxx_chip *chip, int addr, int reg, u16 *val);
 	int (*write)(struct mv88e6xxx_chip *chip, int addr, int reg, u16 val);
+	int (*init)(struct mv88e6xxx_chip *chip);
 };
 
 struct mv88e6xxx_mdio_bus {
diff --git a/drivers/net/dsa/mv88e6xxx/smi.c b/drivers/net/dsa/mv88e6xxx/smi.c
index 466d2aaa9fcb..dfb72a29626b 100644
--- a/drivers/net/dsa/mv88e6xxx/smi.c
+++ b/drivers/net/dsa/mv88e6xxx/smi.c
@@ -108,11 +108,6 @@ static int mv88e6xxx_smi_indirect_read(struct mv88e6xxx_chip *chip,
 {
 	int err;
 
-	err = mv88e6xxx_smi_direct_wait(chip, chip->sw_addr,
-					MV88E6XXX_SMI_CMD, 15, 0);
-	if (err)
-		return err;
-
 	err = mv88e6xxx_smi_direct_write(chip, chip->sw_addr,
 					 MV88E6XXX_SMI_CMD,
 					 MV88E6XXX_SMI_CMD_BUSY |
@@ -136,11 +131,6 @@ static int mv88e6xxx_smi_indirect_write(struct mv88e6xxx_chip *chip,
 {
 	int err;
 
-	err = mv88e6xxx_smi_direct_wait(chip, chip->sw_addr,
-					MV88E6XXX_SMI_CMD, 15, 0);
-	if (err)
-		return err;
-
 	err = mv88e6xxx_smi_direct_write(chip, chip->sw_addr,
 					 MV88E6XXX_SMI_DATA, data);
 	if (err)
@@ -159,9 +149,20 @@ static int mv88e6xxx_smi_indirect_write(struct mv88e6xxx_chip *chip,
 					 MV88E6XXX_SMI_CMD, 15, 0);
 }
 
+static int mv88e6xxx_smi_indirect_init(struct mv88e6xxx_chip *chip)
+{
+	/* Ensure that the chip starts out in the ready state. As both
+	 * reads and writes always ensure this on return, they can
+	 * safely depend on the chip not being busy on entry.
+	 */
+	return mv88e6xxx_smi_direct_wait(chip, chip->sw_addr,
+					 MV88E6XXX_SMI_CMD, 15, 0);
+}
+
 static const struct mv88e6xxx_bus_ops mv88e6xxx_smi_indirect_ops = {
 	.read = mv88e6xxx_smi_indirect_read,
 	.write = mv88e6xxx_smi_indirect_write,
+	.init = mv88e6xxx_smi_indirect_init,
 };
 
 int mv88e6xxx_smi_init(struct mv88e6xxx_chip *chip,
@@ -179,5 +180,8 @@ int mv88e6xxx_smi_init(struct mv88e6xxx_chip *chip,
 	chip->bus = bus;
 	chip->sw_addr = sw_addr;
 
+	if (chip->smi_ops->init)
+		return chip->smi_ops->init(chip);
+
 	return 0;
 }
-- 
2.25.1

