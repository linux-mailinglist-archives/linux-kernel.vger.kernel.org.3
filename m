Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E114F7BBD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243838AbiDGJgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243814AbiDGJgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:36:09 -0400
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61069674DB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649324044;
        bh=DyWMmxwvueYQtUN0i/Vyg4p9gpIkRWzZvm2GGvGoZXg=;
        h=From:To:Cc:Subject:Date;
        b=t0oZSTlPkbIPMEHr8zxLHc2+/bA21SivC9bLB+KLrLe05gUP4OkVTJLLLWOlmoyXx
         u7K/r5ORZa3u6VJuMehzzn+GBDzais55NJ/+QoJbPl+ne8xHA1bxnRaw3XqsZY0s6X
         3IXtUgsgBf4dDlQ96vpGyOHqXFDL2QGTD/GP+Ln4=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc8.qq.com (NewEsmtp) with SMTP
        id 8810AC49; Thu, 07 Apr 2022 17:34:01 +0800
X-QQ-mid: xmsmtpt1649324041tq9osk1yb
Message-ID: <tencent_2B9817738F38B02844C245946EFF3B407E09@qq.com>
X-QQ-XMAILINFO: M3Q/Kj4zjy60dkerLqbXeBwvcAhmYce6CAkj5VIPEgRTkNhoorWI/XYqrIWo2c
         Jwsvc9UP9gtG638C/RTf9aQqoh0FiQXLFlm3OOE62DtjZPQ8XTx7V27o2x+ve+XkyESFJqI9xwDN
         U73OiKWhD8ZfiBE2TgOqFwwRTyafrdTtcV7AvJhEhoATREeFfsB/VHzVYSwZYD2TcgdzT9zOYnY/
         6iL8Biidnl6uY1d+Hv2znImVkut9J5tLDDAWUv/UXhxFY3Rxbr8ly9wqE9hR8//QpaJ2jtxuydgd
         EpCuliM8XZW27IQxwoz0zLoBIkOLXz/Ovx08fDnqLOEnaHKnFwBoCHMnTnCMttD0W2MQgjrZPyv3
         QzIwJD6Hsdwtk9dBCxq+6tyxevb+O4s14J9lwIhBlR51eO9COZMHi9XqXXieUhmdE6sgRdYoUtbp
         Opw//rezjMzSunqtqA8XZOxRQuMgstO8QrRDW9jSha3q+0dX04yn6nOQ38TZ7G7vbgOnAymHmokD
         jwn+3q1B1CvOjzcRaIMNXBx2h7tZREDVGJ4+s/o2jdCErqJY0CDdMA80+AUWNS0tLco1W+mID43F
         fyVSlpN9f+ISbOtHwmTDx8g5E9VGq6Wie/Ey3RwR6C09GCKOGjzRl8vcsBYONS4cvBsR3n51LXQl
         xi8WVvnjLq6u+ozm05NiwoeA/+C8o5MZ37fbccHzvxcbJp0C8r6JtEJ+OLC+1TrlVF3C38m841Mz
         W0Ui129Qqm/I4QZ33ss0NmkYjJ1wOO936vrAcZURaDIdxKTfWYY5KPObvsCAsJbGrmogjUnp5LGh
         70qOKHG+yWiD2vPSh3FP7YggKzX844Qeu4xlaDBNALEcrsa801pWptZsj4Ex9w+i40t0OSPpFZmc
         QDRLX1BWjxNWGXEfoWWrnjMvSFysOsgyXvfCD+rT2gleusfmXaAMb+guK01D4cI0CpgRZRkZdXLw
         bQbPOpkz3x0yy2RMVa9g==
From:   xkernel.wang@foxmail.com
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2] clk: pxa: add a check for the return value of kzalloc()
Date:   Thu,  7 Apr 2022 17:33:49 +0800
X-OQ-MSGID: <20220407093349.14639-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kzalloc() is a memory allocation function which can return NULL when
some internal memory errors happen. So it is better to check it to
prevent potential wrong memory access.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 stop trying to allocate more and return an error.
 drivers/clk/pxa/clk-pxa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/pxa/clk-pxa.c b/drivers/clk/pxa/clk-pxa.c
index cfc79f9..be6b950 100644
--- a/drivers/clk/pxa/clk-pxa.c
+++ b/drivers/clk/pxa/clk-pxa.c
@@ -102,6 +102,8 @@ int __init clk_pxa_cken_init(const struct desc_clk_cken *clks, int nb_clks)
 
 	for (i = 0; i < nb_clks; i++) {
 		pxa_clk = kzalloc(sizeof(*pxa_clk), GFP_KERNEL);
+		if (!pxa_clk)
+			return -ENOMEM;
 		pxa_clk->is_in_low_power = clks[i].is_in_low_power;
 		pxa_clk->lp = clks[i].lp;
 		pxa_clk->hp = clks[i].hp;
-- 
