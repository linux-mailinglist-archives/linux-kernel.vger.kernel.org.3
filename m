Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7AE554139
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiFVEJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356471AbiFVEJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:09:44 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B0D33E17
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:09:43 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id g8so14298092plt.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=8a9fQe0ScUZXLADDjkAaIEciBfbUGtcUKGKu69KZMM4=;
        b=7a9sqZhMOrv9d1Jj341zLdUTERsmX6EN2EHXL/bVu+aZI0rYc7SwMfe5uAzleJE7AC
         KTT5ZW8437miJClVcneVmWBI284Oy/5EQ1tvhWhvDOGgZEO1r+Hg1y2h49B+YQQkJ3Gw
         PdiF7Ex6AkO31fCwcw2KzlKgKoUmHDuKSbs9izymzbHBQDd3TvW5cv73P4hCK43B4V0S
         XeVeCgQbsH7UjGoO1aEsCNCk0BLL/c8L6LGcXVPtOIuH1y3cTD/tS+diI+hFFYCgZBDn
         pF7mpXS9cn7iRet5TtZGWq76Mcrp+nN/JWsDNCQ4CFxCExFHiufGsOkoif/neF97AXKL
         62Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8a9fQe0ScUZXLADDjkAaIEciBfbUGtcUKGKu69KZMM4=;
        b=ETBeDiphgV0NVz29219h2LDNBF2/qOUktMIp9G06bTpPTjjroHRW4vYeRDdgzG8LUe
         OwkPYLcQs56TGNCBTBXvOwgbcoV+FAzlBDfjA3KkLEwVjiOGDJq8WQd6gFnRSlUR0Wn5
         whzOL2jjznoM8ZYN8f4zpiXtX2cacHpo/Rub3s2/4x6mAiUmyB3Hqdio8iQATT3QnN1i
         oleziNUVYjb6582lu1C8j13lPPuu1sBva90/G20HousODzW/VKMqTHcaOV7ZuLl1m264
         9zdSlU5K8eZErktZ5I0o2YLqwTvZ5Co52wAIp9PSIf1Rs8YNOEeiTWbGioto6swgmiTF
         uoxg==
X-Gm-Message-State: AJIora8s8vifqUFkLlz3ve2xN9oE75c+Ry4Y+4XxWgD0Mu8e9QljIPl7
        IGc/lCI9TKDU6/uXgPb0zQ3Ssg==
X-Google-Smtp-Source: AGRyM1vL1GLWjsczHaaLN5PR2rW/9O0ybvtd8lSdJZdNWzfrMKxeLJnajmjkvuQO/HjOZY2VZaAzMQ==
X-Received: by 2002:a17:902:728f:b0:168:b18e:9e0d with SMTP id d15-20020a170902728f00b00168b18e9e0dmr31386280pll.174.1655870982569;
        Tue, 21 Jun 2022 21:09:42 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id p19-20020a639513000000b0040ceac94813sm2853749pgd.67.2022.06.21.21.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 21:09:41 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski=20?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Li Chen <lchen@ambarella.com>, Shunsuke Mie <mie@igel.co.jp>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: endpoint: Don't stop EP controller by EP function
Date:   Wed, 22 Jun 2022 13:09:24 +0900
Message-Id: <20220622040924.113279-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For multi-function endpoint device, an ep function shouldn't stop EP
controller. Nomally the controller is stopped via configfs.

Fixes: 349e7a85b25f ("PCI: endpoint: functions: Add an EP function to test PCI")
Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 5b833f00e980..a5ed779b0a51 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -627,7 +627,6 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 
 	cancel_delayed_work(&epf_test->cmd_handler);
 	pci_epf_test_clean_dma_chan(epf_test);
-	pci_epc_stop(epc);
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		epf_bar = &epf->bar[bar];
 
-- 
2.17.1

