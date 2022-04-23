Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE7E50CA51
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 15:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbiDWNFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 09:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbiDWNFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 09:05:22 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5201F040A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:02:25 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id i24so10505943pfa.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oyv6GRijgI6ZlQEYxlfZHmDpqpNucWtnXIaYxQpviek=;
        b=gpE6EbIka79YAOkWw/HkIZ4o/eLh5qUEEfeLWfx4F3l9r6mNubqOGbe4OHMTsYlUG5
         kwdGKktCdxXTwJBgn0kXcbkm9QZJVYHZnnJe7sLGfqVgEZKykmPwjgQZbjt4YwK+SS5E
         cjt1C9smys6T2aErJJyQG6C2uEBVvmuEzBJml88xWcFCYEru3agIiVxoj5p8lXmBceWv
         3mkbuiZ2Ou41Vu9McGHMOgI7Atrj6Yui8qxFsJcw8SogNA/hdSiiOvZyKY3NyIuIhDGb
         kmSyoNDq7jx1taFe58HH329FlIjILfM/lv3zjCT2V9spneUSlmFoBlmsc+TkBK+YBR9J
         C+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oyv6GRijgI6ZlQEYxlfZHmDpqpNucWtnXIaYxQpviek=;
        b=iYUNjHdnttBfMBsixRhRsFxMjHEsqj73ZC6mKJCxUrq4lN9oBa6gsA0BOIsAqqodyd
         EUM3U2HrZgCwNjClYd+zQT3DjDL4SCgF1kN2B0urMHrsEzJzNaO0z+UmDFMw2+wMYvAA
         OfNtr274qMOFwtLAtZj+xzsitd8Jj0vKlEQl62IQKSJM11DmvFwO1YyvyqRyPsNNf9W/
         2tM6F5mwzc/XZFKInfgSjdH4LxYbGD04W3K6STo8/0NbEx0Jggu/H9f5xKI9pGgf2Xcl
         Lj6Z7746PYtirI/0eac/5pQqVeUzNXkopJQ3VBxy4CCPCqARiSJ3I10m9hY5N5q6TaPf
         Qbqw==
X-Gm-Message-State: AOAM531YFEdS5TIJHqEsM22oilafemnAgCmdUT9ZX/+UZRnsHFedWKEw
        E+mVBh65Udr0d4CBmeKIICc=
X-Google-Smtp-Source: ABdhPJyFcHs6ZfXij+Hc0XU13+ZgJuibRmhSOeNb5WawPnZnK/GODXcAy7louFq1siZa+3VxSDonpQ==
X-Received: by 2002:a63:5648:0:b0:398:dfcf:c9c6 with SMTP id g8-20020a635648000000b00398dfcfc9c6mr7875249pgm.0.1650718944637;
        Sat, 23 Apr 2022 06:02:24 -0700 (PDT)
Received: from localhost.localdomain ([14.100.36.163])
        by smtp.gmail.com with ESMTPSA id c139-20020a624e91000000b005060cdff4ffsm5808994pfb.129.2022.04.23.06.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 06:02:24 -0700 (PDT)
From:   Solomon Tan <wjsota@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: [PATCH 5/7] staging: rtl8192e: Remove unnecessary u16 argument cast
Date:   Sat, 23 Apr 2022 21:01:48 +0800
Message-Id: <20220423130150.161903-6-wjsota@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220423130150.161903-1-wjsota@gmail.com>
References: <20220423130150.161903-1-wjsota@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the explicit u16 casts for u16 argument in the function call. This
function has declared its parameter to be of type u16, so the argument
given to that parameter will be automatically coerced to u16. Therefore,
an explicit cast is unnecessary.

Signed-off-by: Solomon Tan <wjsota@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index b7bdbd895e7b..f92551094738 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -929,7 +929,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 				break;
 			case CmdID_WritePortUshort:
 				rtl92e_writew(dev, CurrentCmd->Para1,
-					      (u16)CurrentCmd->Para2);
+					      CurrentCmd->Para2);
 				break;
 			case CmdID_WritePortUchar:
 				rtl92e_writeb(dev, CurrentCmd->Para1,
-- 
2.36.0

