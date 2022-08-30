Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4767C5A5F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiH3Jc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiH3Jca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:30 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A707FDF648
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:32:16 -0700 (PDT)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1235E3F1E6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1661851934;
        bh=Fq9Qj2I6Q4wEeIF7BMuG23ODRUy0T0fqLeGWPb/D12A=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=HQ30tjCruGI56K6rn4cIRtS9dyoHA08tZWa1xaRCTR9jUxanxvVBfITQvDZvNc9cB
         fbUa6NEB77x2PFR7+0qEWLpY0gTa0xKswBFoli5tzSJgGANXhEtWgqGajO05sRkk/z
         z9NuDFLp4I1JspDu7jBBy9gZjiRUWcHandWAUbbxwKFt6wFmV3ZCpOCspWipB7kqUq
         XRm8MzM30Aeiy0khMdbKCFSHN0dzEnwv8izpAnatx41zEEM71Uple/0poa7nWu5LJe
         qaW8xVCap8mZzXXhCxFFvN+Tzn5b1LgaLsO1QYElYzGcduALUYkojRtCYhpGEszHux
         1RsUMVVMRZO4A==
Received: by mail-pf1-f200.google.com with SMTP id a21-20020a62bd15000000b005360da6b25aso4378014pff.23
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=Fq9Qj2I6Q4wEeIF7BMuG23ODRUy0T0fqLeGWPb/D12A=;
        b=ROgGhUjjLwbbumcM1j7Lwn0mE8XFH1OBZJBGzQ7zELo/7ZY+eHWEXYWOCGCyJmZG29
         3QewjxcFyPHWmeuYbQ9x3e9BtNiQlYZJeAD1VAT4oV+jORcoy5ClorG/toKOZWCWkYBj
         xNqyM9Zg2QA8in54L+2gfyLTYyuwlfaw/g7b3W0q3BQjyo5IUP8DgPUw/Vfe5CKAsBig
         K4LYZTLfqdtJThthBDeqZIa3ndLMIQQOkfEZQL2CJknm99jUjmcxzfXLCGEKl8lN0VU/
         dJ5dG2yA0kmfZx5hjU/yckglzcNFjP4oOFLO3bFHJXxmEa6Evo81Fyx9ddO9NQnFWiZ8
         DJPQ==
X-Gm-Message-State: ACgBeo0F3UfqPXlxeJWHRgm7g63+artXMPLSlIUINJC9iU7yWfS/NPr7
        BLS+UJGU91bsBeY0L1RKTJidBRLU3NAR9DRggd3P6TlI1afInLIEwkMJbrWHs8OFAuq11Aiz7Em
        Q3PmanTHSRuk4/7hv5gwqhewMzuuIl4VjJpTj5usCRw==
X-Received: by 2002:a17:90b:3b8a:b0:1f5:56c3:54ac with SMTP id pc10-20020a17090b3b8a00b001f556c354acmr23274728pjb.2.1661851932316;
        Tue, 30 Aug 2022 02:32:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5hx669oD60wW9i25ZVdcENxqvxMPQWvOLTezF0zSAk3cXNR5nnSCtfnCL97BDlQQBTqsU2PQ==
X-Received: by 2002:a17:90b:3b8a:b0:1f5:56c3:54ac with SMTP id pc10-20020a17090b3b8a00b001f556c354acmr23274705pjb.2.1661851931978;
        Tue, 30 Aug 2022 02:32:11 -0700 (PDT)
Received: from canonical.com (2001-b011-3815-3671-090c-7c62-b076-d6cb.dynamic-ip6.hinet.net. [2001:b011:3815:3671:90c:7c62:b076:d6cb])
        by smtp.gmail.com with ESMTPSA id w3-20020a63d743000000b00422c003cf78sm1170293pgi.82.2022.08.30.02.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:10 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dmaengine: Fix client_count is countered one more incorrectly.
Date:   Tue, 30 Aug 2022 17:32:07 +0800
Message-Id: <20220830093207.951704-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the passed client_count is 0,
it would be incremented by balance_ref_count first
then increment one more.
This would cause client_count to 2.

cat /sys/class/dma/dma0chan*/in_use
2
2
2

Fixes: d2f4f99db3e9 ("dmaengine: Rework dma_chan_get")
Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
 drivers/dma/dmaengine.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 2cfa8458b51be..78f8a9f3ad825 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -451,7 +451,8 @@ static int dma_chan_get(struct dma_chan *chan)
 	/* The channel is already in use, update client count */
 	if (chan->client_count) {
 		__module_get(owner);
-		goto out;
+		chan->client_count++;
+		return 0;
 	}
 
 	if (!try_module_get(owner))
@@ -470,11 +471,11 @@ static int dma_chan_get(struct dma_chan *chan)
 			goto err_out;
 	}
 
+	chan->client_count++;
+
 	if (!dma_has_cap(DMA_PRIVATE, chan->device->cap_mask))
 		balance_ref_count(chan);
 
-out:
-	chan->client_count++;
 	return 0;
 
 err_out:
-- 
2.25.1

