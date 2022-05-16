Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B3C5293F9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 00:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347027AbiEPW5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349862AbiEPW5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:57:00 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECF664D1;
        Mon, 16 May 2022 15:56:56 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id s12so8934441iln.11;
        Mon, 16 May 2022 15:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cpRV3Wk55836kFETyr3P+oiMpdiGkRAymJ30pnxlc/A=;
        b=QWDky+6aYSWTOwbaXHfQ0qh88ZnwyW0nlRYt7AFIGi+pr/O7HtcDIZJoUwY2uQliu9
         5DAnS8pAk7ltR19hsFx8xD11J2e9C34b2EjKu7G6GZifsv++3x/PCoYhmSfc/jI82CXO
         JUEUoEtDBZ7pN9W2qjVFdRQisajSDDRF9gBcGxncCVHpLUX9MVMMQrf7oBR96vEAgw3v
         G1Vvu/OQQjiiWdQZCJFaUgvE5rJQOlDtXzKaHx5ANWL3e16JKqk/EXa4Id3glwwNsY4o
         WuevVJX9Rtx87k0vFCNdiF7BW2MjYUmONfgUNWzT6G14Gl158geu3MfQqxnhhv8rS5mn
         OMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cpRV3Wk55836kFETyr3P+oiMpdiGkRAymJ30pnxlc/A=;
        b=KhuthDJ2PGd9ZpiW01lHNB+YYcvXQttJrTBOEOscGfCfKIXq6KNxK3rsisHFAPRCfV
         mEsBX/x9+eD17a28sIhtkD1Q6nMNMSR+/Hy+eoEwh7k8ltXT4uIxIltkl4JDELD/b+TV
         Z6B45NCNFJg5MTEcMvw8abZgwAzodKGEbYKSIW/aK7mPOabtTxX1i1wdV5FLkMOCIbkk
         orgU7PATv754d8HUu8E2Ifg0mc3LrF5YmmJc8oPy2NPofJw6z0XwER619Mxu0+Gw0XMG
         WjfR4ed6rOBhg2RxDqZVZLP/G3qt93wHskdXiqor8cPduZoSuaaMFB28uHX6Zs6tEzjS
         Zq3A==
X-Gm-Message-State: AOAM530iAYra1bQVY9CGBpFwWgbA8iuag3gOKKrYPMogT4C93915eYGq
        Kzt4OMiuPnhfFY1PCz6MUx4=
X-Google-Smtp-Source: ABdhPJxZQnf4PMb/pE6aahB0jrFIkVLr5qLnxheVKq6wugGMIzNly4UwftUMV/XycUHdiBmfQ/0yIQ==
X-Received: by 2002:a05:6e02:190c:b0:2cf:31b2:b0f7 with SMTP id w12-20020a056e02190c00b002cf31b2b0f7mr10351042ilu.46.1652741816349;
        Mon, 16 May 2022 15:56:56 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::dd9f])
        by smtp.googlemail.com with ESMTPSA id k26-20020a02661a000000b0032b74686763sm3133949jac.76.2022.05.16.15.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:56:55 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch,
        seanpaul@chromium.org, robdclark@gmail.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, quic_saipraka@quicinc.com,
        will@kernel.org, catalin.marinas@arm.com,
        quic_psodagud@quicinc.com, maz@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, mingo@redhat.com,
        jim.cromie@gmail.com, vincent.whitchurch@axis.com,
        Jason Baron <jbaaron@akamai.com>
Subject: [PATCH v2 01/27] dyndbg: fix static_branch manipulation
Date:   Mon, 16 May 2022 16:56:14 -0600
Message-Id: <20220516225640.3102269-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220516225640.3102269-1-jim.cromie@gmail.com>
References: <20220516225640.3102269-1-jim.cromie@gmail.com>
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

This is Vincents test-case, reduced.  It needs the 2nd flag to
demonstrate the bug, but it's explanatory here.

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
Acked-by: Jason Baron <jbaaron@akamai.com>
---
.drop @stable, no exposed bug.
.add jbaron ack
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
2.35.3

