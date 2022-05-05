Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110D151BD73
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353107AbiEEKuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236767AbiEEKuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:50:16 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC5B15FD4
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 03:46:36 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220505104631euoutp026dfcabb9e523704208aa4d3b718e6b33~sL67cPb252602726027euoutp02E
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 10:46:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220505104631euoutp026dfcabb9e523704208aa4d3b718e6b33~sL67cPb252602726027euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651747591;
        bh=mg/NUpBY85tB1dAupvcSEb0snLTPuulD/LMLPpTmxfA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=AbZhCDn8x5mthXKDm2QEAcqwFUvkgZ+ku/L/kiLkvHrNHYQILbJIW3DG0nw8Ma0cs
         +ZgndOTdL4RlAT64Q2CB6vDh9PgHxjkHxXjcYeggDK4ad3Uc2odLraDXUgYM8djol9
         9Hh/ezizFRAMPXKXC7agPNWrKTw3vuculGlW/H+A=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220505104630eucas1p12367c46d6e73cf19feef790433066908~sL665S-HR2131621316eucas1p1g;
        Thu,  5 May 2022 10:46:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 15.EF.10260.60BA3726; Thu,  5
        May 2022 11:46:30 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220505104630eucas1p1e3797aef5ed7f54f861bf3622b542713~sL66c4r_60413904139eucas1p1W;
        Thu,  5 May 2022 10:46:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220505104630eusmtrp2b83a1c239c554e2cc4e88e625085293a~sL66cNN8o1534715347eusmtrp2Z;
        Thu,  5 May 2022 10:46:30 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-0e-6273ab06046b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 93.9D.09404.60BA3726; Thu,  5
        May 2022 11:46:30 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220505104629eusmtip1c1d8e969f99ec7f9de3c014dc1f84093~sL66FQA6M1420014200eusmtip1W;
        Thu,  5 May 2022 10:46:29 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] usb: dwc2: gadget: don't reset gadget's driver->bus
Date:   Thu,  5 May 2022 12:46:18 +0200
Message-Id: <20220505104618.22729-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsWy7djP87psq4uTDOY+1rJoXryezaLx1152
        i8u75rBZzDi/j8li0bJWZou1R+6yW0z4fYHNgd1j/9w17B6z7/5g9OjbsorRY8v+z4wenzfJ
        BbBGcdmkpOZklqUW6dslcGXMWmBS8JS/4vLaz8wNjPt5uxg5OSQETCTa3k9i72Lk4hASWMEo
        sW3ZYVYI5wujxJ2WH2wQzmdGiav/FjPBtKxq6IRKLGeUmDLjOjtcy/Tni9hAqtgEDCW63naB
        2SICCRJHNr9nBrGZBbYySuz47dnFyMEhLOAise+ZCEiYRUBVYv6/O2AlvAK2En2Hv0Itk5dY
        veEAM8h8CYFGDok/K2aygPRKAPUu/6UFUSMs8er4FnYIW0bi/875TBAl+RJ/ZxhDhCskrr1e
        wwxhW0vcOfeLDaSEWUBTYv0ufYiwo8T/hm42iE4+iRtvBSHu5ZOYtG06M0SYV6KjTQiiWk1i
        1vF1cDsPXrgENdxD4sqjSSwgtpBArMTyS2/ZJjDKzULYtYCRcRWjeGppcW56arFxXmq5XnFi
        bnFpXrpecn7uJkZgCjj97/jXHYwrXn3UO8TIxMF4iFGCg1lJhNd5aUGSEG9KYmVValF+fFFp
        TmrxIUZpDhYlcd7kzA2JQgLpiSWp2ampBalFMFkmDk6pBqaak8VXegXPPJh8ZtKH1vMRj4OO
        vYpS79g6Pefmb5ZrUxeU8GwJ+D1JgVEp/86Bv1Vzj/iev7xV6Mzem48v3jwT//5USYH85lVX
        llx43GcXxhBgtnHl3fg7LxZMu/Hs7N+Vfg2r/y/syGFR7Njx0kTpbjPbycvnnynvkI6a963f
        RKb7ZcY2zYnOzLpLjmQkzfq1t/LY7KbaM/JRy2eIHZZ8dKx6afcF6Wh9T5aqZcL1p87MFE36
        upC17mtDo9nnl7571FkWrbxpEfSXNTIo7eo2HjZ2m9/bvve/Wvk2xkxfdO9Lk7cX7qqt3HJd
        40eO58EUnfuLLzyonBUVcn33zQ/3bL7/2rFjUcRnbwNlT89ZBdpKLMUZiYZazEXFiQAgdz8h
        cAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsVy+t/xu7psq4uTDLr3C1o0L17PZtH4ay+7
        xeVdc9gsZpzfx2SxaFkrs8XaI3fZLSb8vsDmwO6xf+4ado/Zd38wevRtWcXosWX/Z0aPz5vk
        Alij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJm
        LTApeMpfcXntZ+YGxv28XYycHBICJhKrGjrZuhi5OIQEljJKdP5/xwSRkJE4Oa2BFcIWlvhz
        rQuq6BOjxJGfv1hAEmwChhJdb0ESnBwiAkkS15+cZgEpYhbYziix9EU/cxcjB4ewgIvEvmci
        IDUsAqoS8//dYQaxeQVsJfoOf4VaJi+xesMB5gmMPAsYGVYxiqSWFuem5xYb6RUn5haX5qXr
        JefnbmIEhuC2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrzOSwuShHhTEiurUovy44tKc1KLDzGa
        Au2byCwlmpwPjIK8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQYm
        2Vs+r/envj32Y8mRL0vjW68qGRum8SkUFRkIvP9n/PteECNr4poHP/gnmi5d8Si2NSdEs/nu
        46sML9viA9uY816bfdn0abbmfV6LQ0FfWjZPDNtu5uFtv2xLseukHZu3yE5dVTij2jwmfF3X
        mpsmujdPGIk9ePC5Pihu72qZ5BU2i3U//LrTPHHWbp6l15ivOCz9rPT24cEvXPFnNgSsywzm
        D771fulJg91doruWtM3U+Zc5TX/Z+SOchS9ffNz9ubA2purava+MYtqPcvliUo7zm4i9N5hY
        8sa+w2qt4tZiGck4OZVEyzDlIjZGNck/rfzqLHe/qz9+3/79n/nFY5a+mlfsJl0Uiu+0fXR6
        ixJLcUaioRZzUXEiADm9YNfKAgAA
