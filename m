Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4182F517DF4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiECHBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiECHBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:01:43 -0400
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C846D2DA8B
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 23:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1651561089;
        bh=DhzTsTCZctDSkn9RQOs6gvHg47wttYi8um9rAMxo+cY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LznF8cVRIXSaZmPWQVhNRnycWv8myIBG8oHKmlHrm291yivvhpLx3hNPZcEWx+0wl
         OWQvLLlYY4ebrm0awvmmDT7kwGsrVOLA5I8PNo3yVDEVe2/IK803YZVJGRB6eT2Yfz
         ZIthk0+RHx3wSMt67wRJ2Mye7fZvNWkMKbDhqgxg=
Received: from localhost.localdomain ([59.172.176.242])
        by newxmesmtplogicsvrszc10.qq.com (NewEsmtp) with SMTP
        id E868B0BD; Tue, 03 May 2022 14:58:06 +0800
X-QQ-mid: xmsmtpt1651561086t1cjo9w6a
Message-ID: <tencent_B08D70242590FF10905466BFDC158E4F0A07@qq.com>
X-QQ-XMAILINFO: MOZWoti2yOjR1WCeDO5N20RXttkwDHDnYOlFHq8MDHm8z9n2L/UyXvCueM6/dK
         geQjNkB2reOZcTNmrarqeKwAt95l1M7N2TxmLF3efh1gjT+G6YUnaGLMvfRRu9NwcdhQz4KhWge/
         +JjEkzMjV79s8n7OKle4m3L4Iveo/SUro36qseFwJ4l8TxdjUEOhqXnqT1wt1xMVrbVLDOvirUwh
         7D5D+5JFy+zzjFUrlnEpbJA5HFOUNIi771OKgthUY+RZ56gZi6cDnMzBAAFVWqSm22ZZtZOZLYJ0
         Exc8FpYrSeLKG+rLJ5WJT+VukK7I+yBlCLe6M0mkAJH1fudFvexMVKMI9pvub0R4VQUsJJoDsSZu
         ZnAL7SW5FcxGRG+ymwMClfADXd5gAoXKkcbiADBr3J2EomR2vzkWzqRv3wrEhQNEDVQji34v1aMM
         NkSgNSvutoLiF+8/CI0eXxGHAq8qAuManAONCV/pHRhcJwmxAUdCGNCDj/jn3KqZB1dgvCTMc6nY
         BYRW6SzG63MqM0Zk9l5ILHSbDNPcjObE1Fg9ubyDOs2+QEot4kMxqROOXgZcODC5enS7PEjB4kH/
         YcdhVJWVIH8vENzoSHVYRmBdWHVIqMdWKLAkb3w4ef0U48voK6xwd24vOFRE+1yFFXJZM1Ot+fZn
         MqXnobTaA5n/CmKO8QthfwMcIeF3fgYPMLV29Y5Jux3/GMNDYcJ5j4lM0iMsErK3equ8YgLEQhIq
         QWRxHnSDowsDzkaqu7Frrpup+SVevhCRN+zZGkEcfssigoNzSBN02kzpBW7s8BnpelIiYRQ7sztT
         IXqV4kPlCD3s+yQ0i0TcFChzjyZOLhkCHmzqWqeZgvAKtCcBrVLW7tfrn22pkRg3SktC4U5f71aO
         x9zZS8U0uuFFPkbVe78Qb/+0TdJP789zGbkpXTh36upYRbJ/8GFJho9KFs+xegQavoimtqqh9tpm
         v9fiDvDQsT7+VA5fgRMfplM0PT7TKp
From:   xkernel.wang@foxmail.com
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH 01/12] staging: rtl8712: fix potential memory leak in r8712_xmit_resource_alloc()
Date:   Tue,  3 May 2022 14:57:53 +0800
X-OQ-MSGID: <20220503065753.3174-1-xkernel.wang@foxmail.com>
In-Reply-To: <tencent_A80380E4306BE7BA73E450F084232B4DFC0A@qq.com>
References: <tencent_A80380E4306BE7BA73E450F084232B4DFC0A@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
