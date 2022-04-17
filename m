Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A995048B2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 19:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiDQR5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 13:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbiDQR50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 13:57:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A775D71
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 10:54:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id t11so23482179eju.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 10:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88taCigWH9mYhbbUWC8GxUjVzrfbEewXNsQRIQG981U=;
        b=B08AYVFeW3NYEqrd2gEUo6LRdIIpXceAPrNO0xE83cntgkSQC8qpKpZZ4cLeyqU0hu
         A2srZdJc4QmaxOxY8f2vmxDA2TCi55mNXJazZGr2qvy+XknS6rnAZZTXbXl5sw9pZTie
         NOBWcTcT4VsCmF67fHL3H/oXr2uuqbxreDSCGPfF8YfImoYPy3luOAPSIOY8BQNR8fzN
         5e0QxKaOh64rfjqGd7xiCd2TMIbzo72s1W1QRgATOxha2Zokl8r+RVOByP8t2gz5S3Jy
         k4NFNQNk+7+09JHLa4QX3XYi1w10ezhJUY4ikc+sI/a2dHYUKE0KysNrloVs7WpaceFb
         4M+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88taCigWH9mYhbbUWC8GxUjVzrfbEewXNsQRIQG981U=;
        b=KJ6VBEafAqvREhLinIwajohtXbApOptLZvMIyGg7e+yuPfh4HHG61ITuKkm90zeogI
         EJSwhahIn7yjZkQWhNyvRHSotvTW8ZRXdNJm5pq9aLTVMcWDQFmxU1vWoXW5fR1MZfJ2
         cRECOw0+26wUJG0FpbdY9m9+DIIB6pT/Zns9PE+PH6tqmRH0rarlIaiwK2V+Gq+Imfnu
         gfeb75oPzKHG7A1HOJaGj2c/saGLvymvOsAGPlnbjei/FJb3D+CUGhvwJgEcZ4L1ajGZ
         14FMHTW8gMvU4fUepDNr//nfUigQyjtrYrZBwKzs/ftNQoShTV1XHiNKxM8U1bwqU8A5
         KXlQ==
X-Gm-Message-State: AOAM532biNRKW++k8G6fOAv2XswtmdF0maxz0UDqMi1tUpKA6PUT9XgF
        CXz9BPzKKu4L2fD/wk/RDx0=
X-Google-Smtp-Source: ABdhPJwu7a4ODeJTadJJdUNYffpNWAr9ewqlhTQVuaRqB7l2lxcQ7DeH7c6/PmtyLbEE5V22+4fF3g==
X-Received: by 2002:a17:906:7684:b0:6e8:5d05:196b with SMTP id o4-20020a170906768400b006e85d05196bmr6492880ejm.209.1650218089065;
        Sun, 17 Apr 2022 10:54:49 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id jw12-20020a17090776ac00b006e87137194esm3719409ejc.150.2022.04.17.10.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 10:54:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v4 2/8] staging: r8188eu: convert u32 fields of rt_firmware_hdr to __le32
Date:   Sun, 17 Apr 2022 19:54:35 +0200
Message-Id: <20220417175441.13830-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220417175441.13830-1-straube.linux@gmail.com>
References: <20220417175441.13830-1-straube.linux@gmail.com>
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

Convert the u32 fields of struct rt_firmware_hdr to __le32 for
consistency.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v4:
- no changes

v3:
- this patch was part of patch 1/8 in v2

 drivers/staging/r8188eu/core/rtw_fw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index eb4ab11f6b28..7cd08268f3b9 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -42,11 +42,11 @@ struct rt_firmware_hdr {
 
 	/*  LONG WORD 2 ---- */
 	__le32		SvnIdx;	/*  The SVN entry index */
-	u32		Rsvd3;
+	__le32		Rsvd3;
 
 	/*  LONG WORD 3 ---- */
-	u32		Rsvd4;
-	u32		Rsvd5;
+	__le32		Rsvd4;
+	__le32		Rsvd5;
 };
 
 static void fw_download_enable(struct adapter *padapter, bool enable)
-- 
2.35.1

