Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2002F51766A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386833AbiEBSV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386789AbiEBSVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:21:24 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96641F3F;
        Mon,  2 May 2022 11:17:54 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id z12so8376218ilp.8;
        Mon, 02 May 2022 11:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oljhvr5L//T9Vy02GcvXRkCXJypJDloAClOtYKsY/0E=;
        b=m8g+klr4FSoI2I5mvjR+ATb/3XQ5Mh5s9DwzGed58GsXWVUbF4mq3GH+lVjr5f5AhU
         12UWNwsWDOb2Z85I9rHqYmC7DiU6MfAtWZSZFKKEorv7U9IWVh27fTnexF3l28nJ1Ug+
         S9KqUcHmyh6hQPhhJeZ6XuV7LcBjwN8QlsiioG8w5lJTI+4zsWhhro/6dbWe7VtNa/rn
         XCvpgt3BwNQghGs+iV3DSWZgIN72E832AVZlcD+eVAWueyMwZUP6TwwFTIDXnazn6+wg
         dxLfzJNn0A+uRWTjF+e+nhEpFh3U+l5ANpQqY42f/ReFqR1XF0cLlTVvjfgE+lWzsJIn
         aFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oljhvr5L//T9Vy02GcvXRkCXJypJDloAClOtYKsY/0E=;
        b=ztsXn1I8JCZwO6aL7Lwf6gyqgomRgFuU1ktFFvH103q8Gexy/pLQxUVZxMY6tMEg5Y
         GcifaNs58bSX/z25SRc9/4OLWC2fOKvrCWsMH7O0arDEqIgHTZwSOaMcjCc6lUT/5cSi
         vSy9davqeevioCRJAZ8bhp+YMawXNrpKIPyn6ADfGZG2V/DLbAZ3xi82IZDqyN/0DTO5
         tSkWO8twFnuvWhOF6Nr+adZR+9A/dszlKCGy3yyXxTrxWTfyAXoEHFAI2eXrLJ2zI1Kr
         C26eUEdt+KQY/SZkW0CVDsUiZQuwNLRzw5v3ZhoPlwvL4kf+AlqMnamz43jkuqOLqRkn
         ONlA==
X-Gm-Message-State: AOAM532NxHcnZo5eN9XmJ4padbDM2zhZkAhqiNEhGR6URNC3xBSbZLlx
        JoSNz9u5K941p0Yk/m33oYwZ21Vmgv0=
X-Google-Smtp-Source: ABdhPJx/NXLucnD6P0oMjFgEU5sNoFUlCqSo2QDN0SEVxjEh4UX3XcYl4M8nazibbtYM3Sfdi3FFJA==
X-Received: by 2002:a92:c26a:0:b0:2cd:9acf:c42d with SMTP id h10-20020a92c26a000000b002cd9acfc42dmr5153571ild.143.1651515474007;
        Mon, 02 May 2022 11:17:54 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:2d25:3fcb:9ffb:5d5a])
        by smtp.gmail.com with ESMTPSA id f43-20020a02242b000000b0032b3a7817a9sm3230678jaa.109.2022.05.02.11.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 11:17:53 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slawomir Stepien <sst@poczta.fm>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/3] of: overlay: add entry to of_overlay_action_name[]
Date:   Mon,  2 May 2022 13:17:40 -0500
Message-Id: <20220502181742.1402826-2-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502181742.1402826-1-frowand.list@gmail.com>
References: <20220502181742.1402826-1-frowand.list@gmail.com>
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

From: Frank Rowand <frank.rowand@sony.com>

The values of enum of_overlay_notify_action are used to index into
array of_overlay_action_name.  Add an entry to of_overlay_action_name
for the value recently added to of_overlay_notify_action.

Array of_overlay_action_name[] is moved into include/linux/of.h
adjacent to enum of_overlay_notify_action to make the connection
between the two more obvious if either is modified in the future.

The only use of of_overlay_action_name is for error reporting in
overlay_notify().  All callers of overlay_notify() report the same
error, but with fewer details.  Remove the redundant error reports
in the callers.

