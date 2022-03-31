Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48864EE375
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241972AbiCaVvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbiCaVvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:51:36 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CA85E779
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:49:48 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g20so832282edw.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qGMBrUlPQYOKyx37WJ+CfAZb6HqK2marpAbff4MbnZ8=;
        b=aH/mGSIx6JYuCSnhq67DpbCnoI8R9U2DwIHvu2o8j1p7edTV/pvvLSCRs/VGoNPAlo
         a37NWAofXqtZ3OenGsky7Zi238NZPpW0UQQjqSfH/GSJd+rK1TAlzcMK6TX/Y7KhwQ99
         u8F8/MzXNiodsFeO0VhdCXjH8PQmeJ/qpvaY2r1NIhvlJc5kJqXNY1aYX2joACdxuOCw
         5oz+su87Ri/pROAw9FRbGVz5Ot8RjHNHTPW4W7LANksi6yA1X5kFJels8TS4oLKEPR+I
         dPXON4cFOOdDZ2LsTZIfueKaPIZHZ/i89eoFSDGbnfedTcNXCPMtv3qyvKQgWek1W8N+
         ALhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qGMBrUlPQYOKyx37WJ+CfAZb6HqK2marpAbff4MbnZ8=;
        b=iIc3Z5XDViBz/SGPBfqT/ypn593CaugPZP0MqcbjMdHYp3qtqX1QBf2ciGEbts2u4k
         iXAmtMsUaWgjE19vl/AVkG/FQ8cbGuvnjkXKSz2neC6mlCZPQ3KzISjW+UUe0e8W9rKs
         KL8TBWLBe6eUY7inLgugeTn7Yo4Xf5oJRP62kh1vzXGB1SJCBWc6bD/dSSTKKE6stnGh
         WyyfW8EstdNPuvKcJXGfnjIPbktbI5d2cM8QUDBt6gZDWnJGudgJtwW64v32sSZ+Wez6
         VcpyWZYXOrS5eTJ/qHzMBTkFc1KtGncjaQujZ9If6f2W5iWbOBz7piMyznlaN0If+czs
         O2vw==
X-Gm-Message-State: AOAM5331oLRhmKst67u3Vd09q7igOpHW0J3sQDf1hQMfWulxQ1kcE3sq
        bnetuf5pBfQocUa1l9AXfcM=
X-Google-Smtp-Source: ABdhPJy2B7AopM0KwTEyzhYtq/KyNtb8dGx4YMfBVqHpLP6gMbPpPqTM2nzyADNvNK2RpvmoIjwoZQ==
X-Received: by 2002:a05:6402:847:b0:419:7fb0:9e29 with SMTP id b7-20020a056402084700b004197fb09e29mr18299068edz.45.1648763387245;
        Thu, 31 Mar 2022 14:49:47 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id b8-20020a056402350800b00419407f0dd9sm311698edd.0.2022.03.31.14.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:49:46 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Russell King <linux@armlinux.org.uk>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH 2/3] ARM: pxa: ssp: remove check of list iterator against head past the loop body
Date:   Thu, 31 Mar 2022 23:47:18 +0200
Message-Id: <20220331214719.881886-2-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331214719.881886-1-jakobkoschel@gmail.com>
References: <20220331214719.881886-1-jakobkoschel@gmail.com>
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

When list_for_each_entry() completes the iteration over the whole list
without breaking the loop, the iterator value will be a bogus pointer
computed based on the head element.

While it is safe to use the pointer to determine if it was computed
based on the head element, either with list_entry_is_head() or
&pos->member == head, using the iterator variable after the loop should
be avoided.

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 arch/arm/plat-pxa/ssp.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index 563440315acd..6d638f02eac5 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -38,22 +38,20 @@ static LIST_HEAD(ssp_list);
 struct ssp_device *pxa_ssp_request(int port, const char *label)
 {
 	struct ssp_device *ssp = NULL;
+	struct ssp_device *iter;
 
 	mutex_lock(&ssp_lock);
 
-	list_for_each_entry(ssp, &ssp_list, node) {
-		if (ssp->port_id == port && ssp->use_count == 0) {
-			ssp->use_count++;
-			ssp->label = label;
+	list_for_each_entry(iter, &ssp_list, node) {
+		if (iter->port_id == port && iter->use_count == 0) {
+			iter->use_count++;
+			iter->label = label;
+			ssp = iter;
 			break;
 		}
 	}
 
 	mutex_unlock(&ssp_lock);
-
-	if (&ssp->node == &ssp_list)
-		return NULL;
-
 	return ssp;
 }
 EXPORT_SYMBOL(pxa_ssp_request);
@@ -62,22 +60,20 @@ struct ssp_device *pxa_ssp_request_of(const struct device_node *of_node,
 				      const char *label)
 {
 	struct ssp_device *ssp = NULL;
+	struct ssp_device *iter;
 
 	mutex_lock(&ssp_lock);
 
-	list_for_each_entry(ssp, &ssp_list, node) {
-		if (ssp->of_node == of_node && ssp->use_count == 0) {
-			ssp->use_count++;
-			ssp->label = label;
+	list_for_each_entry(iter, &ssp_list, node) {
+		if (iter->of_node == of_node && iter->use_count == 0) {
+			iter->use_count++;
+			iter->label = label;
+			ssp = iter;
 			break;
 		}
 	}
 
 	mutex_unlock(&ssp_lock);
-
-	if (&ssp->node == &ssp_list)
-		return NULL;
-
 	return ssp;
 }
 EXPORT_SYMBOL(pxa_ssp_request_of);
-- 
2.25.1

