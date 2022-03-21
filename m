Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E114E2517
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346710AbiCULRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346706AbiCULQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:16:55 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2045A554A1;
        Mon, 21 Mar 2022 04:15:29 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id c4so11588866qtx.1;
        Mon, 21 Mar 2022 04:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r58jtRbok/salGZLYM01BLC5vndO53EKP4rvTMG539M=;
        b=N9g+VtIuE50+e80f/IWduxz+a2u7dFN/Ik1qSRvlzP90TaARL55x492QbBQC7DTF8Z
         /uA614WiLOa3DCmi/soVltz8+lbAjUOZUqoJLfAYyW2EmlUefK8CNt1ZOn4aarrpVSrE
         bauTmQhj0TuIokEDLfG5RDceSbn5f0GGUvLAtYMCHMNOd5xz6LRuwj6tearhenvWZX4x
         wCNGYACHOhmS6PPC0m28yaLVmWIhzMo4GtQL1LeBJnU2/QNhT9DzpWD32qT1Ye7bNtBn
         XdB2uNP7TfrQk6aoSn3J0+gpeDQ+WBCf1CWG6Xb7FRT8TYA9WWJiRuLcPZGY9SvZgzS6
         LzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r58jtRbok/salGZLYM01BLC5vndO53EKP4rvTMG539M=;
        b=VwEnTK/CJ/cjYxY0To88LVwbbWwCfEMxNvNOtKCjr2YpXOTA42CtXayP49L2hAFXRE
         es2pqAEUBoytjKa0lfG2F3DF1F0q++yB5U30Tc4d1bnMsCjkHondE/ro0RFamiQqyjxd
         NovzD8n8qW4CP1jgM2d22Cwq/5kW0YuSW4CnY2WvbB5qfodhudt+I9A3slsRf2rnHH+j
         ZQpnEf/kVhiWM3+Yr/+Ne0tSPPfvsaS/YtBTETjqPzXarksIhBVdnA0k0b41YomToD31
         l7yQpkwC1VLW8SGR8B2vIrd1T9odqA57AgIFHbwyz14PnACi5nv0SLgERm8CvCSHSqG6
         rGXA==
X-Gm-Message-State: AOAM531+UWl6ZxwTQmRFosOLfEffvjDZHS1AsfBMYciKLxgRQMmDhpGd
        /uWFwfNfT2Lm4twAEVU4CXA=
X-Google-Smtp-Source: ABdhPJy/HYNeExNgRICAe7MeZiNOQ3nwcf9303GuNuAbuyWWRy/LkElT8eUYYLCtAVQzhgCm8jFckA==
X-Received: by 2002:ac8:5f07:0:b0:2e1:d695:d857 with SMTP id x7-20020ac85f07000000b002e1d695d857mr15755266qta.40.1647861328214;
        Mon, 21 Mar 2022 04:15:28 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id x21-20020a376315000000b0067d1b191f89sm7653630qkb.68.2022.03.21.04.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 04:15:27 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, john.ogness@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, tglx@linutronix.de, schspa@gmail.com
Subject: [PATCH 5.15-rt] printk: fix suppressed message print when reboot/panic
Date:   Mon, 21 Mar 2022 19:15:02 +0800
Message-Id: <20220321111501.68241-1-schspa@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update printk_seq for suppressed message.

When message is suppressed, printk_seq should be updated, otherwise
this message will be printed when reboot. This problem was introduced
in commit 3edc0c85d154 ("printk: Rebase on top of new ring buffer").

This patch apply fix to 5.15-rt according to
Message-ID: <87a6dj3b5c.fsf@jogness.linutronix.de>

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 kernel/printk/printk.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0cc8e8acf545..c3e245c95de4 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2255,8 +2255,12 @@ static int printk_kthread_func(void *data)
 		if (!(con->flags & CON_ENABLED))
 			continue;
 
-		if (suppress_message_printing(r.info->level))
+		if (suppress_message_printing(r.info->level)) {
+			console_lock();
+			latched_seq_write(&con->printk_seq, seq);
+			console_unlock();
 			continue;
+		}
 
 		if (con->flags & CON_EXTENDED) {
 			len = info_print_ext_header(ext_text,
-- 
2.29.0

