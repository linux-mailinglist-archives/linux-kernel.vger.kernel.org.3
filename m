Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501BB5AE0D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbiIFHUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238835AbiIFHUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:20:13 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA63F1F604
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 00:20:10 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id q15so10472680pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 00:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=wUM9TG8n899TMK7xfOD3wSfej2b1DDNKD7A4zDy+X0w=;
        b=lJqMcav9akWTUkl7ucSdLf6fhDnUC5ApxPb2WzWhdE8mOEemfi5xDHa4gBZefQKSu2
         KutoepYo9e2ptjcPA9KPT11yWmCDSBUA6UIglTEopbsAtY9JzceZKdFd/NvUx3/o1qle
         EEzhCbi7PsNvp7Pjoq1ZPPi5EuB8FaU6yd2xd9k8Jhtka3VY2JMNDdFTxM0ZG6fBwN5Q
         Cvxc6MNnAILosSK/YBdgrCQVN2qRd2xpZoqVDwQQZ2/ICx/XL0Dt7JlhnTqP+syy2qkx
         4v0rzu13gsx1mOkaCtJNKUKb1dbg8Z4ZlBn+6H+AjZMyerrZXRgT+gDfnGHUj3jaDcGr
         g6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=wUM9TG8n899TMK7xfOD3wSfej2b1DDNKD7A4zDy+X0w=;
        b=au9xH7Kx4ztP+3PrC9B6kX42i3uTpe1T9C5phKAc8sfpq5Bu6dZugbUkOF87nGhUHs
         u92ceNouG/OcUD5hXVYvkc9ZlwjOTDJZDehXq2Bv8V7bU5UXxx3hggn85zYTyQVLgrlJ
         xx3yGwFxjzQzQSoMxMhL9mlSum79sC3jqUEppp37e4AaBj5pkEYrFcwDrNDjnhWDj3Ff
         eAAmg0tuj6tsZdej6fjuG7/URYknTFh+E4RxO3GpjnWkT8MSGsZr3l+Nq9d9ciMaiNn2
         1VocewdzdAX0dGAkGobOgiw1mVyCmXeTTcIDC6z8gMblGHqzmDKOv45NZMXn6EzPp+G3
         IBtA==
X-Gm-Message-State: ACgBeo0ggloxLP3w54dHit0BwlpMm9WrDDLI3iAUbOLI/Jq5pksvS9C1
        R9HcuM2ykp3k/QUwK4XFXyg=
X-Google-Smtp-Source: AA6agR6rEeZiwwk75IIxtYGnPtBHMCn+4GvuoL7LTtv0PcnQlgqMGE+lBtFD1xCNUcEvDQOVQe3yWw==
X-Received: by 2002:a05:6a00:114f:b0:528:2c7a:634c with SMTP id b15-20020a056a00114f00b005282c7a634cmr53373587pfm.41.1662448810030;
        Tue, 06 Sep 2022 00:20:10 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f28-20020a63511c000000b00422c003cf78sm1121918pgb.82.2022.09.06.00.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 00:20:09 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     fbarrat@linux.ibm.com
Cc:     ajd@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ocxl: Remove the unneeded result variable
Date:   Tue,  6 Sep 2022 07:20:06 +0000
Message-Id: <20220906072006.337099-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value opal_npu_spa_clear_cache() directly instead of storing
it in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 arch/powerpc/platforms/powernv/ocxl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
index 27c936075031..629067781cec 100644
--- a/arch/powerpc/platforms/powernv/ocxl.c
+++ b/arch/powerpc/platforms/powernv/ocxl.c
@@ -478,10 +478,8 @@ EXPORT_SYMBOL_GPL(pnv_ocxl_spa_release);
 int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle)
 {
 	struct spa_data *data = (struct spa_data *) platform_data;
-	int rc;
 
-	rc = opal_npu_spa_clear_cache(data->phb_opal_id, data->bdfn, pe_handle);
-	return rc;
+	return opal_npu_spa_clear_cache(data->phb_opal_id, data->bdfn, pe_handle);
 }
 EXPORT_SYMBOL_GPL(pnv_ocxl_spa_remove_pe_from_cache);
 
-- 
2.25.1
