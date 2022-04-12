Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774534FE120
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354237AbiDLMyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356439AbiDLMtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:49:03 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A73D522FB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:21:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id d10so22188448edj.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EPjj/sFnkjhGM2biUN3Tl6oPqdHpDSyFwE2ONZLcGJo=;
        b=nuTbpnQoPTPHlZCQtpdrFqrjjSokDH8oF8Eu2o2WLYoqmEHIkDhTOuF039KVucaFH6
         BiczPoEs5gfaNzxNJUdvjC2IH/rDt/I6cCOm+qjv8KzyPreJCl9C559kDfo0/21dJDXM
         TFPdoQvV1MQqCdHrnvCiug+M/3GKfTehLjVb7t30V6sY2sJ94MODDCJOe9tZzImjm2ZI
         +tfSeBh+JacFHvBsgFGH/ftHk5h1jgpa8sugL55YcszggbPTC8QMPTWtdCPyUC2/4F34
         noYFuNE7fhk+7gaSwdJCjUfHrJR78UOq4JcFJPiDaYcoqUm65Y9AsDwHtW16XGrwhKlw
         UZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EPjj/sFnkjhGM2biUN3Tl6oPqdHpDSyFwE2ONZLcGJo=;
        b=zgoaLF1ZQ55I31S009kchoiiiLrcwFkKe6Rmf5SIaXbrfnDJ0WmVZbUyF1KawCcWOI
         RoGFh6uTK9G/GfWgDP08XmdWKKKGS4lJ1CR0xcO4umsWBdtXA6uqb1P876qNGznfbCaQ
         kcg3rxBedoPe1laQ3O/z+MWoK4Ub6zQtbkuPDjDmI5Qb3/qbatS2L6vKrBbEC9qjGNNr
         3JvzcA5bfH+MSIhdkgvMW6VRWJK08TsFIcY/QmEYiG+ibvzJM3tdJu61uFw428CQi4Oo
         eqakvCLoagCJqn+lUNRYscLcvRNGw/wHQiONVgGr5t8dgwshLZKxX9bNQCTK2BJO2qVh
         QKqQ==
X-Gm-Message-State: AOAM530UXznBW4cA2gCwZ/4bNkKKXtWZmRXumTm53o8Uo3pIwQCe6I5N
        eQsueUYSRyhymQDRSxTo4t8=
X-Google-Smtp-Source: ABdhPJyCNnVdUgHBuoYZ5573qvtHmSJN7I9YwbEFcLdy45eTKGjB+NhKYFi8H5zsYU/qiEIyy4vzaw==
X-Received: by 2002:a05:6402:1753:b0:41d:7a22:3822 with SMTP id v19-20020a056402175300b0041d7a223822mr10867791edx.247.1649766068696;
        Tue, 12 Apr 2022 05:21:08 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id op12-20020a170906bcec00b006e89b09a238sm1954081ejb.4.2022.04.12.05.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 05:21:08 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH v2 2/2] f2fs: replace usage of found with dedicated list iterator variable
Date:   Tue, 12 Apr 2022 14:20:40 +0200
Message-Id: <20220412122040.3555423-2-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220412122040.3555423-1-jakobkoschel@gmail.com>
References: <20220412122040.3555423-1-jakobkoschel@gmail.com>
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

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
Reviewed-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7ec1a2ef2167..7c52e352a356 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1666,33 +1666,32 @@ static unsigned int __wait_discard_cmd_range(struct f2fs_sb_info *sbi,
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
 					&(dcc->fstrim_list) : &(dcc->wait_list);
-	struct discard_cmd *dc, *tmp;
-	bool need_wait;
+	struct discard_cmd *dc = NULL, *iter, *tmp;
 	unsigned int trimmed = 0;

 next:
-	need_wait = false;
+	dc = NULL;

 	mutex_lock(&dcc->cmd_lock);
-	list_for_each_entry_safe(dc, tmp, wait_list, list) {
-		if (dc->lstart + dc->len <= start || end <= dc->lstart)
+	list_for_each_entry_safe(iter, tmp, wait_list, list) {
+		if (iter->lstart + iter->len <= start || end <= iter->lstart)
 			continue;
-		if (dc->len < dpolicy->granularity)
+		if (iter->len < dpolicy->granularity)
 			continue;
-		if (dc->state == D_DONE && !dc->ref) {
-			wait_for_completion_io(&dc->wait);
-			if (!dc->error)
-				trimmed += dc->len;
-			__remove_discard_cmd(sbi, dc);
+		if (iter->state == D_DONE && !iter->ref) {
+			wait_for_completion_io(&iter->wait);
+			if (!iter->error)
+				trimmed += iter->len;
+			__remove_discard_cmd(sbi, iter);
 		} else {
-			dc->ref++;
-			need_wait = true;
+			iter->ref++;
+			dc = iter;
 			break;
 		}
 	}
 	mutex_unlock(&dcc->cmd_lock);

-	if (need_wait) {
+	if (dc) {
 		trimmed += __wait_one_discard_bio(sbi, dc);
 		goto next;
 	}
--
2.25.1

