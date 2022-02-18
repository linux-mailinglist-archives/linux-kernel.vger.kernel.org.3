Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3349C4BBA5F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbiBROFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:05:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiBROFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:05:10 -0500
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8240F1802A1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1645193089;
        bh=wuoQIaGoRFvIHL8ZcJz8D0YUuexOBBo3ixCvdfEidYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GzU9vWguYtt3coIZ3jmWMaXhl+U16qLxsclJfFiBTboDnSsTQZJkbjuvGU6v62O43
         b6bCU+WR7P7AW01dKWk5JzWPqfowccJsZazwpR98lMIzlpfQVjXxv6mkN0dB2fiZK9
         yDgSTgg2k9F4Soyo1NLoQ1yQj6OaFisq+P84YB5U=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszb7.qq.com (NewEsmtp) with SMTP
        id 12E9D49F; Fri, 18 Feb 2022 22:04:46 +0800
X-QQ-mid: xmsmtpt1645193086ths6y3hwo
Message-ID: <tencent_3CB9DC1C721449E14B4AD3FF65201CCC4C08@qq.com>
X-QQ-XMAILINFO: OExQYVWihm+Fj0v0OX9DLxRH011pjRSh82ImpdIJwaWCBVRYVh/ImXE45uWCuY
         B2CHFgViw1/kv7motsCRqLFQ7hxK198DsGZrwefzAObK2gE99FQf9N/rmj5KZ8Q3tb6FcPZIE3jE
         xmxhTh+svdih7FEEIyVP39gAINMlI7BmZjzh/g4xxd2IdoF47EiG7+zoGqqCaYzo7w7cF7TQ2WWD
         upE5/V4OkLoyTJ0rGHbSsTLX40ZqolN6SOqoCTBONDVARJYzh6EussH3LwVXB1dxXCFYSPh45BBK
         CM15oH2KMvFBpCtf5DR53PGXgNE6yMWMIE5pVpgH5dVoEHiEaNWu8QDtStkxOhbjXcXctWRkG74f
         VKdxA9LW0wxj37F+vRyeEBNTVdoQx4Ick1B++XyA59ZKRlZRBjgTjzPpX7Qr27kiKceQxKcylsrF
         o4l95trg1rzlR/0jvfHD+wiNs0BRXEi4+SEMv4jNOMUHf7QFP36UjMJCgBfjnSZ1GHdMQqahxmi4
         DwDpmU/8cjdbjRX6wlDFAIw4ObRn2VJUdISxGdjuFyZXESgxp0rxNxTDcBvZHCagGY+QEupiUGPj
         uRU+bUm1CklAQbrLUdRNkMmRP2MGLDmJ+6Ds+aGEshUrO6HhDa1fuXl3Q3n9lOqFLyxucxIwi+VF
         +Xyny/dsQPD+kviAZ5Z8mNNlm4PWt7h0m4e+SvVq4AOMUV3FNyRqWd+5YkhfHhm7/tgRWS6N7/TA
         fsc664S0oln4Dli6X0IcOr+zbzQpKhXYSi3Vr6ApziTI9PN9B0KzivlwthE4jxTNxLxGCqmN0NF6
         Y9Z672I752jOmarFvxtCAT9YXw0BV5Ayw3fQkz32KQaOsU4M6OAwcbgDasLEXle6diVbAGkmuKWz
         leZ0XWr/j/MtE66T1DMNMUt0tydINXur0TF2+EEE2zel+UnllX4N20PYhSciTPYqgxtoTt5m7GEY
         f54XoINOc=
From:   xkernel.wang@foxmail.com
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2 2/2] staging: wfx: check the return value of devm_kmalloc()
Date:   Fri, 18 Feb 2022 22:04:02 +0800
X-OQ-MSGID: <20220218140402.2262-1-xkernel.wang@foxmail.com>
In-Reply-To: <tencent_24A24A3EFF61206ECCC4B94B1C5C1454E108@qq.com>
References: <tencent_24A24A3EFF61206ECCC4B94B1C5C1454E108@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

devm_kmalloc() returns a pointer to allocated memory on success, NULL
on failure. While there is a memory allocation of devm_kmalloc()
without proper check. It is better to check the return value of it to
prevent wrong memory access.
And I use the err label which is introduced by the previous patch to
handle the error.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
Changelog
v1->v2 update the description.
 drivers/staging/wfx/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
index 9ff69c5..85fcdc3 100644
--- a/drivers/staging/wfx/main.c
+++ b/drivers/staging/wfx/main.c
@@ -294,6 +294,9 @@ struct wfx_dev *wfx_init_common(struct device *dev,
 	hw->wiphy->n_iface_combinations = ARRAY_SIZE(wfx_iface_combinations);
 	hw->wiphy->iface_combinations = wfx_iface_combinations;
 	hw->wiphy->bands[NL80211_BAND_2GHZ] = devm_kmalloc(dev, sizeof(wfx_band_2ghz), GFP_KERNEL);
+	if (!hw->wiphy->bands[NL80211_BAND_2GHZ])
+		goto err;
+
 	// FIXME: also copy wfx_rates and wfx_2ghz_chantable
 	memcpy(hw->wiphy->bands[NL80211_BAND_2GHZ], &wfx_band_2ghz,
 	       sizeof(wfx_band_2ghz));
-- 
