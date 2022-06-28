Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3DA55CE1E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiF1D1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238993AbiF1D0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:26:52 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A792526578
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:26:43 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id go6so11333469pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=sxL1ZzxVZPT2Vlyl25hhsBkrjfEbbbI9SH3Gm8imfVg=;
        b=iWWIz/hmhX4hQ4eJ/gJsDp2Fqd62foD15EKzuQf4HboapEpF27bFvB1qW0Bik5ndjf
         bMO01egTkbkkik9waEzKQSeMi3Rto7RtEFfAlO8qh0nt05BYXSnN8d5n/MFh80AHzCcg
         84OZiTlP084lAWXGuCC/+Pc9hT4w0sMMF+HQcwH5jIfnfXMqrWj3iLscoy4TArSLTT3I
         9FlGGuonXxQBOzyTk3snuIWerOaN1y++HOUekXjY1LhhZh7+UQjqaYEAxzmnqHj9zJwv
         RuDfwB88h8E8sIu9VA9/M9Bc+NeDs6KyWsOzdGXqqhHE4rRpCF62rLM3iKzWlvhZnH0B
         HwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sxL1ZzxVZPT2Vlyl25hhsBkrjfEbbbI9SH3Gm8imfVg=;
        b=4Venak9TbplWrpO3TR7SQhe3K33z5aLyTqUIZLN72+diK002bnlrIKfUQAG7hHz1wu
         EeBqHIdYmA5h4uI5CaOItmFcpyogDID72Yg+77O43dVYZtWzydok/kPWPObugNENIK6A
         1xsWwlBTbJt1N9ruupTl3i/290lePRCn7/9BfjrQRWycLo8vONT4Q2CDOZUwWWLqb9ba
         FNezQWWtVcx8gDLeU3/30hDg2HJkmldgJ4fzmXeTRodDD8i+nPPQcJR3dWvyIA5/xeXm
         USUDmxC7KvxO1RHhDWHHHekL1wGPWoQiC5qZDT2fogDoW90G4fdZlPji87zNep548iGJ
         nwUg==
X-Gm-Message-State: AJIora+47NcTfE/nmvmS8eI56iVokgyl7JJNheKSdbi9wNi8YxoVj5Ge
        jDkooWRK1KMsfLhJW4BMjST9hicBEm7XvLkD1xY=
X-Google-Smtp-Source: AGRyM1vpBm73OTEtWRsynFV5fEsgX+k/Joz9k5puhCRKBwaofC//Rq4m+7R+1LoMJwXAEXp/OhASiA==
X-Received: by 2002:a17:902:8343:b0:167:8899:2f92 with SMTP id z3-20020a170902834300b0016788992f92mr1495175pln.117.1656386803259;
        Mon, 27 Jun 2022 20:26:43 -0700 (PDT)
Received: from desktop-hypoxic.kamiya.io ([42.120.103.58])
        by smtp.gmail.com with ESMTPSA id t20-20020a1709028c9400b0015e8d4eb282sm7939541plo.204.2022.06.27.20.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 20:26:42 -0700 (PDT)
From:   Yangxi Xiang <xyangxi5@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        nick black <dankamongmen@gmail.com>,
        Yangxi Xiang <xyangxi5@gmail.com>
Subject: [PATCH v2] vt: fix memory overlapping when deleting chars in the buffer
Date:   Tue, 28 Jun 2022 11:26:28 +0800
Message-Id: <20220628032628.29780-1-xyangxi5@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A memory overlapping copy occurs when deleting a long line. This memory
overlapping copy can cause data corruption when scr_memcpyw is optimized
to memcpy because memcpy does not ensure its behavior if the destination
buffer overlaps with the source buffer. The line buffer is not always
broken, because the memcpy utilizes the hardware acceleration, whose
result is not deterministic.

Fix this problem by using replacing the scr_memcpyw with scr_memmovew, and
preserving the memcpy optimization when the buffers are not overlapping.

Fixes: 81732c3b2fed ("Fix line garbage in virtual console")
Signed-off-by: Yangxi Xiang <xyangxi5@gmail.com>
---
Changes since v1:

add more information about this bug and which commit id this fixes
---
 drivers/tty/vt/vt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index f8c87c4d7399..d87bff9d8ed5 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -853,9 +853,13 @@ static void insert_char(struct vc_data *vc, unsigned int nr)
 static void delete_char(struct vc_data *vc, unsigned int nr)
 {
 	unsigned short *p = (unsigned short *) vc->vc_pos;
+	unsigned short cp = (vc->vc_cols - vc->state.x - nr) * 2;
 
 	vc_uniscr_delete(vc, nr);
-	scr_memcpyw(p, p + nr, (vc->vc_cols - vc->state.x - nr) * 2);
+	if (cp > nr)
+		scr_memmovew(p, p + nr, cp);
+	else
+		scr_memcpyw(p, p + nr, cp);
 	scr_memsetw(p + vc->vc_cols - vc->state.x - nr, vc->vc_video_erase_char,
 			nr * 2);
 	vc->vc_need_wrap = 0;
-- 
2.17.1

