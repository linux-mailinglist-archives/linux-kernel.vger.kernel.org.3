Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241BF590666
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 20:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbiHKSku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 14:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbiHKSkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 14:40:46 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93992AE09
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:40:44 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id jx17-20020a17090b46d100b001f33b230098so8954452pjb.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=mtBgBOU+VmnH7pWxeMXp2NFGHFR9AtO9bHxsGX8CxYk=;
        b=aRrfZ3uIY2oExMKgXew+0/7DIVuyZEv0YCRdFmB0rrJs5NDlschOTM6h1hgPROBEGq
         pIRHTvmopk31k8omZuKbWsoWYCtPlJIuqACoiRNuC69/HSXuly/9QaHTOHVZP5A7mEqf
         6n9l6MAY/tD3etm8n+FjxQ4jZo1OG3gq+Loty0+SBt+K6MymY2gBfaK7vpJUVtnGMxzk
         RfW0nOxmNbuFLGLjjGizR3+bb4i/EWOEnqK/TsDnW1NsRMeJw9QupQ6DYzyAUEGxR+O7
         tqkMMh5yd2cEsYEHzRqoz0IfyUUxqqkJ27/lS7W/6ufiaSwetUzI6byqkCQubKcanwcv
         FWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=mtBgBOU+VmnH7pWxeMXp2NFGHFR9AtO9bHxsGX8CxYk=;
        b=KR1UVoivHjOJQCSiyUT8ifsWloL/JMFEssEuCql/17MSvfy6EyDoxxHc0L+Jeusee4
         W08Z5dkX1msV52AGq/PRUgW+LTK/y+wCITK8+mG/+OJPVzzTTDmx7hRksxl74CHYQ7bq
         Aj+td3PHikrybeEWbR3r8GqjNEuByecGLjDp1uh4eXgUzvXEaG7u+sXf82EQwzpj6mb7
         EhRkN36ul/vYHDAeUN0/3Al5Fsx4VJUP6tuZRQ13sMJSUcIlqKTEE53fcmsTLxCzvdXy
         ZBhJLMfO2alG4lZNWuW4MNZtJm/Hiv69H7JvRxevM1Zw5tkrZdVUBmaTYoB8hlsZ4efs
         n1wQ==
X-Gm-Message-State: ACgBeo0/b6huVF42hBbQw5llr3RqqDEdvoJ0T+u/05UeYb93KiX9tuXo
        DdXsx1pP3GQM6WswP167jBgYMZHP3wSYjOzKtwE=
X-Google-Smtp-Source: AA6agR761TkfSRWps8RSK2h035rykG9I4qj4f0+lF0QXQpT2kRQxZC4YFJt+a9+PCKXcOUZKSwK2UdCAV4otpCx8Hjs=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a17:903:2286:b0:16e:ef47:4013 with
 SMTP id b6-20020a170903228600b0016eef474013mr531363plh.120.1660243244311;
 Thu, 11 Aug 2022 11:40:44 -0700 (PDT)
Date:   Thu, 11 Aug 2022 18:40:01 +0000
Message-Id: <20220811184001.2512121-1-willmcvicker@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v1] PCI/PM: Switch D3Hot delay to use usleep_range
From:   Will McVicker <willmcvicker@google.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     kernel-team@android.com, Sajid Dalvi <sdalvi@google.com>,
        Will McVicker <willmcvicker@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sajid Dalvi <sdalvi@google.com>

Since the PCI spec requires a 10ms D3Hot delay (defined by
PCI_PM_D3HOT_WAIT) and a few of the PCI quirks update the D3Hot delay up
to 20ms, let's switch from msleep to usleep_range to improve the delay
accuracy.

This patch came from Sajid Dalvi <sdalvi@google.com> in the Pixel 6
kernel tree [1]. Testing on a Pixel 6, found that the 10ms delay for
the Exynos PCIe device was on average delaying for 19ms when the spec
requires 10ms. Switching from msleep to uslseep_delay therefore
decreases the resume time on a Pixel 6 on average by 9ms.

[1] https://android.googlesource.com/kernel/gs/+/18a8cad68d8e6d50f339a716a18295e6d987cee3

Signed-off-by: Sajid Dalvi <sdalvi@google.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 drivers/pci/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 95bc329e74c0..5ae5b3c4dc9b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -72,7 +72,8 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
 		delay = pci_pm_d3hot_delay;
 
 	if (delay)
-		msleep(delay);
+		usleep_range(delay * USEC_PER_MSEC,
+			     (delay + 2) * USEC_PER_MSEC);
 }
 
 bool pci_reset_supported(struct pci_dev *dev)

base-commit: 2ae08b36c06ea8df73a79f6b80ff7964e006e9e3
-- 
2.37.1.559.g78731f0fdb-goog

