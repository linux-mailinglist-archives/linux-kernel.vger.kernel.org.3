Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE21A5B11C2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 03:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiIHBEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 21:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiIHBD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 21:03:58 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99346C481E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 18:03:56 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so712978pji.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 18:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=TRse0X7sU7AjHfynOC+gpm+WIMjXapHyhtFjTek9tOk=;
        b=MxBql03W/i2eRRPewdj2IRtrZo2qdT+oVBv/Yn5VZyIf/xv3IuR2E2oxCQcrPSUWp9
         AU0I/2K96jqkpBA+qsxTj+9wU+eJ7Vo9ss+KF8h4juOm9yaGRkgW0KQFcPSFPizlGo7r
         xCCcvWdjeYTxlcrj4J7u2S/XIO9ixy31ugeybL7yL95a2IN2j/tfcaX6Juqw30PwHKT6
         o3H1fD/8RtYGHPZSCM6EOzfZCku2TrDxEWilD5ZrpBNhJ8KWgLt9fA8izeqfpzHhSJMZ
         usUx3WDluFl2eSe4GMOJKtabasVZEhIsagyTNXKPe3/CLva9GEcow8pWivrrwULqlBJX
         DF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=TRse0X7sU7AjHfynOC+gpm+WIMjXapHyhtFjTek9tOk=;
        b=QKNzqQo5ePfsOrGWHiliV+8OVdrNP+GjfEW+S1y5HDCzO/UN4Geivl/FJU9F1l52Dp
         Iga/v2FvRVqakXpuesihYjInf66kzkBPWHdkxpOOmr2xhSvka3E8Q+nI+QfJH5Q9LiBj
         nM2j3bENMfA+UUrL8QrCAR3ZDsJuCDdfeM7By7gerOq7YHmjqU739c9q5/JWZzCXOL/M
         Q+ir3wmXMHnguIrVw7l676r6k5eysppkriHF6D74CY7FjCT3zIxGOwAOTZG73t+V9MWf
         KUCbx+FfpbIzq2SC1ILlPuqN0FcxfRdMZnp6uRpiDQJBhOFcgfUxtfkgStJ39uZKmtc1
         L8aw==
X-Gm-Message-State: ACgBeo3TQCUH9zomUusEtabi64y+QUn9kKveRm6zS3RESSrQxszD+sT0
        pfNuBI4xGXisD+nKvYsmlfs=
X-Google-Smtp-Source: AA6agR7T5o2FWlNfLbNb4POXrUnAjrjA9F0ffYX6CAtSlK+QaNw0/kCzpp8csJWL3MzeGijqj8PdwQ==
X-Received: by 2002:a17:90a:5b0d:b0:1fe:3769:5fb8 with SMTP id o13-20020a17090a5b0d00b001fe37695fb8mr1389571pji.152.1662599035750;
        Wed, 07 Sep 2022 18:03:55 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p68-20020a625b47000000b0053e93aa8fb9sm1354416pfb.71.2022.09.07.18.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 18:03:55 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     ebiederm@xmission.com
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] kexec: Remove the unneeded result variable
Date:   Thu,  8 Sep 2022 01:03:52 +0000
Message-Id: <20220908010352.342820-1-ye.xingchen@zte.com.cn>
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

Return the value kimage_add_entry() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 kernel/kexec_core.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index ca2743f9c634..969e8f52f7da 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -561,23 +561,17 @@ static int kimage_add_entry(struct kimage *image, kimage_entry_t entry)
 static int kimage_set_destination(struct kimage *image,
 				   unsigned long destination)
 {
-	int result;
-
 	destination &= PAGE_MASK;
-	result = kimage_add_entry(image, destination | IND_DESTINATION);
 
-	return result;
+	return kimage_add_entry(image, destination | IND_DESTINATION);
 }
 
 
 static int kimage_add_page(struct kimage *image, unsigned long page)
 {
-	int result;
-
 	page &= PAGE_MASK;
-	result = kimage_add_entry(image, page | IND_SOURCE);
 
-	return result;
+	return kimage_add_entry(image, page | IND_SOURCE);
 }
 
 
-- 
2.25.1
