Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693DF5775B6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 12:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiGQKXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 06:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiGQKW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 06:22:56 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F1214018;
        Sun, 17 Jul 2022 03:22:56 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id cp18-20020a17090afb9200b001ef79e8484aso10732792pjb.1;
        Sun, 17 Jul 2022 03:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N8jLDe75DF7X7EgllRZVFN7v6x4x8NvijaCiwku09NM=;
        b=lQRJ54gUPs9huk/nj/SXTN6PbuPH6CofkN1QOBX+gWiVMP1SdMvN+IikLIaBZTYhCc
         N3wxXgz8h4ZY/Mv4VZLsXQUiLagiif0v+MVowe2ge7tvRdWhbLykwWUgzV+cs4+AVp6w
         p1Y+cjhjn+kPazbKCRle91Tw6I4zLUf8LWsfzrKFNuBAu2ZUSsEB4/MxH2TGl3xCgNqM
         qWOf05+pFVYBOj3uAALLxXT+ZIkstVfpD17ox2xe8JRCBeUuk+2D4QNqh9YwFlQsOqOl
         VFJXpUQYJWJnVXGBe3/aLRjQ2WdnpFzYz/JN7W6q8BEWkDoa0fWhtRCpktPRVrahSJEp
         RrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N8jLDe75DF7X7EgllRZVFN7v6x4x8NvijaCiwku09NM=;
        b=HguM7gJ0EVZceIuFDzK1mOHUwTNyjV0wMSeUt7msS4MwFCA+GMGTkgoXjiM/qhJ5/t
         DLwAe169o1UxPUEu5dMZq7Owqw0/KBZvSQcz51ZXVhxryxbQhDKCXyG0l4AYFIVEf135
         oKyyUx1Mxx+NcjYed6qRHKMPosGonOtQLum/t8uHZ/ynm5bh/5PRkhiBpUv9vpL6IPCx
         YS06o4qK97P2d12gPwZj2vIgRUnrb0GsGBRzwDUK8d/rhF94zTiV6+zlMzGr5uqcIw43
         f2017OhH8hrE7MJ6piEuDT/K+0uxnI0pwYvvrlaBM8pl4fedy6TK9F/Mn3pgSp3XgSg7
         7y5A==
X-Gm-Message-State: AJIora+TOW903eltXIrYYJNBTsa0gpCy9pFdnr63gPKePLSCy1VuwVAM
        gQmz0/oBN/yGTlBQN2GjdSI=
X-Google-Smtp-Source: AGRyM1tXi/Vbbvg21DPegOEpYdaKp/DYhDJJkkcGx4Tl/IQjrPIQCvScIdBTuHvavDxAlI4+lhKfHg==
X-Received: by 2002:a17:902:ec8b:b0:16c:1cc2:6794 with SMTP id x11-20020a170902ec8b00b0016c1cc26794mr22122293plg.17.1658053375335;
        Sun, 17 Jul 2022 03:22:55 -0700 (PDT)
Received: from biggie.. ([103.230.148.189])
        by smtp.gmail.com with ESMTPSA id pf12-20020a17090b1d8c00b001ef8ab65052sm6945516pjb.11.2022.07.17.03.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 03:22:54 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     axboe@kernel.dk
Cc:     Gautam Menghani <gautammenghani201@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: [RFC] block: Add a NULL check in blk_mq_free_rqs()
Date:   Sun, 17 Jul 2022 15:52:42 +0530
Message-Id: <20220717102242.219424-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reported a general protection fault in the function
blk_mq_clear_rq_mapping() in the file block/blk-mq.c.
The issue is that the variable drv_tags is NULL, and this
originates from the struct blk_mq_tag_set. The dashboard link for this
issue is : 
syzkaller.appspot.com/bug?id=c3ce4caa4fc58c156d4903984131cdfa38eee354

This patch fixes the above bug, but there is another syzbot bug which is
related to this and getting triggered after the call to
blk_mq_clear_rq_mapping(). As a result, I cannot determine if the issue
is really solved. The link to other issue:
syzkaller.appspot.com/bug?id=7643cea70f1d0ce15f5f4bc39488918837ad4233

Please provide feedback/suggestions on the same.

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 93d9d60980fb..c1dd1b78b95c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3092,7 +3092,8 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		}
 	}
 
-	blk_mq_clear_rq_mapping(drv_tags, tags);
+	if (drv_tags)
+		blk_mq_clear_rq_mapping(drv_tags, tags);
 
 	while (!list_empty(&tags->page_list)) {
 		page = list_first_entry(&tags->page_list, struct page, lru);
-- 
2.34.1

