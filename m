Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDE854F662
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382037AbiFQLJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381867AbiFQLJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:09:22 -0400
X-Greylist: delayed 2317 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Jun 2022 04:09:20 PDT
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480E76C561
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
        s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From; bh=YulpAZhbVg6y+ee/fL/9bL7V1W2kdnst8Vz1P9ePPw0=; b=yf+iJk
        yI71j1TcQ4ladswWyndbvQfuGP+BeLRZoU4udUHEybiof1cl2Fr/+byepGeDvJasr+2dCKEBnxxBu
        DPB6qIORYjKdpEdJFJiyXbOStaI0yFq+dN7RFbQlrGIzeveTqzSRllFMOKZj0kJQtXhSRv74V1xNH
        5FsmH/+gdpQ=;
Received: from xenbits.xenproject.org ([104.239.192.120])
        by mail.xenproject.org with esmtp (Exim 4.92)
        (envelope-from <julien@xen.org>)
        id 1o29FQ-0000GD-Nm; Fri, 17 Jun 2022 10:30:40 +0000
Received: from 54-240-197-232.amazon.com ([54.240.197.232] helo=dev-dsk-jgrall-1b-035652ec.eu-west-1.amazon.com)
        by xenbits.xenproject.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <julien@xen.org>)
        id 1o29FQ-0003sg-DK; Fri, 17 Jun 2022 10:30:40 +0000
From:   Julien Grall <julien@xen.org>
To:     xen-devel@lists.xenproject.org
Cc:     sstabellini@kernel.org, jgross@suse.com,
        oleksandr_tyshchenko@epam.com, linux-kernel@vger.kernel.org,
        Julien Grall <jgrall@amazon.com>
Subject: [PATCH] x86/xen: Remove undefined behavior in setup_features()
Date:   Fri, 17 Jun 2022 11:30:37 +0100
Message-Id: <20220617103037.57828-1-julien@xen.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Grall <jgrall@amazon.com>

1 << 31 is undefined. So switch to 1U << 31.

Fixes: 5ead97c84fa7 ("xen: Core Xen implementation")
Signed-off-by: Julien Grall <jgrall@amazon.com>

---

This was actually caught because I wasn't able to boot Linux 5.18
and onwards when built with GCC 7.3 and UBSAN enabled. There was
no message but instead an early crash because the instruction "cli
was used too early.

This issue has always been there but it only shows after Linux
switched from C89 to C11.
---
 drivers/xen/features.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/features.c b/drivers/xen/features.c
index 7b591443833c..87f1828d40d5 100644
--- a/drivers/xen/features.c
+++ b/drivers/xen/features.c
@@ -42,7 +42,7 @@ void xen_setup_features(void)
 		if (HYPERVISOR_xen_version(XENVER_get_features, &fi) < 0)
 			break;
 		for (j = 0; j < 32; j++)
-			xen_features[i * 32 + j] = !!(fi.submap & 1<<j);
+			xen_features[i * 32 + j] = !!(fi.submap & 1U << j);
 	}
 
 	if (xen_pv_domain()) {
-- 
2.32.0

