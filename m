Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E455B2D3E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 06:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIIEKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 00:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiIIEKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 00:10:03 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81C36B8F4;
        Thu,  8 Sep 2022 21:09:51 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q9so447403pgq.6;
        Thu, 08 Sep 2022 21:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=8RLKIEC5coZ0squ6v0xIcah94Pvav6o3jSl3N5xP2Q4=;
        b=VSZqCEeWfo4HBqEmz+c8qCCNvWeCVhZ7GXP5TuRl6vyQOHWXUjVE0FYAgxiCs6iNJ+
         EZfA2g//eDSbXg2+bb9lFjYHhqCw2ouajLrpyDicfmKz2TBon+9bjPYSyZ4UQHUNi5YV
         EQ93XwfhnFiEgXNIudJ82+fgaDPk+nxtoADYLHFIkmxgpbTHKGPV+I/tSs8LQFQJ2RZL
         eQdiPCXt9yV7ZaQwX9p/5VuyJCxiqThYUOQSlwr/IdjvfVp0FUK9/TInciYvdP0Pd7LJ
         PdSdlX7WtslK+LE+Qu355XpFINa6nFw5H9dgajv7blX7jvxj6iDt8C6XOOEc4Dz8qXos
         EH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=8RLKIEC5coZ0squ6v0xIcah94Pvav6o3jSl3N5xP2Q4=;
        b=QZ+YDQ2M/f0S/MlXji6frUxglUcwGATjAmrrnN6Eo0gqVwphzHMZZyoPYe3Rsmc2om
         wT79h+QfjXi/wJjfr/Cc08PcbSxDXREotIACFMr4xx2LbJkSdpiVDgm8BeLjcItYAMnk
         YyU+M49y+bODRTPc9XzGbez7kaRnE5aYGEN7ykFYzK+zvjZPwlktf+XqNvUVguNQKIZO
         FSgPbAhhQQvIA2yr71WC0dv0QqKkuQwT17MI6Vx83lmE+HDxfA5eD3eqP76rmtEQNUuR
         68O1O+UHo/yW2EimP5QsGcphHSrVE7dQpu7OE3LEFfZwdTqYZlBxDLaVYM8VW+3vobI9
         Pf3A==
X-Gm-Message-State: ACgBeo30ndopLou1gI3kLZ7txR+a1k+WFVvcncQ/O8Svqhfxa9SqMFOx
        iiiZbTypGQlvrGm3LTLgEiJMoFu79sc=
X-Google-Smtp-Source: AA6agR5iWtc9VwAvsdPPspO8pIpYOK6bsqQ8wHZQiqOS/j6juFYPy41EV4zghGLzHSnob2tAuL9zrQ==
X-Received: by 2002:a05:6a00:1688:b0:53b:4239:7c5c with SMTP id k8-20020a056a00168800b0053b42397c5cmr12412828pfc.81.1662696590917;
        Thu, 08 Sep 2022 21:09:50 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id t15-20020a170902b20f00b00176953f7997sm325484plr.158.2022.09.08.21.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 21:09:50 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Cc:     song@kernel.org, Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v1] drivers/md/md-bitmap: check the return value of md_bitmap_get_counter()
Date:   Thu,  8 Sep 2022 21:09:36 -0700
Message-Id: <20220909040936.2610780-1-floridsleeves@gmail.com>
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

Check the return value of md_bitmap_get_counter() in case it returns
NULL pointer, which will result in a null pointer dereference.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 drivers/md/md-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index bf6dffadbe6f..06ab1098ff99 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2195,7 +2195,7 @@ int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
 
 		if (set) {
 			bmc_new = md_bitmap_get_counter(&bitmap->counts, block, &new_blocks, 1);
-			if (*bmc_new == 0) {
+			if (bmc_new && *bmc_new == 0) {
 				/* need to set on-disk bits too. */
 				sector_t end = block + new_blocks;
 				sector_t start = block >> chunkshift;
-- 
2.25.1

