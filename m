Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF96465EB7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355836AbhLBHcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:32:48 -0500
Received: from st43p00im-ztbu10063601.me.com ([17.58.63.174]:34785 "EHLO
        st43p00im-ztbu10063601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345507AbhLBHcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1638430158; bh=iKqXzBHkuZ5q5N8jiYDPWRjrVq7onkutlEoCQ2xoOx0=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=B9IPnYfVcR5cgvQEh0v2R5BbH9ctVwFQQG3bBI1XFNX/2jmg3poDroVMkL1GTSFRy
         Atg+I8puq5skbqNynhGyTWNKFjEQcrHOcBoPtOKKit7N97zE3u3WGIql9XW8leriDS
         p0NmmIQIihmMBeIDfA2td16WShujO6JMHeVh5ciobrX7BS+Rx52RSVGnY88TkTJA8A
         7qAIkaXRGfCrSJ0dtVM1QzWOd9EBx7Db1corAVjR0A2JhRQL00WYszGGhxNWuF60D/
         rJ7TvT9mSrlgt0W3QYIl/zgI9Ww25HzIflui4+cDs5XnsGkj/w7xP2m0kDB75MJcOC
         B6+REANjsUWEg==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztbu10063601.me.com (Postfix) with ESMTPSA id D6EF77006D1;
        Thu,  2 Dec 2021 07:29:17 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH 2/2] clk: st: clkgen-mux: search reg within node or parent
Date:   Thu,  2 Dec 2021 08:28:50 +0100
Message-Id: <20211202072850.194314-3-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202072850.194314-1-avolmat@me.com>
References: <20211202072850.194314-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-12-01=5F01:2021-12-01=5F01,2021-11-30=5F09,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2112020042
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
 drivers/clk/st/clkgen-mux.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/st/clkgen-mux.c b/drivers/clk/st/clkgen-mux.c
index ce583ded968a..ee39af7a0b72 100644
--- a/drivers/clk/st/clkgen-mux.c
+++ b/drivers/clk/st/clkgen-mux.c
@@ -57,10 +57,17 @@ static void __init st_of_clkgen_mux_setup(struct device_node *np,
 	const char **parents;
 	int num_parents = 0;
 
+	/*
+	 * First check for reg property within the node to keep backward
+	 * compatibility, then if reg doesn't exist look at the parent node
+	 */
 	reg = of_iomap(np, 0);
 	if (!reg) {
-		pr_err("%s: Failed to get base address\n", __func__);
-		return;
+		reg = of_iomap(of_get_parent(np), 0);
+		if (!reg) {
+			pr_err("%s: Failed to get base address\n", __func__);
+			return;
+		}
 	}
 
 	parents = clkgen_mux_get_parents(np, &num_parents);
-- 
2.25.1

