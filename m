Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467F3488529
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 19:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbiAHSAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 13:00:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52143 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230162AbiAHSAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 13:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641664848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=pzEFHr83S9POpRQq4pM/eG49Pxi7C/LXxl9tC2D25S0=;
        b=TcWhXw0uEWVd1UuWCb+bgQKED/9ASrNdmlLH9JaP6+nXOlVzCYllHDPVfTi3D4CWgaMesN
        mOxYgvJ5t9HgGXreZK6EL2SpTlwtz08ld7g198DPSLSn/EotcyLacWZnNFKswp7zykCDx5
        XuZR2acfLOytD0QoM59pzsnVPufFby0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-4pnuOBITM-me-p8UXf6mpQ-1; Sat, 08 Jan 2022 13:00:47 -0500
X-MC-Unique: 4pnuOBITM-me-p8UXf6mpQ-1
Received: by mail-wm1-f72.google.com with SMTP id bh10-20020a05600c3d0a00b00347aa76728fso2851451wmb.9
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 10:00:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pzEFHr83S9POpRQq4pM/eG49Pxi7C/LXxl9tC2D25S0=;
        b=EowJ0DTyn9X2uz2gwi5URG4fWvzokS7RNM0WTwfB5KSrJsUy1a2lOV9c+YIIxkmjux
         TLc7EatOydi8mTyCXPd7FNFJqJTMB1ogs4WXC8jMQ4LtaEGQmP/1hiCFBYzfQlQV+NXB
         a6xVPP+MNkxMFunSmO6Z6NWzOtUyDp278QUpXdIMmKJtylN7G592qXuSig+l159ikXVG
         Z5VD9FEBkJ3n6QhzJivRT4J6WTxtCFUoPjME0yb9rOUPDLV720oRGx+c3gBXDcNKOWlJ
         FufyMnyFT9AjYEeg04caspDWBUk4o2Q7xNYCx+Losb4gyIy0/nziCSt/TpM392+nWqW1
         hCUw==
X-Gm-Message-State: AOAM532r80kNInxEhGnK6D5Zby7FASPz4h1yz5O65bktsX0qGmuxWYR8
        asDOHyErbiuGXBseFAZuE9NGwj/CjhduTyek3Vw6D+BodyJIxrviXiR1aCIMQ4zN2CSmHDEHa2D
        HhFAyDvxjle5XXa2Znugw6obeAHJlG5WIAm5bjzWq+ZTYEZBwTcHxYz3PLWwY3bOEc+8jdA==
X-Received: by 2002:a05:6000:23a:: with SMTP id l26mr56753437wrz.666.1641664845508;
        Sat, 08 Jan 2022 10:00:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwz9GxLhfeBhj5hp36+qSVZeY0MnNgIW7wIVNb8K+OXWilRMvLTYxibFK7C1W6P4qkC6t8P/Q==
X-Received: by 2002:a05:6000:23a:: with SMTP id l26mr56753418wrz.666.1641664845266;
        Sat, 08 Jan 2022 10:00:45 -0800 (PST)
Received: from redhat.com ([2a10:800d:b77b:0:4c0a:9a47:da3d:38fd])
        by smtp.gmail.com with ESMTPSA id l26sm2173403wrz.44.2022.01.08.10.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 10:00:44 -0800 (PST)
Date:   Sat, 8 Jan 2022 13:00:43 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Eli Cohen <elic@nvidia.com>, kernel test robot <lkp@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] vdpa/mlx5: fix endian-ness for max vqs
Message-ID: <20220108180041.4601-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse warnings: (new ones prefixed by >>)
>> drivers/vdpa/mlx5/net/mlx5_vnet.c:1247:23: sparse: sparse: cast to restricted __le16
>> drivers/vdpa/mlx5/net/mlx5_vnet.c:1247:23: sparse: sparse: cast from restricted __virtio16

> 1247                  num = le16_to_cpu(ndev->config.max_virtqueue_pairs);

Address this using the appropriate wrapper.

Fixes: 7620d51af29a ("vdpa/mlx5: Support configuring max data virtqueue")
Cc: "Eli Cohen" <elic@nvidia.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 84b1919015ce..d1ff65065fb1 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1242,7 +1242,8 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
 	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
 		num = 1;
 	else
-		num = le16_to_cpu(ndev->config.max_virtqueue_pairs);
+		num = mlx5vdpa16_to_cpu(&ndev->mvdev,
+					ndev->config.max_virtqueue_pairs);
 
 	max_rqt = min_t(int, roundup_pow_of_two(num),
 			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
-- 
MST

