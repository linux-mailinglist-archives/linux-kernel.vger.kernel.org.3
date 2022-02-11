Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125F64B2572
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349928AbiBKMPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:15:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349926AbiBKMPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:15:46 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA588F59
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:15:44 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id p5-20020a170902bd0500b00148cb2d29ecso3217590pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dHcRBMyYOzUwhslp5JRE655B9xCzIebKFjgXEXXATO4=;
        b=KByLTW8roR7b/NsGCj8KMJC8GU7G4BMRSMdx4gOMyWClsbzAJNpymM1x4Wd1ISttSQ
         7v+LCjeOaKaoaSqOwYupW16di9rAp5Mcn1DYAh4QvsBrDgilYFcx83J9LAk73ZHTwufX
         mp8kzHEZeLPFaaVBV/HItgbLfcQVFbCZ7LoN/ewSXazk0x3gZxrtknjG3KmzlI+xT6F0
         5Fvp4rRdBZj9246kq3sDuBzKtK7bMFoD8RWnkJkz3Gqpin2rcn5VD1rgC7qU1WO91JHx
         dAKdDhjAalEgEL+RzkfZww5rUWly4cp5y0T+jBsHm5GbsASZ/r/9MrLSgbzg8nmwZxDr
         U+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dHcRBMyYOzUwhslp5JRE655B9xCzIebKFjgXEXXATO4=;
        b=pf7iAq0qULQ+zHSKt+tGyZ7WaTmiuf29fCEJIKUEWXnhnMW8Ls8gQIlzJrp5WeQtKY
         s6w/KZkVWLJ7HU65oz/FQTbuPhJRvdu/+IQ4j8zfZMytE/IfglOCp7H09dqqtobRYC5l
         hyMGqtaj8BYgf7Htgi9As2+YslcHQaVyY+nMfbxF7ZT9dU9eWNdvi7olIdm5yuFBtcMq
         9LNcbp6CSVP6oPX87c0Z98kmsc4ityPH4rAqYuQhb12ihyiI4vRagDh0HODWTJpAokHq
         XYXkyQePeRSwVrsWiSqk94jF5z4G1pkqpI7fFf8akGb1+vMIVDLr/97WSaivceIuGdGa
         0isQ==
X-Gm-Message-State: AOAM532kEaQmoNsvI7vTSDSNN+HPHdyeIG1a7/EaVbTIFR/jKlNvVHTz
        VaU59c9ImVM1K90A9vlTNqDCXp68k5q/
X-Google-Smtp-Source: ABdhPJy7sBPtRxK0skNt82llh8Dm6SEUyT6OPVuRpGC7qERJhH/4cznimN+5yN/os6Q6UDXSavGQkZ2g6g+7
X-Received: from ezekiel.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:108e])
 (user=shraash job=sendgmr) by 2002:a17:90a:e7ce:: with SMTP id
 kb14mr75272pjb.202.1644581744235; Fri, 11 Feb 2022 04:15:44 -0800 (PST)
Date:   Fri, 11 Feb 2022 12:15:38 +0000
Message-Id: <20220211121538.1636240-1-shraash@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH] dm crypt: fixed compiler warning in conditional expression
From:   Aashish Sharma <shraash@google.com>
To:     Alasdair Kergon <agk@redhat.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        Aashish Sharma <shraash@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly converting unsigned int in the right of the
conditional expression to int to match the left side operand
and the return type, fixing the following compiler warning:

drivers/md/dm-crypt.c:2593:43: warning: signed and unsigned
type in conditional expression [-Wsign-compare]

Signed-off-by: Aashish Sharma <shraash@google.com>
---
 drivers/md/dm-crypt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index d4ae31558826..489b23cb37c3 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2590,7 +2590,8 @@ static int crypt_set_keyring_key(struct crypt_config *cc, const char *key_string
 
 static int get_key_size(char **key_string)
 {
-	return (*key_string[0] == ':') ? -EINVAL : strlen(*key_string) >> 1;
+	return (*key_string[0] == ':') ? -EINVAL
+				: (int)(strlen(*key_string) >> 1);
 }
 
 #endif /* CONFIG_KEYS */
-- 
2.35.1.265.g69c8d7142f-goog

