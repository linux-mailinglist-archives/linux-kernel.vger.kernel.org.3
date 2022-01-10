Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667D1489908
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiAJNBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:01:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42786 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiAJM7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:59:55 -0500
Date:   Mon, 10 Jan 2022 12:59:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641819594;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjeqJ4GSwfqdPtR2mocifLg0mCvhNuJqOxta26ebrDY=;
        b=rbf8cSN3gfRlCZ3WxvVFEq9DvKcFTT1tN84QInp5uTqZUkxEa2gHY+uCZYf0nyDdzlGvVN
        yXvOjL/c++kQLTvp4vxfVCaXkvABueCJDgNiixUU/3MRwcafvGDi/x2nAWB+gwa3yKVME1
        2r2A2FYLGf6dCi14QjRkdY38qXJ+VPgQ4Sguj4MnG1TmWSFClrYcPPBnpDvOErtEUI5AhG
        DJVBk4JHPmSChx5APTkvPl9nnhtcm/Zyf3WAqEZt5RkMTN9GJORkUGzhDFtozod+X6NKm/
        gEcRmhxyAV1PscRofuF2qYn5tGlGfuHehZ2M3taLXtcmrvw3r76kw63fa2Hgow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641819594;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjeqJ4GSwfqdPtR2mocifLg0mCvhNuJqOxta26ebrDY=;
        b=Hj7OoFcxR5u7MMo/2mNXCxqRpvGjWel4bsGQ7lQ8j8oi8SWynrcjusjzmaT840WY3sxP5o
        9jvr0oEAleMaNkDA==
From:   "tip-bot2 for Drew Fustini" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/pistachio: Fix
 -Wunused-but-set-variable warning
Cc:     kernel test robot <lkp@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Drew Fustini <dfustini@baylibre.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211123192524.1038304-1-dfustini@baylibre.com>
References: <20211123192524.1038304-1-dfustini@baylibre.com>
MIME-Version: 1.0
Message-ID: <164181959340.16921.12441384820128333820.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0642fb4ba68f7158f7a6d92190b3090cf0c7fac6
Gitweb:        https://git.kernel.org/tip/0642fb4ba68f7158f7a6d92190b3090cf0c7fac6
Author:        Drew Fustini <dfustini@baylibre.com>
AuthorDate:    Tue, 23 Nov 2021 11:25:24 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 14 Dec 2021 10:17:36 +01:00

clocksource/drivers/pistachio: Fix -Wunused-but-set-variable warning

Variable 'overflow' set but not used, but this is the intended behavior.
The hardware only updates the counter register after the overflow
register read. However, the value of overflow is not actually needed.

Link: https://lore.kernel.org/lkml/202111200402.afQsussU-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
Link: https://lore.kernel.org/r/20211123192524.1038304-1-dfustini@baylibre.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-pistachio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-pistachio.c b/drivers/clocksource/timer-pistachio.c
index 6f37181..69c069e 100644
--- a/drivers/clocksource/timer-pistachio.c
+++ b/drivers/clocksource/timer-pistachio.c
@@ -71,7 +71,8 @@ static u64 notrace
 pistachio_clocksource_read_cycles(struct clocksource *cs)
 {
 	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
-	u32 counter, overflow;
+	__maybe_unused u32 overflow;
+	u32 counter;
 	unsigned long flags;
 
 	/*
