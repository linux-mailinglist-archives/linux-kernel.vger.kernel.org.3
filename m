Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DE05A7F76
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiHaODC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiHaODA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:03:00 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23232D5EAC;
        Wed, 31 Aug 2022 07:02:58 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id c24so13580797pgg.11;
        Wed, 31 Aug 2022 07:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=HUyOr5FedssBlryfN/1PxbuuG/tFo/uBwIYcDSDQTHM=;
        b=THxxbMkGuCNE0GYzQ8ouO8of8iFU/xAgUBv6p4Z90mDaOKDE2ZVQ5zycypjclwPJ+S
         H9CKfVBwJQJrFvI6fo3D/D6xQDHtqGlPUnP+GBfUJ7z8S5c/mbictcu3JnEdeK/hy1yN
         Qb3wqBj69bAEHUYHyrdKJhUBV7OHxxFl3CzlfUtFomJkr08bVTl7Ygst50z8sXvtXDhl
         yFAurEcm9JwBLtWZiyYmypiII+XU2HqKbpSUZXB9AZKRQALaQB3TKELXLiE3FkevANN2
         wYLe2D258jtkre94YubAmLrASqRSbkRQRju22h8zwesHeFdlyZT/7zWnljXLR/ydHCy3
         AjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=HUyOr5FedssBlryfN/1PxbuuG/tFo/uBwIYcDSDQTHM=;
        b=uvuia7G2L+wjIJtAjnWoAaYtW5DemgwAWVBpuyIYBFGrH9VLHxmgTSLYeQRWZAxHkx
         vad7blw2a4dFhzRKliMIweQlN7WV+z5JRn+JwB4NZqM6n+gWg6VJMAHUiXCdXgbiKazm
         WPiankuxATgk8FQ8HlE94KNc8Cmjw+gX8cAbskHUG1iNBfWRe6jH5Jlv4lKgj+Kco/li
         A8C8Y4rD0iQaTnJ/apYg7TGZ7x+MAkkcqelzuAzIdOjupJ6R6enLk6syBTHq+tHQCyun
         YLqeqD19usLdcHo4771HvJRx1BNAZJR3pnvztkYuXogcjfFTHvP5WTjn8O0QUCEdtDMp
         /GrQ==
X-Gm-Message-State: ACgBeo0y8llH8Imq4gN0T6vpkq+nmZ6aLJpbnzR6lZep106wy36qcKEQ
        aPW5SGb0GBpM/287Aq3w7PU=
X-Google-Smtp-Source: AA6agR7GM1xECWvwtxoKU6cLB7gCxgRt26MgAjiTKqXX+f66bb9UdV8jR2Y/TQkqsHIo2jevz1kzTw==
X-Received: by 2002:a63:8a41:0:b0:42b:7450:4e81 with SMTP id y62-20020a638a41000000b0042b74504e81mr20604048pgd.341.1661954577723;
        Wed, 31 Aug 2022 07:02:57 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d33-20020a630e21000000b0042c012adf30sm3393428pgl.2.2022.08.31.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 07:02:56 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     leitao@debian.org, nayna@linux.ibm.com, pfsmorigo@gmail.com
Cc:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] crypto: nx: remove redundant variable rc
Date:   Wed, 31 Aug 2022 14:02:48 +0000
Message-Id: <20220831140248.303940-1-cui.jinpeng2@zte.com.cn>
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

From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Return value directly from set_msg_len() instead of
getting value from redundant variable rc.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 drivers/crypto/nx/nx-aes-ccm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/crypto/nx/nx-aes-ccm.c b/drivers/crypto/nx/nx-aes-ccm.c
index 3793885f928d..c843f4c6f684 100644
--- a/drivers/crypto/nx/nx-aes-ccm.c
+++ b/drivers/crypto/nx/nx-aes-ccm.c
@@ -134,7 +134,6 @@ static int generate_b0(u8 *iv, unsigned int assoclen, unsigned int authsize,
 		       unsigned int cryptlen, u8 *b0)
 {
 	unsigned int l, lp, m = authsize;
-	int rc;
 
 	memcpy(b0, iv, 16);
 
@@ -148,9 +147,7 @@ static int generate_b0(u8 *iv, unsigned int assoclen, unsigned int authsize,
 	if (assoclen)
 		*b0 |= 64;
 
-	rc = set_msg_len(b0 + 16 - l, cryptlen, l);
-
-	return rc;
+	return set_msg_len(b0 + 16 - l, cryptlen, l);
 }
 
 static int generate_pat(u8                   *iv,
-- 
2.25.1

