Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F00599D28
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349463AbiHSNum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349438AbiHSNue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:50:34 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD3AFBA7C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:50:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dc19so8877870ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Wkt4yDwYFOHbUgy/ksyjGBA/L251ZQDRHJTdSWCyqSA=;
        b=dRPN98xziBG2n6jy2drmwYpBCuIcqx00aPQBaA4fKvBcLeEe617/Cd2j2a040sjt6r
         4r5b7ryasI9MjEcFoiue4KG2lBKzD+rAnFqbrgHuUilh4oQhwGhiohnYAsr/l13UCjjB
         9NVJimd01k1LqFudpSiLF4LuZtVYzJlJwmahDV0bTQQefJsoCJUAMn5QKgR3ow0PIAkk
         sUCUc+5w9eqFJhiQG5yjwcbhge5C/F99YaYGaWlJJ5xoGIWWQsfIXDzMsXt7I4cLVkHK
         uSZJ9xffLAagbYtcwkWzSgQhpqS7qwOmHrELEPQSlpETuymzgfOX5penx/Hw6O4iy694
         tYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Wkt4yDwYFOHbUgy/ksyjGBA/L251ZQDRHJTdSWCyqSA=;
        b=VoU2hedSdaoEAr23yZVTbHW+MJBFzoU8mGY1RtgSB1FQXssiXtTiSDbSQyI4ZRcjr9
         VeWq3qrEHBKuIb8qmBhoqffDQNQWrOH61rBjlKidCFZBwTnArnVD3eHo3BmwxPGLEM4c
         LQ83+hTVRehnz3gGJWE+MyhIsViKCaF9t2L3px7D+mSslVsfJ6zCkGuCfpbW/mkuyT7k
         17kTflmwcCZPLj3iP9WovVVyq4+WKH2NjVmIk9LbTM8qTN+PqeFgz0UfeNO9TQf/iMPX
         UHhbIujYneacr4WXy1aDGpZMv8rAQzUepZHjk5CTNzckojrfuINoSNQYabvaPVTUIYOa
         dU1g==
X-Gm-Message-State: ACgBeo3yBuQKKK/LFMKg+XNPOfeKMUnaCz/wFhBlQLB8+Ryk1TDn99WE
        5ydYOGue6FrdqUTnNJBt9k8=
X-Google-Smtp-Source: AA6agR4ND+FbJiurFHvDzvIv1YD5QK/jNEld+D2NxMCMIQBQMkni0BfsvP24ydsja1f4CrQ+Hj9Q1Q==
X-Received: by 2002:a17:907:6eaa:b0:730:9fb6:41a5 with SMTP id sh42-20020a1709076eaa00b007309fb641a5mr4841567ejc.675.1660917032017;
        Fri, 19 Aug 2022 06:50:32 -0700 (PDT)
Received: from nam-dell.ucebne.fiit.stuba.sk ([147.175.148.17])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b0073087140945sm2313821ejk.123.2022.08.19.06.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 06:50:31 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     lkp@intel.com
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com
Subject: [PATCH v2 5/8] staging: rtl8723bs: remove function IsCommentString
Date:   Fri, 19 Aug 2022 15:49:39 +0200
Message-Id: <c062f678dc8f99c18a251f6137c4c3883f8c8205.1660916523.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660916523.git.namcaov@gmail.com>
References: <cover.1660916523.git.namcaov@gmail.com>
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

