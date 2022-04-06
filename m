Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B5B4F6A3B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiDFTqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiDFTp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:45:56 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528A328E49A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 10:22:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w18so3424108edi.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 10:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CwqBXDz668FHAz4y6CpGiuk9ISChfbzhgCaR+tulTMk=;
        b=EvHMKCFZCZDfyLJTYvlmtVf5grd8BgJpV5V6KZJqOS53R1pGZ7CNR6kyTy6ChuiW9Y
         XuQCu3tDeJo74DAXUvqIxMt11hXqmHTfV7wO8zIJLxeVHuZcVUFFlGTdUrXi/RhJNDei
         PYSWVg2NF80s7l8CPVv1U2RvjUVMcpzWOgvk686K91f15MO/SNTimslRG6g8cPzhD3EX
         MZ7EUYPPjkxNMV5xHSN4bQoEDNC106BbPvZz2V9fjzojEkXJODCxERoV/1BD76fVIrGX
         uygIWzW38kj/1lQ+DCHNsIvIl9p/3ulb8nSVy8pgA/zP64I7sq608GyVOt2QU/NFG+zf
         wPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CwqBXDz668FHAz4y6CpGiuk9ISChfbzhgCaR+tulTMk=;
        b=NYrcd7wGZ4rgdcFWiAuHHTY1hzuuC46cvUHlZat9pQIiRXxJvVoWBBBNGHfJJYJWAW
         LwR0JXR34PDLJ9s9r5dfTnBOO+BD4l3y/t49j4Ucc+eSJH3BBs5Bi1WoJ9yjTGvpeoG1
         D8qlzocOyl1e0LWFW0ioukqM7jEUMa3POoKb64uCOnU+d7SP5/SH5jnEWGU2vFHs0oaV
         k4UX40GhCX8aTiagWja7BicTDO7SsnE8qMEZkaBk4WKySD6hFD5Xj0ydN9njcb/8dRX7
         MVcQvCdNBOTf+uhV3fyzOrjqY0BxbrdIvOFq0lFGmEMqNtGp2KcTIid2jrMo9Y3iF6wT
         blGg==
X-Gm-Message-State: AOAM531BiMUHHtkN2WDJ6PzpEZifDRLfYh4DWq5Pcozv2G+fMwrTWDCZ
        zLP/29OlCLtK4dv8ISIu3Mc=
X-Google-Smtp-Source: ABdhPJxEA2MeNQtB5aPt+y7Y43evp/8rgGqQFSwINva8bP39DtlmAZlA+iBJeLY9vUpK9mLfxAYcEQ==
X-Received: by 2002:a05:6402:5146:b0:415:fd95:6afa with SMTP id n6-20020a056402514600b00415fd956afamr10007508edd.200.1649265756888;
        Wed, 06 Apr 2022 10:22:36 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id da19-20020a056402177300b00413583e0996sm7912730edb.14.2022.04.06.10.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 10:22:36 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 2/5] staging: r8188eu: use round_up() instead of _RND4()
Date:   Wed,  6 Apr 2022 19:22:16 +0200
Message-Id: <20220406172219.15565-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406172219.15565-1-straube.linux@gmail.com>
References: <20220406172219.15565-1-straube.linux@gmail.com>
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

Use in-kernel round_up() instead of custom _RND4().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2: no changes

 drivers/staging/r8188eu/core/rtw_cmd.c          | 2 +-
 drivers/staging/r8188eu/include/osdep_service.h | 8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index ecd0488c439b..4977a0b99415 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -264,7 +264,7 @@ int rtw_cmd_thread(void *context)
 			goto post_process;
 		}
 
-		pcmd->cmdsz = _RND4((pcmd->cmdsz));/* _RND4 */
+		pcmd->cmdsz = round_up(pcmd->cmdsz, 4);
 
 		memcpy(pcmdbuf, pcmd->parmbuf, pcmd->cmdsz);
 
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 56e5cbfec1f1..388c22751d09 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -96,14 +96,6 @@ static inline void flush_signals_thread(void)
 
 #define _RND(sz, r) ((((sz)+((r)-1))/(r))*(r))
 
-static inline u32 _RND4(u32 sz)
-{
-	u32	val;
-
-	val = ((sz >> 2) + ((sz & 3) ? 1: 0)) << 2;
-	return val;
-}
-
 static inline u32 _RND8(u32 sz)
 {
 	u32	val;
-- 
2.35.1

