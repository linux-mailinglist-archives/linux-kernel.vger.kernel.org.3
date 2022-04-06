Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB354F5AD5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbiDFJil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572988AbiDFJe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:34:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C637120D95
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 23:19:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b15so1366696edn.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 23:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5W91nY5g2x/PNBMnEeWdlyukY7wlgLCqBSWWvoZMNo8=;
        b=hiUy4X2LA1nqaFfDcQ7InCwRGzw3PSPmausfWQ3ChZJ9uFDiaCL2dcjiwVSPNw/qAV
         sWSIN1HLyP/5jjej30IG9xImLT+sEbYB3qNiBkVCIQkWaFDqw4rB/0i42NDTGThmktde
         u0DW8ldMQ1ArwSCc25vweHnMh3EMlihmaTSX1lpFGxARcc6/NkI22D4S6hT74yEeWrf2
         bDYwO2bj+ogy8Rl83hJtIId+VNNHqGqkCrFd2H/l1oxP3ZGq4f8ascZOMBswR7mR9T26
         lkc26D4YMbvYUGFQljUip1MAZOsJ2GOwvv142MaXQPXBKP7wRnu9zXC4mfTPyCFERxE4
         NvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5W91nY5g2x/PNBMnEeWdlyukY7wlgLCqBSWWvoZMNo8=;
        b=U1EXz6BIf4t1UcEN9iG32Oz0pXQGaDsRkmkLQJz2ceW3CAn9vYmoR/y1vUgVCmWK41
         aZCNmdtMVlMairEXizy+IrqXr2uZ3ELi7tio7/Ys4vT0BbJrR+VQsVV6/bs7uDWUmJ+h
         937iwRL2cz6NcpHnCTRQZJ1r4PRCQhVqPi+uugPZqUTRBVR/6Jm9ZWNkMQ7MCM043Yyq
         +yVpnBLRKvamD5DMa4z5Tv+r52jz2EgxLko5Ur5VFSOIrTAOVQ91nuDqTvKlQFT5P7sS
         rQQONUBHdQqgkl1Q6g/+WtAGSlq2XkrNRxz/Lpp0WbwtcD1ytqyfuapeTSKK19aek2Jh
         qR0w==
X-Gm-Message-State: AOAM533RhSoPDFdCooK6fwT7iBZiPE16aHoUNLOZ+XRnJD525zfyUZuf
        IHTkoBKMG5W54e6ji6qSU4lg69iK4mc=
X-Google-Smtp-Source: ABdhPJxMQvIE9nIXz2sl2HyN4f2u8FCzHt4WeaO6gFBzfgNpMziy7VJQ3LnoEua7c0bTVhs78i2+KA==
X-Received: by 2002:a50:9e61:0:b0:419:d8e5:6236 with SMTP id z88-20020a509e61000000b00419d8e56236mr7124021ede.327.1649225953449;
        Tue, 05 Apr 2022 23:19:13 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id q3-20020a50da83000000b0041cdd6e92b1sm2475251edj.27.2022.04.05.23.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 23:19:12 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/5] staging: r8188eu: use round_up() instead of _RND4()
Date:   Wed,  6 Apr 2022 08:18:56 +0200
Message-Id: <20220406061859.9011-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406061859.9011-1-straube.linux@gmail.com>
References: <20220406061859.9011-1-straube.linux@gmail.com>
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

