Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83654CCFCE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiCDITM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiCDITI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:19:08 -0500
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BE7195330
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1646381894;
        bh=SflRFPXtxQ3Pmt1KAgrpB/jeO17kuUf3fZk7Z71M+LI=;
        h=From:To:Cc:Subject:Date;
        b=qwU/2L9mtNdKJ13RVM39hLHms151Z7e1Kjn6aO+GrTYThWor+GF/GKFtPOzo2qLXj
         LM3GO2/iLkAvUyTn4D3ol3tNnQDD4pYQrkr/mkDa0K7DMtPQeRVGRNyGs9nLbuZ85T
         fswcLNpCpr1y54V/04LA5LsF/S5vWFoqHTB2lIoM=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc7.qq.com (NewEsmtp) with SMTP
        id 48A25A60; Fri, 04 Mar 2022 16:18:10 +0800
X-QQ-mid: xmsmtpt1646381890trs7be3wl
Message-ID: <tencent_410AFB702E25A27F689010E6A1DC308E7807@qq.com>
X-QQ-XMAILINFO: NrI1OKqG5KOqYtBiK5U/ckeV9MUoGKaby4GqN3lWsSuBEkaa0eRPazt2b3O2H/
         fBQlRwzB/Ri3MxZ4C9pKVwp9ZBD/UcsVUzSUK6p8EpjzKyAdSoF+psk88JHAObIGXBbpSK6MKGby
         ODFbZ8iDJojgkgsBIoEZJRuVwQUhOnrYxDiNwM2k+ueC1dVfrWmE88AlWX4nx9QeyidIWLF73oNj
         lJaiF+YUW2Ub/gyui03lnAOZEBiRwgCEycAg/72QHzNZzE1S2TtAKzlH5JmlCekNMmp79cpoyP2F
         clYyw0NLPVy5Z/kNEv+iqapayhBK3rOGF5W3YF7O+5ZocBsoAbIoil8CmDGMSCcOJVBKS/yaITds
         dP/qi34GsBSGNxNqpeZ1uTFW/9bbiLatbtl57mEJoHUFdfIV0+n8A4NWqvPCrhlE1o+5Ywkorh9j
         Pn7YpVhc9FNvVJMdEzovVcZ75gFFpZIuA5F1o9vgIYpQFWca+MGoBkUi9ylzeBKdtmInTAlIoLju
         1U6KxNCvYn11k6RjT6WHnMHMURiVWAPK8KxdyMwmxIlXgjw1OvCHyGTv5npfRLgZhFuNZ7qktayy
         ezHfA4Cs4nUbXNdvVdyJ7qPgHZU0yFzwIsamTrorcZPoegHQSdEDCsW9dVnnLQpFz94xTEIfqqEE
         Ewory+ATlrBW/MwuCdrpmEuQF/sz/Ivv/q+Bps3JETM7lntV53UkmDeKEIxz6Aq06SbJ1rVZD4cH
         tPzW9hDVhJZT8A4wvGgSr5sxjdut7EqfVJHDyy+B8E7M89kmPSo7JC6+ylAORmrhDEL60GDdFTUI
         E3ZMJasXtkZtkTg3IpPMnLfiTu/Rs3oCYPLwYbjOzmglpp/AYy+yYf/zFo4nKwrnVXObol3h6OH4
         I5B3bS03HjK8c4Zdrxtk+IdaX57iDtCdABG2nI0p0OmBeY0Imvh6zG5tHEWT1/Dg==
From:   xkernel.wang@foxmail.com
To:     nsaenz@kernel.org, gregkh@linuxfoundation.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] staging: mmal-vchiq: add a check for the return of vmalloc()
Date:   Fri,  4 Mar 2022 16:17:41 +0800
X-OQ-MSGID: <20220304081741.4728-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

vmalloc() is a memory allocation API which can return NULL when some
internal memory errors happen. So it is better to check the return
value of it to catch the error in time.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 76d3f03..1bbd301 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -1909,6 +1909,11 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
 	mutex_init(&instance->vchiq_mutex);
 
 	instance->bulk_scratch = vmalloc(PAGE_SIZE);
+	if (!instance->bulk_scratch) {
+		err = -ENOMEM;
+		kfree(instance);
+		goto err_shutdown_vchiq;
+	}
 	instance->vchiq_instance = vchiq_instance;
 
 	mutex_init(&instance->context_map_lock);
-- 
