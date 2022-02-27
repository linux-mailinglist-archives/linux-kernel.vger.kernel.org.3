Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8589C4C5E10
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 19:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiB0S1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 13:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiB0S1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 13:27:30 -0500
X-Greylist: delayed 944 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Feb 2022 10:26:52 PST
Received: from mx.treblig.org (mx.treblig.org [46.43.15.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9075654A8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 10:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=D6fceNIjKpwnS1biMuEu0ownwYQK1blsQ+uEVVtQEQo=; b=P0E4Nr4DmqSsmCEHU5jqJRzO5T
        wFVMmg3qXLKqDSiW5jEtJsG7ICRgDchzvZQr1M515LsQp3T7zajfHyexNCInWp+G0sv4g4iR9Egtq
        SNessDhV10bUUkr1eZlF2JPcqWs3/PE6HgqUeaP2/Dz7lLyuptyKDbpvKdA5sBCixDpCbR+bKh9yy
        zrBDho0XW9ntOcoYoY4yGxpIUexIiNCKXOH6RwezM7gq5k/vTYmcx0xUQZAUONkS0mzYQVLqCklaI
        1Vswu/A5swVD3SDzXMo8mR01UBYr61DlsYG+gB2Olbe7FDkgEdcUXgPrKIb2W5QELoj761OIZTjD5
        I/PW/yig==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
        by mx.treblig.org with esmtp (Exim 4.94.2)
        (envelope-from <linux@treblig.org>)
        id 1nOO0f-0006o3-C9; Sun, 27 Feb 2022 18:11:04 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     akpm@linux-foundation.org, pasha.tatashin@soleen.com,
        songmuchun@bytedance.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] mm: Use strtobool for param parsing
Date:   Sun, 27 Feb 2022 18:10:39 +0000
Message-Id: <20220227181038.126926-1-linux@treblig.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use strtobool rather than open coding "on" and "off" parsing in
mm/hugetlb_vmemmap.c and mm/page_table_check.c.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 mm/hugetlb_vmemmap.c  | 12 +-----------
 mm/page_table_check.c | 10 +---------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index c540c21e26f5b..919411386e547 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -192,17 +192,7 @@ static int __init early_hugetlb_free_vmemmap_param(char *buf)
 		return 0;
 	}
 
-	if (!buf)
-		return -EINVAL;
-
-	if (!strcmp(buf, "on"))
-		hugetlb_free_vmemmap_enabled = true;
-	else if (!strcmp(buf, "off"))
-		hugetlb_free_vmemmap_enabled = false;
-	else
-		return -EINVAL;
-
-	return 0;
+	return strtobool(buf, &hugetlb_free_vmemmap_enabled);
 }
 early_param("hugetlb_free_vmemmap", early_hugetlb_free_vmemmap_param);
 
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 3763bd077861a..2458281bff893 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -23,15 +23,7 @@ EXPORT_SYMBOL(page_table_check_disabled);
 
 static int __init early_page_table_check_param(char *buf)
 {
-	if (!buf)
-		return -EINVAL;
-
-	if (strcmp(buf, "on") == 0)
-		__page_table_check_enabled = true;
-	else if (strcmp(buf, "off") == 0)
-		__page_table_check_enabled = false;
-
-	return 0;
+	return strtobool(buf, &__page_table_check_enabled);
 }
 
 early_param("page_table_check", early_page_table_check_param);
-- 
2.35.1

