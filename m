Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A3C4B3DBE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 22:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbiBMVcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 16:32:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiBMVcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 16:32:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EA7254189
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 13:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644787956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/I6i6PhENZxx4r+JP2+zfrQVFZUTWDwnQ0+wWoj72BQ=;
        b=bJWZrXfvz0jfdsjrNfTmMqCIGnZ+/bIDJQwrY/yf7ECPtDsT6pJJJkMKf4U+bpPIMzWnV7
        Q3jmwFFisWm5j7slW6lD7Xnuvpi3xMp3ufm6Xwwy9Pkf6BU0m3VLa2pTfc1yRNP1P2i1p7
        WwddRqP9CMRi/7UGr/7LPLBzhauYHxk=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-UfXiszTzOl-4OgPi4qSWsg-1; Sun, 13 Feb 2022 16:32:35 -0500
X-MC-Unique: UfXiszTzOl-4OgPi4qSWsg-1
Received: by mail-ot1-f69.google.com with SMTP id n99-20020a9d206c000000b00590dde2cca8so9226989ota.9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 13:32:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/I6i6PhENZxx4r+JP2+zfrQVFZUTWDwnQ0+wWoj72BQ=;
        b=wfb07EfC5lPVyNaiUzKjDi1NNjzbrhOaHDBzqY6IH63u+Y6xcSUcy6V4ZbOey0uXLY
         jpkUjX0qFPKjUrj30E0DT/0jQTsDV4T8qlozUnG+9JRaBEOSxuDlGBvGmLLXNPMKY6wO
         SKLsOx8LtpYfGk5Ji7AZmWS9Mxe+SDFirM07MMezG9UnK9xaXzyoB1WvzHXwZLq6RZLH
         wHgflJpPQEK2tCjzNP9csXB7bd5M8xQ/HnSFxyxvK5k+E1zt26PPmUpoAVrRburGaOIx
         mWMy693QGnVnBt26j6LNS3dJaTOajmWJDxdZ3XrrfPuonSzV5VipTAQ3QbFq7PL4EDfw
         WJyQ==
X-Gm-Message-State: AOAM530rxUZTwHDBdkv9QHDY8Vmi8ypLf7iL/Plr7yG/C+3jVgsBhkm8
        PQi5YeiTK0rDJiEhQOfgqxu7sf0im1AeAbp9m6qEEJ5xRG2i5lSWea2hTaeIVea+pepeSi2/4te
        TLW5OQSX/LmhfAqqfEm3EmL6b
X-Received: by 2002:a05:6870:9513:: with SMTP id u19mr3117033oal.306.1644787954641;
        Sun, 13 Feb 2022 13:32:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwf8m3PM0Q+IByx9JRSjUHD8ba4ddxKwsH+XNREuYDXRmRjodxeXKoo+nFYHjXqi6suXy/d4w==
X-Received: by 2002:a05:6870:9513:: with SMTP id u19mr3117030oal.306.1644787954514;
        Sun, 13 Feb 2022 13:32:34 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id q4sm11650306otk.39.2022.02.13.13.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 13:32:34 -0800 (PST)
From:   trix@redhat.com
To:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] apparmor: fix aa_label_asxprint return check
Date:   Sun, 13 Feb 2022 13:32:28 -0800
Message-Id: <20220213213228.2806682-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this issue
label.c:1802:3: warning: 2nd function call argument
  is an uninitialized value
  pr_info("%s", str);
  ^~~~~~~~~~~~~~~~~~

str is set from a successful call to aa_label_asxprint(&str, ...)
On failure a negative value is returned, not a -1.  So change
the check.

Fixes: f1bd904175e8 ("apparmor: add the base fns() for domain labels")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 security/apparmor/label.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index 9eb9a9237926..a658b67c784c 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -1744,7 +1744,7 @@ void aa_label_xaudit(struct audit_buffer *ab, struct aa_ns *ns,
 	if (!use_label_hname(ns, label, flags) ||
 	    display_mode(ns, label, flags)) {
 		len  = aa_label_asxprint(&name, ns, label, flags, gfp);
-		if (len == -1) {
+		if (len < 0) {
 			AA_DEBUG("label print error");
 			return;
 		}
@@ -1772,7 +1772,7 @@ void aa_label_seq_xprint(struct seq_file *f, struct aa_ns *ns,
 		int len;
 
 		len = aa_label_asxprint(&str, ns, label, flags, gfp);
-		if (len == -1) {
+		if (len < 0) {
 			AA_DEBUG("label print error");
 			return;
 		}
@@ -1795,7 +1795,7 @@ void aa_label_xprintk(struct aa_ns *ns, struct aa_label *label, int flags,
 		int len;
 
 		len = aa_label_asxprint(&str, ns, label, flags, gfp);
-		if (len == -1) {
+		if (len < 0) {
 			AA_DEBUG("label print error");
 			return;
 		}
-- 
2.26.3

