Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9AE48CB9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356904AbiALTMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356642AbiALTLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:11:06 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5438FC033277
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:10:57 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id hv15so7029376pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pKeAIKPGnBe5p4mKBOYRyjPyKIPYZXrfJeUjwODaD04=;
        b=O9xzxnEyN48+XuI6KdJAjnPm1qqgTtzP1kc0YLwuJejoGCDPV/ekTNYZ/Lo7B1X01m
         jIyns4PECcoO+KuOt93ZVQfVzz2TQ38CLaZBa/EAt/RzdMN4/QVe5Qxhapej9ohQ/vod
         cZRi0OKSOXuGRzsc1zuRfbw/f5496CPT7mZZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pKeAIKPGnBe5p4mKBOYRyjPyKIPYZXrfJeUjwODaD04=;
        b=bPPeoNqs3qdJuhYXC3D8CX9lSvDPq+eg6OhPaUeLBwYwemW8PQFS1WucloFA9XcbV8
         EZr9UnGA2x38icDjFYPikO7EpmLRAKHGv3Y7HpHpn+qy9/SAWjh1AmQH72kSdGNbUMEs
         kFuQnQVlli1fbbFr7/PwVwScRKfZ7oq3bdIfTcrU8VjhNtVrE6RMVSvFnIXBEbyDHgp1
         sWVvNUJRS+B5mir1rsV4U2db69SrjmuV3tGPhS4cD8c2B2p3hGGNLtN9kjV4OhDsgxnl
         7h6aptP0JhlS17q6ppF/kx4FszHR3IcTvcM/x0uM8tN3zfFLjzpXnDsu4KdgFALOqepd
         1+Fw==
X-Gm-Message-State: AOAM532QXM41NWStTzG+gmbdEMVjbnuFbG2bpw9ZH/IJcBLGzKqqL+ka
        5xGU4NqMnGFtAZNEiHJLBO3xwQ==
X-Google-Smtp-Source: ABdhPJwFVqMt/whp1hvarNmRUEpprD9igUYqty+P+1qtyx4QHrs7Sz6wMecsVhJczPLGXbJP2yPZWg==
X-Received: by 2002:a17:90b:1d0b:: with SMTP id on11mr10638905pjb.114.1642014656908;
        Wed, 12 Jan 2022 11:10:56 -0800 (PST)
Received: from localhost ([2620:15c:202:201:f6eb:5b26:28c:1ca5])
        by smtp.gmail.com with UTF8SMTPSA id z3sm381030pgc.45.2022.01.12.11.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 11:10:56 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-usb@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v19 2/5] driver core: Export device_is_bound()
Date:   Wed, 12 Jan 2022 11:10:45 -0800
Message-Id: <20220112111028.v19.2.Ie1de382686d61909e17fa8def2b83899256e8f5d@changeid>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220112191048.837236-1-mka@chromium.org>
References: <20220112191048.837236-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export device_is_bound() to enable its use by drivers that are
built as modules.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v19:
- none

Changes in v18:
- patch added to the series

 drivers/base/dd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 68ea1f949daa..07eefddd4a77 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -370,6 +370,7 @@ bool device_is_bound(struct device *dev)
 {
 	return dev->p && klist_node_attached(&dev->p->knode_driver);
 }
+EXPORT_SYMBOL_GPL(device_is_bound);
 
 static void driver_bound(struct device *dev)
 {
-- 
2.34.1.575.g55b058a8bb-goog