Fixes: 067c098766c6 ("of: overlay: rework overlay apply and remove kfree()s")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
Changes since version 1:
  - patch 1/1 v1 did not apply on Rob's dt/next branch, rebase on top of
    5f756a2eaa44 of: overlay: do not break notify on NOTIFY_{OK|STOP}

 drivers/of/overlay.c | 27 +++++----------------------
 include/linux/of.h   | 13 +++++++++++++
 2 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index bd522da7f76b..ae5ea5b1079b 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -152,13 +152,6 @@ int of_overlay_notifier_unregister(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(of_overlay_notifier_unregister);
 
-static char *of_overlay_action_name[] = {
-	"pre-apply",
-	"post-apply",
-	"pre-remove",
-	"post-remove",
-};
-
 static int overlay_notify(struct overlay_changeset *ovcs,
 		enum of_overlay_notify_action action)
 {
@@ -178,7 +171,7 @@ static int overlay_notify(struct overlay_changeset *ovcs,
 		if (notifier_to_errno(ret)) {
 			ret = notifier_to_errno(ret);
 			pr_err("overlay changeset %s notifier error %d, target: %pOF\n",
-			       of_overlay_action_name[action], ret, nd.target);
+			       of_overlay_action_name(action), ret, nd.target);
 			return ret;
 		}
 	}
@@ -925,10 +918,8 @@ static int of_overlay_apply(struct overlay_changeset *ovcs)
 		goto out;
 
 	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
-	if (ret) {
-		pr_err("overlay changeset pre-apply notify error %d\n", ret);
+	if (ret)
 		goto out;
-	}
 
 	ret = build_changeset(ovcs);
 	if (ret)
@@ -951,12 +942,9 @@ static int of_overlay_apply(struct overlay_changeset *ovcs)
 	/* notify failure is not fatal, continue */
 
 	ret_tmp = overlay_notify(ovcs, OF_OVERLAY_POST_APPLY);
-	if (ret_tmp) {
-		pr_err("overlay changeset post-apply notify error %d\n",
-		       ret_tmp);
+	if (ret_tmp)
 		if (!ret)
 			ret = ret_tmp;
-	}
 
 out:
 	pr_debug("%s() err=%d\n", __func__, ret);
@@ -1192,10 +1180,8 @@ int of_overlay_remove(int *ovcs_id)
 	}
 
 	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_REMOVE);
-	if (ret) {
-		pr_err("overlay changeset pre-remove notify error %d\n", ret);
+	if (ret)
 		goto err_unlock;
-	}
 
 	ret_apply = 0;
 	ret = __of_changeset_revert_entries(&ovcs->cset, &ret_apply);
@@ -1218,12 +1204,9 @@ int of_overlay_remove(int *ovcs_id)
 	 * OF_OVERLAY_POST_REMOVE returns an error.
 	 */
 	ret_tmp = overlay_notify(ovcs, OF_OVERLAY_POST_REMOVE);
-	if (ret_tmp) {
-		pr_err("overlay changeset post-remove notify error %d\n",
-		       ret_tmp);
+	if (ret_tmp)
 		if (!ret)
 			ret = ret_tmp;
-	}
 
 	free_overlay_changeset(ovcs);
 
diff --git a/include/linux/of.h b/include/linux/of.h
index 17741eee0ca4..f0a5d6b10c5a 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1550,6 +1550,19 @@ enum of_overlay_notify_action {
 	OF_OVERLAY_POST_REMOVE,
 };
 
+static inline char *of_overlay_action_name(enum of_overlay_notify_action action)
+{
+	static char *of_overlay_action_name[] = {
+		"init",
+		"pre-apply",
+		"post-apply",
+		"pre-remove",
+		"post-remove",
+	};
+
+	return of_overlay_action_name[action];
+}
+
 struct of_overlay_notify_data {
 	struct device_node *overlay;
 	struct device_node *target;
-- 
Frank Rowand <frank.rowand@sony.com>

