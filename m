Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC7946751B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350424AbhLCKeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:34:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380092AbhLCKe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638527463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7AQ+sijhqr1hLh8k3G0hBUKnAnkPkK4JtbjwrpiEz80=;
        b=OR2lKVvGX7eNWlwiuSWG7OqMZOwDqVVcBUBbSojWrUVNWBYXMKcH2rtwmmATwSXzMUksYq
        4R6IqlLCm9vSyQfBuKfQAADWmHgVZoBkborLY7m0OLzoNdujYVwwg16NNqJsPi52vCPvjX
        1egoakz8xwNlTLT+IFVLDg83Q7Ifxxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-WVL18RYTPdyq0hCM-6ohjQ-1; Fri, 03 Dec 2021 05:30:58 -0500
X-MC-Unique: WVL18RYTPdyq0hCM-6ohjQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C79A42F24;
        Fri,  3 Dec 2021 10:30:55 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F3AF60843;
        Fri,  3 Dec 2021 10:30:51 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v7 13/14] media: ipu3-cio2: Call cio2_bridge_init() before anything else
Date:   Fri,  3 Dec 2021 11:28:56 +0100
Message-Id: <20211203102857.44539-14-hdegoede@redhat.com>
In-Reply-To: <20211203102857.44539-1-hdegoede@redhat.com>
References: <20211203102857.44539-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since cio2_bridge_init() may now return -EPROBE_DEFER it is best to
call it before anything else.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v6:
- New patch in v6 of this patch series
---
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
index e2874fee9530..0e9b0503b62a 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
@@ -1713,11 +1713,6 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 	struct cio2_device *cio2;
 	int r;
 
-	cio2 = devm_kzalloc(dev, sizeof(*cio2), GFP_KERNEL);
-	if (!cio2)
-		return -ENOMEM;
-	cio2->pci_dev = pci_dev;
-
 	/*
 	 * On some platforms no connections to sensors are defined in firmware,
 	 * if the device has no endpoints then we can try to build those as
@@ -1735,6 +1730,11 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 			return r;
 	}
 
+	cio2 = devm_kzalloc(dev, sizeof(*cio2), GFP_KERNEL);
+	if (!cio2)
+		return -ENOMEM;
+	cio2->pci_dev = pci_dev;
+
 	r = pcim_enable_device(pci_dev);
 	if (r) {
 		dev_err(dev, "failed to enable device (%d)\n", r);
-- 
2.33.1

