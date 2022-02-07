Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686694AC032
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389189AbiBGNvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377766AbiBGNMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:12:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57478C043189
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 05:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644239544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AM7CkP1jX2ZU2ehs/pvwC2vA3OLiBCABJ2xVS2YUHFE=;
        b=AfP+HyJ4GR7QQ8SuFT7e4mBawn/dh/3CgP9XDQhc7Rr9hoOdh2bBd8huAWfFksnc0PTc8U
        R+ihyC7g1TmEhTTLIfeG/tx3fQ3EGalO6rwCoFm7QRImj4/aYHzXkcLvbIerpaL+52MG39
        jdUnJ5PsnZH5PoK51ZqaDluXZM4WLBw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-OHkHsLw_PKqT4r-a8qfekg-1; Mon, 07 Feb 2022 08:12:23 -0500
X-MC-Unique: OHkHsLw_PKqT4r-a8qfekg-1
Received: by mail-qk1-f197.google.com with SMTP id z1-20020ae9f441000000b00507a22b2d00so8524717qkl.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 05:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AM7CkP1jX2ZU2ehs/pvwC2vA3OLiBCABJ2xVS2YUHFE=;
        b=gg/7JJjpMqhwBISg5F+vxh4Te6M4ad30vTByG6gxoceBKBVCqxxsSQshqF077h4ILs
         KxfFq3PFvpv2GFXSDhAKFEny3A92nNdXGvvduCP1kuVyszoWsa2R+t6yahI+6Kic0t6q
         Br8GN4JvNPsHTIMGBwmrGbvnVaWnipaQx1QErnTBKZTVAmqLUYHku2/QGVyg7bQN6qc0
         fyQjdMwFbeflwpIrmvcu5mrJK7Cs7nbgnNwydymRLsy+FR4vwmiDsVWrdKAllSqLcbl1
         rPapF5vO8pYkqdte+ZwtEy3N4q/DBeguFk5KTjFf0VcENgJMxYzt14vdzIgSBIMuFj2K
         AP9Q==
X-Gm-Message-State: AOAM5329xJq8LUnw1IS/7IOYVaQpAv0SmukJKRi+DqL8fWuazN65RQze
        23pPdvwH5/7Hb674ewcw1FnJqcVSmNvKlAKdPEOYslQRNqjR1YBWqQLoct6IeUb+Gp+V6XMeLp4
        QFTtWUkpZM4c5Dh5Poyo9sz4h
X-Received: by 2002:ac8:5b86:: with SMTP id a6mr7687367qta.511.1644239542995;
        Mon, 07 Feb 2022 05:12:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYryoti78q4IRbgop6R+gf6+laHXQJvL6b4IkG5WweRk4kKP/sxjxwOMadnrYqhcaBGgsmaQ==
X-Received: by 2002:ac8:5b86:: with SMTP id a6mr7687354qta.511.1644239542824;
        Mon, 07 Feb 2022 05:12:22 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id m22sm5441448qkn.35.2022.02.07.05.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 05:12:22 -0800 (PST)
From:   trix@redhat.com
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] tracing: cleanup double word in comment
Date:   Mon,  7 Feb 2022 05:12:16 -0800
Message-Id: <20220207131216.2059997-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'is' and 'to'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/trace/pid_list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
index a2ef1d18126aa..95106d02b32d8 100644
--- a/kernel/trace/pid_list.c
+++ b/kernel/trace/pid_list.c
@@ -118,9 +118,9 @@ static inline unsigned int pid_join(unsigned int upper1,
 /**
  * trace_pid_list_is_set - test if the pid is set in the list
  * @pid_list: The pid list to test
- * @pid: The pid to to see if set in the list.
+ * @pid: The pid to see if set in the list.
  *
- * Tests if @pid is is set in the @pid_list. This is usually called
+ * Tests if @pid is set in the @pid_list. This is usually called
  * from the scheduler when a task is scheduled. Its pid is checked
  * if it should be traced or not.
  *
-- 
2.26.3

