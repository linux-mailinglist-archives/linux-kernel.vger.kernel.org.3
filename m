Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149694EE3BF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242265AbiCaWFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242234AbiCaWFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:05:10 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC9F55229
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:03:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g20so863858edw.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TIkpZXU6eDpzo3cMVd1sBQyW2EHQ/n+w+rqxQP5ETUw=;
        b=fZMZ8TDchV6kJBU+jOU/iyBddQaCPhq03VYavivWD1Yd3m+uKrqWO4s4YynLAlK+7W
         YDHgc6RsxdM9VBytXwRuiMiIzljeti2SmDFfnul8Cjb3Jj0NSSs++5Xe33aj/sEAqhW7
         rdcpwEOj0jlgba9l1B6ej+r88CWwZQVst+9PFXz8lJXOd4J82Yh7zW+rrxH4QQoWkR/k
         hEAHg6rHmdtgvdOZ2tfeFI13ZepqSs3owaK5mBM+jK3OWtNi7FI4pIPfHwcACiA7C1ew
         CuDxFKRDmi8dorjguUh7DvCLVWd3zrzZ1DqHDY/NsrbFAqzVOOqLbkf5m93bYmUy0xuB
         P63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TIkpZXU6eDpzo3cMVd1sBQyW2EHQ/n+w+rqxQP5ETUw=;
        b=oh3YStmRio8Zw2hM5vT6xi8OOgVNHqgwPUogy/X7ezzl/5XEn0FTFu4OHl/utVmr3g
         0DOeALONZLJyD6nS0GvtJXsEMpmdTsuVAayEwP+wCu47wz0nLMM0Ye028xWpO72z1v1U
         /WW0NMmaPNFQdiH7x9G7/Hzz7aRyECUwPRYCkZFKjquw0G1XHdbclN154dc1TpM55KnQ
         gm4Cj55A1Z7e2kQTXrSLoa9aqPA+KmOdQghh3YL0khR6W3JPnN/vJTFzBEtYsJ9akxtf
         5YtnJz7t86QUD1+f69TSqFP2PyBofKGApVRAuhEQptw1GhJjZ4uc7SptY3O7fasQOjI7
         LJOw==
X-Gm-Message-State: AOAM531PDAnFHmkt95OJEdHVd1AWqQ4IWVWyzT/xAO3379JZsu9qafF2
        SHprTihoQMkEQRD3cw+sxaw=
X-Google-Smtp-Source: ABdhPJwrocf5wfA3uY8P68HIYW1QfY4wsiYuxLMBN3abwaj3bbyno9YqIO5Vdj98GczqduyWM46BQw==
X-Received: by 2002:aa7:c64c:0:b0:418:ecf7:afaa with SMTP id z12-20020aa7c64c000000b00418ecf7afaamr18660269edr.38.1648764199045;
        Thu, 31 Mar 2022 15:03:19 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id sb15-20020a1709076d8f00b006dfe4cda58fsm247312ejc.95.2022.03.31.15.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:03:18 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Alasdair Kergon <agk@redhat.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH 1/2] dm snapshot: remove usage of list iterator for list_add() after the loop body
Date:   Fri,  1 Apr 2022 00:02:35 +0200
Message-Id: <20220331220236.884887-1-jakobkoschel@gmail.com>
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

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element
[1].

Before, the code implicitly used the head when no element was found
when using &pos->list. Since the new variable is only set if an
element was found, the list_add() is performed within the loop
and only done after the loop if it is done on the list head directly.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/md/dm-snap.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 0d336b5ec571..23386a6e67e7 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -528,13 +528,17 @@ static int __validate_exception_handover(struct dm_snapshot *snap)
 
 static void __insert_snapshot(struct origin *o, struct dm_snapshot *s)
 {
-	struct dm_snapshot *l;
+	struct dm_snapshot *l = NULL, *iter;
 
 	/* Sort the list according to chunk size, largest-first smallest-last */
-	list_for_each_entry(l, &o->snapshots, list)
-		if (l->store->chunk_size < s->store->chunk_size)
+	list_for_each_entry(iter, &o->snapshots, list)
+		if (iter->store->chunk_size < s->store->chunk_size) {
+			l = iter;
+			list_add_tail(&s->list, &iter->list);
 			break;
-	list_add_tail(&s->list, &l->list);
+		}
+	if (!l)
+		list_add_tail(&s->list, &o->snapshots);
 }
 
 /*

base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
-- 
2.25.1

