Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8309B4F21B1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiDEDhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 23:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiDEDhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 23:37:02 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AC7BC1D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 20:35:04 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220405033455epoutp046e9c34c5e304f13b0e644acf32353fd1~i4rhf6XBY3079030790epoutp04n
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 03:34:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220405033455epoutp046e9c34c5e304f13b0e644acf32353fd1~i4rhf6XBY3079030790epoutp04n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649129695;
        bh=CKTKAhXTaSx818utW4r9R7NQFknJNHgDoVip59njvEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PaZJYMkVYO9PT1djcso0sVT7G4l0lk5xddDLzi5RcDlZW8nN+FX/NUivvnJitQgn+
         0GTakD1V/wsnY5F0WfebyoDI1m2ST0qWUxAbxWRgLfxnqizOHUWETbg0EaK4SmZn/G
         VQPifUkDjrffQB4Foi4EY56TVFbenxoRQauJLod8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220405033454epcas2p20c8c15c5d6c17d6d5c65ee844359d970~i4rhK1ujC2545725457epcas2p2P;
        Tue,  5 Apr 2022 03:34:54 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.99]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KXYDY2jssz4x9Q9; Tue,  5 Apr
        2022 03:34:53 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.F4.16040.9D8BB426; Tue,  5 Apr 2022 12:34:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220405033448epcas2p397080e15c54369d24eaf94c2a27bd06c~i4rbwDbjo2389723897epcas2p3d;
        Tue,  5 Apr 2022 03:34:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220405033448epsmtrp29b3065ec2163fe09f31a320f899fc47f~i4rbvKhax2074420744epsmtrp2U;
        Tue,  5 Apr 2022 03:34:48 +0000 (GMT)
