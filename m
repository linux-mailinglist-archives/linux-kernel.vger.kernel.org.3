Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCF74F584B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 11:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343801AbiDFJCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1454332AbiDFI7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 04:59:16 -0400
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7381578F6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 20:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649217302;
        bh=Qji2tpEUH3o4mJwBDFsQS4SqD05eihtujsHl1AMU6Mc=;
        h=From:To:Cc:Subject:Date;
        b=FPOLIKPfHe/eWAxfV2CNWt4P30tUfbLja8lunrItNkh1fQ+ZoS3PWHhCo5pehwWhG
         mN1MDyf/mMjP52wj0sA7gvPjWogwEQ+KMUxdWqhxqBvVgZ1kGNTtQP42AWSKMiUCU2
         qTcg8E2KehhfAvlzebK0NK/nzh5ljWLiQ+4VbIr8=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrszc11.qq.com (NewEsmtp) with SMTP
        id DBB9BC4D; Wed, 06 Apr 2022 11:54:59 +0800
X-QQ-mid: xmsmtpt1649217299t7amwayzb
Message-ID: <tencent_8289F062A5E3FF2C104466AF5C5A0E1B0A07@qq.com>
X-QQ-XMAILINFO: NiAdzfE16ND47ZF6Tl2VR9BFDfDwNJvBOVJ3rFJP/srV5vksrGsuJ8TghR2wsb
         pDGK+mDDsBHOdE/z6lGVzUB/KuIA76gMZQ6pQLQ2lb3afhApl8/s2uu2+7pV43IVCfu4WUajcNmb
         n1OXT+hCm6Hy1PXPfpOGbaLbzszm4oFEyFuI90C2kifN6t6qqyurMbzaqAv1xNKadgwz3Oy/Oz7C
         Y1igEe9u6li3fiw6wynaxSeHBwyumHHFTN/HoT5n51T7v3wfV4TwTJjJ85SsKGsCOerX91joWjxj
         06rxHuLu6mFQedjloCuY+0Sy2dOkwMGs6A+QysYo6m7ymO6ZmOXCUFgnj1t7MXYKQ6ONiVDRSYJG
         hInjOFUG8SdNHYjTikPEGrvwoZqxn4GCyvUmjlvbbwys9zJ6SH3IhAjWnZYQBtM5PcTHAHaRLy4J
         shHw5vyF0QwA4Mxfs9GQR4rE+JNgR1SdqVxj26GOa5Sd1FOY64UDTIF5Y3gd5Z3mrZOPmM7Bhndk
         t0mFJEeePhGeSBb7YxHYLOXC9oAUL5W0GxhaNZNZ90QrFtcyf1eFJ7AOm27XX/nq3YPjAkLejVyu
         c/+yno2p+dtzZzrepQ9Gq1VqlZ4r+Ftl4zoNh25N3TgdMCOqErdpG/3JJlZORF0diCqmlB9YuvFJ
         4M+wSrJUhHrxbVTxKmpjpHcXkkeNlv5aRbEK8VZeoPTyNUNh5dIhV23lt3km6M4Q5H0oqyFC7i9/
         KeahrzefZHfZJqkUp1wig4Ax6t3e4AVPRid6h5T5ZZaBks69j/mg91PV9WXIFtGkyF6NT2QETWiV
         orbBo5bd47Y4GVNqJjOYWEV+6xV+UIwrJIiR9f2ANN4FgO231i3cNXztBxJLPSUU6LGkGklJlSU7
         e8H7Dwt746aDGS10HO+7wp9VlKsKVsS/cm2n3UnpvV1xfNNv4y4LrCo056VqYmz+SFtmxp77BZ9D
         hq5nYYICRInytIYqxU7OZTmRmk3/Rt9S68RXqfmIw=
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v3 1/3] staging: rtl8712: fix potential memory leak in r8712_init_drv_sw()
Date:   Wed,  6 Apr 2022 11:54:46 +0800
X-OQ-MSGID: <20220406035446.12892-1-xkernel.wang@foxmail.com>
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

In r8712_init_drv_sw(), there are various error paths do not properly  
release the previous allocated resources but directly return the error  
status, which leads to various memory leaks.

To properly release the resources, this patch unifies the error handler  
of r8712_init_drv_sw().
According to the allocation sequence, if the init function returns 
failure, it will jump to the corresponding error tag.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 adjust the sequence of the patches in this series.
v2->v3 update the description.
 drivers/staging/rtl8712/os_intfs.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index 9502f6a..1f7ccec 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -304,10 +304,10 @@ int r8712_init_drv_sw(struct _adapter *padapter)
 	padapter->cmdpriv.padapter = padapter;
 	ret = r8712_init_evt_priv(&padapter->evtpriv);
 	if (ret)
-		return ret;
+		goto free_cmd_priv;
 	ret = r8712_init_mlme_priv(padapter);
 	if (ret)
-		return ret;
+		goto free_evt_priv;
 	_r8712_init_xmit_priv(&padapter->xmitpriv, padapter);
 	_r8712_init_recv_priv(&padapter->recvpriv, padapter);
 	memset((unsigned char *)&padapter->securitypriv, 0,
@@ -316,13 +316,25 @@ int r8712_init_drv_sw(struct _adapter *padapter)
 		    r8712_use_tkipkey_handler, 0);
 	ret = _r8712_init_sta_priv(&padapter->stapriv);
 	if (ret)
-		return ret;
+		goto free_recv_priv;
 	padapter->stapriv.padapter = padapter;
 	r8712_init_bcmc_stainfo(padapter);
 	r8712_init_pwrctrl_priv(padapter);
 	mp871xinit(padapter);
 	init_default_value(padapter);
 	r8712_InitSwLeds(padapter);
+	return 0;
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
 	return ret;
 }
 
-- 