X-CMS-MailID: 20220505104630eucas1p1e3797aef5ed7f54f861bf3622b542713
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220505104630eucas1p1e3797aef5ed7f54f861bf3622b542713
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220505104630eucas1p1e3797aef5ed7f54f861bf3622b542713
References: <CGME20220505104630eucas1p1e3797aef5ed7f54f861bf3622b542713@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UDC driver should not touch gadget's driver internals, especially it
should not reset driver->bus. This wasn't harmful so far, but since
commit fc274c1e9973 ("USB: gadget: Add a new bus for gadgets") gadget
subsystem got it's own bus and messing with ->bus triggers the
following NULL pointer dereference:

dwc2 12480000.hsotg: bound driver g_ether
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in: ...
CPU: 0 PID: 620 Comm: modprobe Not tainted 5.18.0-rc5-next-20220504 #11862
Hardware name: Samsung Exynos (Flattened Device Tree)
PC is at module_add_driver+0x44/0xe8
LR is at sysfs_do_create_link_sd+0x84/0xe0
...
Process modprobe (pid: 620, stack limit = 0x(ptrval))
...
 module_add_driver from bus_add_driver+0xf4/0x1e4
 bus_add_driver from driver_register+0x78/0x10c
 driver_register from usb_gadget_register_driver_owner+0x40/0xb4
 usb_gadget_register_driver_owner from do_one_initcall+0x44/0x1e0
 do_one_initcall from do_init_module+0x44/0x1c8
 do_init_module from load_module+0x19b8/0x1b9c
 load_module from sys_finit_module+0xdc/0xfc
 sys_finit_module from ret_fast_syscall+0x0/0x54
Exception stack(0xf1771fa8 to 0xf1771ff0)
...
dwc2 12480000.hsotg: new device is high-speed
---[ end trace 0000000000000000 ]---

Fix this by removing driver->bus entry reset.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/usb/dwc2/gadget.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index eee3504397e6..fe2a58c75861 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -4544,7 +4544,6 @@ static int dwc2_hsotg_udc_start(struct usb_gadget *gadget,
 
 	WARN_ON(hsotg->driver);
 
-	driver->driver.bus = NULL;
 	hsotg->driver = driver;
 	hsotg->gadget.dev.of_node = hsotg->dev->of_node;
 	hsotg->gadget.speed = USB_SPEED_UNKNOWN;
-- 
2.17.1

