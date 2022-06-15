Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EA754BEC4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 02:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbiFOAhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 20:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiFOAhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 20:37:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA8D13F64;
        Tue, 14 Jun 2022 17:37:45 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id u2so10013127pfc.2;
        Tue, 14 Jun 2022 17:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lqune7TOKj50JTMv6xtwhBh+LkwqGuxbN/y3qLyMyvk=;
        b=R2URQgjtUB7aM836Yy31HgZM0qvwzRxuWIIm07hP3WxbfsNsdvCuDyk4sYGuHILWPJ
         ClBDw/az8yWCkfj8YOcMm2+UidIU2x9Nc4lXh4xIIpocaJvPuuuz5APnodOGXLC0Z0Q7
         kQ82Eh/7IqTftZwBF4kpcmij5vzqj2ktdqCXk/fBjpR8Jvu2tEnuMzXj/aklGSu+GOln
         gqyTlnpSzfMB4P4Uya98wS9uc2QCfK9nVxRl2sFBVc6WeSHUUMPrhdC6lf+I1Fc2KWQQ
         Ads9P2hoq8Eo5iHR4yw2TSgmqz0OrduhrTJa+M9xcz3yEIog//9HhYV6Pn3zT2WUQGO3
         v/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lqune7TOKj50JTMv6xtwhBh+LkwqGuxbN/y3qLyMyvk=;
        b=VFKn5EWVahxh6mo4+ptkR/qSp4uv1ZjkyzVxYvvgZ93gL+hnoC9yRjl892xAyYBxoq
         9HCq+qU6yz2sXwuZKtkUz87+YA3jnfdSZOW4v3yYhjMYt4lghceE30TMZihQHFnHrSBg
         NKECudBPYZsISJj2crNP8kDP4/tMSpssUSSQkbw7/+PVczFhur8H9PCAGdPc0urCh6wa
         vQ5kk8QcoGS75+J4cqogAsNDPeYeHQ5ncD1ixGN2R6xGwPp9qS1XecycNibhFWN5qmP5
         +p/4hAWseQYFRiyhNn6KRe8TQk6EfdU6J9TrGdJX7HOZuYMJOuQ1QiWuW4rVJ5gnP1QE
         68+Q==
X-Gm-Message-State: AOAM531Tt79IYGn8OHt3iYkBORqGybUwXZLeyMZJnovD6DOMkrQSLwaU
        DwjL0RDCRbzuaWXalm17bqajxh4BJUY=
X-Google-Smtp-Source: ABdhPJxbSglsT720F2LqHdv7BVKCccCzbzw4JaHonjnhD227mdnNa24wO18UR3J6Rz7bs+nng77uKw==
X-Received: by 2002:a63:ee54:0:b0:3fe:30cc:899f with SMTP id n20-20020a63ee54000000b003fe30cc899fmr6813140pgk.234.1655253465042;
        Tue, 14 Jun 2022 17:37:45 -0700 (PDT)
Received: from localhost.localdomain ([199.101.192.2])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090aec0900b001dcf49d92a1sm216795pjy.28.2022.06.14.17.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 17:37:44 -0700 (PDT)
From:   zhouzhouyi@gmail.com
To:     john.ogness@linutronix.de, pmladek@suse.com, paulmck@kernel.org,
        dave@stgolabs.net, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH linux-next] RFC: torture: add pr_flush to flush the results to console
Date:   Wed, 15 Jun 2022 08:37:33 +0800
Message-Id: <20220615003733.16447-1-zhouzhouyi@gmail.com>
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

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

currently tools/testing/selftests/rcutorture/bin/torture.sh reports
false positve because of kthread printing.

Commit "printk: add functions to prefer direct printing" (2bb2b7b57f812)
have added functions to prefer direct printing activated for the primary
import messages.

Meanwhile adding printk_prefer_direct_enter/exit to
torture_cleanup_begin/end still can't eliminate the false positives
for a hundred percent.

This patch add pr_flush to torture_cleanup_end because the latter
is sleepable.

Reported-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com> 
---
 kernel/torture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/torture.c b/kernel/torture.c
index 789aeb0e1159..b51e42463a67 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -878,6 +878,7 @@ void torture_cleanup_end(void)
 	mutex_lock(&fullstop_mutex);
 	torture_type = NULL;
 	mutex_unlock(&fullstop_mutex);
+	pr_flush(1000, true);
 }
 EXPORT_SYMBOL_GPL(torture_cleanup_end);
 
-- 
2.25.1

