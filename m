Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79220516113
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 02:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbiEAAJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 20:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237705AbiEAAJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 20:09:21 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE38205D6;
        Sat, 30 Apr 2022 17:05:58 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id m6so9021298iob.4;
        Sat, 30 Apr 2022 17:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fmRz1ww2hntYhSKRq/16Hr+8zlIhz/D9VnEyrgYQiW0=;
        b=jzj3NYMKubS/aJMg5kYwhjzpXtDMXBQxn4A+0O4dLAPeRXAI4YWlqvjNt5/F8lr0tv
         ly1aJjQ2GsoIKz6tfEGKWAZyqaNCp6H6JCSm67dF7MFSnaKH3XJ9FjzPrG+sgTniYrjQ
         Ub3lSACAtRTX/wrWKnHyji7Sif/84qf1YEkmziRk8jVUp7tuPUF5qAUVibnye7dIgG3Y
         47A1Qhv1/6yxkuF//bPvTDjxySDgIpOFl9LXJi8u6emUihrfI3YuwC+l/w5xg2czg18d
         pifw5bSaApdNh560tLUZE5Os8e4npV1qtKo/NJ0MGPYVrOIN5ttf/is5u3OlnmgLIsCK
         UwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fmRz1ww2hntYhSKRq/16Hr+8zlIhz/D9VnEyrgYQiW0=;
        b=XGC60+JlL3XHO3sM+GLSMKzuUgT5mktHJk4kBkiZ0wkIgCFFeSl+3EH+uF3fSeb9gx
         YEdkGcH8uIuCTJ5/atKPKBr1l74LuuVsl0bwKh8wwhR/z7ZnCxaeeMnqqqrmnIFzgJqq
         PF60vLXId0upMrb3ohN8IXuCaeoDLbQ41x74ECl9ZN2QULm7GnwHpHXyMmpbC57ebxyR
         QM+1FcAo9161D6DNfk7wopr8noszmruQKQ6yIRCSd6YZLEYfbzxyb+x5NfwfukHhCusH
         Hb4px/IZjduIdLgpyH0l/h8Jlb+IKm3wXZYPqny3gvhk9avSzCj4QsVV6GDZHgHMPVGu
         l8eA==
X-Gm-Message-State: AOAM531crm/AlGqImcxDflTs8NA5jYyGgxIzVFjG3SPnf/g6ndS0XxId
        WitZAsem8i1PGwfsu+KuO74=
X-Google-Smtp-Source: ABdhPJxSL81YunTahBT5wZ38W0/tBod3rFQZc3VTh1msEut9Ln5nAtLdBw0XzW/nTTadc6zEdW55tg==
X-Received: by 2002:a05:6638:2643:b0:32a:cce3:e533 with SMTP id n3-20020a056638264300b0032acce3e533mr2490754jat.24.1651363557854;
        Sat, 30 Apr 2022 17:05:57 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:809b:de5d:7e0a:bf83])
        by smtp.gmail.com with ESMTPSA id n13-20020a92d9cd000000b002cde6e352dcsm1567160ilq.38.2022.04.30.17.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 17:05:57 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slawomir Stepien <sst@poczta.fm>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] of: overlay: do not free changeset when of_overlay_apply returns error
Date:   Sat, 30 Apr 2022 19:05:43 -0500
Message-Id: <20220501000543.1368005-4-frowand.list@gmail.com>
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

New unittests for overlay notifiers reveal a memory leak in
of_overlay_apply() when a notifier returns an error for action
OF_OVERLAY_POST_APPLY.  The pr_err() message is:

   OF: ERROR: memory leak, expected refcount 1 instead of 3,
   of_node_get()/of_node_put() unbalanced - destroy cset entry: attach
   overlay node /testcase-data/overlay-node/test-bus/test-unittest17

Change the error path to no longer call free_overlay_changeset(),
and document that the caller of of_overlay_fdt_apply() may choose
to remove the overlay.

Update the unittest that triggered the error to expect the changed
return values and to call of_overlay_remove().

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

===

Output of the new overlay notifier unittests, as filtered by
scripts/dtc/of_unittest_expect:

   ### dt-test ### pass of_unittest_overlay_notify():2825
ok OF: overlay: overlay changeset pre-apply notifier error -16, target: /testcase-data/overlay-node/test-bus
   ### dt-test ### pass of_unittest_overlay_notify():2846
   ### dt-test ### pass of_unittest_overlay_notify():2851
