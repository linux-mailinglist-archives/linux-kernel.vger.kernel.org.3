Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EEA4CB043
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244710AbiCBUt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244838AbiCBUtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:49:35 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A184DD465
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:48:35 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so1770071pju.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ezGZS6wKoaDPZZr1vSGSOGCOOXHs/t5LaRnTO/HK9rM=;
        b=LawSeR1NmUPUaUioLDLVRqBuUyq3N4d67ynn20lLI3i3DZ3CODegap5Yx7zLInYZ/r
         O8E5M8tCP1pGZ9VUwlv+xv98o9JL8OsaV30TLtKckOZNrYzkWxO3OjkYw+5ETMEVG4ib
         K2IGe5HzdbqZcgrhpAfHFCC6HvDVOmji0/t9EzKBXtMtqTsQbbvlLgoOnwpSWSRR2v8h
         GJuxjshLyHG92UAdodKsXzogzMlZC4wnVaurId9t2/7NhZWFFWjuk6S5lMwZuWCIOHrV
         JLIUQYW/5Qo9fDK5jBeWmreyJmekoOFaYbF9ZEGgMk/veivOmr2veDI4EdWhjvNy3/S6
         ngtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ezGZS6wKoaDPZZr1vSGSOGCOOXHs/t5LaRnTO/HK9rM=;
        b=qYggJ79h7MZ0UG9nQ40pqDikFKcBXRhQVUaCNu1erILc0J8D+KTYBkfivlX8N8nIBS
         /G7DRiYn0GqpSi545YaPIzeyC8xzaZ9JHrWN9wPrYSg6UBGaBgvB4YgvGLOLzpbFOpn/
         SQIwGdbuqVR/dJkyfszuWc91rA4+pIbnLv98h89GmqVgn3gKnTZtJ8ksh8WPFOhKMFP8
         QjdqvmxlJubhrddq89Ar/b4zr7jtL6SOL34DIY3GoWKeYz3IDnXIUxn+ZhcFXJ1JH5p5
         HQ7eJPI4J8Sf1QNYi3m5qCiqc76I+R+6Iv1pqfwEe0HAvBb5NTfZ/NeBUuRTWNtUS2Em
         tZwg==
X-Gm-Message-State: AOAM530uiyUhb1RC6vJaKSiZXp4tJ9LZHQy4sh+XGWHtfBonr/8TZJpH
        XYFEFG9tXCioVLaRlNYUMnQ=
X-Google-Smtp-Source: ABdhPJzQJ3VVGTz9pnkt/XW/nXhMX9DaRNvZpdSD6AbdCZsfrAJkHTTFWDXhW9jS3HYgUMIXa+uCzw==
X-Received: by 2002:a17:902:6bc5:b0:14f:ae30:3b6f with SMTP id m5-20020a1709026bc500b0014fae303b6fmr33142297plt.60.1646254114629;
        Wed, 02 Mar 2022 12:48:34 -0800 (PST)
Received: from localhost.localdomain ([103.161.98.179])
        by smtp.gmail.com with ESMTPSA id bh11-20020a056a00308b00b004f40144cf76sm50905pfb.142.2022.03.02.12.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:48:34 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 10/16] staging: r8188eu: mark is_basicrate as bool
Date:   Thu,  3 Mar 2022 02:17:31 +0530
Message-Id: <20220302204737.49056-11-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220302204737.49056-1-makvihas@gmail.com>
References: <20220302204737.49056-1-makvihas@gmail.com>
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

Mark is_basicrate as bool as it returns true/false.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index eef8523c3..8e8a82a1e 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -167,7 +167,7 @@ static unsigned char ratetbl_val_2wifirate(unsigned char rate)
 	return val;
 }
 
-static int is_basicrate(struct adapter *padapter, unsigned char rate)
+static bool is_basicrate(struct adapter *padapter, unsigned char rate)
 {
 	int i;
 	unsigned char val;
-- 
2.30.2

