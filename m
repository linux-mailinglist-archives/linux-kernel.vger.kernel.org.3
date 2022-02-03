Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23CE4A8236
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 11:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350073AbiBCKRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 05:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350043AbiBCKRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 05:17:07 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D171EC06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 02:17:06 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m14so3955495wrg.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 02:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=/al0prgIzPH9k1uNInWvvy4CEvy9CcExx2RD1oCo46Y=;
        b=ykuAyEO7Zz2lYqqFSIrk2ysdk1zaZsO7ZQ+xLe4vX+sJjGcZ8yryVST6bfRC6Ug09Q
         D8pdf1vVjTfJwpfKP4nKs9HzhyjAtVGUzDQIzxL/dW79Lb2reZaotyt8KPWz+XWdG626
         FalXsepTOzgYIH3wzJmE/SaYZdJWRly1h13a0Q7PTjb7Us38hJELW97oRVuVe7CELs+j
         HDdpyppXZq7eRNVbXRHFIksrUGNvayfZSx5r0qhbvhjWs4LkN1yv5yRLleV1DwJKfl9m
         nNZeaSc/pRlVtP6PGP+whFQysJhq3NNqgEoJcbVkvtUN8BBtMz49Z8jaFm/rYUwBROSn
         F5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=/al0prgIzPH9k1uNInWvvy4CEvy9CcExx2RD1oCo46Y=;
        b=OZ6Oh04cAx3asgeZnPaG8EWiyw8psEqNNQ+A3opasUknGMJHgJKKQnFV4sK4vknFii
         22Q96g48Tb541uLQJN4nL8F/ouyy3zToyjjwThWVdzksB5imz+M83mDbanyPN2sEKtoX
         704yd/kgFL1IpM/QnjVDv2AcwWc/gIl1SVweasI1NlYSic7CBPEMRjWI5GyjkUc4FWuQ
         eLrAGudZBnHbntERw/wmXbYOUhNaqQTWKKuSjrr/jjXEkEV+1tsqycXtX6uWqhyq16CL
         wojyki/+kiTpnczYZWOaaT7BMZsSUUtZk26wF9HcpNBHon/Oe6YL3LK0YDiQ9un20CWD
         sKgw==
X-Gm-Message-State: AOAM530oMlXpoJuHPcs9kM/TzdQQzSQtc33ZsoGZ3C0czfL+EmKshPug
        UxMeAFCD+1YsGznlntHvSQHSvw==
X-Google-Smtp-Source: ABdhPJzGN/eA8oMwkpIb673VebVUrG0sARzp5cCakB0m4ZmXye0dD4kQXCBmnt9zKjMHjzVCQ/i5kQ==
X-Received: by 2002:a05:6000:18af:: with SMTP id b15mr27598340wri.589.1643883425399;
        Thu, 03 Feb 2022 02:17:05 -0800 (PST)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id g6sm19017148wrq.97.2022.02.03.02.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 02:17:05 -0800 (PST)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 2/5] net: dsa: mv88e6xxx: Support policy entries in the VTU
Date:   Thu,  3 Feb 2022 11:16:54 +0100
Message-Id: <20220203101657.990241-3-tobias@waldekranz.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203101657.990241-1-tobias@waldekranz.com>
References: <20220203101657.990241-1-tobias@waldekranz.com>
MIME-Version: 1.0
Organization: Westermo
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A VTU entry with policy enabled is used in combination with a port's
VTU policy setting to override normal switching behavior for frames
assigned to the entry's VID.

A typical example is to Treat all frames in a particular VLAN as
control traffic, and trap them to the CPU. In which case the relevant
user port's VTU policy would be set to TRAP.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.h        | 1 +
 drivers/net/dsa/mv88e6xxx/global1.h     | 1 +
 drivers/net/dsa/mv88e6xxx/global1_vtu.c | 5 ++++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 438cee853d07..80dc7b549e81 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -179,6 +179,7 @@ struct mv88e6xxx_vtu_entry {
 	u16	fid;
 	u8	sid;
 	bool	valid;
+	bool	policy;
 	u8	member[DSA_MAX_PORTS];
 	u8	state[DSA_MAX_PORTS];
 };
diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
index 4f3dbb015f77..2c1607c858a1 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -46,6 +46,7 @@
 
 /* Offset 0x02: VTU FID Register */
 #define MV88E6352_G1_VTU_FID		0x02
+#define MV88E6352_G1_VTU_FID_VID_POLICY	0x1000
 #define MV88E6352_G1_VTU_FID_MASK	0x0fff
 
 /* Offset 0x03: VTU SID Register */
diff --git a/drivers/net/dsa/mv88e6xxx/global1_vtu.c b/drivers/net/dsa/mv88e6xxx/global1_vtu.c
index ae12c981923e..b1bd9274a562 100644
--- a/drivers/net/dsa/mv88e6xxx/global1_vtu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_vtu.c
@@ -27,7 +27,7 @@ static int mv88e6xxx_g1_vtu_fid_read(struct mv88e6xxx_chip *chip,
 		return err;
 
 	entry->fid = val & MV88E6352_G1_VTU_FID_MASK;
-
+	entry->policy = !!(val & MV88E6352_G1_VTU_FID_VID_POLICY);
 	return 0;
 }
 
@@ -36,6 +36,9 @@ static int mv88e6xxx_g1_vtu_fid_write(struct mv88e6xxx_chip *chip,
 {
 	u16 val = entry->fid & MV88E6352_G1_VTU_FID_MASK;
 
+	if (entry->policy)
+		val |= MV88E6352_G1_VTU_FID_VID_POLICY;
+
 	return mv88e6xxx_g1_write(chip, MV88E6352_G1_VTU_FID, val);
 }
 
-- 
2.25.1

