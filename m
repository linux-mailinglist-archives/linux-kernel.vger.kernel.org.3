Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F393955E85E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346773AbiF1Nnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346861AbiF1Nnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:43:39 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DB818B2B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:43:38 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id c6-20020a17090abf0600b001eee794a478so5268690pjs.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1981ByijFES4Z51VKfKpaqL9mzBb3Klm3MJNFz1LN/Q=;
        b=iMtXOFUICTVdHSxy2et3XQLWdCcymKIrE960JXJYygPsX5hsTLgbjSqlUp1MZ0oKJj
         GZ9FKM1BFHNVuCEzkdqzhTvB3jSr0s7hIYI4u7Bm6ALCT3IoE/xYDEmiTE018aJaWO21
         N8aEK79WNO3k+e2nm2zmHYMDSdOblAmciiv4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1981ByijFES4Z51VKfKpaqL9mzBb3Klm3MJNFz1LN/Q=;
        b=kUmJW2uVyhhVAd6Jabi49q+cSaNFuQy9AbdvV4JUDcZkoDkr7nvOh1mpEgyLYEvnsd
         qJShqyEdjbsuga2S3uZGho/kHoYKUdSUWdW6aI84XeprrrOfdJuEkRLyHuvmKIWTXeBf
         mNeE2gBk7GSzr45oC1X3VrYeiysybwiT7Np70WY6b93xjuduatHHH6cUvI45zxy09s6u
         hY37QkPY/k2RP1mBbEOLBEk3kaqYc1kauxmgRUjRh82J7OTchD4a11bPnfI0VCYwI7xL
         rmJ37o0tR3XSVBefOEMtPnE6crOZtLFZlZ21fv6469xtc2VYMVuDFXOZ0UXAHJmB0bpa
         YmDg==
X-Gm-Message-State: AJIora97PEfs9p1myMXnKuwPYSrekhTlyLRLFE7JO04VycmqBnvzrY+k
        VMpSWfZwbneBsW3JAEKro04dDg==
X-Google-Smtp-Source: AGRyM1vROI5ZbSMg9ZLu8nsfvS9fFnxl9Zl5EGmk1xq1YkMOpWjVrGZOnWDOJo4m81UOSjjVVba8XQ==
X-Received: by 2002:a17:90a:ab16:b0:1ed:2251:a878 with SMTP id m22-20020a17090aab1600b001ed2251a878mr22439498pjq.231.1656423817685;
        Tue, 28 Jun 2022 06:43:37 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:18c2:6594:17be:c241])
        by smtp.gmail.com with ESMTPSA id 22-20020aa79116000000b00527af57598fsm3107197pfh.43.2022.06.28.06.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 06:43:37 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] soc: qcom: cmd-db: replace strscpy_pad() with strncpy()
Date:   Tue, 28 Jun 2022 06:43:13 -0700
Message-Id: <20220628064301.v3.1.Ie7b480cd99e2c13319220cbc108caf2bcd41286b@changeid>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ac0126a01735 ("soc: qcom: cmd-db: replace strncpy() with
strscpy_pad()") breaks booting on my sc7280-herobrine-herobrine
device. From printouts I see that at bootup the function is called
with an id of "lnbclka2" which is 8 bytes big.

Previously all 8 bytes of this string were copied to the
destination. Now only 7 bytes will be copied since strscpy_pad() saves
a byte for '\0' termination.

We don't need the '\0' termination in the destination. Let's go back
to strncpy(). According to the warning:
  If a caller is using non-NUL-terminated strings, strncpy() can still
  be used, but destinations should be marked with the __nonstring
  attribute to avoid future compiler warnings.
...so we'll do that.

While we're at it, let's change the query array to use
"sizeof(ent->id)" so it can't possibly go out of sync with our later
copy.

Fixes: ac0126a01735 ("soc: qcom: cmd-db: replace strncpy() with strscpy_pad()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v3:
- Add comment that query isn't necessarily '\0' terminated.

Changes in v2:
- Size array with "sizeof(ent->id)"

 drivers/soc/qcom/cmd-db.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index c5137c25d819..629a7188b576 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -141,14 +141,18 @@ static int cmd_db_get_header(const char *id, const struct entry_header **eh,
 	const struct rsc_hdr *rsc_hdr;
 	const struct entry_header *ent;
 	int ret, i, j;
-	u8 query[8];
+	u8 query[sizeof(ent->id)] __nonstring;
 
 	ret = cmd_db_ready();
 	if (ret)
 		return ret;
 
-	/* Pad out query string to same length as in DB */
-	strscpy_pad(query, id, sizeof(query));
+	/*
+	 * Pad out query string to same length as in DB. NOTE: the output
+	 * query string is not necessarily '\0' terminated if it bumps up
+	 * against the max size. That's OK and expected.
+	 */
+	strncpy(query, id, sizeof(query));
 
 	for (i = 0; i < MAX_SLV_ID; i++) {
 		rsc_hdr = &cmd_db_header->header[i];
-- 
2.37.0.rc0.161.g10f37bed90-goog

