Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAA05A9A49
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbiIAO2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbiIAO2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:28:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BB72B60F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC01DB8274C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 14:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A59FC433D6;
        Thu,  1 Sep 2022 14:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662042501;
        bh=KeVQMW/jzqn+YDQ+gpJVMN2ue0rhR1eGWQBtG7/NbrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pI3n0Lrpto/7VCyVzJ4GZdYYs/xT5xoKmLzHHrTnn0ksHCKGDv4OgjpnfI6NcyU83
         2+uYWQaR5OsyPti51CnvxqVorO5Ev/DfYrX4FwcBLU6Wj37Ujf2BnXjsyxSbQYx+5k
         AvCc75is62NGNEPRS83UK6t6eDs4LOyU/98kue8lrFuX9dUhzM7SLvpXvFRGQKjue8
         USlA6BhrZT4FB4SIeFsJzNkaneNAykhOd9d1ErNjQaxkCRfP+/Ixu3Ei8WK7mfLZlD
         LjEealQySXRF0FoUIRmT0HUmidwyp+pIbrTwVcQVyobalomphwB1RozgqMtJU068Rh
         vsvH/B5mMYeYw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oTlB9-0003Zu-3x; Thu, 01 Sep 2022 16:28:23 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 4/4] irqdomain: use per-domain mutex for associations
Date:   Thu,  1 Sep 2022 16:28:16 +0200
Message-Id: <20220901142816.13731-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220901142816.13731-1-johan+linaro@kernel.org>
References: <20220901142816.13731-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new per-domain map mutex instead of the global domain mutex for
associations, something which may potentially speed up parallel probing
somewhat.

Note that the global domain mutex is still used for hierarchical
domains.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 kernel/irq/irqdomain.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 9f3203e180c5..7009ef30c09e 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -611,9 +611,9 @@ int irq_domain_associate(struct irq_domain *domain, unsigned int virq,
 {
 	int ret;
 
-	mutex_lock(&irq_domain_mutex);
+	mutex_lock(&domain->map_mutex);
 	ret = __irq_domain_associate(domain, virq, hwirq);
-	mutex_unlock(&irq_domain_mutex);
+	mutex_unlock(&domain->map_mutex);
 
 	return ret;
 }
@@ -695,7 +695,7 @@ static unsigned int __irq_create_mapping_affinity(struct irq_domain *domain,
 		return 0;
 	}
 
-	if (irq_domain_associate(domain, virq, hwirq)) {
+	if (__irq_domain_associate(domain, virq, hwirq)) {
 		irq_free_desc(virq);
 		return 0;
 	}
-- 
2.35.1

