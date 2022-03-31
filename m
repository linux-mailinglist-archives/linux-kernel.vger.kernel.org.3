Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93B14EDF65
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240521AbiCaRKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240498AbiCaRKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:10:33 -0400
Received: from out203-205-251-80.mail.qq.com (out203-205-251-80.mail.qq.com [203.205.251.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D394B10FC
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 10:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648746519;
        bh=2BDky/aXZPoSGgr2B6zDkv68+SbUOKwLUyizxNTRazM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=wAl5rNVS9UhMETjJOPBUYlLF/YLkdYvudC3OIwGF3d9bwUTYdoq7DEeAcQeYq2OIT
         W0lNzozCM5CjuQVekPHjcRB9rT6PzxsO5qCHn2etDzlgNgubNaJbh3hnVT1kS4aVpr
         z6ikLYsKnl4/aie4VMRbOWfCkL4ack/+na+MtTgM=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
        id 22424C5F; Fri, 01 Apr 2022 01:08:36 +0800
X-QQ-mid: xmsmtpt1648746516tf40y674s
Message-ID: <tencent_F3B552EEBF1CC810B36CEE23070BC54BF806@qq.com>
X-QQ-XMAILINFO: NC/J3CrDtaBbdPm4764oEE1R0IkljAkzU/G2Yi6VZGaSvo6+2Pd/ApBFM42NCS
         tajZdW9Ws+VCHRYctN5pVxNTVhDqOWrCzXnWYc90iGxmmG81LEh2JoAhLVmNU0dk8DZXELqIJFOV
         u0wU9cqKuX3nKYL1+82K6/OQqWOlW9CyhIOPnYcIGQ/J44zpPo0Y4FLsqaYJUzjh11TbrjvAwOHg
         4EoDAWVHG4PKF0k/ORbA57cjE939lGeU2n8IzCAEunbWEZV/WM/aZqG781IrHGR3hNaOtRvAPaJb
         UYtEFR3TWG0OKJAH0PXX7yNAay/WYBWsB9AMPOeZr5MEATlKoAlHaHI58KlAOjHtNO86/SRLhrgT
         UM6yvtsbiSE7QUJMaQa7rArpzOAyBMBjaecmEuFdsZrUjfCQ+iAYkV6Siks63tRBf1U4bY9A7Sup
         SETpfhT1uNXA7+tXg9Acp1BYRWafB9Zn/OFgCZE2u5cnpRONHVcPiI5jPUBapdw36Z+3UmpFUVr7
         8BBIPu3i1oo9MnYo1HhuS00t0ClBLVMBhiVY0+Q5ZO7uSDsezlTzS9wG0qd8TnzBJFphddW7/PS7
         z3uxY7eGYSXSO0g8xc2Xe+XDQPW2b8Xocn8WGCwRtIehpJpXy4DCbJ8tKQo5JQE58OOoiNF3xzbR
         oZyvsxGzLlKMs9fn4al02Wn7w58zrz7ijlMtnL2ZKApcW9aSHXGkVM/yjAXeHmbduh5DEmC5MjvB
         qKFJaEBVJKDZBpACieZD47CtFbI/OVeSG2iJgpbp/RvoHRQ9VNv2shqWdoDPRHGsLyhzEd5Sso7q
         s7HzqiB9nLk6WALF8Zy5lcrPfyaG+gbHcZ5hgtuTqc7jbDCrwDo6ThUm8+hDGX/w5KH9Fz9iSj2N
         NK72e4Vg6i/EdN74UTb7k+mvEdADoE2y9QAMYTivndb09RjGC8rx6/0woMEkOKA3wb1RZgDQPN
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH 3/3] staging: rtl8712: fix potential memory leak in r8712_init_drv_sw()
Date:   Fri,  1 Apr 2022 01:08:19 +0800
X-OQ-MSGID: <20220331170819.9613-1-xkernel.wang@foxmail.com>
In-Reply-To: <tencent_0A1273526E1E87150578F8B752CF7F178806@qq.com>
References: <tencent_0A1273526E1E87150578F8B752CF7F178806@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

In r8712_init_drv_sw(), all the error paths do not properly release the
resources allocated by its callees.
This patch is to free them.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/staging/rtl8712/os_intfs.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index 163baaa..28b1684 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -304,23 +304,23 @@ int r8712_init_drv_sw(struct _adapter *padapter)
 	padapter->cmdpriv.padapter = padapter;
 	ret = r8712_init_evt_priv(&padapter->evtpriv);
 	if (ret)
-		return ret;
+		goto free_cmd_priv;
 	ret = r8712_init_mlme_priv(padapter);
 	if (ret)
-		return ret;
+		goto free_evt_priv;
 	ret = _r8712_init_xmit_priv(&padapter->xmitpriv, padapter);
 	if (ret)
-		return ret;
+		goto free_mlme_priv;
 	ret = _r8712_init_recv_priv(&padapter->recvpriv, padapter);
 	if (ret)
-		return ret;
+		goto free_xmit_priv;
 	memset((unsigned char *)&padapter->securitypriv, 0,
 	       sizeof(struct security_priv));
 	timer_setup(&padapter->securitypriv.tkip_timer,
 		    r8712_use_tkipkey_handler, 0);
 	ret = _r8712_init_sta_priv(&padapter->stapriv);
 	if (ret)
-		return ret;
+		goto free_recv_priv;
 	padapter->stapriv.padapter = padapter;
 	r8712_init_bcmc_stainfo(padapter);
 	r8712_init_pwrctrl_priv(padapter);
@@ -328,6 +328,18 @@ int r8712_init_drv_sw(struct _adapter *padapter)
 	init_default_value(padapter);
 	r8712_InitSwLeds(padapter);
 	return ret;
+
+free_recv_priv:
+	_r8712_free_recv_priv(&padapter->recvpriv);
+free_xmit_priv:
+	_free_xmit_priv(&padapter->xmitpriv);
+free_mlme_priv:
+	r8712_free_mlme_priv(&padapter->mlmepriv);
+free_evt_priv:
+	r8712_free_evt_priv(&padapter->evtpriv);
+free_cmd_priv:
+	r8712_free_cmd_priv(&padapter->cmdpriv);
+	return ret;
 }
 
 void r8712_free_drv_sw(struct _adapter *padapter)
-- 
