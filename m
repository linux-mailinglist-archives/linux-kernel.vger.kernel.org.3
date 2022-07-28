Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AECA5837A8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbiG1DkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiG1DkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:40:17 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2611863FB;
        Wed, 27 Jul 2022 20:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=OWL50
        Trspqxmk9IY0VQ8b5aq34QuyRnC8h+e5TH14Oo=; b=DRDGAfivuYNqQy+6DkKBX
        UCRW3g6XnhKnqGkEbXkacHmTGU3q7dLZjD1hhzA3sDLmfoHOFY0LdWIMB2wdVl8w
        /uCvJ1DtWQfQbLfO6u5+kLOdgHZ5mm4P2HY2+AehK7fEzbrhCZenWwrqhfmr8sdG
        fHsassUkgKrMT2FJmXg66E=
Received: from localhost.localdomain (unknown [221.222.55.182])
        by smtp5 (Coremail) with SMTP id HdxpCgB3_vL3BOJivq50Qw--.25809S4;
        Thu, 28 Jul 2022 11:40:02 +0800 (CST)
From:   Wentao_Liang <Wentao_Liang_g@163.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wentao_Liang <Wentao_Liang_g@163.com>
Subject: [PATCH] drivers:md:fix a potential use-after-free bug
Date:   Thu, 28 Jul 2022 19:39:19 +0800
Message-Id: <20220728113919.7985-1-Wentao_Liang_g@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgB3_vL3BOJivq50Qw--.25809S4
X-Coremail-Antispam: 1Uf129KBjvJXoWrtFyDtw4kXFWUKFWxXF1kKrg_yoW8Jryfpa
        yrAF43ZryDWFn8tFZxZFZ7XF1FkayaqrZ7KFWvgw1fu3W5XryIkw43tFy8tr4Dtr4Fk3yr
        Zw1qgw15Wr1UKFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UvoGdUUUUU=
X-Originating-IP: [221.222.55.182]
X-CM-SenderInfo: xzhq3t5rboxtpqjbwqqrwthudrp/xtbBORJML1-POqlVoQAAs-
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In line 2884, "raid5_release_stripe(sh);" drops the reference to sh and
may cause sh to be released. However, sh is subsequently used in lines
2886 "if (sh->batch_head && sh != sh->batch_head)". This may result in an
use-after-free bug.

It can be fixed by moving "raid5_release_stripe(sh);" to the bottom of
the function.

The bug has been confirmed by Song on 2021-08-14. Now, I resend this
patch with my real name. I hope the patch can be updated in a near
future.

Signed-off-by: Wentao_Liang <Wentao_Liang_g@163.com>
---
 drivers/md/raid5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 5d09256d7f81..93fcbeac5096 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2881,10 +2881,10 @@ static void raid5_end_write_request(struct bio *bi)
 	if (!test_and_clear_bit(R5_DOUBLE_LOCKED, &sh->dev[i].flags))
 		clear_bit(R5_LOCKED, &sh->dev[i].flags);
 	set_bit(STRIPE_HANDLE, &sh->state);
-	raid5_release_stripe(sh);
 
 	if (sh->batch_head && sh != sh->batch_head)
 		raid5_release_stripe(sh->batch_head);
+	raid5_release_stripe(sh);
 }
 
 static void raid5_error(struct mddev *mddev, struct md_rdev *rdev)
-- 
2.25.1

