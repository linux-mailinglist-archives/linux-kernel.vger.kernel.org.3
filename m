Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8134A49761E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 23:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbiAWWrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 17:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiAWWrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 17:47:43 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21276C06173B;
        Sun, 23 Jan 2022 14:47:43 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s18so10300911wrv.7;
        Sun, 23 Jan 2022 14:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/5S9xyESZcclPaDw6CXf6+0+vxSG5iw7208cSFoi+Ek=;
        b=Bqn+ku0d8MUE+YXmG1PeLK6uIYJHfwCkMPh++n1Ufh2oJAxx8cgm1A/UN3ZwzpdSX/
         fRnzX+L7mEi5SJbHjd4vgT1KmPEaeadro5cqQTbFjj8gRu8sucwUMx684BvA0SOPG6PT
         iVK2Pd2+fY/9KJ7htcbmm9U7/h0NPo989kB4ySK+n4dbNcsZubCNeMk6YFC5nwBf53Cs
         du9T3og3NRchzmBE2jv/ox4mLN6BmU8ph+uPAtCDoDLG8SgRG5eppI/yCOSIzTuI4JGP
         ZIt0yM7X+gqyrjC593ptp10p8DJWTXIi0hpVhaZtBjcl03QzAo//ANSB9YsqP7LALcRz
         PGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/5S9xyESZcclPaDw6CXf6+0+vxSG5iw7208cSFoi+Ek=;
        b=D1IIpW7YIgq+juO8O67L9SZ36b0fCAGULQgA8lveq1M3aX8CkJ+dp6hAlrM9adjTKi
         IEggE66xtd0g+wrBv2NzKFj3+iiVuoq3kxr4BVgBK5kQjfEuAg+Y8vvnugFmH7HCvfb8
         lqnT6CWoMMl+R9TMLatBtIr35Pzisuu7Cbp8+qmLYCxmYpjnYtDcPAK5OKlQwNb8GGIw
         HrnBhFkjrWUOA5iE3RZkbjg1CjTfTSilTjUARvlFwrFv/h0KAQ6Zz4ZwPC3q8fKB0VBc
         +zyqAnFlJLOEI7bNqj/wcc9cx0mD3ctCfXLrM+SXpn7OhnkbikaEwwkgIBexqtGpfZzs
         95Lg==
X-Gm-Message-State: AOAM533NhveZqMCOpi9mLX+e7rJKpXtxtP4dClVbAGgzUEDl9WvP6H5s
        LSuhMe1yythsHrk6at5qAG0=
X-Google-Smtp-Source: ABdhPJwgQfGhLKl/aE6FaexUpoUSwbCHdwzqIBIatkY66lzhhjF6X11hlksM/fh8scWrKDOqpbeshw==
X-Received: by 2002:a05:6000:1884:: with SMTP id a4mr12195041wri.316.1642978061708;
        Sun, 23 Jan 2022 14:47:41 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p14sm1643086wmq.40.2022.01.23.14.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 14:47:41 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dm: make static read-only array table const
Date:   Sun, 23 Jan 2022 22:47:40 +0000
Message-Id: <20220123224740.6875-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static array table as read-only so it make sense to make
it const. Add in the int type to clean up checkpatch warning.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/md/dm-cache-policy-smq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-cache-policy-smq.c b/drivers/md/dm-cache-policy-smq.c
index b61aac00ff40..19eac5d980a8 100644
--- a/drivers/md/dm-cache-policy-smq.c
+++ b/drivers/md/dm-cache-policy-smq.c
@@ -1026,7 +1026,9 @@ static unsigned default_promote_level(struct smq_policy *mq)
 	 * This scheme reminds me of a graph of entropy vs probability of a
 	 * binary variable.
 	 */
-	static unsigned table[] = {1, 1, 1, 2, 4, 6, 7, 8, 7, 6, 4, 4, 3, 3, 2, 2, 1};
+	static const unsigned int table[] = {
+		1, 1, 1, 2, 4, 6, 7, 8, 7, 6, 4, 4, 3, 3, 2, 2, 1
+	};
 
 	unsigned hits = mq->cache_stats.hits;
 	unsigned misses = mq->cache_stats.misses;
-- 
2.33.1

