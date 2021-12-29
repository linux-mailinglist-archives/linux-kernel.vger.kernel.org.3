Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467C148103D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 07:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbhL2GBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 01:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbhL2GBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 01:01:08 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C08AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 22:01:08 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id p1-20020a17090a680100b001b1ea621b81so13456207pjj.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 22:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tQelzoARs5ra+pSWLPhaNJDMAtSK+jHnIMtEXaTxZ84=;
        b=tajqY5NjUcaY8lTtNNrIXtWpibx6s8oiWhvC2kChhIjnWlk1XI3SQsXycdIeyHksBY
         LsgZElbl3ds+8TZIm3ct/Annr7d5xGx2SqmuTAtYMVNhveCYw353U7ekdnryBjQ+4lTm
         jE/BxHwrpNYddsK5R0L2eP779/ZoNdqqq6iE8i1F8Wv8ymuay/EVXxCjPYoIJskd7FTt
         dJmVMAgfvmFbRgkXBy7GmBY5yCO2zsIqf4gIzEoNkZ1aiVgfOzDzaPcCixW41nTDHMhh
         8OkR1hGn+5rIHVldVuhPpIe4PLQF6ftruhOyMFlPxcFLl1i2XCYxdeAE1g0T8mPjG5my
         ai+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tQelzoARs5ra+pSWLPhaNJDMAtSK+jHnIMtEXaTxZ84=;
        b=PkYpplggRMQfv3YjFY2qrHEiWc2Ak3BjQ6HtYeWFAXuM0sy7Er5DVkc3DwvjA78juK
         oUyoNlz2OpgMprPkh1GysckzAwdrW2AW5WQDJYRKZO2G1zVOYcg0gykovDEfM9VsVJRL
         MWUViVDrypj58DLQ8WvCkhlBgTeJc922QJTgGLJS81yT2/UyknkMLJ9Povefu9CB39Fd
         MyoZCk22tYJwSDyOEPY/xG+HlQCd9e6sW6ywFtlIwQpVDtcBacSZ9MC9Qok6D9OHlVwZ
         oOuzgmqxPRuzuZWERmJKNf2qrVS/mLTGHNhali0RWloM5/E7g8NTV/1OkBarEVft312d
         DCyw==
X-Gm-Message-State: AOAM532jWjlancHFO4SKDgXhlKZtgw18GEQKUFtcIBYoQKQV6grsvsig
        jiJCdic+6kyfMfJuxWl704+RsbqhKZ2B
X-Google-Smtp-Source: ABdhPJxRvmN18eh1dLSwUNAh64RdQLY2KNOiIVk1dse7p0r77U6eYtX15Qg6TCJuwcaaS1n5DRMDntNTDq+r
X-Received: from pumahsu.ntc.corp.google.com ([2401:fa00:fc:202:51fc:cf30:243:df6e])
 (user=pumahsu job=sendgmr) by 2002:a05:6a00:10cf:b0:4a3:124d:bb81 with SMTP
 id d15-20020a056a0010cf00b004a3124dbb81mr25771116pfu.75.1640757667499; Tue,
 28 Dec 2021 22:01:07 -0800 (PST)
Date:   Wed, 29 Dec 2021 14:00:14 +0800
Message-Id: <20211229060013.3366166-1-pumahsu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v2] xhci: re-initialize the HC during resume if HCE was set
From:   Puma Hsu <pumahsu@google.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     s.shtylyov@omp.ru, albertccwang@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Puma Hsu <pumahsu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When HCE(Host Controller Error) is set, it means an internal
error condition has been detected. It needs to re-initialize
the HC too.

Signed-off-by: Puma Hsu <pumahsu@google.com>
---
v2: Follow Sergey Shtylyov <s.shtylyov@omp.ru>'s comment.

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

