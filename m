Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5D351766B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386853AbiEBSVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386818AbiEBSV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:21:26 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8F1109B;
        Mon,  2 May 2022 11:17:56 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id d3so8376935ilr.10;
        Mon, 02 May 2022 11:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TJq9Y2j2hvjQOKUEqQsEklHfEq8wyddeCa52aAthpsM=;
        b=MS4i9i1M056zAMef/ia3Kh2Ot8KqLzlLj/J45yrFWVW24uDlE6Z0y2tVYgqVda2Cn+
         C6WZYHLf8VGwgAjuTIIwJYqeVdiDAaKiZ2kcJ3pZIaS2E23A3ZEFrRQ+Udt7ogYJGTNx
         7Mf7Vhyp8dOy2FQwegmEH3mkNxXempihpLIAVn8/l4D6ocM5lWJu/0OX14RaJWOMQeac
         T+GcTUpqwQVE3JMFWAH7QMzX5ZdyWQ3YiWKo2F4drMn27LDVxnc87pN2BGlbQQttctqu
         QX7hJhI1iMRST6wgZDyPjUn3Duwyi0S2G8d6X//9lo1pNysN899eGHtx51DqHzeIXRCV
         VYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TJq9Y2j2hvjQOKUEqQsEklHfEq8wyddeCa52aAthpsM=;
        b=K9uhBvcSjrPbUp7WtOfY9+ENNl7XUg3L6n+tf2jbGzLhOlzMTVcmkZxxr7MVOgFtvq
         sqMgKnct5Pi/xWq7oPFcpHG+56c0i6HTmlOjjD/SeXRCHWPrNeMTAz083Ukk+IhD95Q0
         xtvZ3fCmzEP4qlXMbDIOnEJmTgSa1YhXDryVc7Rt6F/K9K6uvd2fPKS79/rFl03UT2/7
         Jf3+MkXXRp+ja2ZId68Ukar1DAYcizxYem2n2UunUR9QuJ+YnL/pdSCvpujWz8ae4vxc
         fUOwOC9Je2rG4MCCOMSw5TgyqauOaVgAWbwUidO1luD4F6fx4BRi1R/BflsAcudqJcdf
         pYwQ==
X-Gm-Message-State: AOAM530Mv21mbNakcgKUHgtsbwOy//yh4sn+v+5DLfKbjkwDcZith0Qr
        SEgs4d3qA00adaHagnlCej8=
X-Google-Smtp-Source: ABdhPJxd7u0XnbmXPnGFaxJCsYXOLdMq3rXoAV+PBXFZY5be3h+QpLTuU5xzRSvXpmRQouSr1Clojw==
X-Received: by 2002:a05:6e02:152b:b0:2cd:ffb6:59bf with SMTP id i11-20020a056e02152b00b002cdffb659bfmr4617792ilu.180.1651515476048;
        Mon, 02 May 2022 11:17:56 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:2d25:3fcb:9ffb:5d5a])
        by smtp.gmail.com with ESMTPSA id f43-20020a02242b000000b0032b3a7817a9sm3230678jaa.109.2022.05.02.11.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 11:17:55 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slawomir Stepien <sst@poczta.fm>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 3/3] of: overlay: do not free changeset when of_overlay_apply returns error
Date:   Mon,  2 May 2022 13:17:42 -0500
Message-Id: <20220502181742.1402826-4-frowand.list@gmail.com>
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
Changes since version 1:
  - patch 1/1 v1 did not apply on Rob's dt/next branch, rebase on top of
    5f756a2eaa44 of: overlay: do not break notify on NOTIFY_{OK|STOP}

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
index ae5ea5b1079b..4044ddcb02c6 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -952,6 +952,25 @@ static int of_overlay_apply(struct overlay_changeset *ovcs)
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
@@ -1019,15 +1038,19 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
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

