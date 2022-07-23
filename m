Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD6157EC76
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 09:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbiGWHiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 03:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiGWHiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 03:38:15 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C7211A1B;
        Sat, 23 Jul 2022 00:38:14 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gn24so6104746pjb.3;
        Sat, 23 Jul 2022 00:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=brR0MVXsmfnedFdVlx+Mtq+k2iIuOl3il9h6qHAj7S4=;
        b=Z/DCLUPE55617MED1Zs69n0XPiNK5iw5IYFnbPMcwPCdYzGShDyUFVciyjzLTmmh1E
         hfTgl/Sd/+tOUGrXHuOlBfA4u/JpdbhB5KwDwPr9NGqxNjfGJYKGcsUdnO3xrydvEQPF
         ICRHHYyioA5MkRB23bwWNBkYZnFW3yW9M6rx5YCpXtYKpB47D2VW+LlpB/E3Wn1ThkdL
         6U79OThEJ1sAPAZIlu3pz6cVqLnmti2PKUDcEsWs6yF9w/2RAiSUVPvfMcEQV1ur7iyG
         F/xuotm7DkMr8CiDwKyxc62QFIJMia84qE/VxjbHCzwDHqTQsNf/TyWiKm8G84DflUfr
         BzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=brR0MVXsmfnedFdVlx+Mtq+k2iIuOl3il9h6qHAj7S4=;
        b=ngCHbj4vjWXnz2oGbn4as4NFQHln9djBtc6GlH9mbvA3Ch4JvXI+WrvbB7BweuquXc
         36cB90UsGZ0EvjHRq2TpiQCGV+iZOKyA2oHDFUCw4xe0Mfv1ZataxjKj3p4SOYP5dJKD
         YcTLCe4gao3EeLRuTOnWprDJwy99P7DlkA3S+ICguNfnUKw9I1G2HU5+i3dTYd2AwKO7
         GnorH59+3/nh2bZJw5JG+nrA+wXeD2+Fkb864U4K3D1n9cx9B62mIfq5n0NBm+ZKNvGI
         rIFnrObQdDn9EfrckFCT4H+hDPwp+9RDjDG/elQLirkYUWfIrL6qIen5il6qlYjFiPi9
         HFrA==
X-Gm-Message-State: AJIora+RSciX4HCxr6XQvitJu8VU0tdF24EyV6MYsBxNkWUJx5b5eZgS
        zaz4a7sQNzL5mBG1uQjFQ2I=
X-Google-Smtp-Source: AGRyM1ug2HZs7aTnabxUvOumGaGm/5b2EsrVcDzfJOayyHaOGXGKQSEEj0+jortiUbh0gfjMaqhuEg==
X-Received: by 2002:a17:90a:e290:b0:1f2:190b:32b7 with SMTP id d16-20020a17090ae29000b001f2190b32b7mr21124329pjz.240.1658561893565;
        Sat, 23 Jul 2022 00:38:13 -0700 (PDT)
Received: from localhost.localdomain ([220.202.218.250])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902da8700b0016bfafffa0esm5042958plx.227.2022.07.23.00.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 00:38:13 -0700 (PDT)
From:   xy521521 <xy521521@gmail.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        EdisonZhang@zhaoxin.com, PeterWu@zhaoxin.com, cobechen@zhaoxin.com,
        wugaoquan@kylinos.cn, Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: [PATCH -next] usb: ehci: Read CMD_RUN instead of STS_HALT in ehci_halt with ZX-200
Date:   Sat, 23 Jul 2022 15:38:05 +0800
Message-Id: <20220723073805.23491-1-xy521521@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hongyu Xie <xiehongyu1@kylinos.cn>

Forcing HC to halt state is ensured by reading STS_HALT field in USBSTS
register every microsecond(2ms in total) after clearing CMD_RUN filed in
USBCMD register during initialization.

But sometimes the STS_HALT field in USBSTS is not set during that 2ms, i.e
ehci_handshake returns -ETIMEDOUT. And host controller won't work after
that, so does the device attached on it. This was first found on a system
with ZX-200 HC on it.

The interesting part is that if you ignore -ETIMEOUT returned from
ehci_handshak or read CMD_RUN instead and continue the initialization, the
HC works just fine.

So read CMD_RUN instead.

Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---
 drivers/usb/host/ehci-hcd.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 684164fa9716..a935cfb79bcc 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -181,6 +181,7 @@ static int tdi_in_host_mode (struct ehci_hcd *ehci)
 static int ehci_halt (struct ehci_hcd *ehci)
 {
 	u32	temp;
+	struct pci_dev  *pci_dev = to_pci_dev(ehci_to_hcd(ehci)->self.controller);
 
 	spin_lock_irq(&ehci->lock);
 
@@ -204,8 +205,14 @@ static int ehci_halt (struct ehci_hcd *ehci)
 	spin_unlock_irq(&ehci->lock);
 	synchronize_irq(ehci_to_hcd(ehci)->irq);
 
-	return ehci_handshake(ehci, &ehci->regs->status,
-			  STS_HALT, STS_HALT, 16 * 125);
+	if (((pci_dev->vendor == PCI_VENDOR_ID_ZHAOXIN) &&
+		(pci_dev->device == 0x3104) &&
+		((pci_dev->revision & 0xf0) == 0x90)))
+		return ehci_handshake(ehci, &ehci->regs->command, CMD_RUN,
+				0, 16 * 125);
+	else
+		return ehci_handshake(ehci, &ehci->regs->status, STS_HALT,
+				STS_HALT, 16 * 125);
 }
 
 /* put TDI/ARC silicon into EHCI mode */
-- 
2.25.1

