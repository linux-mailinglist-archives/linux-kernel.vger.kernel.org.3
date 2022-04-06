Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749194F654F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbiDFQQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbiDFQQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:16:13 -0400
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CAB1AD1FD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 20:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649217185;
        bh=/3v/n9JdJY9saPfEt6mwbCOo5wF4ZWKg9nyuXSpL/9o=;
        h=From:To:Cc:Subject:Date;
        b=Z/8fMC2eyMMGrdbh/tCxFMovJMt+6JN57CnQVvkSANSYcAscA0JReqCofMa/jqigF
         OhhFJ1QPFqowsqKVDhvTxEv9kT6jPhbu9GesNzz4WvPwQ/Ic71EOHSII/zkcNzYYVI
         n69xW/ojzgy2hWNs9wwTnVGIU+4UI6vbYolYYpLA=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrszc7.qq.com (NewEsmtp) with SMTP
        id D422002D; Wed, 06 Apr 2022 11:53:02 +0800
X-QQ-mid: xmsmtpt1649217182td0indq9y
Message-ID: <tencent_A887200ACC0AB9B11C761479E1E84A22FF08@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjlcvuejhie0WMTAU+d81tm9s6Jv1nFWGjhjJ4MNjXOZq43kjLv7
         pwA0Ny9Egj4o4m6ocfIWk7ut04zOPpy/KfySOf96JdTu1cf9TrwkO8/MsybjrniZVSNzgOCr7wSS
         hm0zIWB8mAwpPu2cupXBkmM8bqErBY9LBs3GpaZq0TCgeHfYCAFp/XAB1SCippNC8oVuJzGHJ48n
         +sducBurCMIqdP0RfzAoM/OMtrtYuPKwCQUEa9pepWawMYGJCaHuhc5Y+KEqtlzuNyFhxi5/tO8I
         wj4icrQ0Po6Bu+YMqjw9jnGjuRJMVKC/Ul0bzInz1E1Z4wf54ydAX/3qwoPQDNPVWT/iitChNhdw
         8rReJ6OF5tYOsOSjU1dJc13OGO+RaN3H+huDOOeNz/moQ9PZrzA92zmLZCEJzTlqo0tCBu79n5u7
         OhGTH0pyPl6pgjp1yuv1ZXdaSNL3u4qssLelXj6aO/Ty+qjxaRYc9YzPdNY8+OLZ9K3T7Dp6Niyw
         qQhl/HaAYZbDykr2PpHPM9fwRxvAccWaniFmDLBMdUM3uEGqHq7ATCg2BPo+svuMxsj/TftW7k30
         +sV2yJxd6n8ikP2OP+kieT/BZ/Bwu4mHC5bp+zZVHYMbZfRBeCGH0jb2jncLXPjEEqpruRydNJkr
         OIadWCQm8S8g9XH7KczZqCuA0HAEcG5PVHurXeTNatuo5pFyjxVxxpUSsk95EVYQlDABhjbDQ8VY
         vGDRyAEpFjDjKHeYWGhZp6etKmpmmPfAgHw95pjzbXO27qBp8Vd5H1s+cwOLeA0JzB55xIcr0IAC
         v2DQ9WeVr6HBV2Miw1NKe/NMqc214mifFcMaTP2s4q54ANTRju+dcTVlIJElMPlIbHDyPsr3z06P
         LuvCr8U4/ZlgLhoxoQcv5o/5H8IBWAHiz6W0kPC9uAQSfBYY5CukxfmlWblKNUfdJUmtNdJKW+C/
         +YUrxqMjyMl7Hn7GczXDosmh8fx+5I
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2] staging: rtl8712: fix potential memory leak in r8712_xmit_resource_alloc()
Date:   Wed,  6 Apr 2022 11:52:52 +0800
X-OQ-MSGID: <20220406035252.12835-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

In r8712_xmit_resource_alloc(), if usb_alloc_urb() fails, there can be 
some explored items are not released before this function returns.

Therefore, this patch re-explores the allocated items and uses 
usb_free_urb() to release them.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 remove kmemleak_not_leak() and update the description.
 drivers/staging/rtl8712/xmit_linux.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index 4a93839..034de02 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -113,9 +113,10 @@ int r8712_xmit_resource_alloc(struct _adapter *padapter,
 		pxmitbuf->pxmit_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
 		if (!pxmitbuf->pxmit_urb[i]) {
 			netdev_err(padapter->pnetdev, "pxmitbuf->pxmit_urb[i] == NULL\n");
+			while (i-- > 0)
+				usb_free_urb(pxmitbuf->pxmit_urb[i]);
 			return -ENOMEM;
 		}
-		kmemleak_not_leak(pxmitbuf->pxmit_urb[i]);
 	}
 	return 0;
 }
-- 
