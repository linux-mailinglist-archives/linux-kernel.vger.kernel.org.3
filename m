Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CEA4990F8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 21:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354520AbiAXUIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 15:08:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46772 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357225AbiAXTtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 14:49:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F2886091C;
        Mon, 24 Jan 2022 19:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867CAC340E5;
        Mon, 24 Jan 2022 19:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643053778;
        bh=WzNw0oSd1gKe/M9faZwGg+IalzTanMcEGX+KVptdEPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TcSepyyzt82KiaaIWdXx3BxTx7HKMqHV8mVziOHgPRBtmEpr1DvuR4sT69iadsslI
         1s9voMzxfkEltQbjNjaqb2Ky1itTzxSthjpmE1ziAlnSK9rtExS9mRD7tWW5REiDb4
         cxjwGPUKo3q1K+9DcFo/kyIFgjEVUcOKEQq1flvg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Antony Antony <antony.antony@secunet.com>,
        Eyal Birger <eyal.birger@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 173/563] xfrm: interface with if_id 0 should return error
Date:   Mon, 24 Jan 2022 19:38:58 +0100
Message-Id: <20220124184030.397155595@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124184024.407936072@linuxfoundation.org>
References: <20220124184024.407936072@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antony Antony <antony.antony@secunet.com>

[ Upstream commit 8dce43919566f06e865f7e8949f5c10d8c2493f5 ]

xfrm interface if_id = 0 would cause xfrm policy lookup errors since
Commit 9f8550e4bd9d.

Now explicitly fail to create an xfrm interface when if_id = 0

With this commit:
 ip link add ipsec0  type xfrm dev lo  if_id 0
 Error: if_id must be non zero.

v1->v2 change:
 - add Fixes: tag

Fixes: 9f8550e4bd9d ("xfrm: fix disable_xfrm sysctl when used on xfrm interfaces")
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Reviewed-by: Eyal Birger <eyal.birger@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_interface.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_interface.c b/net/xfrm/xfrm_interface.c
index e9ce23343f5ca..e1fae61a5bb90 100644
--- a/net/xfrm/xfrm_interface.c
+++ b/net/xfrm/xfrm_interface.c
@@ -643,11 +643,16 @@ static int xfrmi_newlink(struct net *src_net, struct net_device *dev,
 			struct netlink_ext_ack *extack)
 {
 	struct net *net = dev_net(dev);
-	struct xfrm_if_parms p;
+	struct xfrm_if_parms p = {};
 	struct xfrm_if *xi;
 	int err;
 
 	xfrmi_netlink_parms(data, &p);
+	if (!p.if_id) {
+		NL_SET_ERR_MSG(extack, "if_id must be non zero");
+		return -EINVAL;
+	}
+
 	xi = xfrmi_locate(net, &p);
 	if (xi)
 		return -EEXIST;
@@ -672,7 +677,12 @@ static int xfrmi_changelink(struct net_device *dev, struct nlattr *tb[],
 {
 	struct xfrm_if *xi = netdev_priv(dev);
 	struct net *net = xi->net;
-	struct xfrm_if_parms p;
+	struct xfrm_if_parms p = {};
+
+	if (!p.if_id) {
+		NL_SET_ERR_MSG(extack, "if_id must be non zero");
+		return -EINVAL;
+	}
 
 	xfrmi_netlink_parms(data, &p);
 	xi = xfrmi_locate(net, &p);
-- 
2.34.1



