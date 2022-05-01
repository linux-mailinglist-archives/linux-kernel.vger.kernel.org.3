Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8768C516115
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 02:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbiEAAJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 20:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237650AbiEAAJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 20:09:19 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510FD6257;
        Sat, 30 Apr 2022 17:05:56 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id h85so1888508iof.12;
        Sat, 30 Apr 2022 17:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bPaGf/rH6ukn1gEDjnUl5sTBDKAvT3vaR48iLuz34ZI=;
        b=Yq9+f1NSq3TXgTBNe8Hyk8bJ049f3J+/b+8bPKW4WnQWUifG9JBd27qXgdHzjFZY1l
         iBzAylBQWoIi34jN43H2zwd38ZkxOvTJLxf+5x/JluX3IKFkeRrIlZAvDaGp7muU03fT
         wu+GFevhQZWTe06Mi3N5IoGeRfdZnRU42c5deZOmq8gJPjxJt9Xg5nn1SnYL0CTkSLLo
         WY+KH47nMfJMcl1JI/IhbWkL3g7DjKUMsiSZ+3d8BBn+fZ6QrgiF+aB8wD2529Br2ha8
         WZDvYXmFz1bmM+RiD9SBgOTNwUhs2XTOXZ08ZSdnge08b4Iu8OL410teFAOVYsVd4E5a
         GSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bPaGf/rH6ukn1gEDjnUl5sTBDKAvT3vaR48iLuz34ZI=;
        b=mpLo67jCLjGpn4W5GjntxpDV26+lTS0yidvpPeckw3qqM40mUMWdpwOP6T+KjalJUm
         87BYZH2YiBn564Biyt8g9qpoKdmBWTArZVDG9+Y9kf+VhN03q0WCaLArEHpvCDJIjGck
         /XDBK18S5P/pk9yut0otnK2vhkb9m1XFeDFfiUeQp2ubvdxHzjDoWPXHcjEXJ+n8DGvw
         mbMR0LbRoq1UjoaMhMzaNYqxd5yrtFto8plUNQmXAIJtepNvMeqaMIUyGMOb23hw6CfI
         OXEkiY2rBQ7wUNnl6nWx7F7b2k9ZKKVoST8PbURJLwACkCFLuRLnTaJ1swwqamC+pDB0
         IKQg==
X-Gm-Message-State: AOAM530yDCMsodE3XoKoc3Oo/rcYOHp8ZT+T8rhv06YmS+5VjuBkIMO+
        JwbU3imFuQQUl7YCdbfDxD4=
X-Google-Smtp-Source: ABdhPJwcw8XQMx6rXmwXUHiaEQsEWlnaD+nLkJ72J3zOJyHLQ8tE85LSnZeluENmvit5b7wOckPFxg==
X-Received: by 2002:a02:cddd:0:b0:32a:e923:d0a3 with SMTP id m29-20020a02cddd000000b0032ae923d0a3mr2489565jap.88.1651363555738;
        Sat, 30 Apr 2022 17:05:55 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:809b:de5d:7e0a:bf83])
        by smtp.gmail.com with ESMTPSA id n13-20020a92d9cd000000b002cde6e352dcsm1567160ilq.38.2022.04.30.17.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 17:05:55 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slawomir Stepien <sst@poczta.fm>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] of: overlay: add entry to of_overlay_action_name[]
Date:   Sat, 30 Apr 2022 19:05:41 -0500
Message-Id: <20220501000543.1368005-2-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220501000543.1368005-1-frowand.list@gmail.com>
References: <20220501000543.1368005-1-frowand.list@gmail.com>
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
 drivers/of/overlay.c | 27 +++++----------------------
 include/linux/of.h   | 13 +++++++++++++
 2 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 64588bff99ce..48c240b06d3b 100644
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
@@ -180,7 +173,7 @@ static int overlay_notify(struct overlay_changeset *ovcs,
 		if (ret) {
 			ret = notifier_to_errno(ret);
 			pr_err("overlay changeset %s notifier error %d, target: %pOF\n",
-			       of_overlay_action_name[action], ret, nd.target);
+			       of_overlay_action_name(action), ret, nd.target);
 			return ret;
 		}
 	}
@@ -927,10 +920,8 @@ static int of_overlay_apply(struct overlay_changeset *ovcs)
 		goto out;
 
 	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
-	if (ret) {
-		pr_err("overlay changeset pre-apply notify error %d\n", ret);
+	if (ret)
 		goto out;
-	}
 
 	ret = build_changeset(ovcs);
 	if (ret)
@@ -953,12 +944,9 @@ static int of_overlay_apply(struct overlay_changeset *ovcs)
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
@@ -1194,10 +1182,8 @@ int of_overlay_remove(int *ovcs_id)
 	}
 
 	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_REMOVE);
-	if (ret) {
-		pr_err("overlay changeset pre-remove notify error %d\n", ret);
+	if (ret)
 		goto err_unlock;
-	}
 
 	ret_apply = 0;
 	ret = __of_changeset_revert_entries(&ovcs->cset, &ret_apply);
@@ -1220,12 +1206,9 @@ int of_overlay_remove(int *ovcs_id)
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

