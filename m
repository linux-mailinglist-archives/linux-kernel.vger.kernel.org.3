Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5975905EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbiHKRgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbiHKRfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:35:55 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE9B6A48D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:35:54 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id o2so15188667iof.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8o46kS926x+QNuy5c4uBrvlsDlM/ABLoibmgwB6shD8=;
        b=U6UOu+ihAb2JTfwfKtFLGsAM5//yojM/EfxSJg1oSpNRwMmWCAKD6ad6mx1KbfzOOd
         h13rHKkT0IktAVFiXb4kQEEsnAfleLXx7Vqr9lu2L2KtZOGYWSfiuJ0p/zWOphTUU5WD
         gtS3fcpge3mmi4Dta/Cjq9P9AgCadxNP2NA+YUdHGeM8aJmHjY20IBOPsiwi/rUVHnug
         VSLo9v0yu9ca5PCkKK+K5Pxk3Rg8ptP/AA1fACgzgw9JxUUaWjCDJnsUi/txCrzbaKX/
         9sggavFA7EnP63UQGOCSGU0fUuaXdr6s6PvoRd2kj/gxKVcvIhnjBdAWtko4hqD9pN94
         KnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8o46kS926x+QNuy5c4uBrvlsDlM/ABLoibmgwB6shD8=;
        b=LAIaKmtn8yWxF2G92B1tF0njUZE3va0mwsn1N52CtnD9uQBH0AGUpguGkjERFhE/gc
         8Bk/53px9qa6VI/DMzSQ9UPn9jGe7dFp/oczSaWeOtlvqnHbMc/7Eoz3ogSLpKyGuLxu
         bMPq4fkYE80xNaT89keT7UmWlmCCYv05pAufis692Ws8Af+dDpNHozGLHLjEW01YXgV9
         OsSk9CGUdhw8sxrHZ+dVMZ8/VC9mLe0AJezXJpSTfFs+gtYDlkhjGDMIsp8jBu3pvPte
         FMGIk/QZSiQvnipaY9BASMcvRE0QJwR43djfvdNl7ojekEIhqzB8QXqIJO7y5gILktjD
         QNoA==
X-Gm-Message-State: ACgBeo1TItASLuxSzIjhV5pKTmICognVCAfOx7T+Tt0GXYsoCsES82vd
        WKUgZ46gFRificZcyMmmsUPi/3vqFxA=
X-Google-Smtp-Source: AA6agR75o8hqLLPSwEMM+0RAW4piNtgIvz2GqtLLtUL08G5TuwqU52b+3AxKOsC4QnNmt6RFGUsB3g==
X-Received: by 2002:a02:b799:0:b0:343:390a:4f66 with SMTP id f25-20020a02b799000000b00343390a4f66mr180392jam.222.1660239352513;
        Thu, 11 Aug 2022 10:35:52 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id n9-20020a056638110900b003435e8635bbsm27928jal.77.2022.08.11.10.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 10:35:52 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jbaron@akamai.com
Cc:     Jim Cromie <jim.cromie@gmail.com>, vincent.whitchurch@axis.com
Subject: [PATCH 01/11] dyndbg: fix static_branch manipulation
Date:   Thu, 11 Aug 2022 11:35:31 -0600
Message-Id: <20220811173541.2901122-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811173541.2901122-1-jim.cromie@gmail.com>
References: <20220811173541.2901122-1-jim.cromie@gmail.com>
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
Acked-by: Jason Baron <jbaron@akamai.com>
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
2.37.1

