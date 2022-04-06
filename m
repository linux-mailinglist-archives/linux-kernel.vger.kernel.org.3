Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146184F5E25
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbiDFM2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiDFM1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:27:38 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D926A3B21BB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:18:32 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220406081827epoutp0101049c66525587f51c30d80d4c9caa2c~jQMXfQw1Q1340813408epoutp017
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:18:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220406081827epoutp0101049c66525587f51c30d80d4c9caa2c~jQMXfQw1Q1340813408epoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649233107;
        bh=pZ68lE/yVojdDH0LXtiSiATpeoPKm9HOHcGFlaOhWAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k31NT6S+v+reWpc0rMoGz1Qow2lqCWqoSg5LeaxqkWaW6Jc9jutbpRxfJ24wSP/tV
         bo3hE6XmYmYnfq0eK0yGEHpzS2zf90obmolqVy7LG/6TFyIezJXB5GAgMZILaeaMj3
         Fs9C9bMJooL9TW90ga6mr5xITQLtS3AtzM9EMLuw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220406081826epcas2p4c69bea871ea256d610ba66a73c2ed872~jQMXJl8IV2886628866epcas2p4L;
        Wed,  6 Apr 2022 08:18:26 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.89]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KYHTF2KFfz4x9Q0; Wed,  6 Apr
        2022 08:18:25 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.37.25540.0DC4D426; Wed,  6 Apr 2022 17:18:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220406081823epcas2p2f7afa27e2402c4fc02c9bee5972bed4f~jQMUbDwbC1713417134epcas2p2K;
        Wed,  6 Apr 2022 08:18:23 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220406081823epsmtrp19183c8d1a985530de3d2a5eba5063025~jQMUaL53y1921919219epsmtrp1m;
        Wed,  6 Apr 2022 08:18:23 +0000 (GMT)
X-AuditID: b6c32a47-831ff700000063c4-e2-624d4cd0a85f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.1C.03370.FCC4D426; Wed,  6 Apr 2022 17:18:23 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220406081823epsmtip11172b4e3fe7884a960870fbe196feaa6~jQMULi29s2148221482epsmtip1x;
        Wed,  6 Apr 2022 08:18:23 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH 1/1] tty: serial: samsung: add spin_lock for interrupt and
 console_write
