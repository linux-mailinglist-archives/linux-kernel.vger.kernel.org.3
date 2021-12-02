Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE3C46685B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348146AbhLBQeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348060AbhLBQeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:34:17 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EC9C061759;
        Thu,  2 Dec 2021 08:30:55 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id q16so225344pgq.10;
        Thu, 02 Dec 2021 08:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=xfHD3PJp2+zpFPC6cbhXhGVotEkFSNwM4d8Y3uvqvg0=;
        b=bvHMQ6twxvxMP0xp97Qyk9rDJawkYDrlxG699ksGGP5WykjDH41hrVy6aEr7vnv4Ew
         BnsZD4MC0V9SC/NZPXCG2M0JDxP+pgKocPZXVEjlCcqcw1Lq+vaNIH5PONMGS+K2KRMz
         EiCeEqUDFFblNnRQAcT391w5ixAk7Dq+YUO/oEgX/vYnaQPNQ3PZo7Bo4FtBJiSVirok
         OG+ItU4RA0+w3agFro28kg6+BCFfwiZm8w0FgeC3Y+DSwafOmZXeeBo3QcRMYwVGUq1R
         3gai9hYxCQkyI+u2GmE1Ed3r7Mf/d6AHaTQGdGCsFdag8ly+OvI4bjVTrEsP9WsLWmdC
         VNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xfHD3PJp2+zpFPC6cbhXhGVotEkFSNwM4d8Y3uvqvg0=;
        b=z0/XihO517JnDZ8q0ifwomzRpnPAYWP+WJ7RjtCREnIKI8jFEjNAG6DqAe5BphaVbJ
         MXeHJ8kYzkLdpGsPJSPiu61TRullV4I0lyRNG7k7l4QUTVQO70Y6X2GtXMqo/A755wSM
         rdt20GLtrB89x1i4f24aY2oX96TVdHulQDozP7hKuB4jCz20SIrQ2wgr9TyyuYc1go8F
         dJkTyHAZ6BKP1hQB7kanxZ8Xh+9aZVGlBOVK1qu/WqAZG2bI86nIWR/abA7R8bZ/j7ue
         Y84yqKHKLDFwbY0AxDXKnNoFdLOIvAkmrUZ+73YEU6FSD8NdAAV672UgdHfJlQ2omHhO
         Qeig==
X-Gm-Message-State: AOAM532xqLeKL6vfvE1o2FveWpTuVwyUwU3i7EQDTAMGiURDvh9g6IA3
        DLSgh0Jzs3w/X81crCRJBDL5gNJoyvzcSQ==
X-Google-Smtp-Source: ABdhPJwa223cdCFhuD3uArlF69/2lcVEAW1qydhZ+mFj+8EtIfLpaSyjXeRASAblQFFR6B5tu3xuXg==
X-Received: by 2002:a63:1945:: with SMTP id 5mr166781pgz.99.1638462654709;
        Thu, 02 Dec 2021 08:30:54 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id z10sm287368pfh.188.2021.12.02.08.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 08:30:54 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] mmc: sdhci-iproc: "mmc1: Internal clock never stabilised." seen on 72113
Date:   Thu,  2 Dec 2021 11:30:49 -0500
Message-Id: <20211202163050.46810-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is in the .shutdown callback that was added to the
sdhci-iproc and sdhci-brcmstb drivers to save power in S5. The
shutdown callback will just call the sdhci_pltfm_suspend() function
to suspend the lower level driver and then stop the sdhci system
clock. The problem is that in some cases there can be a worker
thread in the "system_freezable_wq" work queue that is scanning
for a device every second. In normal system suspend, this queue
is suspended before the driver suspend is called. In shutdown the
queue is not suspended and the thread my run after we stop the
sdhci clock in the shutdown callback which will cause the "clock
never stabilised" error. The solution will be to have the shutdown
callback cancel the worker thread before calling suspend (and
stopping the sdhci clock).

NOTE: This is only happening on systems with the Legacy RPi SDIO
core because that's the only controller that doesn't have the
presence signal and needs to use a worker thread to do a 1 second
poll loop.

Fixes: 98b5ce4c08ca ("mmc: sdhci-iproc: Add support for the legacy sdhci controller on the BCM7211")
Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/host/sdhci-iproc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 032bf852397f..05db768edcfc 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -428,6 +428,10 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
 
 static void sdhci_iproc_shutdown(struct platform_device *pdev)
 {
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+
+	/* Cancel possible rescan worker thread */
+	cancel_delayed_work_sync(&host->mmc->detect);
 	sdhci_pltfm_suspend(&pdev->dev);
 }
 

base-commit: 58e1100fdc5990b0cc0d4beaf2562a92e621ac7d
-- 
2.17.1

