Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A104C90A9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbiCAQrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbiCAQrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:47:36 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB0A427F9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 08:46:54 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id 9so12973247ily.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 08:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z8u4MF+f5/cGlLGB0/vAj9alSkuZujSqlEVmUNGHTX4=;
        b=EoKe1Vmlza53p81HMtpffi/FybfHcwZEbuj/YR2K3DkCNQ8dNkbtA0D9ABl/k5l3CT
         iGyWhO/JC3xToc7WdDDe0J+ymBPPVaDNKXdQWnDoeKbt0KlRdtLDXXvQ5HSCTvDwPVzx
         ti+sbATfop4sNR8TEufa/jTcJ+HVvV1fANPunTC4VWAIpR0vZkosU5xD2ut9CmD9uJHI
         aIALlS8bGfvMoC6BLuRrKwww+3/sdpVpBhcVl/CQfvcn/H6oJY06xsn13OjGB8qV0RUY
         Kg1qEE/FBSjxSN/b6N6YsuuMx0aFX3nWar49uUGKCDkOzaSm3Ym1QpmVJLghds3pYZt9
         PPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z8u4MF+f5/cGlLGB0/vAj9alSkuZujSqlEVmUNGHTX4=;
        b=YhPkomnQXAOTaNfjmtK7WJL8fPw8fquUxa5Gv5KdahIsz1gwe5T/R26bAd1yXwqpz6
         BACHNmXf/A4utOfUgIM6gPMDyI3y9lw9CWrQ5ZtyXb0d9Fp50DYV+V1QoP2B/bF4rP/4
         b0eXJomXaBjGM3+8Z8xoXMLJxHRmoQYc68tw3K6ze02m69lYVjldpSPuMBaKca8XMvyP
         aHdEe0TOabCvNmcxfJ5PVpfQ0qAI7Moc1RpvCiwZqCFsqDS+Fw0Iietp8BINCOcKcOOk
         hkWwrzsH0QbduQ0OnmAn82Xvum5DOE6AahKJ2kJpIAyHUn9PyHGHOTPIMXEEMCh84d7I
         KnvQ==
X-Gm-Message-State: AOAM533j+lsxgA3FOs+loQvqoEo5mDa0sFhd0Lc1yRlX+M7Y0Z7mecjV
        F4FdtNToPwve44Zv4IJSBY0=
X-Google-Smtp-Source: ABdhPJxK5WeEUVyEuTuND3j4vG/YJnSaxYEpQFY4ZNpRm7OJTrBmY08zUwihDnew7RXNG33rQR7jMw==
X-Received: by 2002:a05:6e02:1bc3:b0:2c1:a992:9ffa with SMTP id x3-20020a056e021bc300b002c1a9929ffamr25168133ilv.124.1646153213496;
        Tue, 01 Mar 2022 08:46:53 -0800 (PST)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::f10e])
        by smtp.googlemail.com with ESMTPSA id o3-20020a6b5a03000000b00640a33c5b0dsm7272411iob.17.2022.03.01.08.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 08:46:53 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 05/13] dyndbg: improve change-info to have old and new
Date:   Tue,  1 Mar 2022 09:46:21 -0700
Message-Id: <20220301164629.3814634-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301164629.3814634-1-jim.cromie@gmail.com>
References: <20220301164629.3814634-1-jim.cromie@gmail.com>
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

move site.flag update after the v4pr_info("change") message, and
improve the message to print both old and new flag values.

Heres new form:
  dyndbg: changed net/ipv4/tcp.c:2424 [tcp]tcp_recvmsg_locked pT -> _

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 60b2572e64f0..ab93b370d489 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -158,7 +158,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	struct ddebug_table *dt;
 	unsigned int newflags;
 	unsigned int nfound = 0;
-	struct flagsbuf fbuf;
+	struct flagsbuf fbuf, nbuf;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -223,11 +223,12 @@ static int ddebug_change(const struct ddebug_query *query,
 				static_branch_enable(&dp->key.dd_key_true);
 			}
 #endif
+			v4pr_info("changed %s:%d [%s]%s %s -> %s\n",
+				  trim_prefix(dp->filename), dp->lineno,
+				  dt->mod_name, dp->function,
+				  ddebug_describe_flags(dp->flags, &fbuf),
+				  ddebug_describe_flags(newflags, &nbuf));
 			dp->flags = newflags;
-			v4pr_info("changed %s:%d [%s]%s =%s\n",
-				 trim_prefix(dp->filename), dp->lineno,
-				 dt->mod_name, dp->function,
-				 ddebug_describe_flags(dp->flags, &fbuf));
 		}
 	}
 	mutex_unlock(&ddebug_lock);
-- 
2.35.1

