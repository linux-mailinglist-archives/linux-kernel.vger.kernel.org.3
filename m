Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAF9479814
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 02:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhLRB5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 20:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhLRB5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 20:57:11 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED62C061574;
        Fri, 17 Dec 2021 17:57:11 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id w24so3295745ply.12;
        Fri, 17 Dec 2021 17:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FWqKFfL0KnIRZ7fFC42ZHJVI9If0P8ietPAL2PVfcNk=;
        b=iiObPEgrWKUc39gyldEFVpjAyEhD6GkJAxtS2exyvywdMY4A846TPrlUZ8VepXlTX8
         NDOGavwbnTJ2S7RBImH3zv/+PVOjR8zr3Z+BTy/QPnev8Csp6WfrQkKZ2EyjIFZyeoKB
         nxHMfcaCFTrBxMjbY5OYJKSAsVC2mIKAD3zjBjZ20SX7yNG4gP8jlUxs8O4aHkGzJCUP
         rxcC1fPYkyiluPqaHgyCv2KMe2ScC/hxADyr7WAORa42Dbfo+Zo0RT1LdeUMHussiHbJ
         8qGSQjB2ju57tvkUOibqoY/Bgpq5XjSg3UCpYVlTgHiI2BnaPqoHX67at1/8vebAqaok
         PxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FWqKFfL0KnIRZ7fFC42ZHJVI9If0P8ietPAL2PVfcNk=;
        b=vIfW6XWF6GtObbwt2pd5ySYz2XIrdIH6UayB87PhZa15w62AihX6ROaQOT0VqZvrar
         ZT1WWJqgkSGsKDfPASkpt6mOfhZpH9wJUi9d/8m1ftb8U/l0fefhIp+jC7K+P8n037Vc
         ih9gs0xsS2nAtfo/74LpnaUSu+3QfyBSqEetE/Kpg9c8wULpbiVWQ1LC5skWREy9XolK
         U+oWYeUWNdGM1NhV3D3Ij6KVrvE+6RDp3sHjHdQnQQu16YXOs+3vvzs7Zhjfy4ZYRXxD
         5KKq80rUwjz9Y81GPfI2MogvDunRBZFT7FrnfAXhUeuPdbyjyLXyLapR5RounCY19ItL
         6Nmw==
X-Gm-Message-State: AOAM530tnl1h2Ah0S5ez9fiVyMCWLWVx6cWFGT/gs5bPGdxhC1hIiKZB
        0P/IitWydHhNu/YkS0PTJyw=
X-Google-Smtp-Source: ABdhPJxp0drx+e0V2hp8dhYxC09S94TpbG+m+EAN7fjKrBkCzuJ20GTwyN6MAdNpAiCrpKPmptN1kA==
X-Received: by 2002:a17:902:bcc4:b0:141:bfc4:ada with SMTP id o4-20020a170902bcc400b00141bfc40adamr5847673pls.20.1639792630688;
        Fri, 17 Dec 2021 17:57:10 -0800 (PST)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id v63sm9434593pgv.71.2021.12.17.17.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 17:57:10 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     thomas@winischhofer.net
Cc:     davidcomponentone@gmail.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] video: fbdev: use swap() to make code cleaner
Date:   Sat, 18 Dec 2021 09:56:59 +0800
Message-Id: <81d101e615dcd8cc661272965a6a3a51d77aa491.1639791676.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 drivers/video/fbdev/sis/sis_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index 266a5582f94d..742f62986b80 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -213,7 +213,7 @@ static void sisfb_search_mode(char *name, bool quiet)
 		/* This does some fuzzy mode naming detection */
 		if(sscanf(strbuf1, "%u %u %u %u", &xres, &yres, &depth, &rate) == 4) {
 			if((rate <= 32) || (depth > 32)) {
-				j = rate; rate = depth; depth = j;
+				swap(rate, depth);
 			}
 			sprintf(strbuf, "%ux%ux%u", xres, yres, depth);
 			nameptr = strbuf;
-- 
2.30.2

