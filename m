Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28D1481200
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 12:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239915AbhL2L0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 06:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239917AbhL2L0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 06:26:00 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF521C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 03:26:00 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id m27-20020a62a21b000000b004bac77dbb41so11469054pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 03:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=e7WgSppgHVTiS0GBY6FQvAHLTqvWZ2JPhKURhagZADA=;
        b=phMArrDzw+X3VBxeIWtJfMPIByM7/dJOeBoLr6QESQIYE1PK7Z4nuL2ZTE5Mph8Baw
         Wg19OqARLbBj/MWRBsZ6b78f83N9RdCcXySjaX9c3gAdA41NvnpQF0+tmjdOfa3ZuCJL
         xHpOpyR7tGcBeHD47PaXL+giTlONVHJad4mERZvdy5m8d+I0uQcMAM5ToXMeAMThykIk
         tpF7sfHApshEV+h2/cg53SEBeWIkcnzPg4uKkHMa/Ml1+/pA6rajH0kD+yb34hVjYE6+
         0ydWdHeqTuDPAHu8a5lnJPf8/uHWSS3k1A8AAoSYV1yqcjwFl+sUN+NY+s6/uPODdAfK
         cESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=e7WgSppgHVTiS0GBY6FQvAHLTqvWZ2JPhKURhagZADA=;
        b=ZnThWeS7eESApcFDqBl+CKtHSeinZn5BTgG9tZmU/gX5QKEdP/rc+RtaQeK/qszqdb
         9yEdOMCHAWhMBVLgmlENhJZyNyCaguYF+PbCNLKWuRq/aMeTMYyA7F84OSXd2YY3B9cN
         8k9ryW6rGOojUb3MwpVU6GPg9xIIeyDINlt4xoNny9nfOdcpvnnvL6OdRMgZh7qM05T5
         utr2DD13tbWC/WJgIUa4CDpGxlptnLxXFEutaWu5TqUOlsFr5jETfbIVvqmlrrjN1F9P
         mfIqIhil9CPRdPfthZppNQuE4q3gFX6lZ/cegilVdpMDDIrScKONuZ6kAZoav5xcW9+0
         /+Rg==
X-Gm-Message-State: AOAM5321O78Ibe//sEGwrjFjLNi1oMBotZU9ZWs1FhkbhSxBboDfzCxE
        R+0ZZFCPfvEgGyeMcQGdbk8wSluu9KgF
X-Google-Smtp-Source: ABdhPJyN6VDij37BK+e9Kjbzovo54XwINCtUdWdKaDYQ05EUPC55hW+ZbpVRS2lGsCh64h75rVS2jutUb5Qu
X-Received: from pumahsu.ntc.corp.google.com ([2401:fa00:fc:202:51fc:cf30:243:df6e])
 (user=pumahsu job=sendgmr) by 2002:aa7:8c17:0:b0:4ba:7f42:68de with SMTP id
 c23-20020aa78c17000000b004ba7f4268demr26708635pfd.18.1640777159719; Wed, 29
 Dec 2021 03:25:59 -0800 (PST)
Date:   Wed, 29 Dec 2021 19:25:51 +0800
Message-Id: <20211229112551.3483931-1-pumahsu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3] xhci: re-initialize the HC during resume if HCE was set
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
error condition has been detected. It needs to re-initialize
the HC too.

Cc: stable@vger.kernel.org
Signed-off-by: Puma Hsu <pumahsu@google.com>
---
v2: Follow Sergey Shtylyov <s.shtylyov@omp.ru>'s comment.
v3: Add stable@vger.kernel.org for stable release.

 drivers/usb/host/xhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index dc357cabb265..ab440ce8420f 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1146,8 +1146,8 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
 		temp = readl(&xhci->op_regs->status);
 	}
 
-	/* If restore operation fails, re-initialize the HC during resume */
-	if ((temp & STS_SRE) || hibernated) {
+	/* If restore operation fails or HC error is detected, re-initialize the HC during resume */
+	if ((temp & (STS_SRE | STS_HCE)) || hibernated) {
 
 		if ((xhci->quirks & XHCI_COMP_MODE_QUIRK) &&
 				!(xhci_all_ports_seen_u0(xhci))) {
-- 
2.34.1.448.ga2b2bfdf31-goog

