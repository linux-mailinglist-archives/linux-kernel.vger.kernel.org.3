Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A71513B90
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351061AbiD1Sen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346144AbiD1Sel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:34:41 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F510B7C75;
        Thu, 28 Apr 2022 11:31:25 -0700 (PDT)
Received: from localhost.localdomain ([37.4.249.94]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MeTHG-1oKIcH3Ufs-00aRvm; Thu, 28 Apr 2022 20:31:05 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] clk: bcm2835: fix bcm2835_clock_choose_div
Date:   Thu, 28 Apr 2022 20:30:10 +0200
Message-Id: <20220428183010.1635248-1-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ROg9fHO+7lB5ftkBrfzS6z5Xqc0WiEHelZu+8KRp+4H7JD2NLNK
 0CQUdONatjMCTxpBiiNSdY+Nb4nNGVYkG404BvDZnW3+ao8ZjF0eFeq0OE/UiwjPrNQT13m
 rke7opJan1AoEu72mcXIABbNueCdoFdKos/ddLXuCjzvtnOziUzGsbVFt8AS3mGFzcYls1f
 M4umhJIqagTJRsSDSrQfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1HqqFbLnT3o=:vmhdHLj7PGOk5jSXwMWq32
 rA3esa3S6D43+/pkCwJNboeuBAedAj8OwBQ90339Ccb5n7Z1ymmADUl03cIfMgdMC7t2HmFyI
 bnsYVJE0HI7tVkziGv1ToF7AcMGyymTJ/nEs8yk4rKVPDo2laljt6WNsqwBEW2rmhqZh8W/cC
 3SUg8k4xB48IiSAbmpvdkfUSsntavkdjpuAspB4jxwXGyNGUoFSsA/wRbYkBnL933NvIQhR7d
 cyaKGvoTMemm0XQ2zB8k4SmGjMO+pwABRaUi4jDhFAhIwulQ+gj1a0ENg9cX5UaE1kjYuR8SN
 Hyk0xwB35GZC5/0L59grXHUkzal2SXrft/NOHgRh1ay7wZdcIiCGstiZsT4RUiRJWM4uulBlH
 mu9YuUzP6DpfYxar5Z9hJTKQj9WuxaUeLHVCiycc4gvDx8THT17PpgTO3jz7vaIk9/qRo8MNq
 imRn0wt4q8bB1B/zaT0c5Dn8oK0VNLUa4GYktVJfmq27tBv83sds476TpXo7alEYIh1jNwu3H
 HNeNH4igDJ746jO0mTiIYbCqyJCSY/oVnITU0dJcLUd4dhNG8dBY0CbDhPyYILYfTp2ue2w3d
 V8apEH6GfgWs/qAXVr9Q9Diqqsx0ppSZUVtpPV2zzCxaORtsqPZ6cG5mBLTG71t3oi4tsEFy+
 2R9HcPgYsTdeuQujMte6OUmx+dA0nKDqD7o6cRPSbLhBXrxxZLkTZB3lnS/I2SdKZU/AVdGiu
 2UNKmC4vn11tBsFu
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 09e3b18ca5de ("clk: bcm2835: Remove unused variable")
accidentially breaks the behavior of bcm2835_clock_choose_div() and
booting of Raspberry Pi. The removed do_div macro call had side effects,
so we need to restore it.

Fixes: 09e3b18ca5de ("clk: bcm2835: Remove unused variable")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/clk/bcm/clk-bcm2835.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 3ad20e75fd23..48a1eb9f2d55 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -941,6 +941,7 @@ static u32 bcm2835_clock_choose_div(struct clk_hw *hw,
 	u64 temp = (u64)parent_rate << CM_DIV_FRAC_BITS;
 	u32 div, mindiv, maxdiv;
 
+	do_div(temp, rate);
 	div = temp;
 	div &= ~unused_frac_mask;
 
-- 
2.25.1

