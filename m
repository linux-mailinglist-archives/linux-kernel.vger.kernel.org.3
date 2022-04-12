Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FF74FE85D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 20:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358917AbiDLTBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 15:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358800AbiDLTAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 15:00:24 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CB843AD5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:58:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 21so10293199edv.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BsWsL39ltA1wTpv8W1hqbPPmQmDEyFgKV3mcaWzu08c=;
        b=deKENVLfFRR1fSZcs4ZiGvcW7ukzwIj8EfVX9z37LnXJPhxKNy3FxGIe6CQWbppQIZ
         aUtXjcAGORu3rS41d0DFthdls3+R9BXfOayU3ZVY6alx9It4b/1sA/9Q8sW/dkT/rJ2G
         9Ao5L5yysnSmKppJdLi3k8ZhAwWiJpjpgdWOPVfMgdGFaSfqQopk/Y1WJTZxPxt2ZDP8
         MaY0YsabmrGjtB+Q8UuEbY+n+gncLmW/+aa4camFgK4cnumJYM+U9/uWC6sRAa64MIhh
         Ls8lSPJ+3GTpzD1LHjG9g3DZMpo2nd7Y4COzsHpA4iu3dV0ji96ME61a5RJRK5Ze1E0Q
         q6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BsWsL39ltA1wTpv8W1hqbPPmQmDEyFgKV3mcaWzu08c=;
        b=s1kemyzJhBEN5ZdlL+Pv6aKMhOp/oSi0YGVdTHRkIQNkIOMq0MeThEyFtV5tcHDSLB
         siI4E+cyVEsfMxK1VwF3UoxAsVzzu+0fj3Tc51cuLa5SWCiM40myGCkuGXM+6U6mbO4i
         9AigvzHrYAxVX25qnFqUKp0SlVeMOlcqCh4G2Aj6lCxlWvtTwq0zhPRW1IV9oauPD6yd
         0yESmrs8DwTMlYIswcegtB8SGZD6qy1VPzL/X4ySZ1oEqatTyS7dJ4bWdQ9X7418/uOe
         fZltedlS2SNb02h7bIf5xQNY0gcNTEJK6h+aTgdcdG4FkN3GnIqOJMbpV0KNKyGoUlC1
         +EZQ==
X-Gm-Message-State: AOAM531QgS3REMdH1TI8QqoVUaig4qJAWSn7JUbJl5edCpMOqvGbhpq0
        oOt8Rwg3czyKQ+ZLSgLG3GE=
X-Google-Smtp-Source: ABdhPJxvfzcTLZbNQM0pkZ2JE75eq79nLgBBh5wlxm3gTixrxFK/X6sdt7LCtKYa6G2Wc4lkwKqYGA==
X-Received: by 2002:aa7:d494:0:b0:41d:704f:7718 with SMTP id b20-20020aa7d494000000b0041d704f7718mr17595132edr.147.1649789885302;
        Tue, 12 Apr 2022 11:58:05 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906771600b006cf8a37ebf5sm13443482ejm.103.2022.04.12.11.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 11:58:04 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/6] staging: r8188eu: remove unneeded initializations
Date:   Tue, 12 Apr 2022 20:57:53 +0200
Message-Id: <20220412185754.8695-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412185754.8695-1-straube.linux@gmail.com>
References: <20220412185754.8695-1-straube.linux@gmail.com>
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

The variables i and offset in block_write() are set in the code
before they are used. Remove the unneeded initializations.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index b4ab050a6f23..1e930799a0b3 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -75,7 +75,7 @@ static int block_write(struct adapter *padapter, u8 *buffer, u32 size)
 {
 	int ret = _SUCCESS;
 	u32 blocks, block_size, remain;
-	u32	i = 0, offset = 0;
+	u32 i, offset;
 
 	block_size = MAX_REG_BLOCK_SIZE;
 
-- 
2.35.1

