Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BA3493514
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 07:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351812AbiASGk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 01:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351814AbiASGkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 01:40:24 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC58C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 22:40:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so3000413ybg.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 22:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8U2NSEHKCUQ9Z36JnWsd++SgPVSc/KZrscz58kGHWbs=;
        b=IRSqYBoUeD7Ry93C2zrCYgsanGN31qieUkxi0BeTfinOsX6JpBzwbaqcpcyFqxF53p
         06IewAyfME4FVUIdzowKMLV3t2g/Cwb/7vvspipBtDa08Iq2QWPR35ESj7ELH41wavef
         8AUmVblRGqkDAX2TFq7SOtmQlaT5Hsvio/ujx+P2MIaj9JP0mwvlOv1Hsopjv0wTZnBd
         VGwB36GqnKnDVk6CjP/cUFqA7xp8pkQDhQXzWGICjpLYnvPaL5vSsUai3jKXDlvUzrPV
         FbT5s9+u+NTQTFk17dRIYQgZ1P57mx2pT45LmKZs+TbWJ1/02J8BmNuIHY3duTLMgLWT
         tGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8U2NSEHKCUQ9Z36JnWsd++SgPVSc/KZrscz58kGHWbs=;
        b=QugUccD5+6qauvKcF/Dg5DIBLAsVBdf18WhqbGR7uk/KHUlMcjyRNdJ8WW2I0mb8Oh
         EmNHXEfOOzz+7n3i2PWz8haAHoyJHOlEYncFtesBb7t0TS8AxNtU1yKUJlEz5btcZyhz
         qjY36s/06DSmYqRRsgNhFEraN9uDJLLGWMHDN8O1sb9wLl2NW0qZUAdJuM1UQg9Wjs/1
         s49x+Ct5ndA5SFVYWdoSw7/BTsuSJFxyrt/PRmZb0pQY9y26asxrdpI91xUt7dBRXGpE
         VqeWbcsCVMIlqrFkI89FcHBKrWdVvNUORcjzcTLOeT8UcjKfaZqE2ZMg8m0SZ/FNvlSw
         +Dcg==
X-Gm-Message-State: AOAM5333kDDyUfR/sca0k1Caa2ohVuoRrYHxEtFcIxZd7VhcP4eljhww
        /jWrfXMAJT/Qzj5Sgvvb9FaCceIs7Qfi
X-Google-Smtp-Source: ABdhPJw4oZplaLI2nBLpJgDmj7/V9O9mEV4kAhMMQKEjyAszy2Z9I1QfXjY8/d+wFeXvKFrQlCyN/+A6d/Yd
X-Received: from pumahsu.ntc.corp.google.com ([2401:fa00:fc:202:726e:776:90fe:956c])
 (user=pumahsu job=sendgmr) by 2002:a25:b599:: with SMTP id
 q25mr17915493ybj.274.1642574423209; Tue, 18 Jan 2022 22:40:23 -0800 (PST)
Date:   Wed, 19 Jan 2022 14:40:13 +0800
Message-Id: <20220119064013.1381172-1-pumahsu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v5] xhci: re-initialize the HC during resume if HCE was set
From:   Puma Hsu <pumahsu@google.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     s.shtylyov@omp.ru, albertccwang@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Puma Hsu <pumahsu@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When HCE(Host Controller Error) is set, it means an internal
error condition has been detected. Software needs to re-initialize
the HC, so add this check in xhci resume.

Cc: stable@vger.kernel.org
Signed-off-by: Puma Hsu <pumahsu@google.com>
---
v2: Follow Sergey Shtylyov <s.shtylyov@omp.ru>'s comment.
v3: Add stable@vger.kernel.org for stable release.
v4: Refine the commit message.
v5: Add a debug log. Follow Mathias Nyman <mathias.nyman@linux.intel.com>'s comment.

 drivers/usb/host/xhci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index dc357cabb265..41f594f0f73f 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1146,8 +1146,10 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
 		temp = readl(&xhci->op_regs->status);
 	}
 
-	/* If restore operation fails, re-initialize the HC during resume */
-	if ((temp & STS_SRE) || hibernated) {
+	/* If restore operation fails or HC error is detected, re-initialize the HC during resume */
+	if ((temp & (STS_SRE | STS_HCE)) || hibernated) {
+		xhci_warn(xhci, "re-initialize HC during resume, USBSTS:%s\n",
+			  xhci_decode_usbsts(str, temp));
 
 		if ((xhci->quirks & XHCI_COMP_MODE_QUIRK) &&
 				!(xhci_all_ports_seen_u0(xhci))) {
-- 
2.34.1.703.g22d0c6ccf7-goog

