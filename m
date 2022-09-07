Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57415B0E2D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiIGUbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiIGUbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:31:05 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1A3A8CDE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 13:31:04 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so114047pjh.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 13:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=6pTFRiLK72lDLdL/CFtwCq6GJd3SSyre7C8utHPxd+4=;
        b=fvL/o8B1ENY3XHHeVrn/YgUX6sbs4i4wkEy6cHe09y4QFdkPVA4E9R/TSlNItba4wZ
         DS1TRmY8StylFp0fThfo8H9qlliuIHD+9CcdLaWW/YebyUEXh47hMRH13qvciTJ7NfkP
         SENfaYeiSPd7zeBmlKcnJP+4hdwNLiVxYYC6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=6pTFRiLK72lDLdL/CFtwCq6GJd3SSyre7C8utHPxd+4=;
        b=7axCKuWl/QFXx7JcBGKFzuXqGisMWphTaUPuqvz5fSYmXMNdxock1Z8BH3PlqrbeYd
         oLtH5fE5jBOLye1s8+JIV9RUyaoNzWYDzZe9ngzvCm6QrvjVAi7zIHJxm7jcB70wexBf
         K5O9qh/AwjoCz/SDCqXXUFcL02srZe7A9D2es6Vk8TGVwmx+R27KOhPRQMuODYF2DFqL
         lHEsIFbuNxXegvhGLb1XgmSPmOH2IOZAl+388jMWPj0R8vzdcIEtHEMJaXwKcEZ8mMsX
         hF6FCyQyhbnzpyKcbyLTz74b7cZNeQ+3Yf/TrNAm1wfeabUtwv+4a29V6NJEYoPPNOK3
         eYqQ==
X-Gm-Message-State: ACgBeo3fXEgBzvr+UZPg0AEkJqmAkbWDqm0NiC6XM5eJoQPDlw37ydsk
        mHhSVpHuFQAxTnHcT0CkGUz19w==
X-Google-Smtp-Source: AA6agR4Jj+aDoQUpu0UnfmMWUM+18y8TybSFaxZUO1YTlB7aUNe4vRMzcskBpJQXeKKRvJ290Hr/3w==
X-Received: by 2002:a17:90a:aa87:b0:200:68d8:17b8 with SMTP id l7-20020a17090aaa8700b0020068d817b8mr313448pjq.110.1662582663653;
        Wed, 07 Sep 2022 13:31:03 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:7731:4d19:a7d1:20d])
        by smtp.gmail.com with UTF8SMTPSA id ik20-20020a170902ab1400b001769e7062c0sm8955667plb.249.2022.09.07.13.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 13:31:03 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org,
        Sarthak Kukreti <sarthakkukreti@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] dm: verity-loadpin: Only trust verity targets with enforcement
Date:   Wed,  7 Sep 2022 13:30:58 -0700
Message-Id: <20220907133055.1.Ic8a1dafe960dc0f8302e189642bc88ebb785d274@changeid>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Verity targets can be configured to ignore corrupted data blocks.
LoadPin must only trust verity targets that are configured to
perform some kind of enforcement when data corruption is detected,
like returning an error, restarting the system or triggering a
panic.

Fixes: b6c1c5745ccc ("dm: Add verity helpers for LoadPin")
Reported-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/md/dm-verity-loadpin.c |  8 ++++++++
 drivers/md/dm-verity-target.c  | 16 ++++++++++++++++
 drivers/md/dm-verity.h         |  1 +
 3 files changed, 25 insertions(+)

diff --git a/drivers/md/dm-verity-loadpin.c b/drivers/md/dm-verity-loadpin.c
index 387ec43aef72..4f78cc55c251 100644
--- a/drivers/md/dm-verity-loadpin.c
+++ b/drivers/md/dm-verity-loadpin.c
@@ -14,6 +14,7 @@ LIST_HEAD(dm_verity_loadpin_trusted_root_digests);
 
 static bool is_trusted_verity_target(struct dm_target *ti)
 {
+	int verity_mode;
 	u8 *root_digest;
 	unsigned int digest_size;
 	struct dm_verity_loadpin_trusted_root_digest *trd;
@@ -22,6 +23,13 @@ static bool is_trusted_verity_target(struct dm_target *ti)
 	if (!dm_is_verity_target(ti))
 		return false;
 
+	verity_mode = dm_verity_get_mode(ti);
+
+	if ((verity_mode != DM_VERITY_MODE_EIO) &&
+	    (verity_mode != DM_VERITY_MODE_RESTART) &&
+	    (verity_mode != DM_VERITY_MODE_PANIC))
+		return false;
+
 	if (dm_verity_get_root_digest(ti, &root_digest, &digest_size))
 		return false;
 
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 94b6cb599db4..8a00cc42e498 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -1446,6 +1446,22 @@ bool dm_is_verity_target(struct dm_target *ti)
 	return ti->type->module == THIS_MODULE;
 }
 
+/*
+ * Get the verity mode (error behavior) of a verity target.
+ *
+ * Returns the verity mode of the target, or -EINVAL if 'ti' is not a verity
+ * target.
+ */
+int dm_verity_get_mode(struct dm_target *ti)
+{
+	struct dm_verity *v = ti->private;
+
+	if (!dm_is_verity_target(ti))
+		return -EINVAL;
+
+	return v->mode;
+}
+
 /*
  * Get the root digest of a verity target.
  *
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index 45455de1b4bc..98f306ec6a33 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -134,6 +134,7 @@ extern int verity_hash_for_block(struct dm_verity *v, struct dm_verity_io *io,
 				 sector_t block, u8 *digest, bool *is_zero);
 
 extern bool dm_is_verity_target(struct dm_target *ti);
+extern int dm_verity_get_mode(struct dm_target *ti);
 extern int dm_verity_get_root_digest(struct dm_target *ti, u8 **root_digest,
 				     unsigned int *digest_size);
 
-- 
2.37.2.789.g6183377224-goog

