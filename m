Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0675E5905EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbiHKRgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbiHKRf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:35:58 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626776A48D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:35:57 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id x64so15216792iof.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=66tB9GURiJGDaXzm2IfI1R+C6P9N6jM87DtEYp8w9s8=;
        b=LHNuQSl/JLN/8xG1Ng6NDXJSooMN+HxNs52JDN/aGZkxyvMArWvQr818nDXXDfvrLy
         jVKlYAym6enmXF9MFzCrNma1M98Gq1XHUTL2m80F+FJxt88IAq/KeEXedS35oRfR1Axk
         IGu8fsi+dHPQbS7WV/d6VKGK4DItc2E+FmgF2+MSph1cPht9GeZNf2nO/k5ZUxwvO5LO
         mq61+m+CNl4a/YxP2BJOSYiQ9Pi7jHv6+i098KLdtMbZ7DTkPSiO2qqSeoWeOjou/UqY
         68Qaiqf5X5e28pioTXMWFEn47fAveE7/fSqjmmJ19h3BC5bBK8E3ecnQqEyGMy8f1YoE
         LF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=66tB9GURiJGDaXzm2IfI1R+C6P9N6jM87DtEYp8w9s8=;
        b=Y/Ymj9ldNk++JYADV1Oa6jQiGs+RTbWn7V3YnAJfpLVxp6l3ivz2n9UKvigXrNt5nG
         NszA7L65n8sUUtuay/wMmIzQyjlW0rKB/7xfw/wBvlp71JWiwNoAyADxo/C6IKWjXB7O
         RidShXuLDxDfnqt53294mIhy9qgkUyseESj5Zj+dVntZKUNG3RByK9YiWZGraflCJGO8
         xBJuUj0RGfMH263LrRuDuEz4T1HWDetFEa8/iJFQXAHbl4uo0ulHsiji7yv+nPgI2rBB
         pKoaApqdWkHHJecxUfEM+peNYM5Ep7ctcpI5vVtg75Z4TvUqq2olwaBydyJ2amNIcEis
         Wwbg==
X-Gm-Message-State: ACgBeo0upCdCP+6a7m1oFRo3iXxUuIjV50R1B6+9fn+BBWohbrNaOaTd
        o2T1vQmsL1cNo5Tmpr9nZW2nwD0H95A=
X-Google-Smtp-Source: AA6agR45kbmTMXQWqGjPtZgg9ZFvk16Op2qVYEeVm8ju6DVbo5szux1govHUPtEjVhezgToPXMHpBQ==
X-Received: by 2002:a05:6638:3015:b0:341:de68:602c with SMTP id r21-20020a056638301500b00341de68602cmr201109jak.10.1660239356342;
        Thu, 11 Aug 2022 10:35:56 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id n9-20020a056638110900b003435e8635bbsm27928jal.77.2022.08.11.10.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 10:35:56 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jbaron@akamai.com
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 03/11] dyndbg: show both old and new in change-info
Date:   Thu, 11 Aug 2022 11:35:33 -0600
Message-Id: <20220811173541.2901122-4-jim.cromie@gmail.com>
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

print "old => new" flag values to the info("change") message.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Acked-by: Jason Baron <jbaron@akamai.com>
---
 lib/dynamic_debug.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a56c1286ffa4..8faf584f2f4b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -156,7 +156,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	struct ddebug_table *dt;
 	unsigned int newflags;
 	unsigned int nfound = 0;
-	struct flagsbuf fbuf;
+	struct flagsbuf fbuf, nbuf;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -217,11 +217,12 @@ static int ddebug_change(const struct ddebug_query *query,
 				static_branch_enable(&dp->key.dd_key_true);
 			}
 #endif
+			v4pr_info("changed %s:%d [%s]%s %s => %s\n",
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
2.37.1

