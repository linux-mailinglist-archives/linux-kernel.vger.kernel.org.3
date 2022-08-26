Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4C85A21D4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245336AbiHZH1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245330AbiHZH1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:27:42 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152F6D345D
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:27:41 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v23so881126plo.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=3iM6b2joscpJlkQz/PuQlcsTrGiQrRr+gu4xFycwI0U=;
        b=BTZkjmCOYHErNWV+QEQwC0dnuK2mKtDbtbwLYGxtBclKinJ28FS+vp7CL/nMqQtGYF
         qVdTQM2a1u2ZASn/BkFojOxML2evKj+4Adb2KTZuWiCMDrXDd0hJIBSbS0N9ggRmE7+w
         UZOaxqJNrFNi+JKXDoOBIkh9+syfY2l19T/5dkoXIvrIhKIFcZ+MvOf38zzS8v9N0s5s
         x7RwFfl3LQcTLFiQGbhI/dakUulBX8l4257HpaZVs7Qb431aZsMUU2VR03S2MJWktUBC
         mNJ2+vPs7aFz5aYDsuCjLuJ3zYQW/mM2zdaQRQAYpXMnPFDFNXWKa1OY22xcy15VOBU7
         PiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=3iM6b2joscpJlkQz/PuQlcsTrGiQrRr+gu4xFycwI0U=;
        b=563O31WKcwOG5qCOeV3n/s4YHsaJEhCRQkeYEb/UlpqNs0/NhQ1NWlF4tAncWIU9Cx
         q+RNwmuqHdIEPrRzs3wwst5Sc6H8qrhvvout9JcwD/Mk6tgPgZMJzyPf/nXK9qEHqSnh
         /STKOuuhaBDa5kMUFtmT36p84k2ioHWhFM/amYv09pS+bSPZQHdKzAiFf9GwCP4Lvwfy
         z8w5RP8JNiEukhhr4m9/jYKmEH3m65o3WrE1nyX03Lsw02nXzV3kRiE98eFCIaZgQmGB
         MvbUjgAMrpF3SzypM+NdsLiRkTOCfRx/fRUYBQXIA80utygdbQEKM16jZ3by7Frup7xV
         2/ag==
X-Gm-Message-State: ACgBeo3sf7VJD28Q0WQi/b/HeIsNcqaG1nRbCJBh4VIW2b9wXjQqyMAi
        Y7PbBQovPQXUB1san8vXO0o=
X-Google-Smtp-Source: AA6agR4r3Bci/NicMKP3JvGZHI7EYJ9xz9g80TSRrFpgLqRBw942b1w+5vdGowJ2+th9Zvc5OZ8SMA==
X-Received: by 2002:a17:90b:35c1:b0:1fd:6992:f82a with SMTP id nb1-20020a17090b35c100b001fd6992f82amr862320pjb.188.1661498860251;
        Fri, 26 Aug 2022 00:27:40 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g11-20020a17090a290b00b001fb23c28e9asm954802pjd.2.2022.08.26.00.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 00:27:40 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] tracing: Remove the unneeded result variable
Date:   Fri, 26 Aug 2022 07:27:36 +0000
Message-Id: <20220826072736.253086-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value simple_read_from_buffer()  directly instead of storing it
 in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 kernel/trace/trace_events.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 0356cae0cf74..9e4dd1720fff 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1435,7 +1435,6 @@ system_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 	struct trace_array *tr = dir->tr;
 	char buf[2];
 	int set = 0;
-	int ret;
 
 	mutex_lock(&event_mutex);
 	list_for_each_entry(file, &tr->events, list) {
@@ -1465,9 +1464,7 @@ system_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 	buf[0] = set_to_char[set];
 	buf[1] = '\n';
 
-	ret = simple_read_from_buffer(ubuf, cnt, ppos, buf, 2);
-
-	return ret;
+	return simple_read_from_buffer(ubuf, cnt, ppos, buf, 2);
 }
 
 static ssize_t
-- 
2.25.1
