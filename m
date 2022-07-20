Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B6A57BE64
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiGTTZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGTTZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:25:46 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76357481F8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:25:41 -0700 (PDT)
X-QQ-mid: bizesmtp67t1658345111t20e7wo6
Received: from harry-jrlc.. ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 21 Jul 2022 03:24:53 +0800 (CST)
X-QQ-SSF: 0100000000200030C000B00A0000020
X-QQ-FEAT: hoArX50alxFrHxhGqacyHg4kyF85k+e/7SwaSyLAySeab5/C92Ymm9OyYl3oX
        AOh4mgdTgMW0MCuCN0YSOk4YsQQEWjQNnMVFFfSRkTIFMnkhynZDz9bXyicp5ULbOt+1u3V
        wNBD5kq6faAfkOv5fnLDPVL2Y5QqG56s2VUrT8AWzO9DogYroTzNmtCqp/iuR3aqJnvwck9
        tIsrylto2Px3eJzmiSDkvCd8QY5fcHBmbpTqGSJY2SytB4bl7gB7uKcCPZTdKIbQb8+oawh
        0RDbJ7SnBClTWOhquiIx9mVQqcG/TBlrAqjlcISIF5LFerIP+FUoFJXUoCgA8Yv7cdgGMfB
        AI0RR5iFAC9m7te1Ei87eEtOlp4w1ZoMwoxOr6vDXxY2nuwOU0=
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] um:do not initialise statics to 0.
Date:   Thu, 21 Jul 2022 03:24:51 +0800
Message-Id: <20220720192451.7384-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do not initialise statics to 0.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 arch/um/drivers/ssl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/ssl.c b/arch/um/drivers/ssl.c
index 41eae2e8fb65..891e9c83d407 100644
--- a/arch/um/drivers/ssl.c
+++ b/arch/um/drivers/ssl.c
@@ -108,7 +108,7 @@ static const struct tty_operations ssl_ops = {
 /* Changed by ssl_init and referenced by ssl_exit, which are both serialized
  * by being an initcall and exitcall, respectively.
  */
-static int ssl_init_done = 0;
+static int ssl_init_done;
 
 static void ssl_console_write(struct console *c, const char *string,
 			      unsigned len)
-- 
2.30.2

