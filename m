Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF00052044F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbiEISTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239998AbiEISTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:19:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F812246A0
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 11:15:07 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n18so14644265plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 11:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SyowesK9U7eSVq7QMaQPegZAs2FL+kTvFFeYpSRPCwQ=;
        b=fgQGgwonLNudSAc9oIt4TtM9RE17sdmswvDyDJ0PtqtNkRiny6l0en3Jkns0vr/kKi
         1UGmLm2hTfC2iwuhwJutDwXkb558QFwjLEUZRr4+xUePhvmoJ2ZyTUito0NusLIL+X+/
         Z7PuITXKzLlUwXe3pq2kAYJxKJhXFaEg7hTbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SyowesK9U7eSVq7QMaQPegZAs2FL+kTvFFeYpSRPCwQ=;
        b=zObC4HFffdt3GSmCsV2O+kwKx5vePfsojlrMaVA7HtYGwWWb3nsGJtOtjk4BquQOEy
         a0tT6J8ADXM9/JNUalfTBq5cETXguWDxeU8FOnKSanLXTVS4dsKstw+pwPGfh7KVKXwu
         ZtLCAd3n/IzWOHa96BU3CHXHro/ldEV9tmlgFHDB62v1aflNX7TGphCTrpP/neWep/ih
         NSB4/AXImUjDEqtZJRewJuDt6d2q1OZQD7cpBHUAJlbib4sHJKa+9fuAWi0sYzFhQP1H
         SB90dAQe5vdZQWIpsj/32GyR2RIukpriatILfY7d/1jYssRZClpcdp1isn9a+Gu1DJta
         TLdw==
X-Gm-Message-State: AOAM533Nmld+ws50timY2iA5ReRGnsdCIvH9fiLMeJeEP2kYr+uLG5g8
        U8t0MzqJ0crXfpOVUABNJ/zYYA==
X-Google-Smtp-Source: ABdhPJzFNBRQ2Q1XDKbHbd7ZYGXOOytDH274fEG/tp2JYfzyhz5+wsbzR7mkgvY/m4+E/0FXM7Wjsg==
X-Received: by 2002:a17:903:240f:b0:158:b871:33ac with SMTP id e15-20020a170903240f00b00158b87133acmr16950870plo.135.1652120106524;
        Mon, 09 May 2022 11:15:06 -0700 (PDT)
Received: from irdv-mkhalfella.dev.purestorage.com ([208.88.158.129])
        by smtp.googlemail.com with ESMTPSA id m18-20020a170902db1200b0015e8d4eb293sm152377plx.221.2022.05.09.11.15.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 May 2022 11:15:05 -0700 (PDT)
From:   Mohamed Khalfella <mkhalfella@purestorage.com>
To:     mkhalfella@purestorage.com
Cc:     stable@vger.kernel.org, Meeta Saggi <msaggi@purestorage.com>,
        Eric Badger <ebadger@purestorage.com>,
        Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org (open list:PCI ENHANCED ERROR HANDLING
        (EEH) FOR POWERPC),
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI/AER: Iterate over error counters instead of error strings
Date:   Mon,  9 May 2022 18:14:41 +0000
Message-Id: <20220509181441.31884-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI AER stats counters sysfs attributes need to iterate over
stats counters instead of stats names. Also, added a build
time check to make sure all counters have entries in strings
array.

Fixes: 0678e3109a3c ("PCI/AER: Simplify __aer_print_error()")
Cc: stable@vger.kernel.org
Reported-by: Meeta Saggi <msaggi@purestorage.com>
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Meeta Saggi <msaggi@purestorage.com>
Reviewed-by: Eric Badger <ebadger@purestorage.com>
---
 drivers/pci/pcie/aer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9fa1f97e5b27..ce99a6d44786 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -533,7 +533,7 @@ static const char *aer_agent_string[] = {
 	u64 *stats = pdev->aer_stats->stats_array;			\
 	size_t len = 0;							\
 									\
-	for (i = 0; i < ARRAY_SIZE(strings_array); i++) {		\
+	for (i = 0; i < ARRAY_SIZE(pdev->aer_stats->stats_array); i++) {\
 		if (strings_array[i])					\
 			len += sysfs_emit_at(buf, len, "%s %llu\n",	\
 					     strings_array[i],		\
@@ -1342,6 +1342,11 @@ static int aer_probe(struct pcie_device *dev)
 	struct device *device = &dev->device;
 	struct pci_dev *port = dev->port;
 
+	BUILD_BUG_ON(ARRAY_SIZE(aer_correctable_error_string) <
+		     AER_MAX_TYPEOF_COR_ERRS);
+	BUILD_BUG_ON(ARRAY_SIZE(aer_uncorrectable_error_string) <
+		     AER_MAX_TYPEOF_UNCOR_ERRS);
+
 	/* Limit to Root Ports or Root Complex Event Collectors */
 	if ((pci_pcie_type(port) != PCI_EXP_TYPE_RC_EC) &&
 	    (pci_pcie_type(port) != PCI_EXP_TYPE_ROOT_PORT))
-- 
2.29.0

