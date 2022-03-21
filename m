Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039FF4E202E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 06:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344424AbiCUFkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 01:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237634AbiCUFkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 01:40:00 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9712611D;
        Sun, 20 Mar 2022 22:38:36 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id kl29so4469257qvb.2;
        Sun, 20 Mar 2022 22:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ElyZxBSGFcV7GRF7AHMLc39rdz6a/cByjmTIAqRWb9w=;
        b=hv5W1ECgcQ1dF9rhFkQb3PFBtyZOm+aZunZsyGWsV1eI1ISLonvLLPwTEqML/HcCVR
         my7bUb4IYJ1L293x2TbNTKlK17U+1Lx1ae8prjFGj96SBMssSdQUH6nP1/JeIRaeJgJD
         1a/5UfuS2ToHVrIdQLpqcuN9efN3Pc57nmSqqO44EEL+sNrUcmsgZpmuvRxQCgsaD7M/
         xykBJF8Y1oA9UQGdbxaBDo+LOUUHL0Cs7rw5fFLlsXy7eblS5gcOmScQoqzBYSoIQwxs
         FNGSuBaP1hVb+rehn0dlJMRR0H5gqlY+PwGmE3Va1bQSs52oAhcx+8G/TdEuxkh/Agg5
         h8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ElyZxBSGFcV7GRF7AHMLc39rdz6a/cByjmTIAqRWb9w=;
        b=4bWtsUuhvg8TLAZBUtmtYgJfEfgDymTb12yMU2gBl6uVeKC+/bNez0GNFjSNYxoX2I
         1RmrlLUfayTCo9WsJXRDnCjAQllbt2D932bBV7fX6r5bF1Ylg9UGk2RzxcUj9HbMN1kZ
         aTM8YCD5nyufMoP9B6MlhE3r9W0hHWFUFw3T5Rf89hHwZ/oz8O7RXOkiMNp+oR6aBIoF
         h1h61Gb3tCcCz0JYk+nJ49VMhKt9/B0xCVVca2H/45ViSFLnIsosVr+RMkVCeObvehPP
         eiY+NOp9c8PEfXVjA+8ihVeegDO/naVE+YhD6yjQ/ycyU+7mt2mawEW/EuhwDwzcphWZ
         tZ6Q==
X-Gm-Message-State: AOAM532eO+VQSdOIzKQowZTiyE+HmTF1Rg2h7IodKlqerE1nuZPUSbAB
        rTB+5sIi94Be2HH3J5gr5Fw=
X-Google-Smtp-Source: ABdhPJyIqxkdkSIUu18d2F0nVvEAN+k6swQvjRrfh9TbYnj1z2/8wI06xHn1i82zJlN6yn1SbKsiiQ==
X-Received: by 2002:a05:6214:2487:b0:441:1c21:2693 with SMTP id gi7-20020a056214248700b004411c212693mr3736618qvb.17.1647841115223;
        Sun, 20 Mar 2022 22:38:35 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id l7-20020a37f507000000b0047b528ef416sm7263142qkk.93.2022.03.20.22.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 22:38:35 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, john.ogness@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, tglx@linutronix.de, schspa@gmail.com
Subject: [PATCH 5.10-rt] printk: fix suppressed message print when reboot/panic
Date:   Mon, 21 Mar 2022 13:38:16 +0800
Message-Id: <20220321053815.71316-1-schspa@gmail.com>
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

Affects 5.9-rt and 5.10-rt

When message is suppressed, printk_seq should be updated, otherwise
this message will be printed when reboot. This problem was introduced
in commit 3edc0c85d154 ("printk: Rebase on top of new ring buffer").

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 kernel/printk/printk.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0c56873396a9..f68c4ba7eb4d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2826,8 +2826,17 @@ static int printk_kthread_func(void *data)
 		if (!(con->flags & CON_ENABLED))
 			continue;
 
-		if (suppress_message_printing(r.info->level))
+		printk_seq = atomic64_read(&con->printk_seq);
+
+		if (suppress_message_printing(r.info->level)) {
+			/*
+			 * Skip record we have buffered and already printed
+			 * directly to the console when we received it, and
+			 * record that has level above the console loglevel.
+			 */
+			atomic64_cmpxchg_relaxed(&con->printk_seq, printk_seq, seq);
 			continue;
+		}
 
 		if (con->flags & CON_EXTENDED) {
 			len = info_print_ext_header(ext_text,
@@ -2843,7 +2852,6 @@ static int printk_kthread_func(void *data)
 				printk_time);
 		}
 
-		printk_seq = atomic64_read(&con->printk_seq);
 
 		console_lock();
 		console_may_schedule = 0;
-- 
2.29.0

