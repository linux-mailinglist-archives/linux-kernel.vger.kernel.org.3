Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF49446685A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347920AbhLBQeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348095AbhLBQeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:34:20 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA955C06175A;
        Thu,  2 Dec 2021 08:30:56 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so2895013pjc.4;
        Thu, 02 Dec 2021 08:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=85a8mtZKwmbAv3R4H4Wl42WbZw39ee4ytKJ8//L9jFk=;
        b=XnKuPawCFmMShML0W9PaeKTDrWlbQ1dprewSJDxyZN8OwzeVusLpyCACzdl52RzRFb
         HKtJNlyFtrJOokg1VvHdmDOhWeyBqpfoTQ/5yNxys2NqhvFayFKYBHu2IUZhU/3bjW1D
         qy5rDer2UD6BqE7sFz/opXf0XpgWP++Fpl9Wqrula3MsSL961DHWb11JRyYWa2qixFxL
         Ak5XnzDG2ARH4pNj2ggAqseK2HebeFhrjmI8C+nTtYs/R5EdKeEm3NVhCTqtkcW2gDAs
         ZlIAs5TzoSXoIw0gbtVPILwJInihPmJfRK8y9HUxZTSpeIgZhDgLtx0k7AHOzHau2TBy
         LTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=85a8mtZKwmbAv3R4H4Wl42WbZw39ee4ytKJ8//L9jFk=;
        b=WUy/AQ4gNw53ljRJCVQ5pHuibHOgIq9eBuWEkUwaxq4Ag0uk6Wd4gV8B76Afi8RQkH
         ZHMrZpt5C/cdn7QbDtUWY/eABnHo/b+KN25EeXv/vpE6aM0GPQWg6vl2Q/cJKF03xuHf
         H+wyHLUFg7SdxM1REdf4WD/2g/LsS+wP9jOuVr1gC2VXhjLbolvg8mru1lpHVhGAdwDZ
         d9DVRXHrVOqxM/oAHZhlaM7Vn1+EFSl7qCi54c+PCNN+W5HwpeyW5/+bvmT38W/NlAuN
         sLWk9YrlppUtj1cECuPtOaG10FTIMqiJ0k6MwJSSymSlgpHSFxU8ZuzVdYpxepcDCsAH
         m3NA==
X-Gm-Message-State: AOAM530bbnltUY9YJX+1S3r41aiPdGwnEFfx3fNhAeeQCNGYJO/mnQp6
        SuY3hZhhRxiYHawTuQkjQCm+O7KoDYR7Dg==
X-Google-Smtp-Source: ABdhPJx9Gth86hMxgCffQtyxPvM2JSuqf6LD4YfY/tyo9NPyUxuteeCtP2Bo6lclCO57tNPOA/npug==
X-Received: by 2002:a17:90b:3b4c:: with SMTP id ot12mr7180561pjb.196.1638462656256;
        Thu, 02 Dec 2021 08:30:56 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id z10sm287368pfh.188.2021.12.02.08.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 08:30:55 -0800 (PST)
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
Subject: [PATCH 2/2] mmc: sdhci-brcmstb: "mmc1: Internal clock never stabilised." seen on 72113
Date:   Thu,  2 Dec 2021 11:30:50 -0500
Message-Id: <20211202163050.46810-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211202163050.46810-1-alcooperx@gmail.com>
References: <20211202163050.46810-1-alcooperx@gmail.com>
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

Fixes: 5b191dcba719 ("mmc: sdhci-brcmstb: Fix mmc timeout errors on S5 suspend")
Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index f24623aac2db..11037cd14cfa 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -313,6 +313,10 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 
 static void sdhci_brcmstb_shutdown(struct platform_device *pdev)
 {
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+
+	/* Cancel possible rescan worker thread */
+	cancel_delayed_work_sync(&host->mmc->detect);
 	sdhci_pltfm_suspend(&pdev->dev);
 }
 
-- 
2.17.1

