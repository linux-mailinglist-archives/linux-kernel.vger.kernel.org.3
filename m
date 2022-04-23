Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A17350CD06
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 20:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbiDWSvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 14:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiDWSvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 14:51:43 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29801C5E29
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 11:48:44 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id g9so9994289pgc.10
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 11:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UUb+ppLFoogYwaTmCBdznH5CdpGbI76fYVRaRMz3mZY=;
        b=LqTp+ahzDUi8OG8Tezrr0Q3SfgqNt7jmuPYJhWCTvWArypx7loPGZE8E77ri8gcwMc
         6NSMN/Wr8C4LWJOqzcS0vbQHe6TXARhDo3QN1zMNiapcl62aFdeF7Wwuo19uoeSqJjoD
         kQD0z6BIEyitPcu+mgCh0704ol93oXQB1f0XUqhAYaC6LO+SeW4Eg3hWeq3lUaWd9j61
         2g3U4fh5XHV3fWgQaEUdWIRDf4fNxEuYOzJQi9TQydTX4QqjMIWe83wNP4LJQrtrL5C3
         1humejQSw7/42jtOc+uUgQ1P9/G59M320ElSp0cdeJWQlXRxXLxElMMHNUAU6e1usr+b
         pwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UUb+ppLFoogYwaTmCBdznH5CdpGbI76fYVRaRMz3mZY=;
        b=dvnlTZZ669qkrLO1pQfbW/QJ3jMzcA3qin6f8B63Y93x3PTRHHYOGlAVq94M6h32P0
         34rXDZLtGr4mSsidhQ7d98D8BPVlFtxSpiuN6+LZf8La3RZJCikgqmkDhDHKAZmEPvvX
         7S9X0mJqcKhDFvmdYoRwr5PW6UgcG290hKSvwkWWe7Jml7u0ze7NZbM1l4vegZDkNTV8
         Quizo7fwSvPKejtTImqAHmYQwyBJ2D/Kooi/v+i8BwCbJ+4xBxwYymKmcAtlpv25wxMq
         Vp7NCjR7PqgJ+RHSTR4rAizh0vlrqhmvfj9Dn3GkXgwF/g6JLniUCU1sV+KkktSK06yW
         ERHg==
X-Gm-Message-State: AOAM533rPlECGCD7tKEouUegT5hcoCzUu0vrwMtZjKxyXkDh4ql2lelm
        ryLGGDvAIFYrA+fSRAIG790=
X-Google-Smtp-Source: ABdhPJwqDzYgIhXoXKNro0nwo9XbCmjvIts0kZXsSLVI6Kcteoyp0FInfGeAHPBDV1Fi5EG4u0z5xw==
X-Received: by 2002:a63:4a09:0:b0:382:597:3d0d with SMTP id x9-20020a634a09000000b0038205973d0dmr8783928pga.18.1650739724308;
        Sat, 23 Apr 2022 11:48:44 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:bc6e:cece:6009:3520])
        by smtp.gmail.com with ESMTPSA id 124-20020a621982000000b0050a73577a37sm6529113pfz.45.2022.04.23.11.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 11:48:44 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH] staging: r8188eu: fix a potential NULL pointer dereference
Date:   Sun, 24 Apr 2022 00:17:48 +0530
Message-Id: <20220423184745.21134-1-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

recvframe_chk_defrag() performs a NULL check on psta, but if that check
fails then it dereferences it, which it shouldn't do as psta is NULL.

Set pdefrag_q to NULL if above check fails and let the code after it handle
that case.

Fixes: 1cc18a22b96b ("staging: r8188eu: Add files for new driver - part 5")
Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index c1005ddaa..db54bceff 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1244,7 +1244,7 @@ struct recv_frame *recvframe_chk_defrag(struct adapter *padapter, struct recv_fr
 			pdefrag_q = NULL;
 		}
 	} else {
-		pdefrag_q = &psta->sta_recvpriv.defrag_q;
+		pdefrag_q = NULL;
 	}
 
 	if ((ismfrag == 0) && (fragnum == 0))
-- 
2.30.2