Date:   Wed,  6 Apr 2022 17:22:16 +0900
Message-Id: <20220406082216.11206-2-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406082216.11206-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmme4FH98kg6/9PBYP5m1js7i8X9ui
        efF6NosdDUdYLd7NlbE4f34Du8Wmx9dYLS7vmsNmMeP8PiaLM4t72R24PDat6mTz2D93DbvH
        5iX1Hn1bVjF6fN4kF8AalW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ib
        aqvk4hOg65aZA3SSkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3uDQv
        XS8vtcTK0MDAyBSoMCE7Y9735ewF3zgr1s07ytbAOI+ji5GTQ0LARKLzRSdbFyMXh5DADkaJ
        9oufWCGcT4wSJ7u6mSGcz4wSc3ZuYoFpOb7oGFRiF6PE46lLmCCcj4wSK/6dZwKpYhPQlvi+
        fjHYLBGB04wSh7cfBXOYQbbsav8OViUsECXxf/YMMJtFQFXi1ZxjYDavgK3EjePnGSH2yUt0
        //sDtptTwE5i18OdbBA1ghInZz4BizMD1TRvnQ12k4RAI4fEr1m3gYo4gBwXiZuPQyHmCEu8
        Or6FHcKWknjZ3wZlF0sc7/nOBNHbwChx9s4BVoiEscSsZ+2MIHOYBTQl1u/ShxipLHHkFtRa
        PomOw3/ZIcK8Eh1tQhCNahL3p55jg7BlJCYdWckEYXtILLmyERrYExklPu7sYpnAqDALyTez
        kHwzC2HxAkbmVYxiqQXFuempxUYFxvA4Ts7P3cQITqRa7jsYZ7z9oHeIkYmD8RCjBAezkghv
        Va5PkhBvSmJlVWpRfnxRaU5q8SFGU2BYT2SWEk3OB6byvJJ4QxNLAxMzM0NzI1MDcyVxXq+U
        DYlCAumJJanZqakFqUUwfUwcnFINTPmqpunhvelnJl2yZzi6LC7pZYRqxKM373dkMf1z/Hrp
        xu8p1/xLHi+8IsvwU0mjQlmmZb+bTEfEMedFMxoN+4pT6ubb2m1cfdP2+6wKVjNn86Kv1/l7
        2OaJWlQkzNj0r9XjoeDHJANLXdewfSy3DZXeqRmy1rT8Xl1+he2fwEEx0VybaW283DqXb31/
        scTh3pmH6QkeVd9l5RPl3infL+lte5IyKeZV71uW1+Ez7LaprHY0rlnSb8Hqkj7H5U3adr3C
        Mgvf+Zk8To7F77bs7a2ftOwC8+1Ifem1JudvbK47uuqp7pYJk/vmrJA9FBLL2jFb4N9jbuvQ
        knCJwwkmaoULV6zy+BBdv5n3ywF9JZbijERDLeai4kQAWK8xMS0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsWy7bCSnO55H98kg4/LdS0ezNvGZnF5v7ZF
        8+L1bBY7Go6wWrybK2Nx/vwGdotNj6+xWlzeNYfNYsb5fUwWZxb3sjtweWxa1cnmsX/uGnaP
        zUvqPfq2rGL0+LxJLoA1issmJTUnsyy1SN8ugStj3vfl7AXfOCvWzTvK1sA4j6OLkZNDQsBE
        4viiY8xdjFwcQgI7GCU2PXzHCpGQkVj+rI8NwhaWuN9yhBWi6D2jxINjW1lAEmwC2hLf1y8G
        S4gInGeUmPz4DRuIwyywh1FizezvzCBVwgIREmu2nWEEsVkEVCVezTnGBGLzCthK3Dh+nhFi
        hbxE978/YFM5Bewkdj3cCbZaCKhm15o3rBD1ghInZz4Bq2EGqm/eOpt5AqPALCSpWUhSCxiZ
        VjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBIe8ltYOxj2rPugdYmTiYDzEKMHBrCTC
        W5XrkyTEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QDk+ND
        xdK/lktNvnEXBFYv+M0nO1fb7vKvq5tDG+ZoXdrgZnJ3Cdsdveb8tA9HV01/l7b4j5OGoSh/
        1rcpz48Y+Urd+pfMdO6SQvGLxvRqR+nLhRXz/Y92xL2awnvjfOTWb+KWm3oFU29v9Vm+Y02o
        xsWoferv05g+vf/6d4aN6NU7N32qZ8vqvgz/4KOjuPCV+5KcTXr7Jbv23enceSiG9yXT6jkZ
        WlnlX9ny9OxePgwzVpfdenpJT/hd3Zm7eJrvVtd4zm1k5cu4fPSYYp/loTizlVdz74hoL5vr
        s3dFgmup26xXc/N3n/hXGLz/O9uJzTvKghMnLz1yvLzHpTNr17XGqy1xb1dGOV8KUohpUFZi
        Kc5INNRiLipOBABobSbH6AIAAA==
X-CMS-MailID: 20220406081823epcas2p2f7afa27e2402c4fc02c9bee5972bed4f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220406081823epcas2p2f7afa27e2402c4fc02c9bee5972bed4f
References: <20220406082216.11206-1-jaewon02.kim@samsung.com>
        <CGME20220406081823epcas2p2f7afa27e2402c4fc02c9bee5972bed4f@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The console_write and IRQ handler can run concurrently.
Problems may occurs console_write is continuously executed while
the IRQ handler is running.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index e1585fbae909..9db479d728b5 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2480,12 +2480,24 @@ s3c24xx_serial_console_write(struct console *co, const char *s,
 			     unsigned int count)
 {
 	unsigned int ucon = rd_regl(cons_uart, S3C2410_UCON);
+	unsigned long flags;
+	bool locked = 1;
 
 	/* not possible to xmit on unconfigured port */
 	if (!s3c24xx_port_configured(ucon))
 		return;
 
+	if (cons_uart->sysrq)
+		locked = 0;
+	else if (oops_in_progress)
+		locked = spin_trylock_irqsave(&cons_uart->lock, flags);
+	else
+		spin_lock_irqsave(&cons_uart->lock, flags);
+
 	uart_console_write(cons_uart, s, count, s3c24xx_serial_console_putchar);
+
+	if (locked)
+		spin_unlock_irqrestore(&cons_uart->lock, flags);
 }
 
 /* Shouldn't be __init, as it can be instantiated from other module */
-- 
2.35.1

