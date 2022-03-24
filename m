Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339904E5F2E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348381AbiCXHQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239174AbiCXHQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:16:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CA6646D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:14:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bg10so7297484ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J6lrvdSEUetE9f4aqDoqbIRlxE+np5nKDc0gW86buHs=;
        b=BYGpdSnkIMbfhRc8kaBxXFHjlhAfWcFFWa0bEzhDAvoQIEkdpolJZtniqHq20pA/1W
         PYwKJW+ClS/uZ2QpXbBUVNG0lFBbgQ27WqgI39Qxi46wmIPoQaYUTcd+ymAS//bEzLjP
         6MwMRTWpeOG7gH+tiCKkHc9HdWZME1ucLvImxbEX5LRxBG+dj+mzDe4W3YoxcCtgXxmX
         xPPoA96prsX7QP6eIdWQOC8EB4Hd+U2KjsOc3o4aRUC+y33O76E3Swy6+rRxNFrRXKkB
         Qvq3W9PRagTiaXWVoguClH+503cZU2ExoGINvNtYWVTprKEn4ss2eVW7GS9Q7d8yKN9P
         pwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J6lrvdSEUetE9f4aqDoqbIRlxE+np5nKDc0gW86buHs=;
        b=a2ec9uzGPd4GFOVvZvInWcT35wjTfH7KqGK0uPSo+kK738yOEhhTSEOJ6qbwJuMoHS
         YO5tHBG+tT3zvQS86HsJbooXcPJkyQSFcYBCae8cmGhIAlUq1hvhYvjmORM9RMlzbU4n
         SnOrSWMXhaIN/fSosOnOMBabpDNbP3qtm1t9tt9EtRkM6BCQwx/NtXNLEUjClNkiVQ6R
         t43y1UlcDmbHHM31Xs+UHVAobE7McvjqQyIvqIujIxeTawuKp/YFy13uI6ZjCK5hGC5V
         edxGSZbaGZhOEVU8o5ed5p2jPoMvKoA/s32dy4NCpjXIT1VSz19yUx19eGGYigOZoKsx
         bzmA==
X-Gm-Message-State: AOAM530fLOZZzqYHmsVsPjUDj03MhnZm1FiQ3k+o/ry2rA37mQm9NrqN
        Xb1px5CKdO+s8Fg3aU8Gie4=
X-Google-Smtp-Source: ABdhPJwkVaX+0y4adZtVlgn7Oow0tRxugS2OUiLzMSpfOFq3bD6XvOPnJrVTskXGT7bNFbdLWNsunQ==
X-Received: by 2002:a17:906:4fcb:b0:6e0:55b7:179 with SMTP id i11-20020a1709064fcb00b006e055b70179mr4381103ejw.159.1648106076148;
        Thu, 24 Mar 2022 00:14:36 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id z13-20020a17090674cd00b006df78d85eabsm764705ejl.111.2022.03.24.00.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:14:35 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] lib/logic_iomem: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:14:12 +0100
Message-Id: <20220324071412.60437-1-jakobkoschel@gmail.com>
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
---
 lib/logic_iomem.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/logic_iomem.c b/lib/logic_iomem.c
index 8c3365f26e51..62426a6f8103 100644
--- a/lib/logic_iomem.c
+++ b/lib/logic_iomem.c
@@ -86,20 +86,20 @@ static void real_iounmap(volatile void __iomem *addr)
 void __iomem *ioremap(phys_addr_t offset, size_t size)
 {
 	void __iomem *ret = NULL;
-	struct logic_iomem_region *rreg, *found = NULL;
+	struct logic_iomem_region *rreg = NULL, *iter;
 	int i;
 
 	mutex_lock(&regions_mtx);
-	list_for_each_entry(rreg, &regions_list, list) {
-		if (rreg->res->start > offset)
+	list_for_each_entry(iter, &regions_list, list) {
+		if (iter->res->start > offset)
 			continue;
-		if (rreg->res->end < offset + size - 1)
+		if (iter->res->end < offset + size - 1)
 			continue;
-		found = rreg;
+		rreg = iter;
 		break;
 	}
 
-	if (!found)
+	if (!rreg)
 		goto out;
 
 	for (i = 0; i < MAX_AREAS; i++) {
@@ -108,7 +108,7 @@ void __iomem *ioremap(phys_addr_t offset, size_t size)
 		if (mapped_areas[i].ops)
 			continue;
 
-		offs = rreg->ops->map(offset - found->res->start,
+		offs = rreg->ops->map(offset - rreg->res->start,
 				      size, &mapped_areas[i].ops,
 				      &mapped_areas[i].priv);
 		if (offs < 0) {

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

