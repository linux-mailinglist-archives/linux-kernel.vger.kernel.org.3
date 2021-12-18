Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB95479CBC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 22:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbhLRVMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 16:12:49 -0500
Received: from st43p00im-zteg10073401.me.com ([17.58.63.181]:41645 "EHLO
        st43p00im-zteg10073401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234212AbhLRVMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 16:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1639861965; bh=+YMWyQxZRZQ4V22bDB1Agjy3ewz23mq9HAIfzWu7EnI=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=D8Nf3KegojRDRiKXLOGYu+SUfgOICJRzWclDGyVJ2V+VSEoZGsqlPuAG4CZeABjqP
         9sX/I5wJGeW2AjZ/eUYcI3uOWklTDPHhmJtIxx8fQb9cfsabLDgjDiSN/LvbjWsgsu
         +2774kweJZsYgzBqug1N80YgMyhUeAnLD6kiSA62CfzQaIOVCTGliaXmj7SGLXDE0V
         R8aYn127n2S2OcodYkYEACWxwVn5xZ3k1AN23GDMZ2aVqEgcjQ2lZPzG5dxPz+y2+p
         wmFeJlOAsJEOlcaZrq1PZLhGbqfbcRQotwmD2IIsLsXOaKkJKBYteSqEEkbpNduah6
         iLGnB0Jg//3Cg==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10073401.me.com (Postfix) with ESMTPSA id 52E035E08E8;
        Sat, 18 Dec 2021 21:12:44 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH v2 1/2] clk: st: clkgen-fsyn: search reg within node or parent
Date:   Sat, 18 Dec 2021 22:11:56 +0100
Message-Id: <20211218211157.188214-2-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211218211157.188214-1-avolmat@me.com>
References: <20211218211157.188214-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-12-18=5F07:2021-12-16=5F01,2021-12-18=5F07,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2112180129
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
v2: add pr_err message when failing to get reg information

 drivers/clk/st/clkgen-fsyn.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index 164285d6be97..582a22c04919 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -988,9 +988,18 @@ static void __init st_of_quadfs_setup(struct device_node *np,
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
+		if (!reg) {
+			pr_err("%s: Failed to get base address\n", __func__);
+			return;
+		}
+	}
 
 	clk_parent_name = of_clk_get_parent_name(np, 0);
 	if (!clk_parent_name)
-- 
2.25.1

