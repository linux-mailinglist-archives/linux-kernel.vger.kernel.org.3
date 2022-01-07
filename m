Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E39F487250
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346161AbiAGF35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346092AbiAGF3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:29:53 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C3BC061245;
        Thu,  6 Jan 2022 21:29:52 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id m4so3844519ilf.0;
        Thu, 06 Jan 2022 21:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CdkftQqQNv/OqkWYbExR0c5h8hkYftad3zXE6/ffMXs=;
        b=A05OlVZNEl+qPoFA0HUlJIfImnTZc2bA0RUaeqMLJ53X1friDFLgKSVSA6hmwwsy22
         tWI6wHkmVsrVd/coDCoALVwCK2ckhx/c7FGVj6bPB3CODaNSMK15IOakHnUWDYBrEASi
         zlGqGf3FtgUGoRvWM+zIm1gma8S0zNkWp4ptXQjJoS1HyRo+VZg1PNmhiR1UHSETBuAd
         2cUlAlMe++EBBBA8C2mZ6mj06cYagKW5LUyoZU98sDlUW4juW8l8i2u/KIn+t1RliDlf
         tbFKZ/FpBcQU7PK6RZoYCImQL/fk4OAWxlwRV4CxliXLLXSrUnRR23PbY/UKCbV4DWz+
         Kybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CdkftQqQNv/OqkWYbExR0c5h8hkYftad3zXE6/ffMXs=;
        b=rBHvPEa4+vez9rgN/6taczDs2eEKqUyLSKIM1jsyDx/sa3YamINVzwfu9ePpBcfcEW
         hrCuilfXLrJeyQfwxKC4e3YLBhMA4L3VE8Z2nHog/K+eWe1lFRTCEt3A1x4PhUCvUkvg
         bmNzUrI51XNQlnAjKhtjNadVmV3CG71nI4wfNoiI4qzsLHfK05KDcplorPucYTaCYnO6
         y/5Jgi2NM089BpA1s7H0GesC8KJn4JX38uRDJaT7MR/R/1+ERkAFVvcSjcxq/GdQiLQa
         AnERDZ9yPHJnfpEWO6C0FWHbkHaAc4Pg1r8S/yLyj/gM0UPQF+WlRZgKMZIJprJVnuru
         iofA==
X-Gm-Message-State: AOAM532vF+vFuopuDVPmawATeAz2EHr1cu4C/Y6GDRKA1Ija47sj85Q/
        +vYNalg+F13jgHigwmIv6AQ=
X-Google-Smtp-Source: ABdhPJyUg6/UkVla9SknnWDUILQsZ44OvsYQsd/nvHiUBfrWChy+SNyC1BoBl8Avpv3Jww8vX10z9Q==
X-Received: by 2002:a05:6e02:1a86:: with SMTP id k6mr28045756ilv.223.1641533392219;
        Thu, 06 Jan 2022 21:29:52 -0800 (PST)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id c18sm1843446iod.18.2022.01.06.21.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 21:29:51 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, daniel.vetter@ffwll.ch,
        seanpaul@chromium.org, robdclark@gmail.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     quic_saipraka@quicinc.com, will@kernel.org,
        catalin.marinas@arm.com, quic_psodagud@quicinc.com, maz@kernel.org,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, mingo@redhat.com,
        jim.cromie@gmail.com, vincent.whitchurch@axis.com
Subject: [PATCH v11 02/19] dyndbg: add _DPRINTK_FLAGS_TRACE
Date:   Thu,  6 Jan 2022 22:29:25 -0700
Message-Id: <20220107052942.1349447-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107052942.1349447-1-jim.cromie@gmail.com>
References: <20220107052942.1349447-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add new flag, and OR it into _DPRINTK_FLAGS_ENABLED definition

CC: vincent.whitchurch@axis.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 257a7bcbbe36..e0c2d7c0938b 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -37,7 +37,9 @@ struct _ddebug {
 	(_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FUNCNAME |\
 	 _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID)
 
-#define _DPRINTK_FLAGS_ENABLED		_DPRINTK_FLAGS_PRINTK
+#define _DPRINTK_FLAGS_TRACE		(1<<5)
+#define _DPRINTK_FLAGS_ENABLED		(_DPRINTK_FLAGS_PRINTK | \
+					 _DPRINTK_FLAGS_TRACE)
 
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINTK
-- 
2.33.1

