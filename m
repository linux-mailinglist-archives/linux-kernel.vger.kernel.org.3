Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63874EE423
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242528AbiCaWhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240705AbiCaWhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:37:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61E71C8A8E;
        Thu, 31 Mar 2022 15:35:47 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id p15so2199679ejc.7;
        Thu, 31 Mar 2022 15:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nik1iTbxoUWnG6UF8WspcQRjvneqvZ965qd0fvy6u0Q=;
        b=onwlNXEfsXY5267AxROmbVgwPHyozyAkfW/eFrSTJ29X2muD4OpT4LcAzhalPbQd/b
         CKKvVbnuI0cwUFkWWUdzbnGsJSK/fRV89XUWiC/WnV/yncPvIhtMQLgUICGaLathnPov
         SQyfqPvBUDIKdjR1LnGVk9ymAD/jMYdQ11bhYyZ6DboyOFk2Q51P/4WpDFx66Om+IUPr
         oLc4SWKuRN472tKQAwpou0cQPzrxZnWOpoX0P8iqr85CgjGt3djEDjxAQwAcR9K779Qe
         brkBa++inBLdnrRA2nDX/4m88mHASicccPQr2P8VaqCzfDtNDb6I/AVh+jqSYcSwCVvh
         1sfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nik1iTbxoUWnG6UF8WspcQRjvneqvZ965qd0fvy6u0Q=;
        b=k0Sk+aWfmTpdSHV5Fl8BjCF9aAhkfiHjwn7gpm0EITMz9pMBEbP7v/DSK68T/3UzBg
         htSUJWqVtblriVSv72bct7MjRbTz2xlICoq8uqsyen3bHQULkKTIIOUKxHn3sw/wrKYx
         ux7pieF0pm6LoXv2sRsbVOJzgOa0f4TEg8DfCWV3PysuXRx9P+B9qh8dy9Z0G8jywMr4
         R0HT2I/abgakujS1xJRMiaJq+pXpmW6P47eIm9XhCTvm/hFu1U4N1c9sp6xeKWLL3tPU
         pEIibWl5kjxG7xEDuGLf7DjqHRFXmmg/iAln0szg/otOAoVRywUq46RMbgw63Wy2Zj+S
         ifww==
X-Gm-Message-State: AOAM5304QjDr8rHJAu+kAULSImKhHqVV499TKpRBfk1Cmt3X8ks0ZCxO
        Ba9E68NtNPWXajvHQYTQ+RzbHS9rEP1uJSpS
X-Google-Smtp-Source: ABdhPJwvadEyXeLejHBvKE54rjB5jVViHNh1B2AJIl0ecn//oet1U6QeTVIECiwaHI2D6i+E5n0PVw==
X-Received: by 2002:a17:907:9725:b0:6e0:b274:aa4c with SMTP id jg37-20020a170907972500b006e0b274aa4cmr6900584ejc.565.1648766146417;
        Thu, 31 Mar 2022 15:35:46 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id p14-20020a05640210ce00b00413211746d4sm337761edu.51.2022.03.31.15.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:35:46 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] video: fbdev-MMP: replace usage of found with dedicated list iterator variable
Date:   Fri,  1 Apr 2022 00:35:03 +0200
Message-Id: <20220331223503.902142-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/video/fbdev/mmp/core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/mmp/core.c b/drivers/video/fbdev/mmp/core.c
index 154127256a2c..03707461eced 100644
--- a/drivers/video/fbdev/mmp/core.c
+++ b/drivers/video/fbdev/mmp/core.c
@@ -127,19 +127,18 @@ EXPORT_SYMBOL_GPL(mmp_unregister_panel);
  */
 struct mmp_path *mmp_get_path(const char *name)
 {
-	struct mmp_path *path;
-	int found = 0;
+	struct mmp_path *path = NULL, *iter;
 
 	mutex_lock(&disp_lock);
-	list_for_each_entry(path, &path_list, node) {
-		if (!strcmp(name, path->name)) {
-			found = 1;
+	list_for_each_entry(iter, &path_list, node) {
+		if (!strcmp(name, iter->name)) {
+			path = iter;
 			break;
 		}
 	}
 	mutex_unlock(&disp_lock);
 
-	return found ? path : NULL;
+	return path;
 }
 EXPORT_SYMBOL_GPL(mmp_get_path);
 

base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
-- 
2.25.1

