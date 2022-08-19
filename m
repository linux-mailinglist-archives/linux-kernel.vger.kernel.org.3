Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33ABC599809
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347821AbiHSIyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347412AbiHSIyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:54:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6AC7F10E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:54:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t5so4841277edc.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Wkt4yDwYFOHbUgy/ksyjGBA/L251ZQDRHJTdSWCyqSA=;
        b=jXR/EAeh1LtJa4xtGuazKLbd8wfW2pJeoinrnZcLK1TPA1cwgDgaxc8TzRq8CApoEh
         PMcpmUyd6s96yUWBZLZaBZBHiMCwiZ2Bj5SEsXnJmKlJS6ZPYNzoFoImKg0GM856xquk
         RSbJ/V5wIWUnxxuZOYeA9G49NqQj9h9V6fIxKzMs2wZWfmeOPBDEom/XJzURF/Q82i0p
         SQq/uEpTtEQqdonAzsVbsBAv4jcZDJdlORzVgE0a2aNrbKuu47GBhqIkzxXMIG5C5+kT
         7ukiotfwxkvMQDcN58Atax9nuQHAJ4v/O4DQdNCUguPeythV+TGpD7cG0BvWfDT9Rmiy
         TFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Wkt4yDwYFOHbUgy/ksyjGBA/L251ZQDRHJTdSWCyqSA=;
        b=C3GEzUL+OewXjVSsvlK0seZfJRmLcEz2WPrVZglHPQTLclLDfyk9MoLqqCdVEwARpW
         LJcRRBCNz/vsU0VxZpMU7qQhRcd43whgk5XfTmEJKqn9lz/Xao4UPg9bToWqmaRImxxr
         NSFzT9fcvum4mpeU64RJOrw57lVX3uHzXUHeG1UrbRMhUB0DddsO5JRJiOS7pH8Y17b4
         +Pe8zSpxTwoEvWUWcmmtmcs6YLORfxa0a6qEMxzaM3yGwXmzXuf/hEW7KFbvnZnT9lxI
         ofkVCqouJ/dphZJbyo1uB0KQDV8PKXdRiYaF5HJn9fk9iiGvrFBwMGnXlRcRtnAT+JuD
         NGSA==
X-Gm-Message-State: ACgBeo2hlDIslEQIXQNd+/kxFmvYst/amaJhq0IgU+hQtNJ1N0yioYht
        8SHNqyBt6Ki7FB9FA4Wazc4=
X-Google-Smtp-Source: AA6agR6dPomSIXWSFzdLmxyvM4Y8IWN55S1vVrbzpLxAZZWG2xnclM4xwiARfhSDuMFnfXdqu3EF5A==
X-Received: by 2002:a05:6402:254a:b0:43d:a634:a0ab with SMTP id l10-20020a056402254a00b0043da634a0abmr5294340edb.298.1660899249140;
        Fri, 19 Aug 2022 01:54:09 -0700 (PDT)
Received: from nam-dell.ucebne.fiit.stuba.sk ([147.175.148.17])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090630c900b0073c9d68ca0dsm1084261ejb.133.2022.08.19.01.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:54:08 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com, hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: [PATCH 5/7] staging: rtl8723bs: remove function IsCommentString
Date:   Fri, 19 Aug 2022 10:52:55 +0200
Message-Id: <c062f678dc8f99c18a251f6137c4c3883f8c8205.1660898432.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660898432.git.namcaov@gmail.com>
References: <cover.1660898432.git.namcaov@gmail.com>
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

because this function is not used.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c     | 12 ------------
 drivers/staging/rtl8723bs/include/hal_com.h |  2 --
 2 files changed, 14 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index f82cbe5a77ff..1c744d0b4742 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -939,18 +939,6 @@ bool GetHexValueFromString(char *szStr, u32 *pu4bVal, u32 *pu4bMove)
 	return true;
 }
 
-/*  */
-/* 	Description: */
-/* 		Return true if szStr is comment out with leading "//". */
-/*  */
-bool IsCommentString(char *szStr)
-{
-	if (*szStr == '/' && *(szStr+1) == '/')
-		return true;
-	else
-		return false;
-}
-
 bool GetU1ByteIntegerFromStringInDecimal(char *Str, u8 *pInt)
 {
 	u16 i = 0;
diff --git a/drivers/staging/rtl8723bs/include/hal_com.h b/drivers/staging/rtl8723bs/include/hal_com.h
index b49b0a0355c6..406fccbcd4b6 100644
--- a/drivers/staging/rtl8723bs/include/hal_com.h
+++ b/drivers/staging/rtl8723bs/include/hal_com.h
@@ -153,8 +153,6 @@ u32 MapCharToHexDigit(char chTmp);
 
 bool GetHexValueFromString(char *szStr, u32 *pu4bVal, u32 *pu4bMove);
 
-bool IsCommentString(char *szStr);
-
 bool ParseQualifiedString(char *In, u32 *Start, char *Out, char LeftQualifier,
 			  char RightQualifier);
 
-- 
2.25.1

