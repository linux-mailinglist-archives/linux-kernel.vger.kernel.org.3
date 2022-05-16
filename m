Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22DD52947E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiEPW5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349938AbiEPW5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:57:24 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F53E42EF7;
        Mon, 16 May 2022 15:57:13 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id e3so17604760ios.6;
        Mon, 16 May 2022 15:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bt4oL+4NDueQ7IK1/UaXo6CBgL/asEIgenKpiK57T5o=;
        b=p80yQOTShj3uaqG5IpCE93ONCxQVqEljr+raFPdtHx7yza8I7Auwkg5j2bxHF4QmZX
         7hDsop8LQgJklHsh5NkBvkY/Vv8QLfXg5SzbSHGjtdLtbZS6bge7Mfp37N/nQDAHXOHM
         DPSmpfdT+xo8fvilpnKL0BCPW7hwI/SSmleqzr8ho7kXo3B0ASzSYnKK0mMYayL9WCYn
         cBZ3uQMTJeKfIA+aCsijIrndP9wv2WrojahrrzikMZAaomnxQM3ix8Zh+kdX6NUgSMFq
         Oo3etlEqkzn/ITkV3Vhx1R+9yMgYpJtQWoPPh3lpxfowVmBH/+IwqUvtVbCpN1Ioe4Gs
         YaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bt4oL+4NDueQ7IK1/UaXo6CBgL/asEIgenKpiK57T5o=;
        b=FmLBy5tFy8tz2zXer2xAZgegX4Ufqf0P5hx1ZO2sR3n2VAPwdic0ElpjY20k0VCQ1Z
         ciVJyPrigEBR6nREPzNe8dI6oEyoYBCwV88xEwSBkQfdo2Pb4zoUkvVLhE/RIB3OuiXg
         2CPTA67iaSLcfSGggk2cElPceKsTd2JmGZ6BLClqfuxy/jUZnz9AYydXym0hiE8ko7iN
         8VQhbt4hCNrMzz4RluI9dy7s7A6OzFKrjj1mNPr8q5FCvDTLSTvE+5c/iK/n3tsCdaNl
         MVisU5Thfk9poczl1LuiDBK+a0OdZWFvEQa5Hv1IA+HtZUtP2Kj0pdAtZiwiYhdpYaIk
         zZcg==
X-Gm-Message-State: AOAM532bI+utuz5YXyfQm55caz6E6sPEjpLV/eY7BXAQlrvQMIjH2tpY
        IRYz45f0jf7M5azH9VrZ61I=
X-Google-Smtp-Source: ABdhPJy66MckGQDyLsJIvF4VToS5sqJd0myJwjL9fDBA20NLuZbxaWNutVsSqrmALyzEJvTgqsIHSA==
X-Received: by 2002:a05:6638:2185:b0:32b:73ff:ef16 with SMTP id s5-20020a056638218500b0032b73ffef16mr11024498jaj.192.1652741832638;
        Mon, 16 May 2022 15:57:12 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::dd9f])
        by smtp.googlemail.com with ESMTPSA id k26-20020a02661a000000b0032b74686763sm3133949jac.76.2022.05.16.15.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:57:12 -0700 (PDT)
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
Subject: [PATCH v2 10/27] dyndbg: let query-modname override defaulting modname
Date:   Mon, 16 May 2022 16:56:23 -0600
Message-Id: <20220516225640.3102269-11-jim.cromie@gmail.com>
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

dyndbg's control-parser: ddebug_parse_query(), requires that search
terms: module, func, file, lineno, are not used 2x in a query; a thing
cannot be named both foo and bar (not even wildcards, no OR is
contemplated).

Amend the treatment of module; while still enforcing the 2x rule on
it, set the default module at end, if none was given in the query
itself, so the preset doesn't spoil the check.

Background:

ddebug_parse_query() got a modname arg to support boot-args with
compound queries, all with "module aMod" added by default.

  aMod.dyndbg="func foo +p; func bar +p"

With default module at end, this becomes possible; "module *" in the
query overrides the default "module aMod".

  aMod.dyndbg="module * class FOO +p"

This means aMod can modify (by explicit means) any FOO class'd
pr_debugs in other modules.  It is intended for use by DRM, which
generally would want sub-system wide coordination.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index b67bf9efec07..42dce2e76014 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -425,10 +425,6 @@ static int ddebug_parse_query(char *words[], int nwords,
 		return -EINVAL;
 	}
 
-	if (modname)
-		/* support $modname.dyndbg=<multiple queries> */
-		query->module = modname;
-
 	for (i = 0; i < nwords; i += 2) {
 		char *keyword = words[i];
 		char *arg = words[i+1];
@@ -471,6 +467,13 @@ static int ddebug_parse_query(char *words[], int nwords,
 		if (rc)
 			return rc;
 	}
+	if (!query->module && modname)
+		/*
+		 * support $modname.dyndbg=<multiple queries>,
+		 * allowing query.module to override $modname
+		 */
+		query->module = modname;
+
 	vpr_info_dq(query, "parsed");
 	return 0;
 }
-- 
2.35.3

