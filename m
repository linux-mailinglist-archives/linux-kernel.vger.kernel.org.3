Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A244F76F7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241503AbiDGHOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241457AbiDGHOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:14:31 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28512F383
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:12:32 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220407071227epoutp0132e0f25eb4269663d6e4893f8a5d1702~ji8Bxhs8P1097410974epoutp01N
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:12:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220407071227epoutp0132e0f25eb4269663d6e4893f8a5d1702~ji8Bxhs8P1097410974epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649315547;
        bh=ZnyEmVL3ZHhbWaj7peONv8ze7ksH6X5qLj9vqgtd1I4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IFeYf5/fT+NrqhaTYo2kdz7x2Lp7iQ1oYjgypqSaXj08d5h+GuK2Smh9GgCq3Urbx
         rS91fcb4OgCYcespsCUyPo7oy3W5L09zJNaQybt0LjHOb1CZnAPQj+Lb6/M2oC+IS3
         qPgCRzYb69D10p4lkPx0hIc0Nhxy5pt6QG8TfQOs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220407071226epcas2p4355bdef78da7e26911fc40dbae6e5960~ji8BR9VNb0437904379epcas2p4O;
        Thu,  7 Apr 2022 07:12:26 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.90]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KYsyd0PKwz4x9QH; Thu,  7 Apr
        2022 07:12:25 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.18.40405.7DE8E426; Thu,  7 Apr 2022 16:12:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220407071223epcas2p16bb11821a0894a3375e84d17c4ff0844~ji7_GH5xo3124531245epcas2p1s;
        Thu,  7 Apr 2022 07:12:23 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220407071223epsmtrp1d9a9050dab0233aab6fe80d18e4bbab5~ji7_FeKLK0308203082epsmtrp1f;
        Thu,  7 Apr 2022 07:12:23 +0000 (GMT)
X-AuditID: b6c32a46-ba1ff70000009dd5-16-624e8ed7a238
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.AE.03370.7DE8E426; Thu,  7 Apr 2022 16:12:23 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220407071222epsmtip19b83dd3634c87ce13bb390bd4b6d0c8c~ji791aH2v2354723547epsmtip1X;
        Thu,  7 Apr 2022 07:12:22 +0000 (GMT)
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
Subject: [PATCH v3 1/1] tty: serial: samsung: add spin_lock for interrupt
 and console_write
