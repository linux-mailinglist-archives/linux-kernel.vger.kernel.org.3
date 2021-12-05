Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3962B468A2C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 09:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbhLEIsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 03:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhLEIsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 03:48:02 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DB6C061751;
        Sun,  5 Dec 2021 00:44:35 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gt5so5510160pjb.1;
        Sun, 05 Dec 2021 00:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=82WlVRMynLPTBi/+2o8jeTUhlynvGd8hPKsx8jxby9g=;
        b=Kdo86afCn6h6eoyD+L4ozMAgAfdhchSqSDqboavdIkUJS/bHXFff5myT2W86EBYBuM
         blDY0hQ3hq77qvw9dytur38yMYV9Odg24XiaADUmm+aFl2WcVxrv2ap0q19BkLTVH02O
         8mBbjFL43biwvfl66rqj/HBr5R3fPKj+hji0qihH+cPlXkYGxJlc+smV7zBL3fEvnNYu
         PazrQftlZeo6ny2VKyFgwuomX2+Lhio+mxfO3WWmY7Kx0BO18CYZCqFDlusC2x81KvHB
         BkcxfTBkG7BLp49njfCIjkhqWHVxOg7b8B1E54FcL+lNNuEjdOwEJq3ZHT7xKOuO+Kxg
         a2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=82WlVRMynLPTBi/+2o8jeTUhlynvGd8hPKsx8jxby9g=;
        b=pF0hyp9mi/bo6TjImarH3WflKpCjy4mLen3VbeFVjkkf9atV9bbBlyJ6rZhViabw2L
         +l0PH3RfI/lruyY4dwz8sruQOjKnFqL7BwjKNIZaFDRCT7Rjm7kH/Ql0AJhWfm34z2z5
         NjysT7ZTHcqHIYKQ3VfSIZMYBSCEjiyDNsZ1J2OBN9SKbU95IiFKfliqpKxwrsPUzlNs
         xHo/xbpWzuFuQyGXHwzVpFseOKKBxqqrZ1hC32/P0bql0RC1s53pO9eybyiWnHf+XlJF
         f08z65TS45xnEYiCgyEYjY3ZZYcE0kZefO1jBsTSxT3epwujC+PwEi3Vgw7nPJWokQ0j
         2eUw==
X-Gm-Message-State: AOAM532df3gHSycZQyBRtk+s4HTKyhM+tJQ86FgsVO6JISIRRrcwXpNo
        VZ9Nnmw2gBt+Ijk7jfSJKzs=
X-Google-Smtp-Source: ABdhPJyX7JvgMADL4ddKNITzVyH5qRbq5H+s1xQRlApOXZIUFase5dGyREXs1V8i+FdOE4tvO9Ntiw==
X-Received: by 2002:a17:902:e302:b0:141:af98:b5ea with SMTP id q2-20020a170902e30200b00141af98b5eamr35234269plc.53.1638693874444;
        Sun, 05 Dec 2021 00:44:34 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.54])
        by smtp.gmail.com with ESMTPSA id pi17sm10535114pjb.34.2021.12.05.00.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 00:44:34 -0800 (PST)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Irina Tirdea <irina.tirdea@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] driver: pmc_atom: free pmc->regmap when pmc_setup_clks fails
Date:   Sun,  5 Dec 2021 16:44:19 +0800
Message-Id: <20211205084419.2382395-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports:

drivers/platform/x86/pmc_atom.c:496
pmc_setup_dev() warn: 'pmc->regmap' not released on lines: 496.

Fix this by deallocating pm->regmap when pmc_setup_clks fails.

Fixes: 282a4e4ce5f9("platform/x86: Enable Atom PMC platform clocks")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/platform/x86/pmc_atom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index a9d2a4b98e57..e338c1572237 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -488,9 +488,11 @@ static int pmc_setup_dev(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* Register platform clocks - PMC_PLT_CLK [0..5] */
 	ret = pmc_setup_clks(pdev, pmc->regmap, data);
-	if (ret)
+	if (ret) {
+		iounmap(pmc->regmap);
 		dev_warn(&pdev->dev, "platform clocks register failed: %d\n",
 			 ret);
+	}
 
 	pmc->init = true;
 	return ret;
-- 
2.25.1

