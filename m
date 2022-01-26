Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956EA49CEF0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiAZPwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:52:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35384 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiAZPwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:52:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F7D061927
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072AEC340E3;
        Wed, 26 Jan 2022 15:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643212341;
        bh=pDJ1n2o3tA01FOf1seMcoBl990OFnzTSM1jb7kUBkmA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kHwxw5x54kqArq5LM7anF8uiy/fNXEnjfAb89CRrPUn6hJeoCu94e34Js1XjBmZw1
         Zcr6ObjuOPHWuqO/nuFZd0IKde8MTHqv6uUgm1fsvU7s+tmTXZx8RcjGgEBfZ2ZIEz
         Yk+IKeR2PbHBzU754oIf9qifEPI8x6MFOqrhDsR7HBPVScPLEL9IQgJbaV3wYC6iEG
         5/6F8XDQ2J6vVTLRGU1u9Yj7zmG/tQ9VX/DMPuzObiQ7ftKu346cWX5+zPCYIDEOHF
         LxQmrHRhQYOWpY6LC+entG4YjvbqUIzaIC4y05Xevc5y+m7ys7ltNciNOuFPdbn45a
         Or76eHkBXm2RQ==
Date:   Wed, 26 Jan 2022 07:52:20 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     jwiedmann.dev@gmail.com, Shay Agroskin <shayagr@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sameeh Jubran <sameehj@amazon.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: ena: Do not waste napi skb cache
Message-ID: <20220126075220.3d60981f@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <YfFJuQQBLJRxIJR+@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220123115623.94843-1-42.hyeyoo@gmail.com>
        <YfFJuQQBLJRxIJR+@ip-172-31-19-208.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 13:16:41 +0000 Hyeonggon Yoo wrote:
> By profiling, discovered that ena device driver allocates skb by
> build_skb() and frees by napi_skb_cache_put(). Because the driver
> does not use napi skb cache in allocation path, napi skb cache is
> periodically filled and flushed. This is waste of napi skb cache.
> 
> As ena_alloc_skb() is called only in napi, Use napi_build_skb()
> and napi_alloc_skb() when allocating skb.
> 
> This patch was tested on aws a1.metal instance.
> 
> [ jwiedmann.dev@gmail.com: Use napi_alloc_skb() instead of
>   netdev_alloc_skb_ip_align() to keep things consistent. ]
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

It seems you missed CCing netdev@, you'll need to repost.
You can keep the ack from Shay.
