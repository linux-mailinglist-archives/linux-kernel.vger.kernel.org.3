Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0CD4DEA96
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 21:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244105AbiCSUUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 16:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240604AbiCSUUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 16:20:01 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11D22708
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 13:18:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id j15so8882771eje.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 13:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IZVebcAv1gMSkhke8vkvP7hwXg0ZkCIulZG5b/+xBiY=;
        b=PSXhM8259OyCG9Yqq/7bKN0DzJh38ZIG325SqCvFrzISGGppXWs7PJ+Te/x2mkx9Id
         SuwWmAn2tlnyx9hf/LhUFlMk8GReYmyEv22FUAYlIR2jno9M9MZ9RxFFaWSN8Xf7TTET
         C5k5Z5HUSPnEe7gYn4glCQ0KrctHEn6rwSk65OlO+N6dpwHwHzNRRD3JG1rk4HK/gVls
         30OvAVVN7ez0nxBIajFICEAUNbX69e4X5sV2BgXZtgQDRjrV9k7PCZFB2SuYR4jRieXh
         gairZcd6jazFjRAkT0qo5Mo5YUPlscCLRahPqmhUqFW3ANDH+Q8n1EjNlloxR/t2WDB2
         gUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IZVebcAv1gMSkhke8vkvP7hwXg0ZkCIulZG5b/+xBiY=;
        b=xakolmr0fXfx6a/tnbi4mYPwNOihNAH3DVJi2AYmzKbxcTShBJNol31EZ6xV3ijcDF
         a8dEoggQJIb/0wN4tpZH3E/bU3FiL+ji4Urvc2VHddgaSiQChC9ISY19ybRETGS/cHTx
         uJAHT7+CSrnFzk3UsRqFAWGRFhZgch4ih/KNAhgY68KRqdps2jRRE6h+FZYxugCWLlw8
         XVgP52OK+kpI+/nfZPDodSvY4ZWn1ARYFlpEwqefmDC5RhGbtTE/pYL+sn5vyFkFdLrM
         Tan8JDH9LIPDS+IG/71nZPEOFyN0ZI1zCFhIc6dw50oNYgJ05ZVExj9av0ob9AZzqhDX
         q7iA==
X-Gm-Message-State: AOAM530brzCiBPtfA6TH24k3VhiNCEAPAeSj/AuIM5S+3oVxtAk/h6N+
        K6wyvzZ04RfF5uGaFq6jFcA=
X-Google-Smtp-Source: ABdhPJz6YGncQ1L+tSJJzun8sdHJ/sWVfbSokhsMTus82Zc5zyyzMDqRv50uxI7CXKWWJhMQ5kxCHw==
X-Received: by 2002:a17:907:7e97:b0:6db:c1ef:6a68 with SMTP id qb23-20020a1709077e9700b006dbc1ef6a68mr13726402ejc.475.1647721118149;
        Sat, 19 Mar 2022 13:18:38 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id w19-20020a05640234d300b00416baf4cdcasm6133932edc.48.2022.03.19.13.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 13:18:37 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Alasdair Kergon <agk@redhat.com>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: [PATCH] dm thin: fix using the correct variable for sizeof()
Date:   Sat, 19 Mar 2022 21:18:11 +0100
Message-Id: <20220319201811.2515178-1-jakobkoschel@gmail.com>
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

While the original code is valid, it is not the obvious choice for the
sizeof() call and in preparation to limit the scope of the list iterator
variable the sizeof should be changed to the size of the array
elements that are beings sorted.

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/md/dm-thin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index ec119d2422d5..2e41e50d6903 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -2251,7 +2251,7 @@ static unsigned sort_cells(struct pool *pool, struct list_head *cells)
 		list_del(&cell->user_list);
 	}

-	sort(pool->cell_sort_array, count, sizeof(cell), cmp_cells, NULL);
+	sort(pool->cell_sort_array, count, sizeof(*pool->cell_sort_array), cmp_cells, NULL);

 	return count;
 }

base-commit: 34e047aa16c0123bbae8e2f6df33e5ecc1f56601
--
2.25.1

