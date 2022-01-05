Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220E748541C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 15:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240583AbiAEOKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 09:10:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240556AbiAEOKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 09:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641391839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NlQ/iPBEfAfoA23wZcas2lBzyY7TNPetcM4L9SBqmXA=;
        b=bH4B5eI3cQlLZR2JDaj0L/ac8lGkDbNPmiKDf8mDPptU8C5f3Ic6dnC57wvlopIA9cN/xO
        qX2rEdilefjmkbVomlOSv/Uk74F3GVYcDpBWhyZwOSoy1jawK2aMzJG126O96+11wr9Hcy
        3s8a3MQDdBpofvqtBVGzveFOAOAnYJs=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-157-jhf71T37Olm1MaM-KpCMUw-1; Wed, 05 Jan 2022 09:10:36 -0500
X-MC-Unique: jhf71T37Olm1MaM-KpCMUw-1
Received: by mail-ot1-f70.google.com with SMTP id z33-20020a9d24a4000000b00579320f89ecso10259037ota.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 06:10:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NlQ/iPBEfAfoA23wZcas2lBzyY7TNPetcM4L9SBqmXA=;
        b=1dUKIikrGCZ5f15LMrcgcjsVfJzfWE5nsY9EXOW07ilkBzXKaq0XTG4znscCChitiK
         Ox7a7/SZ/fss2iISiS+zq3WPfbjMLCvL+z5Vxi/GuHMbqTkShEt5J041i5cDglWa5D7r
         5fCMA5b643tx34MBjEWUBbXHgQGvPoWjoxzJXyM+JW/hUDhVD6vxpGmoZNn4X8jbHFHi
         lc+CRXFja5awUyePfQY2yzC2p8umkJLrHhw4KZIrxQy64GK6t/Wbe4IX9+cJG04dtGT+
         MBPdu6mFlCfM/BHF+Yvq2sy8mG4ZblU0Lvavc7/UOxZhBpgR1BNZ/WmgksC0bCpXBS3o
         wSgA==
X-Gm-Message-State: AOAM530dqsMLu7VeVwpmTFGeiZWRe+CjNz2vNvJx1ATafkt7vk1xk+Ga
        qISP1IFjjd/GNKL+XG+jXr/N0XB+EEezmA+Z6TtXWQ4UGCqFhyXtUH0R9gkC47B6PHWzVjkVrqZ
        QnA9eLqTxV233vHNfSon6ztEh
X-Received: by 2002:a05:6808:a84:: with SMTP id q4mr2559828oij.28.1641391835674;
        Wed, 05 Jan 2022 06:10:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWBhuU3WElHiaxFDGPLjyE+aT1ltvIPzv9WejzLCdA8z9si6UvEo9ovc8kAf5jYm53VGhXqA==
X-Received: by 2002:a05:6808:a84:: with SMTP id q4mr2559789oij.28.1641391835120;
        Wed, 05 Jan 2022 06:10:35 -0800 (PST)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id bg38sm10563593oib.40.2022.01.05.06.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 06:10:34 -0800 (PST)
From:   trix@redhat.com
To:     davem@davemloft.net, kuba@kernel.org, leon@kernel.org,
        arnd@arndb.de, danieller@nvidia.com, gustavoars@kernel.org,
        hkallweit1@gmail.com, andrew@lunn.ch
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ethtool: use phydev variable
Date:   Wed,  5 Jan 2022 06:10:20 -0800
Message-Id: <20220105141020.3793409-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

In ethtool_get_phy_stats(), the phydev varaible is set to
dev->phydev but dev->phydev is still used.  Replace
dev->phydev uses with phydev.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/ethtool/ioctl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index b2cdba1b4aaec..326e14ee05dbf 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2096,9 +2096,9 @@ static int ethtool_get_phy_stats(struct net_device *dev, void __user *useraddr)
 	if (!phydev && (!ops->get_ethtool_phy_stats || !ops->get_sset_count))
 		return -EOPNOTSUPP;
 
-	if (dev->phydev && !ops->get_ethtool_phy_stats &&
+	if (phydev && !ops->get_ethtool_phy_stats &&
 	    phy_ops && phy_ops->get_sset_count)
-		n_stats = phy_ops->get_sset_count(dev->phydev);
+		n_stats = phy_ops->get_sset_count(phydev);
 	else
 		n_stats = ops->get_sset_count(dev, ETH_SS_PHY_STATS);
 	if (n_stats < 0)
@@ -2117,9 +2117,9 @@ static int ethtool_get_phy_stats(struct net_device *dev, void __user *useraddr)
 		if (!data)
 			return -ENOMEM;
 
-		if (dev->phydev && !ops->get_ethtool_phy_stats &&
+		if (phydev && !ops->get_ethtool_phy_stats &&
 		    phy_ops && phy_ops->get_stats) {
-			ret = phy_ops->get_stats(dev->phydev, &stats, data);
+			ret = phy_ops->get_stats(phydev, &stats, data);
 			if (ret < 0)
 				goto out;
 		} else {
-- 
2.26.3

