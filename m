Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED091511B30
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbiD0Ous (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238536AbiD0Oup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:50:45 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8C63BA59;
        Wed, 27 Apr 2022 07:47:34 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23R8jpda029645;
        Wed, 27 Apr 2022 07:47:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=gsxpG4RiXnCTCF6V9lo/7D//jaoYpWLGlyTjAD+8/qk=;
 b=koGcsTh8SpOBk2r6NfOSKOAo4RsmzmAnH5jn03a2QcYMlA9fxXDUpspTfDNk8qjBIS1T
 MnUSAw/JBmQWKSt9j/0gBs09AIQxjWb96zVW+YqZczWukuwwLY7EmJA8J4uvHBrlbKU1
 yiYozr/5xmBdZP2JIrSTF1oxhDNcv3omS+fTrBctxjZpn0GoaH0Bt8gS5ECuBxeIalwm
 UUkvtKWoBi3gpI0AZYaYTJTvodESnxQcwDJ+sselMYF24CPxQALfX+96SSGP2MNikLJj
 yuxML5Wep0pyJ5Ls4TpBxbUBWJbJBteqUYorrdM8rmKFx3yCg3cqCS3WNL2Ny4fqSZG2 XQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3fprsqu7ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 07:47:31 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Apr
 2022 07:47:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 27 Apr 2022 07:47:30 -0700
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id ADFAF3F7063;
        Wed, 27 Apr 2022 07:47:29 -0700 (PDT)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <rric@kernel.org>,
        <cchavva@marvell.com>, <wsadowski@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH 5/5] gpio: thunderx: change handler for level interrupt
Date:   Wed, 27 Apr 2022 07:46:20 -0700
Message-ID: <20220427144620.9105-6-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220427144620.9105-1-pmalgujar@marvell.com>
References: <20220427144620.9105-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0uaggkiGNeQvQqwE58ua4JEIRGRBqzNm
X-Proofpoint-GUID: 0uaggkiGNeQvQqwE58ua4JEIRGRBqzNm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current level interrupt handler is masking the GPIO interrupt
and not unmasking it, to resolve that, handle_level_irq is used.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/gpio/gpio-thunderx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-thunderx.c b/drivers/gpio/gpio-thunderx.c
index 87ab1ad7e652347a67b7747ea497b944498a8b41..b1063e53ceb8edf26ca1a6ecab8035aad62128a1 100644
--- a/drivers/gpio/gpio-thunderx.c
+++ b/drivers/gpio/gpio-thunderx.c
@@ -343,7 +343,7 @@ static int thunderx_gpio_irq_set_type(struct irq_data *d,
 		irq_set_handler_locked(d, handle_fasteoi_ack_irq);
 		bit_cfg |= GPIO_BIT_CFG_INT_TYPE;
 	} else {
-		irq_set_handler_locked(d, handle_fasteoi_mask_irq);
+		irq_set_handler_locked(d, handle_level_irq);
 	}
 
 	raw_spin_lock_irqsave(&txgpio->lock, flags);
-- 
2.17.1

