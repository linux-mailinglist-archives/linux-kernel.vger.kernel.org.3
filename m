Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314D44806A6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 07:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbhL1GDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 01:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbhL1GDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 01:03:18 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDF5C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 22:03:18 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s83-20020a255e56000000b0060c46cc1890so11244824ybb.16
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 22:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Zn+A9HVWRK5K/dRlJI4tJZLeYf7dlCPThs0O3iIpY8w=;
        b=UmnDHa76s6CWzJhDp5zeaRcHprWSXl+xXWXeqXjsEiZSVZieeUVf62Bmr/s/XbA47t
         SxB8S+q589IyfEmUEyGyOnjv7IITchgd/Rc+lRQmgDfn5hw1tNkWFkXIFRG4RxL1nR8H
         Y79vnFyNFvxiCsdhqHgD5lp6oh132+fKqZU8EImDXRfmTTvpw9UwPTHYQdURW8MbMPyr
         ZXbWgJdhiPxAOMIVYsFoOzuSnRuRUFrqGsZ/iZEQ5wlgCeiORcTz2RqP2KMX4RHORT3s
         J4BIpkTk807jg6m+Q6lC81E3m0xYDKkNWOpmLno3VtX8T0SxOPz6+wt4UX10qHBfLQ2T
         P8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Zn+A9HVWRK5K/dRlJI4tJZLeYf7dlCPThs0O3iIpY8w=;
        b=Zi387ujG2bk2e3oNcoSWcukRaNU6Fz1UmI5dzTAQyf8b4Ng/lBd/ajPAFZhCEatlVv
         KtlhVgszKhtp6p1pJgQSA7cj3JznWbn2IjV24tQ+BOLUA2+/wov9SIT8UnAsxeaEDsfc
         dQ3NY/8vPExdP3JGFKOWNaVCRMeaibPc3qeqsJFRVN/wGKx6temjjFbfginHZiHbp5hF
         CJSrv6632nafyTrk8plJZhdqVzJFrrcvYHmsWjw/6rOeW5ZFGOqI7UWIGIDpfKOlqyWR
         5zyJY8SNeJ9koxXNYJYggeVkY0qIf7OXtRgQKphPu8tk9tfA3nWGzXOS55G1MRLdavjS
         /GKg==
X-Gm-Message-State: AOAM531YZSa0fpVT2loFYMK0Q5y+MHRDw3Qa1cVMVUrBwFjZ4TvyeKV3
        F66EuIFJ/2feMJ7H6gIhoJ7SL7ExZk2x
X-Google-Smtp-Source: ABdhPJzbFuNpZudtTehw+vFnQNlHwReEVcccW/za68v0MmgNCYp2o46qLtj5skHRAIB9CbPBXzAneTwV0x7l
X-Received: from pumahsu.ntc.corp.google.com ([2401:fa00:fc:202:2dc0:d0af:9576:e31])
 (user=pumahsu job=sendgmr) by 2002:a25:8547:: with SMTP id
 f7mr1217274ybn.659.1640671397304; Mon, 27 Dec 2021 22:03:17 -0800 (PST)
Date:   Tue, 28 Dec 2021 14:02:46 +0800
Message-Id: <20211228060246.2958070-1-pumahsu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH] xhci: re-initialize the HC during resume if HCE was set
From:   Puma Hsu <pumahsu@google.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     albertccwang@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Puma Hsu <pumahsu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When HCE(Host Controller Error) is set, it means an internal
error condition has been detected. It needs to re-initialize
the HC too.

Signed-off-by: Puma Hsu <pumahsu@google.com>
---
 drivers/usb/host/xhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index dc357cabb265..c546d9533410 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1146,8 +1146,8 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
 		temp = readl(&xhci->op_regs->status);
 	}
 
-	/* If restore operation fails, re-initialize the HC during resume */
-	if ((temp & STS_SRE) || hibernated) {
+	/* If restore operation fails or HC error is detected, re-initialize the HC during resume */
+	if ((temp & STS_SRE) || (temp & STS_HCE) || hibernated) {
 
 		if ((xhci->quirks & XHCI_COMP_MODE_QUIRK) &&
 				!(xhci_all_ports_seen_u0(xhci))) {
-- 
2.34.1.448.ga2b2bfdf31-goog

