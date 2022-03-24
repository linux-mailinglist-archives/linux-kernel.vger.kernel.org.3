Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8745A4E5F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348503AbiCXH0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbiCXH0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:26:00 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE7898F47;
        Thu, 24 Mar 2022 00:24:29 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r13so7321986ejd.5;
        Thu, 24 Mar 2022 00:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hqm0NVjl1XXMxjBpBH/hdq5nmMPm2abv01ReA7/x/Wo=;
        b=jc61vNvypG8xssQ5Sa5SGOiyHPYWy2w3vcRm9ikKtSb6mRZf8jwhTdjF7NAKDnNERt
         aPqHgKARnxasEGnWCRl2wXm5C3tteWC9is+hlqrcfogEO8lVsXNIDbsqk9HcB6ATTQJk
         cZBjKcTn9JumkLi0ujNcD7oEUThNc41DcOd1jx369nrySYCl5WRcwwP4hdo1CiEmZpWz
         yavWs6Fu1aTDRw6ejoVaa/J9jyIy4fl58nAcMtCpJ3U38Xi5qQbSVq/OAOGkGECzcgVf
         AT+u+vLuJu5A5Gj+cPj+YZsC5YJzOf+5wltt1XlO8fQdDNiRoVUeokLbVfQxYaQvzBZl
         wS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hqm0NVjl1XXMxjBpBH/hdq5nmMPm2abv01ReA7/x/Wo=;
        b=W/bV6x+XqePycG1xHDwpvBSIpE2WZyOA+pM/t3GgD54aZQHJ9wfls5qC51d07aJwbk
         hI5Egb2HsHCgMRoaZBwPs1zKlnI4hjECpEqBg61uwRKE+d1SwQ5ZVn8gwDQ8GFnZr+T8
         uqnha/aMAraOdx6jrZ1sacsgk1BKM4Fz2Fm9XUOaSzDVR1ycGi+NqgdJRYtd4Mr0uQRS
         LYxfsyXZ4BI0zg2Tkm57HRwsq3oz0uhCDgvGQkJ/9mYFH4hS/9vQYBUkGkt4ezKQD5ar
         XS9qOL/G7KhbiBUIfoKddXc4BdTFSC+ZpubvgHVjvnVBbP+9LJDWTql9TKtRh6KHGW5S
         pt/w==
X-Gm-Message-State: AOAM532c18WxH2RTvsXrb6G8yP1vrJ0XIApP8KDfYx2M8C9GBlUKlFmm
        hH3HPUlrUhTy8/c6ECDcw+o=
X-Google-Smtp-Source: ABdhPJxbRkqVNvlTWR3sH2yUZCuNFBR0+azuzE6PIpMu3NWXAVIZpa6jCxvAy33KVcFsHAModpDgxQ==
X-Received: by 2002:a17:906:c14b:b0:6da:b30d:76a0 with SMTP id dp11-20020a170906c14b00b006dab30d76a0mr4147482ejc.279.1648106667768;
        Thu, 24 Mar 2022 00:24:27 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id z22-20020a17090655d600b006d229436793sm766013ejp.223.2022.03.24.00.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:24:27 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] sh: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:24:09 +0100
Message-Id: <20220324072409.62899-1-jakobkoschel@gmail.com>
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

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 arch/sh/drivers/dma/dma-api.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.c
index ab9170494dcc..b1a54269b03c 100644
--- a/arch/sh/drivers/dma/dma-api.c
+++ b/arch/sh/drivers/dma/dma-api.c
@@ -127,20 +127,19 @@ static int search_cap(const char **haystack, const char *needle)
  */
 int request_dma_bycap(const char **dmac, const char **caps, const char *dev_id)
 {
-	unsigned int found = 0;
-	struct dma_info *info;
+	struct dma_info *info = NULL, *iter;
 	const char **p;
 	int i;
 
 	BUG_ON(!dmac || !caps);
 
-	list_for_each_entry(info, &registered_dmac_list, list)
-		if (strcmp(*dmac, info->name) == 0) {
-			found = 1;
+	list_for_each_entry(iter, &registered_dmac_list, list)
+		if (strcmp(*dmac, iter->name) == 0) {
+			info = iter;
 			break;
 		}
 
-	if (!found)
+	if (!info)
 		return -ENODEV;
 
 	for (i = 0; i < info->nr_channels; i++) {
@@ -242,17 +241,16 @@ EXPORT_SYMBOL(dma_wait_for_completion);
 
 int register_chan_caps(const char *dmac, struct dma_chan_caps *caps)
 {
-	struct dma_info *info;
-	unsigned int found = 0;
+	struct dma_info *info = NULL, *iter;
 	int i;
 
-	list_for_each_entry(info, &registered_dmac_list, list)
-		if (strcmp(dmac, info->name) == 0) {
-			found = 1;
+	list_for_each_entry(iter, &registered_dmac_list, list)
+		if (strcmp(dmac, iter->name) == 0) {
+			info = iter;
 			break;
 		}
 
-	if (unlikely(!found))
+	if (unlikely(!info))
 		return -ENODEV;
 
 	for (i = 0; i < info->nr_channels; i++, caps++) {

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