ok OF: overlay: overlay changeset post-apply notifier error -17, target: /testcase-data/overlay-node/test-bus
   ### dt-test ### pass of_unittest_overlay_notify():2857
   ### dt-test ### pass of_unittest_overlay_notify():2862
   ### dt-test ### pass of_unittest_overlay_notify():2866
   ### dt-test ### pass of_unittest_overlay_notify():2872
   ### dt-test ### pass of_unittest_overlay_notify():2875
ok OF: overlay: overlay changeset pre-remove notifier error -18, target: /testcase-data/overlay-node/test-bus
   ### dt-test ### pass of_unittest_overlay_notify():2886
   ### dt-test ### pass of_unittest_overlay_notify():2894
   ### dt-test ### pass of_unittest_overlay_notify():2898
   ### dt-test ### pass of_unittest_overlay_notify():2901
ok OF: overlay: overlay changeset post-remove notifier error -19, target: /testcase-data/overlay-node/test-bus
   ### dt-test ### pass of_unittest_overlay_notify():2908
   ### dt-test ### pass of_unittest_overlay_notify():2915
   ### dt-test ### pass of_unittest_overlay_notify():2920
   ### dt-test ### pass of_unittest_overlay_notify():2932


 drivers/of/overlay.c  | 29 ++++++++++++++++++++++++++---
 drivers/of/unittest.c | 10 ++++++++--
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 48c240b06d3b..4c1ac36216b8 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -954,6 +954,25 @@ static int of_overlay_apply(struct overlay_changeset *ovcs)
 	return ret;
 }
 
+/*
+ * of_overlay_fdt_apply() - Create and apply an overlay changeset
+ * @overlay_fdt:	pointer to overlay FDT
+ * @overlay_fdt_size:	number of bytes in @overlay_fdt
+ * @ret_ovcs_id:	pointer for returning created changeset id
+ *
+ * Creates and applies an overlay changeset.
+ *
+ * See of_overlay_apply() for important behavior information.
+ *
+ * Return: 0 on success, or a negative error number.  *@ret_ovcs_id is set to
+ * the value of overlay changeset id, which can be passed to of_overlay_remove()
+ * to remove the overlay.
+ *
+ * On error return, the changeset may be partially applied.  This is especially
+ * likely if an OF_OVERLAY_POST_APPLY notifier returns an error.  In this case
+ * the caller should call of_overlay_remove() with the value in *@ret_ovcs_id.
+ */
+
 int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 			 int *ret_ovcs_id)
 {
@@ -1021,15 +1040,19 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 	ovcs->overlay_mem = overlay_mem;
 
 	ret = of_overlay_apply(ovcs);
-	if (ret < 0)
-		goto err_free_ovcs;
+	/*
+	 * If of_overlay_apply() error, calling free_overlay_changeset() may
+	 * result in a memory leak if the apply partly succeeded, so do NOT
+	 * goto err_free_ovcs.  Instead, the caller of of_overlay_fdt_apply()
+	 * can call of_overlay_remove();
+	 */
 
 	mutex_unlock(&of_mutex);
 	of_overlay_mutex_unlock();
 
 	*ret_ovcs_id = ovcs->id;
 
-	return 0;
+	return ret;
 
 err_free_ovcs:
 	free_overlay_changeset(ovcs);
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index e28c3df2c4c2..dff55ae09d97 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2848,7 +2848,7 @@ static void __init of_unittest_overlay_notify(void)
 
 	EXPECT_END(KERN_INFO, "OF: overlay: overlay changeset pre-apply notifier error -16, target: /testcase-data/overlay-node/test-bus");
 
-	unittest(!ovcs_id, "ovcs_id created for overlay_16\n");
+	unittest(ovcs_id, "ovcs_id not created for overlay_16\n");
 
 	/* ---  overlay 17  --- */
 
@@ -2859,7 +2859,13 @@ static void __init of_unittest_overlay_notify(void)
 
 	EXPECT_END(KERN_INFO, "OF: overlay: overlay changeset post-apply notifier error -17, target: /testcase-data/overlay-node/test-bus");
 
-	unittest(!ovcs_id, "ovcs_id created for overlay_17\n");
+	unittest(ovcs_id, "ovcs_id not created for overlay_17\n");
+
+	if (ovcs_id) {
+		ret = of_overlay_remove(&ovcs_id);
+		unittest(!ret,
+			"overlay_17 of_overlay_remove(), ret = %d\n", ret);
+	}
 
 	/* ---  overlay 18  --- */
 
-- 
Frank Rowand <frank.rowand@sony.com>

