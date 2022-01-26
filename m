Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C7949CA8A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbiAZNQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiAZNQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:16:46 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF2DC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:16:46 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id g9-20020a17090a67c900b001b4f1d71e4fso6071593pjm.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=ZJ2ildf3QiBMHovq0bFBc+IVRyOrQ2Kia2hTCFkSaXU=;
        b=omPtv3zRA8ItW34e93h+eMSKkXAWv/QPwX25Qu2GprOaPQn8xlirCF0o+IbPEMpz5e
         jNTkaduO+WAe+ZW1OqrHh6XtufqCcEx/dQvUcn+z07XIqU1UlXYV569kNHp0+xqhmi67
         ec0LN6xkQOn7QCGXDxfpRidI0XvhsChKBtU1exNZacK1Xaupegl6FdDjaUdmD8GsWhsr
         lJEVOO7J5uERSddgXtLng9H6Zw1vwRUH54aDStqk1esXxrV9XCjW5aNeK4ECzLMJUHBy
         gtAwgpubTihioNthQIxYlPFn9M8uvOxYmmUuSsQ//eTYsj3g0NWYrBz4FgM3b7ORY5cw
         93gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=ZJ2ildf3QiBMHovq0bFBc+IVRyOrQ2Kia2hTCFkSaXU=;
        b=0z6Qyy1JrRl8BoTSj18ysyWeZ3dtDbF9Y0h7FJAfuaF7ipnD3ibyKB43DyKakUz43V
         tPfzOtAzimIzEqBlYSBnIZ8B0nMaRYQZ9SvTMz4bZ9XVe5Q+ZrkhVcdkJFeCvRII8dDZ
         m3+SUjOnomx49IeCw7sgOgeuK0XTizmAZLoYE/pL3d5rwIftTxcY0hfF3pxy1OiSHlGN
         aKYcHHDtEcj3v33x+deMzn/I7eMrHV1fvMAZqUFfKRkCE4YDnwPlC6redVgWrkRR6tUJ
         S7q/e2Oz79xIuF9uvDFS5vLPejyW4yVa3LfgtI9Dyg/YbReuBJTjBFuqbmVMJ2YWDb4f
         yw/g==
X-Gm-Message-State: AOAM533MHttQX9Zpnh5ZXky25g+jLFITGIg9qnJBdHrISLKvRiWhQ76P
        9s8Ugl0soTyrvRNDYoj4QHfxGA02O5rsRw==
X-Google-Smtp-Source: ABdhPJxNPMLnvEMci4ZiqtzNx5lcGarl6yQVSI6FrAYTEYurYvoJgO+fgc25L+lXtfRxd3HpBJxZ9Q==
X-Received: by 2002:a17:903:41c1:b0:14b:8819:cfe2 with SMTP id u1-20020a17090341c100b0014b8819cfe2mr4208093ple.98.1643203006276;
        Wed, 26 Jan 2022 05:16:46 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id d4sm2175504pfj.82.2022.01.26.05.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:16:45 -0800 (PST)
Date:   Wed, 26 Jan 2022 13:16:41 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     jwiedmann.dev@gmail.com
Cc:     Shay Agroskin <shayagr@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sameeh Jubran <sameehj@amazon.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: ena: Do not waste napi skb cache
Message-ID: <YfFJuQQBLJRxIJR+@ip-172-31-19-208.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123115623.94843-1-42.hyeyoo@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By profiling, discovered that ena device driver allocates skb by
build_skb() and frees by napi_skb_cache_put(). Because the driver
does not use napi skb cache in allocation path, napi skb cache is
periodically filled and flushed. This is waste of napi skb cache.

As ena_alloc_skb() is called only in napi, Use napi_build_skb()
and napi_alloc_skb() when allocating skb.

This patch was tested on aws a1.metal instance.

[ jwiedmann.dev@gmail.com: Use napi_alloc_skb() instead of
  netdev_alloc_skb_ip_align() to keep things consistent. ]

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 53080fd143dc..07444aead3fd 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1400,10 +1400,9 @@ static struct sk_buff *ena_alloc_skb(struct ena_ring *rx_ring, void *first_frag)
 	struct sk_buff *skb;
 
 	if (!first_frag)
-		skb = netdev_alloc_skb_ip_align(rx_ring->netdev,
-						rx_ring->rx_copybreak);
+		skb = napi_alloc_skb(rx_ring->napi, rx_ring->rx_copybreak);
 	else
-		skb = build_skb(first_frag, ENA_PAGE_SIZE);
+		skb = napi_build_skb(first_frag, ENA_PAGE_SIZE);
 
 	if (unlikely(!skb)) {
 		ena_increase_stat(&rx_ring->rx_stats.skb_alloc_fail, 1,
-- 
2.33.1

