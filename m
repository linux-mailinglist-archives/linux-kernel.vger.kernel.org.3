Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7848B4636D9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242254AbhK3OjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242252AbhK3Oi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:38:59 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50579C061748;
        Tue, 30 Nov 2021 06:35:39 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so17378953pjb.4;
        Tue, 30 Nov 2021 06:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XKV8x6mjj+Es4MySMdkYoTweXeSYZrs2lhqbIUNJzZg=;
        b=R9RPBCOr/uVOlFq8kdkjM6+GUZveNylGIcB+2dFE7KbkZa+LVuEl5s2IANClzs+THb
         xa7GawQZ6BveqLPV1/9P7cNQZHjUeQs86/9ZymH1mGNLilQO9dvi2J55bW2tcQoMpaLG
         7U8E2SoQ5lnY6GhCmkzlIZ2Nw8JsMAFWiC9nQsfR+pVPewZe76za4x/Y542a6o1dl7Vg
         9NjdpEXTo5zbq8QeBQ3BsMB4kvpRXYmD6hcMDIOA6tTbSQbHkX90b+EtVRIj7HTJOl4l
         78l/0Emjf6mMUyEw5Q9MWbEtL2o4hxLI0rxGrl/VlAq5ijg3qT6EPSl73o+FQSt+9ayr
         OCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XKV8x6mjj+Es4MySMdkYoTweXeSYZrs2lhqbIUNJzZg=;
        b=ZN40mTe3Dt0Y/HqtCah+0Phhs0WGqeXNThKO1F+fDTbn2852K006ubHakcXN0FlwrY
         9T3uOO4omYzH3dgvIhR7PTtMyHswf9iHhE2xxrLkA5EgK7miLFhsdGpUYqNCd8h/4Egb
         agJ9af/ZUAJTBkGDAzVzUWZ/C1yCdK4QG3N1StJcKnUR/jLptv6ZNr4Wb9rBFaX6tyqE
         K3s+LMmP3VR5Cj7zqysYVXCi/VUg8/eK9sD+UkbqZ6BVCMxqOC8VVPqAd/Fa4mWCNziO
         nA5hE4cQXsYue2hUKW7GwebSDPOmI8ds2m5dOZynDnfF8ZFiJ7BO3swIi6KLYZWvLKAl
         tZsQ==
X-Gm-Message-State: AOAM532+38iw45QN/ucm9tdeSscUzUbmAXl/VNWZHNN7QHvomhJhpl00
        lQf18vxNB2NRzdVHOk9Wknc=
X-Google-Smtp-Source: ABdhPJxB42fEXE5tmVEwYs/A0b+N/7676YcSO0RDiCSFcvQZHTTHJhig1QozqTw2dJaJSA0PT4s4JA==
X-Received: by 2002:a17:902:eec5:b0:143:982a:85c with SMTP id h5-20020a170902eec500b00143982a085cmr67865043plb.66.1638282938847;
        Tue, 30 Nov 2021 06:35:38 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.4])
        by smtp.gmail.com with ESMTPSA id z4sm23445273pfh.15.2021.11.30.06.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 06:35:38 -0800 (PST)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] driver: pmc_atom: free pmc->regmap in pmc_setup_dev
Date:   Tue, 30 Nov 2021 22:35:25 +0800
Message-Id: <20211130143526.1820249-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports:

drivers/platform/x86/pmc_atom.c:496
pmc_setup_dev() warn: 'pmc->regmap' not released on lines: 496.

Fix this by deallocating pm->regmap.

CC: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/platform/x86/pmc_atom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index a9d2a4b98e57..95ba108ed716 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -492,6 +492,7 @@ static int pmc_setup_dev(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_warn(&pdev->dev, "platform clocks register failed: %d\n",
 			 ret);
 
+	iounmap(pmc->regmap);
 	pmc->init = true;
 	return ret;
 }
-- 
2.25.1