X-AuditID: b6c32a46-bffff70000023ea8-4a-624bb8d933b8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.95.03370.8D8BB426; Tue,  5 Apr 2022 12:34:48 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220405033448epsmtip2cbcbbdfff2c9e41e4affa517ea08a2dd~i4rbd6IhO0865608656epsmtip2e;
        Tue,  5 Apr 2022 03:34:48 +0000 (GMT)
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
Date:   Tue,  5 Apr 2022 12:38:54 +0900
Message-Id: <20220405033854.110374-2-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405033854.110374-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmme7NHd5JBie281k8mLeNzeLyfm2L
        5sXr2Sx2NBxhtXg3V8bi/PkN7BabHl9jtbi8aw6bxYzz+5gszizuZXfg8ti0qpPNY//cNewe
        m5fUe/RtWcXo8XmTXABrVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJu
        qq2Si0+ArltmDtBJSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8
        dL281BIrQwMDI1OgwoTsjI3HrjEX/OOs+L9tHmMD42KOLkZODgkBE4l9ny4zdzFycQgJ7GCU
        6F2wjhXC+cQo0TFzIyOE85lR4s+vJkaYlpVbdrBBJHYxSvyb/5gVJCEk8JFRomtqNojNJqAt
        8X39YrBRIgKnGSUObz8K5jCDLNnV/p0JpEpYIEri/+wZYDaLgKpEw90LYJN4BewkPq+bzgqx
        Tl6i+98fli5GDg5OAXuJrS8jIUoEJU7OfMICYjMDlTRvnQ32hIRAI4fEtv5vTBC9LhInr26A
        miMs8er4FnYIW0ri87u9bBB2scTxHpB7QJobGCXO3jkA1WAsMetZOyPIYmYBTYn1u/RBTAkB
        ZYkjt6D28kl0HP7LDhHmlehoE4JoVJO4P/Uc1HQZiUlHVjJBlHhIXJ6jAQm3SYwSj9f/YJvA
        qDALyTezkHwzC2HvAkbmVYxiqQXFuempxUYFRvAYTs7P3cQITqJabjsYp7z9oHeIkYmD8RCj
        BAezkghvTpBnkhBvSmJlVWpRfnxRaU5q8SFGU2BQT2SWEk3OB6bxvJJ4QxNLAxMzM0NzI1MD
        cyVxXq+UDYlCAumJJanZqakFqUUwfUwcnFINTPM/TXgRZ/PvtWBg8i3DlD3qoi0G0zW9QmWe
        buX+8fRfU5xAW/qEVQsb43dzh70zLt0dzBzr4+G4Jbgx3OfCGtEM+7rcOQ+L+ObGpyff09rh
        6zb1/MXvn+acCH55eJ9Aw+a2JcKcLsvmtrHyx7x/7n+mka06vG1NwZ5tm6bIupjHdH18oK6s
        b/a2qcy6Lj/02mm+dTODPM+bKkW/srnxdOKNlT6pUcWGXepGfk5LY8vnPPMo23T+wbuJZp93
        nH40R1jfcFuw7aGORUt2ZMoXSE+NsDo1z7n3ntC0dRqvN017ejczWbIr/NABoR/7k40PCfz8
        YOgYPTlydsrCuW0tRjd3fvW9+/TJ3/xr2f4lE5VYijMSDbWYi4oTAbJX4gUrBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSvO6NHd5JBive61o8mLeNzeLyfm2L
        5sXr2Sx2NBxhtXg3V8bi/PkN7BabHl9jtbi8aw6bxYzz+5gszizuZXfg8ti0qpPNY//cNewe
        m5fUe/RtWcXo8XmTXABrFJdNSmpOZllqkb5dAlfGxmPXmAv+cVb83zaPsYFxMUcXIyeHhICJ
        xMotO9i6GLk4hAR2MErMbOxmgkjISCx/1scGYQtL3G85wgpR9J5RYuHplWAJNgFtie/rF4Ml
        RATOM0pMfvwGbBSzwB5GiTWzvzODVAkLREis2XaGEcRmEVCVaLh7gRXE5hWwk/i8bjorxAp5
        ie5/f1i6GDk4OAXsJba+jAQJCwGVHGu6xA5RLihxcuYTFhCbGai8eets5gmMArOQpGYhSS1g
        ZFrFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREc8FpaOxj3rPqgd4iRiYPxEKMEB7OS
        CG9OkGeSEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUzy
        DM72esfanXqNlk94yXwzNa1IfOWLOZ8MbD01djolqTMbyLfsnqvx+Onb/57m29ayKf9T6fhh
        maxyMGtf3ZUqn+yEbb3ePxdbWhuzvlPj+SW2Q7Lgx6Wfb5tDVugFFLB4XrXIrshIXXs75vTt
        2OuuaVO2zexfsXIR1wUpjpgUpcjFb3VDkuVZE732B/qq73k/zz50Rlz+jr93Js88cYqhzGBv
        +hn333cj1KTtliuwNKuuWShWbfB4mvb/V7GL5KYEKP9mdFxof9424FVS9Ts+D/aV39k7Qt8v
        VXsgP2H71Z7ob2fPaurH3nzyuyfm3bqwxkI5nQudye+Nfr9PdN+27/uRtZZ3ym7VXjw+KU+J
        pTgj0VCLuag4EQATeZFy5wIAAA==
X-CMS-MailID: 20220405033448epcas2p397080e15c54369d24eaf94c2a27bd06c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220405033448epcas2p397080e15c54369d24eaf94c2a27bd06c
References: <20220405033854.110374-1-jaewon02.kim@samsung.com>
        <CGME20220405033448epcas2p397080e15c54369d24eaf94c2a27bd06c@epcas2p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/tty/serial/samsung_tty.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index e1585fbae909..d362e8e114f1 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2480,12 +2480,26 @@ s3c24xx_serial_console_write(struct console *co, const char *s,
 			     unsigned int count)
 {
 	unsigned int ucon = rd_regl(cons_uart, S3C2410_UCON);
+	unsigned long flags;
+	int locked = 1;
 
 	/* not possible to xmit on unconfigured port */
 	if (!s3c24xx_port_configured(ucon))
 		return;
 
+	local_irq_save(flags);
+	if (cons_uart->sysrq)
+		locked = 0;
+	else if (oops_in_progress)
+		locked = spin_trylock(&cons_uart->lock);
+	else
+		spin_lock(&cons_uart->lock);
+
 	uart_console_write(cons_uart, s, count, s3c24xx_serial_console_putchar);
+
+	if (locked)
+		spin_unlock(&cons_uart->lock);
+	local_irq_restore(flags);
 }
 
 /* Shouldn't be __init, as it can be instantiated from other module */
-- 
2.35.1

