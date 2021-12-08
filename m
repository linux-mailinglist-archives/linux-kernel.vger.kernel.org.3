Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A3846CF34
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244994AbhLHIl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbhLHIl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:41:28 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94B4C061574
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 00:37:56 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id iq11so1413970pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 00:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=bwXvgd5xsgfADZErjxdRU/XgBlTNkIZ/8hPlFFC57LE=;
        b=LRfZ9sifn/hPu1USVeaa8cVFREZh9urN0dfwz/hOCCiJen+AUihuk440MuHKMcHV/d
         aufyAlAn67BjPYlN6leVXRYV2N/66jZVgzZGl0L0qngGjpkcJKxkcXy26WWRAurlH5EV
         dWK06Pgs2T2G3RsTLw/A9gWQWpv+DdhJD04APNRrOJb/9dFaL/WQxKE3B64hgMneWJi9
         VEZwX/gZqtBeDmnQqJ7C8hOuF4Hmc7WSf9YzufeuLE1Skf3gFpK+Wc0FD1HHp2VHMT7I
         dGNK91i5VDIU3l+TyqAL5ki6mmgV+T0mnt327wrbN+Hdigshui88wmcaRIpwyVBM43eN
         8H+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=bwXvgd5xsgfADZErjxdRU/XgBlTNkIZ/8hPlFFC57LE=;
        b=tc9UOCDrC1ECzsLEStVPAhxQDdRcxAuS572PVTxOq3cXrkx9uXbdKM/pQvinySBI9O
         OAGRUhkDH3DAHOwRFX+JDTdewvlfVEARiXnSQVUlVXT+tcreoszNTD2KalT0sZUFk9mO
         jpPc9j9IT7jhwCdqoA9/yh2byWt36e4B5s/1ORIwBEIgfOZaHLwf1IHbgeBcREBFV+n0
         vsxFss+HCl9qqIFl+EcSO2dCbmJkJ/O9FXvr5H1bDlUmoR94d3+Ill+RLt/3vej1HJHk
         vj4MxcY6w4uFD57Sk9QMLXTEzX5Y2VXgqrQRTMnHG3YoGIcMUJU5vCx9D4NoJKpurVyc
         7uIw==
X-Gm-Message-State: AOAM532DkQAl/flYfWpNTKAADcy4TL0aYsqgdobzSlYX5Z6soIVak1Pc
        Pd84Vp8RTQNLfTjwfSkhZOM=
X-Google-Smtp-Source: ABdhPJyAw4dYVYp0vvKe46EWug52vDhOfOOI9T41J7Rin8b4DrjfUMLTEgqOwp3+ZbgwpN562jlOKQ==
X-Received: by 2002:a17:90a:17ef:: with SMTP id q102mr5519306pja.116.1638952676518;
        Wed, 08 Dec 2021 00:37:56 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id v19sm5331780pju.32.2021.12.08.00.37.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 00:37:56 -0800 (PST)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: judging context via current_is_kswapd instead of gfp_flag
Date:   Wed,  8 Dec 2021 16:37:38 +0800
Message-Id: <1638952658-20285-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Kswapd uses GFP_KERNEL as gfp_flag which make the judgment of
context is unexpected. fix it by using current_is_kswapd.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 fs/afs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index eb11d04..6c199d5 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -485,7 +485,7 @@ static int afs_releasepage(struct page *page, gfp_t gfp_flags)
 	 * elected to wait */
 #ifdef CONFIG_AFS_FSCACHE
 	if (PageFsCache(page)) {
-		if (!(gfp_flags & __GFP_DIRECT_RECLAIM) || !(gfp_flags & __GFP_FS))
+		if (current_is_kswapd() || !(gfp_flags & __GFP_FS))
 			return false;
 		wait_on_page_fscache(page);
 	}
-- 
1.9.1

