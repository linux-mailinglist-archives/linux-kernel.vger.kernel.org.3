Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594A5479CBF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 22:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhLRVM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 16:12:56 -0500
Received: from st43p00im-zteg10062001.me.com ([17.58.63.166]:45766 "EHLO
        st43p00im-zteg10062001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234245AbhLRVMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 16:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1639861969; bh=v0/e1LR3GG6zYqcCoBHl7uIVUQ4dGVk6xV1W5S/bfJc=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=RF17Z9+pzbKvz0uZtf8HS8CPwLe3cazlZ0DIf8jVcvVr6bUEzA5IdZox8wjT1wZUJ
         owcMoxR/zFzbakpqtZvYQI10zEVr5PcEoWczBt9fD1IAUtYDoIiCWLcS8oWL/2vMdZ
         K6f2fd5Iaznic5iEwk1rROuMi6gWJxnmhfH4clOUYt8yc01ruN9hBiOcaGe7KKCuTV
         Zfqkqw6NlHmFM/YcJ8Qv6KZmpzPYtR+o/NCAtPVSJcTN54TAKJ0UBnsIA8JFDcOzeF
         xesu/yBMob4aQE3/1KpuOb9wfDyfJ4D2WlOx99m9iMRvVRZwsJhJc9hfI4r4f8aVK/
         VYax2WosbHuBA==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10062001.me.com (Postfix) with ESMTPSA id 779D080077C;
        Sat, 18 Dec 2021 21:12:48 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH v2 2/2] clk: st: clkgen-mux: search reg within node or parent
Date:   Sat, 18 Dec 2021 22:11:57 +0100
Message-Id: <20211218211157.188214-3-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211218211157.188214-1-avolmat@me.com>
References: <20211218211157.188214-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-12-18_08:2021-12-15,2021-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2112180129
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
v2: identical to v1

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

