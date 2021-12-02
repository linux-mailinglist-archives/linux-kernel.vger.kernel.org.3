Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E3B465EB6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355828AbhLBHcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:32:45 -0500
Received: from st43p00im-ztbu10063701.me.com ([17.58.63.178]:41957 "EHLO
        st43p00im-ztbu10063701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344668AbhLBHcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:32:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1638430154; bh=0DrK59zmZ/s+Xx7NIv/Tj8gNBGopWg8sxyxeNU5Pn9U=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=JTog/7yQj4Ro+JmTU4BIzoE1xy6I3J4pIpQqTW1Rkv9gHIrAO1oB4Cw4Bw8EGkx9T
         DuRicDpZQ/5d82LXUJDHv/wCQrJls4RuOnuSzy7zoXuWc6670BqhIhJc4xS2NCQHfD
         5kiIUre/ZTm43zRgP9XBPtPdAi4Sdv6HU4+0/k4tCqSyvX01dIyJb11uU8+LsFPudD
         Ygkqz70aaY0uRos0GKiKE1A9N0RAilbLDdeJ4eCq9k2vFZC0qNRIY74+bhoVqWGIDr
         JFJRBnyAk9jRCcBkAHk4x3EW4Bvhc9N039y6XYJzZ0e1GP7y0SN8Rqcfrr/loNArU+
         BeM8Lj/4mWSuA==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztbu10063701.me.com (Postfix) with ESMTPSA id ED4A99A07FE;
        Thu,  2 Dec 2021 07:29:13 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH 1/2] clk: st: clkgen-fsyn: search reg within node or parent
Date:   Thu,  2 Dec 2021 08:28:49 +0100
Message-Id: <20211202072850.194314-2-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202072850.194314-1-avolmat@me.com>
References: <20211202072850.194314-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-12-01_01:2021-11-30,2021-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2112020043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid having duplicated addresses within the DT,
only have one unit-address per clockgen and each driver within
the clockgen should look at the parent node (overall clockgen)
to figure out the reg property.  Such behavior is already in
place in other STi platform clock drivers such as clk-flexgen
and clkgen-pll.  Keep backward compatibility by first looking
at reg within the node before looking into the parent node.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 drivers/clk/st/clkgen-fsyn.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index 164285d6be97..0d41164f2c7f 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -988,9 +988,16 @@ static void __init st_of_quadfs_setup(struct device_node *np,
 	void __iomem *reg;
 	spinlock_t *lock;
 
+	/*
+	 * First check for reg property within the node to keep backward
+	 * compatibility, then if reg doesn't exist look at the parent node
+	 */
 	reg = of_iomap(np, 0);
-	if (!reg)
-		return;
+	if (!reg) {
+		reg = of_iomap(of_get_parent(np), 0);
+		if (!reg)
+			return;
+	}
 
 	clk_parent_name = of_clk_get_parent_name(np, 0);
 	if (!clk_parent_name)
-- 
2.25.1

