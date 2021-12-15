Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C58D475180
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 04:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbhLODwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 22:52:20 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32921 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235424AbhLODwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 22:52:19 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JDLsW6MXfzcbyr;
        Wed, 15 Dec 2021 11:51:59 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 11:51:50 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 15 Dec
 2021 11:51:50 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
CC:     <jgross@suse.com>, <gregkh@linuxfoundation.org>
Subject: [PATCH -next] usb: host: xen-hcd: add missing unlock in error path
Date:   Wed, 15 Dec 2021 11:58:05 +0800
Message-ID: <20211215035805.375244-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing unlock before return from function xenhcd_urb_request_done()
and xenhcd_conn_notify() in the error handling case.

Fixes: 494ed3997d75 ("usb: Introduce Xen pvUSB frontend (xen hcd)")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/usb/host/xen-hcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xen-hcd.c b/drivers/usb/host/xen-hcd.c
index 7801dde6f5ee..be09fd9bac58 100644
--- a/drivers/usb/host/xen-hcd.c
+++ b/drivers/usb/host/xen-hcd.c
@@ -942,6 +942,7 @@ static int xenhcd_urb_request_done(struct xenhcd_info *info)
 	rp = info->urb_ring.sring->rsp_prod;
 	if (RING_RESPONSE_PROD_OVERFLOW(&info->urb_ring, rp)) {
 		xenhcd_set_error(info, "Illegal index on urb-ring");
+		spin_unlock_irqrestore(&info->lock, flags);
 		return 0;
 	}
 	rmb(); /* ensure we see queued responses up to "rp" */
@@ -997,6 +998,7 @@ static int xenhcd_conn_notify(struct xenhcd_info *info)
 	rp = info->conn_ring.sring->rsp_prod;
 	if (RING_RESPONSE_PROD_OVERFLOW(&info->conn_ring, rp)) {
 		xenhcd_set_error(info, "Illegal index on conn-ring");
+		spin_unlock_irqrestore(&info->lock, flags);
 		return 0;
 	}
 	rmb(); /* ensure we see queued responses up to "rp" */
@@ -1010,6 +1012,7 @@ static int xenhcd_conn_notify(struct xenhcd_info *info)
 
 		if (xenhcd_rhport_connect(info, portnum, speed)) {
 			xenhcd_set_error(info, "Illegal data on conn-ring");
+			spin_unlock_irqrestore(&info->lock, flags);
 			return 0;
 		}
 
-- 
2.25.1

