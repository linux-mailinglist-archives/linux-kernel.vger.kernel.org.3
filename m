Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709584B3513
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 13:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbiBLM7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 07:59:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiBLM7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 07:59:19 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05E526543
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 04:59:16 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 37559 invoked from network); 12 Feb 2022 13:59:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1644670754; bh=7mkWCxLrplVkkoBQ+yjw/ZRC+lyh2802qNoYkYFx/w0=;
          h=From:To:Cc:Subject;
          b=L3nLAq3y/T3Yqh32CU4ZQ/Hv8f9xGmTdD1tkzgn7uigvjuCAW+tzw97iiyGiC4Vl0
           D07FZ2BQ0LIB+xuwEUzmfVl+DoxalcPhsaoPX55IeR/4nmXnEQ0p2oxFQ5ipLxtZfU
           syMUmWJrwTb6M+kLGWzxa4/5VJQXs3be02Ez6bHY=
Received: from aaem217.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.116.217])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 12 Feb 2022 13:59:13 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Subject: [PATCH] platform/dcdbas: move EXPORT_SYMBOL after function
Date:   Sat, 12 Feb 2022 13:59:08 +0100
Message-Id: <20220212125908.357588-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 301aa98afc16f94db36962caeb208f5b
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [MeOk]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The declaration
        EXPORT_SYMBOL(dcdbas_smi_request);
was placed after smi_request_store(), which made a false impression that
dcdbas_smi_request() was not exported.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <markgross@kernel.org>
---
 drivers/platform/x86/dell/dcdbas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dcdbas.c b/drivers/platform/x86/dell/dcdbas.c
index 5e63d6225048..db3633fafbd5 100644
--- a/drivers/platform/x86/dell/dcdbas.c
+++ b/drivers/platform/x86/dell/dcdbas.c
@@ -284,6 +284,7 @@ int dcdbas_smi_request(struct smi_cmd *smi_cmd)
 
 	return ret;
 }
+EXPORT_SYMBOL(dcdbas_smi_request);
 
 /**
  * smi_request_store:
@@ -351,7 +352,6 @@ static ssize_t smi_request_store(struct device *dev,
 	mutex_unlock(&smi_data_lock);
 	return ret;
 }
-EXPORT_SYMBOL(dcdbas_smi_request);
 
 /**
  * host_control_smi: generate host control SMI
-- 
2.25.1

