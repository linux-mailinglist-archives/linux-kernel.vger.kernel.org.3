Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F25479894
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 05:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhLREYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 23:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhLREY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 23:24:28 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E36C061574;
        Fri, 17 Dec 2021 20:24:28 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id kc16so4288780qvb.3;
        Fri, 17 Dec 2021 20:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ow447+V1jLIH/iB1Z6ZgbSFicWsrQtS2HBi18SMymjI=;
        b=Tm2m6gB0oXXkwYqQqytMLeQSlFoELAY67iY60JFo1kJ9q9FfXeBpPeR0qHPhN9aIoj
         YCPqeygPHhU1D/n4wusxbrjjJ163RINK/Um1Yim6Bj8vj5TZ08glj3QwfgIfSCgfuazK
         5NBLqO7TvueKKYsZ4P9J6VnGrH85A5hP6klteGCIFvekOz1DKIW0+vdhByGmn6hD/pD+
         Zk3hya5XHmuLVzhtYmRgz/xS6iOTROkPT5YxrtT5dIrV8zLVEJi2hrPojImVeGD+c2Zh
         F6o7pUw+Lbg/OIghrvYT+sSpnsjxqrzUabJxOLjsT5dFZ25TcW8+wEXnZYhoYYMACyfn
         VhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ow447+V1jLIH/iB1Z6ZgbSFicWsrQtS2HBi18SMymjI=;
        b=bwlM2fvbUZ86X3KeLkpWZPJUGxAPMWT+BMcAdjW5pnPkTBkUuRSXYgkv/s0RHsfd8Z
         HfJOSLCCooaaD2EVpytHGyxSFlKDruu2Zv4VHX5bLGjW77V5vDHtYOoflPN5c+Hbpdgq
         bBhpVaSbxhHTuSjOxvFeEmE3Z4Yg9NCIPC8wHM6sCCsK/Vpf+cZ4t8WtfAJgAo8SqfFu
         JjZ387XfthpcClNHG1jFgRfvkDikBf7FN79R4jUd3YKbzwPKQWX5Izey1Smxv2lCh3zN
         8/rEwDmwv6fLJjX1hD5ab7DIHtKFMdU8MeNmtdjo5o6pi7bcGBnLd6iyE8OjqJr2kNQR
         rr2A==
X-Gm-Message-State: AOAM532CiV79B0ToCI2Kc5c/Y6cMW4jB+5bkIaYJUW8lbAnyFyHe63bk
        OoEH7e1QkbVO72XtvB/fn+NT5ptUSBiTkg==
X-Google-Smtp-Source: ABdhPJzNtU8NezgXuwPD7NMA6mdzfxgFmGcs3ws8qJb2r9F+tcbyVdWUunGBO0vL8gNmYbk6GS7ayA==
X-Received: by 2002:a05:6214:8c2:: with SMTP id da2mr5296213qvb.23.1639801466037;
        Fri, 17 Dec 2021 20:24:26 -0800 (PST)
Received: from julio.local ([2804:4ec:12c4:7500:e6f3:759c:d652:13f5])
        by smtp.gmail.com with ESMTPSA id r16sm8393793qta.46.2021.12.17.20.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 20:24:25 -0800 (PST)
From:   Julio Faracco <jcfaracco@gmail.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        axboe@kernel.dk, tglx@linutronix.de, damien.lemoal@wdc.com,
        dkadashev@gmail.com, paul.gortmaker@windriver.com,
        zhouyanjie@wanyeetech.com, niklas.cassel@wdc.com,
        penguin-kernel@i-love.sakura.ne.jp, macro@orcam.me.uk,
        caihuoqing@baidu.com, jcfaracco@gmail.com
Subject: [PATCH] usb: fixing some clang warnings inside usb host drivers
Date:   Sat, 18 Dec 2021 01:24:20 -0300
Message-Id: <20211218042420.28466-1-jcfaracco@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang is reporting some issues related variable values not used and
other issues inside some USB host drivers. This commit removes some
trashes and adds some strategies to mitigate those warnings.

The most important is the maxpacket not checking for zeros inside both
functions qtd_fill(). Even if this variable is always higher than zero,
it should be checked to avoid this kind of verbosity.

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
---
 drivers/usb/host/ehci-dbg.c     | 1 -
 drivers/usb/host/ehci-q.c       | 2 +-
 drivers/usb/host/ohci-dbg.c     | 1 -
 drivers/usb/host/oxu210hp-hcd.c | 2 +-
 4 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-dbg.c b/drivers/usb/host/ehci-dbg.c
index 0b7f1edd9eec..70b4ff65295a 100644
--- a/drivers/usb/host/ehci-dbg.c
+++ b/drivers/usb/host/ehci-dbg.c
@@ -903,7 +903,6 @@ static ssize_t fill_registers_buffer(struct debug_buffer *buf)
 	temp = scnprintf(next, size, "complete %ld unlink %ld\n",
 		ehci->stats.complete, ehci->stats.unlink);
 	size -= temp;
-	next += temp;
 #endif
 
 done:
diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index 2cbf4f85bff3..98cb44414e78 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -64,7 +64,7 @@ qtd_fill(struct ehci_hcd *ehci, struct ehci_qtd *qtd, dma_addr_t buf,
 		}
 
 		/* short packets may only terminate transfers */
-		if (count != len)
+		if (count != len && maxpacket > 0)
 			count -= (count % maxpacket);
 	}
 	qtd->hw_token = cpu_to_hc32(ehci, (count << 16) | token);
diff --git a/drivers/usb/host/ohci-dbg.c b/drivers/usb/host/ohci-dbg.c
index 4f267dc93882..6fc9c46ffe3c 100644
--- a/drivers/usb/host/ohci-dbg.c
+++ b/drivers/usb/host/ohci-dbg.c
@@ -561,7 +561,6 @@ static ssize_t fill_periodic_buffer(struct debug_buffer *buf)
 
 			} else {
 				/* we've seen it and what's after */
-				temp = 0;
 				ed = NULL;
 			}
 
diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
index e82ff2a49672..8a20d9d3c377 100644
--- a/drivers/usb/host/oxu210hp-hcd.c
+++ b/drivers/usb/host/oxu210hp-hcd.c
@@ -1232,7 +1232,7 @@ static int qtd_fill(struct ehci_qtd *qtd, dma_addr_t buf, size_t len,
 		}
 
 		/* short packets may only terminate transfers */
-		if (count != len)
+		if (count != len && maxpacket > 0)
 			count -= (count % maxpacket);
 	}
 	qtd->hw_token = cpu_to_le32((count << 16) | token);
-- 
2.31.1

