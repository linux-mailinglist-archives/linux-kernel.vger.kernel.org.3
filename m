Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D09655CDB5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242432AbiF1ASl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 20:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238984AbiF1ASh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:18:37 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6490663EB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 17:18:34 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id k14so9616349plh.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 17:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cb42boPy1G1/5Oq0/d+fF1u+WVmX2leD5qZiodotCIE=;
        b=Di/8PzeuQjGITwPzQck0cLBCACqwOY9vVvNW4SuMuVueccNd876kEWZz25qObwdpHP
         EcrYtnu9yqated8h1s5YlFl//qhF1M11m/6bvHhS5ZRHCDwW89wAX7Eqpb+jvgInw7bC
         SDlWjT31LraalaCVyFyGybU9tlKtgvSpSXtII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cb42boPy1G1/5Oq0/d+fF1u+WVmX2leD5qZiodotCIE=;
        b=r8u2VuRRxZ7psuenKFutqGJHoXIJUAPdEGDJcqZv7SzAmFCEacbiGGGNIJonaunUqC
         rJrmYnbTGrLI6IFzUoxSefu+cUNtzgIwhWmBTWQz69UfWPR7M76Y2xL+GDCwlL4uCw38
         lps2ZI4o7F52fTUkVgoXjTmXqrMN8UFbtLwlHJecCHPlVXzdCD4tEtc1hCL+dGsM3r9C
         f/xPSn++6dBTE4yatf2pRlTgSTwnvQMRBPcUC/RwIMbiY2A3RD5bK6rcaOOuEKebtaFA
         Ujsurlw/mx6669HtUIlyOyRpJjbZlctyNHlloNpFdBfqBgY3x821l2WRjIaSJH0LT0mS
         ueSg==
X-Gm-Message-State: AJIora9papOdH3Su3r/C2SHkiap3Dz+vG7mD6EqDi2lA9X9IUTQZ+4jq
        tGy9Y1Tv5cq+gKemP6mI1UmE+w==
X-Google-Smtp-Source: AGRyM1vqpJj3o338WU9NKhAyPbugDeASo72cZie953H7mClxPONahvkDajKKa7FWGJfS4VtK1Iq8+g==
X-Received: by 2002:a17:902:c94b:b0:16a:3f98:84fd with SMTP id i11-20020a170902c94b00b0016a3f9884fdmr2124658pla.70.1656375513959;
        Mon, 27 Jun 2022 17:18:33 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:18c2:6594:17be:c241])
        by smtp.gmail.com with ESMTPSA id jj2-20020a170903048200b0016a4db1343fsm7780149plb.190.2022.06.27.17.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 17:18:33 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] soc: qcom: cmd-db: replace strscpy_pad() with strncpy()
Date:   Mon, 27 Jun 2022 17:18:27 -0700
Message-Id: <20220627171816.v2.1.Ie7b480cd99e2c13319220cbc108caf2bcd41286b@changeid>
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

---

Changes in v2:
- Size array with "sizeof(ent->id)"

 drivers/soc/qcom/cmd-db.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index c5137c25d819..ffd2660b2890 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -141,14 +141,14 @@ static int cmd_db_get_header(const char *id, const struct entry_header **eh,
 	const struct rsc_hdr *rsc_hdr;
 	const struct entry_header *ent;
 	int ret, i, j;
-	u8 query[8];
+	u8 query[sizeof(ent->id)] __nonstring;
 
 	ret = cmd_db_ready();
 	if (ret)
 		return ret;
 
 	/* Pad out query string to same length as in DB */
-	strscpy_pad(query, id, sizeof(query));
+	strncpy(query, id, sizeof(query));
 
 	for (i = 0; i < MAX_SLV_ID; i++) {
 		rsc_hdr = &cmd_db_header->header[i];
-- 
2.37.0.rc0.161.g10f37bed90-goog

