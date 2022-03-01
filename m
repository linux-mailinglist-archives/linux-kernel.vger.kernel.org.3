Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB154C8154
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiCAC4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiCAC4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:56:42 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5A5506EF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 18:56:03 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id bx5so12896646pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 18:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=+oP2AO871oIpXAcC/nDmnIsSYJzx7JMC4/HUdgahwKY=;
        b=eRUXUXcLipShqDTQl0hZsfJ4zjNtH8BaqLFAUxSVWgweLN8ybhgSDAjhdMVp3zetn8
         jS0lMbS1Eo/cYnWn+5r9pGJTMqYOk86RqPDq8c/0Zrb+UKY2dHAVHA4O9jAaZVIuGHTO
         SfYBvzXpRIHtvCtEhi2AjDHApRRJUssYd1Nc9x9pFFqlcPPDhOREN2mqpC3wjPnHbMrY
         ZeYCDrAimJtEbn6VS9OoKp55gpV2/3F03ht3VfSFeJPbe2aOfp+jF+NVB0VAzdRij95Q
         ULK/DYzBPfyxVBi7OFnIXEnEIUNDYCNSu52x+o1mIm210wmTsi8/xbgthGYp2DUFClfZ
         /hBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+oP2AO871oIpXAcC/nDmnIsSYJzx7JMC4/HUdgahwKY=;
        b=iM+fo8vazaOZqnWv0sZYY5obtXXvPTkR+PBxnrkPPr9GoL0VOtTQe6oEstz8TGacRX
         CP+pGHcC3ABlvotzIXbblZpv1vNU0zZ7+i1IaiEZfLpamSQ01ewmKVrdVD8xtVFuPVe8
         yQeJxvKWpW80cyofcGkZm7MK2Te6PaDyK3HNIpBKizgs1XYnrH1xsXUKPZCJzVHbKUw0
         JR8T+StJR2E9U0cwWTTTqWqxHzbvankQQfJw/YsnZGQfFOUPzJqTCDddFHu2ze5lR0rh
         SHxi9tcNjbdnhbd1rw/IIsdEQpe48K5QQ3v0PJLNiNIl9Ng3VNXKVPVFvx66PAyNXsdl
         9A1w==
X-Gm-Message-State: AOAM5339w83x0tbOjokQVTMMU+l9sw/ZtmrPdn3uivzA/J1tf/R/8Qnq
        zvynBvjMdaz5S945A5ET8Mc=
X-Google-Smtp-Source: ABdhPJxII7ASR0VniO0WOpVAL6u+IKiKmvnlF6UECkG2RZDQzn74RWG9jMPgBrVKRye5xOf8va7pvQ==
X-Received: by 2002:a17:902:ea86:b0:14f:b4be:6f83 with SMTP id x6-20020a170902ea8600b0014fb4be6f83mr23118659plb.99.1646103362801;
        Mon, 28 Feb 2022 18:56:02 -0800 (PST)
Received: from meizu.meizu.com ([137.59.103.163])
        by smtp.gmail.com with ESMTPSA id f6-20020a056a00238600b004e1906b3bb2sm15372383pfc.12.2022.02.28.18.56.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Feb 2022 18:56:02 -0800 (PST)
From:   Haowen Bai <baihaowen88@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org
Cc:     longman@redhat.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Haowen Bai <baihaowen88@gmail.com>
Subject: [PATCH] locking/rwbase: Return true/false (not 1/0) from bool functions
Date:   Tue,  1 Mar 2022 10:55:58 +0800
Message-Id: <1646103358-21591-1-git-send-email-baihaowen88@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return boolean values ("true" or "false") instead of 1 or 0 from bool 
functions.  This fixes the following warnings from coccicheck:

kernel/locking/rwbase_rt.c:226:9-10: WARNING: return of 0/1 in function '__rwbase_write_trylock' with return type bool


Signed-off-by: Haowen Bai <baihaowen88@gmail.com>
---
 kernel/locking/rwbase_rt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 6fd3162..e3dd458 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -223,10 +223,10 @@ static inline bool __rwbase_write_trylock(struct rwbase_rt *rwb)
 	 */
 	if (!atomic_read_acquire(&rwb->readers)) {
 		atomic_set(&rwb->readers, WRITER_BIAS);
-		return 1;
+		return true;
 	}
 
-	return 0;
+	return false;
 }
 
 static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
-- 
2.7.4

