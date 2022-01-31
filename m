Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DFB4A4AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379838AbiAaPrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379799AbiAaPrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:47:08 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF442C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 07:47:07 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id e9so20019959ljq.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 07:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=/al0prgIzPH9k1uNInWvvy4CEvy9CcExx2RD1oCo46Y=;
        b=5KWGrV7a7PWB02JGslg66o88sDCe4kNVUeDBHdnyaWzVayduuhv14EKYyT9X0DCGk0
         umuVm64twjC5RpQN/HLYYJ66XcPuy2uAA72t887I70QhRdlNdzA9OP6c2bQ2s6Oxv2cM
         P3zCMwXiP55246bFsATE4lF8wzefgesct15jN7jYHthbgCHcTYMm3MxlpNMsp+czZLKq
         HVGy7NpuHJPm0uZbhJ94SMskkW2Q9dnjfQt+mMd+0xX/oYpW5tE4qj9Kh8iX/Jd1ebIq
         HMyWikNbwe9In48vWLbhq8N9Sm6/I0hYFn0ztskKn+QmP1yh7EHhcCLwiFyy0bjiI81a
         AOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=/al0prgIzPH9k1uNInWvvy4CEvy9CcExx2RD1oCo46Y=;
        b=5WI/o+a258XcYgRSBUV0T1N7thq+DM/R9AljxfPnSo4U8ch1UBWDuATKX4oDQthemN
         wrdFFKpIJWaMTtj2et8k7boP/fr6R6yB48Ef7LIK47xcBNAvVUnovWczk6LLvA0vD4wG
         sSVj+t4gg+1Wb/qNQC+NyoFs+LJE3Q2lvMLDL81OioeOvtQOAHlXYULvhqgT9HtVoi80
         cENX7plCxmkxe0baqXKCVEOo1dU04aQQ0c17bh8tK3FjS16sR0YEBpSTdhNZAswsjB7D
         XTq3PW4zsD4gt7D23uzo/gX89qvsi77dGLedeghiDDnI19boQCKNh05466NklfHp2I6/
         Im9g==
X-Gm-Message-State: AOAM532oM4lghWBAUpLLcmZ+QLYrMjzyWDZ1/thu6AJgyiRQGxTTCsVT
        r20uSpEEOHvMQNHnw9oyYQ1obw==
X-Google-Smtp-Source: ABdhPJwHpyoHA2DXmWbDA6I9qeR5h3L/U+H+Vk5JvnDCCvJQhDKEpT9JtO6GxXnWqgcaBKo5UkIrzw==
X-Received: by 2002:a2e:9b0e:: with SMTP id u14mr13990314lji.148.1643644025665;
        Mon, 31 Jan 2022 07:47:05 -0800 (PST)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id y36sm3374769lfa.82.2022.01.31.07.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 07:47:05 -0800 (PST)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/5] net: dsa: mv88e6xxx: Support policy entries in the VTU
Date:   Mon, 31 Jan 2022 16:46:52 +0100
Message-Id: <20220131154655.1614770-3-tobias@waldekranz.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220131154655.1614770-1-tobias@waldekranz.com>
References: <20220131154655.1614770-1-tobias@waldekranz.com>
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

