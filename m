Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35E14D59C7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 05:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346385AbiCKEtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 23:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346227AbiCKEtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 23:49:19 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD8597293
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:48:16 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id r2so296813ilh.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oAf0LosuiaLpXGtYs0EMjapukN/Wz4GaZEg3vD6y6ak=;
        b=FGomt3SpUqyItDxQTS6QatofCRhiZIi82c83FcZW5lAA7Hia4dUP0QS/5UI8s6V1iG
         p9ewH/E8qTORsPj4+OnlwfDOXUVrf8HA+fTwEUNyHVWnEW32jyMqS0HEMeua00mED9fG
         Jt5WhOje3GPSyOyvOMadpj6kIzq9ffhFw1is+8tPx5sOzNgcO1DanXFs7auqvAQR2OBg
         O5UhHrzIh8D2tX1MtSnEyQ5Xl0wYsAOwDwWqf53yNtM1nYFJb6c8e8muyyQDgIBl6Ddw
         xd1IC+TTQp3rkOr7C1IvU2aLj6DFtJpHblfIL1P1+F7+iR/oDHQO/VvQ8mZgMhLKEvdi
         yJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oAf0LosuiaLpXGtYs0EMjapukN/Wz4GaZEg3vD6y6ak=;
        b=hO6GHXaH+veNPN3qEZPTAs+u1k7nhpIGcxi5OzyuMfaE6HlgpC/lxULS5iD+DtAYvd
         sTiRNRtuSpfO8+QHo9r0/tT3XUpOP+D5CajapAIjaOFOT454VR4qrZK+JGOIRSd0+1qU
         96Znnxe1o+3kTsngZFMGzEogQpcYaJsqxeslw7+8Ryo5jySj1ga+YqYYKzpvxnue3FU4
         1SToHH/sSmPmTqM/KAY3ivh4vOE2wve2sw/88nqumvlBlB36ddMcBNale5hWfO7aBAnl
         GulDZTfEF19OzdZgvHt2GvtrXXAgYmtZIRM11e4NxR9Y0t6fuLoq4pa/rCVkgpNBgu0C
         JY3Q==
X-Gm-Message-State: AOAM533oxc7U6me8QKPmoUIF/V7Dq7v5k79qxN3dQUtjxxXom874Kq2+
        ScavoWIKoe+IPPCAwJZGut0=
X-Google-Smtp-Source: ABdhPJwFZHg/BgFkwfNAHNLyEDOYNqmvUk/C+4ceSxeoTbqDRVietvJzifHbTMNcdfYqz0MT1Xo4PA==
X-Received: by 2002:a05:6e02:1946:b0:2c7:730d:3e35 with SMTP id x6-20020a056e02194600b002c7730d3e35mr2075171ilu.179.1646974096273;
        Thu, 10 Mar 2022 20:48:16 -0800 (PST)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::f10e])
        by smtp.googlemail.com with ESMTPSA id q9-20020a5edb09000000b00645c7a00cbbsm3529834iop.20.2022.03.10.20.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 20:48:15 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, Jim Cromie <jim.cromie@gmail.com>,
        vincent.whitchurch@axis.com
Subject: [PATCH 1/5] dyndbg: fix static_branch manipulation
Date:   Thu, 10 Mar 2022 21:47:52 -0700
Message-Id: <20220311044756.425777-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311044756.425777-1-jim.cromie@gmail.com>
References: <20220311044756.425777-1-jim.cromie@gmail.com>
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

In https://lore.kernel.org/lkml/20211209150910.GA23668@axis.com/

Vincent's patch commented on, and worked around, a bug toggling
static_branch's, when a 2nd PRINTK-ish flag was added.  The bug
results in a premature static_branch_disable when the 1st of 2 flags
was disabled.

The cited commit computed newflags, but then in the JUMP_LABEL block,
failed to use that result, instead using just one of the terms in it.
Using newflags instead made the code work properly.

This is Vincents test-case, reduced.  It needs the 2nd flag to work
properly, but it's explanatory here.

pt_test() {
    echo 5 > /sys/module/dynamic_debug/verbose

    site="module tcp" # just one callsite
    echo " $site =_ " > /proc/dynamic_debug/control # clear it

    # A B ~A ~B
    for flg in +T +p "-T #broke here" -p; do
	echo " $site $flg " > /proc/dynamic_debug/control
    done;

    # A B ~B ~A
    for flg in +T +p "-p #broke here" -T; do
	echo " $site $flg " > /proc/dynamic_debug/control
    done
}
pt_test

Fixes: 84da83a6ffc0 dyndbg: combine flags & mask into a struct, simplify with it
CC: vincent.whitchurch@axis.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

--
.drop @stable, no exposed bug.
---
 lib/dynamic_debug.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index dd7f56af9aed..a56c1286ffa4 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -211,10 +211,11 @@ static int ddebug_change(const struct ddebug_query *query,
 				continue;
 #ifdef CONFIG_JUMP_LABEL
 			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
-				if (!(modifiers->flags & _DPRINTK_FLAGS_PRINT))
+				if (!(newflags & _DPRINTK_FLAGS_PRINT))
 					static_branch_disable(&dp->key.dd_key_true);
-			} else if (modifiers->flags & _DPRINTK_FLAGS_PRINT)
+			} else if (newflags & _DPRINTK_FLAGS_PRINT) {
 				static_branch_enable(&dp->key.dd_key_true);
+			}
 #endif
 			dp->flags = newflags;
 			v4pr_info("changed %s:%d [%s]%s =%s\n",
-- 
2.35.1

