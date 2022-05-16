Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563DC52940E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 00:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349890AbiEPW5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349856AbiEPW5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:57:03 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646D542A19;
        Mon, 16 May 2022 15:57:01 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e4so2302460ils.12;
        Mon, 16 May 2022 15:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0q2zph1ZCXFs7WKRxPFWrSWi15W02opZe3T7QJQ5ap4=;
        b=D+2Nl0pQxEGTDTo5NEF/KAytSKaLe4sJXJOvqpnRcVc/IZnyy0W1wMyiITHglFfU+S
         pmgMHonBN1r0D+h6EVslkidi/tGcgNxCrfkplfoHiLHtENqxSaHXpEOV0hmlGsFAL1gy
         WMxhbfMRHDPmJQ/ima0D6KrMxyMEU/NPxcGgdV7u6BIi/1NfRuMaCWvgJ8b98Hsi8aaP
         1/xNeEJKp2IotfVLQl30vHtClfiO0oBvomhf8Ch3ixkoss6Uu0JBJpVSpnl0gqlMhNEp
         cIX+I7Q981LaG/iyCIs3c9iLX+tz40fiurace8CRPhis2aLMQuPPHB3Us22EtfY/w7TJ
         OiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0q2zph1ZCXFs7WKRxPFWrSWi15W02opZe3T7QJQ5ap4=;
        b=1SREEclRgmDSOkgt1YOUlRlsZvoCZMLHLV9GAOEw3LMOhpny6n4ImerIrzch/f5/6E
         zSRlgWN4tgvEPzlizonYwEYP4brjBYLDKKfBjk8ITyDwQvyYKTMlADV4NvsEZwIZIVco
         agk49DWPl0sPNfLHTGXJNK9LeJqLIoWFTZ08jUtiORcrHWPxfZLstfxgjKavrrcC4hRa
         MqCOLnXmF/Omw9drOINOr3GMYEAlcgNe41O3w3CNBMwwZHMHk4XO3DoUxx4dHyzhHemQ
         9sS87zFmUa1rQlEceBL6V3i4TXvx8hTRHqMkEqoRYf5HzjkkBxpPLk2mV2NZzXS+f2eo
         BFUg==
X-Gm-Message-State: AOAM5323HLq6ZH2Y+wLDlv6r0JEFVosyx4UZrmaAypNjJrmN2UYkJHfZ
        p7iirQwv+L8wERleRT2XzIM=
X-Google-Smtp-Source: ABdhPJxzuDtDs3r2+Nl0gh2+cAwejD1t+Ts8LpHwPq/tWghODbyudseUdSlIKZM7WeMOEenc8xf2qA==
X-Received: by 2002:a05:6e02:1a2f:b0:2d1:2399:dc36 with SMTP id g15-20020a056e021a2f00b002d12399dc36mr3231577ile.12.1652741820481;
        Mon, 16 May 2022 15:57:00 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::dd9f])
        by smtp.googlemail.com with ESMTPSA id k26-20020a02661a000000b0032b74686763sm3133949jac.76.2022.05.16.15.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:57:00 -0700 (PDT)
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
        jim.cromie@gmail.com
Subject: [PATCH v2 02/27] dyndbg: show both old and new in change-info
Date:   Mon, 16 May 2022 16:56:15 -0600
Message-Id: <20220516225640.3102269-3-jim.cromie@gmail.com>
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

print "old -> new" flag values in the info("change") message.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a56c1286ffa4..ca2a28f1d51c 100644
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
2.35.3

