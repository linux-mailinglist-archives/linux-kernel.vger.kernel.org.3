Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79271480376
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 19:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhL0Sui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 13:50:38 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34172 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhL0Suf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 13:50:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B7A96115F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 18:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29955C36AEA;
        Mon, 27 Dec 2021 18:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640631034;
        bh=XWmzQn8Xxn6YgKl1TUcMnnO2/hUPF7VvKjiYzrTuIRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gvr2G46tGbl0RjT1+p8jBCqJq+kqAsdwQIvB/vI1yR5b1KTsWRVjIUQiyaUnfrw1i
         uAcD2JEalJAxMJEyNO25j6fItV0KHi0yzHTQf21iWB54tw71mK2egLwz922gNKp90w
         ZXOU1JLyJ/fAh3CyXUR0Qu0iLZR5bsJj3Rg/ukNO0EiArODy7jqpCa35Bfrvc9wc93
         Z1PkvyTIh+8cMZWBkMH6r5oXiMC/1aOuo+PfACP79MGaae8J6sVDxx2pb/gW5KQTI9
         +Ds7DtQvffO8B15aSbI5KD5IskvwSCZmb1prqZtcrbocv6DAQiGds+hekPaS9iAo8x
         f44ntt+qWIVKg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Brian Cain <bcain@codeaurora.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 1/3] hexagon: Fix function name in die()
Date:   Mon, 27 Dec 2021 11:48:49 -0700
Message-Id: <20211227184851.2297759-2-nathan@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211227184851.2297759-1-nathan@kernel.org>
References: <20211227184851.2297759-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building ARCH=hexagon defconfig:

arch/hexagon/kernel/traps.c:217:2: error: implicit declaration of
function 'make_dead_task' [-Werror,-Wimplicit-function-declaration]
        make_dead_task(err);
        ^

The function's name is make_task_dead(), change it so there is no more
build error.

Fixes: 0e25498f8cd4 ("exit: Add and use make_task_dead.")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/hexagon/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 6dd6cf0ab711..1240f038cce0 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -214,7 +214,7 @@ int die(const char *str, struct pt_regs *regs, long err)
 		panic("Fatal exception");
 
 	oops_exit();
-	make_dead_task(err);
+	make_task_dead(err);
 	return 0;
 }
 
-- 
2.34.1