Date:   Thu,  7 Apr 2022 16:16:19 +0900
Message-Id: <20220407071619.102249-2-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407071619.102249-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmhe71Pr8kg/U/DCwezNvGZnF5v7ZF
        8+L1bBY7Go6wWrybK2Nx/vwGdotNj6+xWlzeNYfNYsb5fUwWZxb3sjtweWxa1cnmsX/uGnaP
        zUvqPfq2rGL0+LxJLoA1KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
        1VbJxSdA1y0zB+gkJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWle
        ul5eaomVoYGBkSlQYUJ2RsO1h8wFfzkrFn76ydLAuJSji5GDQ0LARGLWfPsuRi4OIYEdjBKz
        mr8xdjFyAjmfGCUW7o6FSHxmlNhwYAITSAKk4XjDDzaIol2MEhPWcEIUfWSUuN0+nQUkwSag
        LfF9/WJWkISIwGlGicPbj4I5zCA7drV/BxslLBArMenlbFYQm0VAVeLPxodgu3kF7CR+3JvN
        BrFOXqL73x+wqZwC9hInly2DqhGUODnzCVicGaimeetsZpAFEgI/2SWO7VrODtHsIjHv9jeo
        u4UlXh3fAhWXknjZ3wZlF0sc7wE5CKS5gVHi7J0DrBAJY4lZz9oZQaHELKApsX6XPiTAlCWO
        3ILayyfRcfgvO0SYV6KjTQiiUU3i/tRzUOfLSEw6spIJosRDYuWjXEhgTWKUeHrhL/sERoVZ
        SL6ZheSbWQh7FzAyr2IUSy0ozk1PLTYqMIJHcHJ+7iZGcArVctvBOOXtB71DjEwcjIcYJTiY
        lUR4q3J9koR4UxIrq1KL8uOLSnNSiw8xmgLDeiKzlGhyPjCJ55XEG5pYGpiYmRmaG5kamCuJ
        83qlbEgUEkhPLEnNTk0tSC2C6WPi4JRqYJrquFrBKjrqpLzYwUy1W5+Xfw5gal7cWJVe/FOb
        k/2nwwrB0yHs2zI/v30/+ckNjktSJ9/xT58yL8Gp6q+R+mVXP33mw/yi+xUC1DcsePPaMmpJ
        +Kniv+znNm7aYLTv607lMz9NGwIviL8RbL6oeo9tokm/x1xOvjb5mYlRWeyVvzUaviy4Zen0
        ueDuDRPNtzo22myqLSw1Nt/es7qsWvPacteSQ++3ejUwnba0sy/wWKvPcJnt3UL1WafZBHzi
        2vawu62wLLFNMc4yra9UYlliXbD8ym/uL8JHF3yPEjxyNcfBnD3T/qbhq63FKSz5L/ktdovu
        3D7v+/STeaFxbc+lLt2xL/Hb+IvL7d3n60osxRmJhlrMRcWJAFpWr00qBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsWy7bCSnO71Pr8kgyWr2S0ezNvGZnF5v7ZF
        8+L1bBY7Go6wWrybK2Nx/vwGdotNj6+xWlzeNYfNYsb5fUwWZxb3sjtweWxa1cnmsX/uGnaP
        zUvqPfq2rGL0+LxJLoA1issmJTUnsyy1SN8ugSuj4dpD5oK/nBULP/1kaWBcytHFyMkhIWAi
        cbzhB1sXIxeHkMAORom2ifdZIRIyEsuf9bFB2MIS91uOsEIUvWeU2DJ3A1gRm4C2xPf1i8ES
        IgLnGSUmP34DNopZYA+jxJrZ35lBqoQFoiW+3GwGs1kEVCX+bHzICGLzCthJ/Lg3G2qFvET3
        vz8sIDangL3EyWXLwGqEgGr2TLwJVS8ocXLmE7AaZqD65q2zmScwCsxCkpqFJLWAkWkVo2Rq
        QXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwyGtp7WDcs+qD3iFGJg7GQ4wSHMxKIrxVuT5J
        QrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTAJzxaYtPrc
        u91+Gy+++NeSc9ase8dX5ath8eanbPh4i4puvyr6uGG1zqtV+gbMXiH9S9c3vJvulFDgIWCn
        53MwXtbqYfi2Uxt2f+/6av6ErYBZ+7O44ZVH1Vp7t3ewvu+Q7tez0D5sXNi+7W/tiiVJX2dV
        vvFyf/f90JWURgezp3OsJvs32jjp2ac8bzne5DeTZ7/3wU2r1wVuuq4g90A8PcxCqj9yy1th
        0aWZ/+y5P9k3eFhNkzI5+r9AUm6h1unWfc9SH64NcWpOfRWz49zl24etr8Wkz9334sSfhouJ
        tm/nzclwkar4+nNNjyvnd9N9x+a8OHG3aT/PvZysY/Gix0UnP36hc7Zot1cAt4uXEktxRqKh
        FnNRcSIAtWh3uegCAAA=
X-CMS-MailID: 20220407071223epcas2p16bb11821a0894a3375e84d17c4ff0844
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220407071223epcas2p16bb11821a0894a3375e84d17c4ff0844
References: <20220407071619.102249-1-jaewon02.kim@samsung.com>
        <CGME20220407071223epcas2p16bb11821a0894a3375e84d17c4ff0844@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index e1585fbae909..8af5aceb9f4e 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2480,12 +2480,24 @@ s3c24xx_serial_console_write(struct console *co, const char *s,
 			     unsigned int count)
 {
 	unsigned int ucon = rd_regl(cons_uart, S3C2410_UCON);
+	unsigned long flags;
+	bool locked = true;
 
 	/* not possible to xmit on unconfigured port */
 	if (!s3c24xx_port_configured(ucon))
 		return;
 
+	if (cons_uart->sysrq)
+		locked = false;
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

