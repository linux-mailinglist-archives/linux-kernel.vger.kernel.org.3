Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27584BD27C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 00:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244747AbiBTXQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 18:16:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiBTXQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 18:16:35 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEBE2B1A2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 15:16:13 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 195so12744480pgc.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 15:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v+5D+f5AfXBOIxZqw3DuNGRZ2y8wgJVOd1esBx4G8SU=;
        b=L2f5+v1ifU3oarN26hOPJsm1Z2PpZlfWx9qdGUlh7o2u97XDcRAJXok2D5loBIB6oH
         GEgNgK3QaA5Ujst0njEzerhPqydz4ZMG8fGUAOiIdKsBPIvrUNg0+hX09d/uHePLBt9w
         1sx335FK3IyUsNYEH6dbNZ8VidQyFZea7X13qty8OA4z2fJ5ggXwO9vifBEXtyC5BL7u
         +Nh6jSt8xzGrHdDqMPQm/07Hyw5fKFcn/yVZNZ7+WrJx2toA/2uOLfj+uDKCKBtQiODL
         xKUlau8UGS4wEOq6WiqHzLB+3IPuQf/Aj7zC354c1QAAL1nIj98NVT1NazV9d/88V3FI
         y4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v+5D+f5AfXBOIxZqw3DuNGRZ2y8wgJVOd1esBx4G8SU=;
        b=HSWAsEk8Chsx5G6MvmN6tBwwyFdGavEMfK6PEMwrubLGsg77si9vpKF+gcqvDDGVkk
         UZ3iogOIXjzqEmWX2aSAal7m50FIUBWUf5MhVPLfmboE20GXNdBYTZgFo0R+W70Kwd2H
         oyf8OyaN2CBX4iZvQ6vwOcpwiY/fv9xpLu31HPxl74LUXhlfC6CmtCyEED5LuKMeMY1o
         Uq4oyUJQLoSkkrRis5DXexbWcEmjNa/xM4uGB09KC3y9jJfK4WPoNx9Z8DmakV52pky3
         QERbCDS4vxyfHXxdLjiyfeWXOt7pXyTLmPyPSjANogdQaV6GhXWTQTcjYcSWl7/8al4Q
         hTSw==
X-Gm-Message-State: AOAM532DlbKRcAR7L5U1CvWDJ9lMVR+BbzxrvnHczsSd2ya1TsE6eyjO
        VDiOeTx+SktOXV//mJLbqGE=
X-Google-Smtp-Source: ABdhPJzXK6lO+JuFiE+zOSXtibF/o69FEKgc7NC+abAX4mpznSrgITRs+qeSwdvviBiO6qX7se/MCg==
X-Received: by 2002:a05:6a00:1354:b0:4c9:1e96:d15c with SMTP id k20-20020a056a00135400b004c91e96d15cmr17446602pfu.30.1645398972881;
        Sun, 20 Feb 2022 15:16:12 -0800 (PST)
Received: from tong-desktop.local ([2600:1700:3ec7:421f:4bcb:4067:79cf:393f])
        by smtp.googlemail.com with ESMTPSA id j4sm3092087pfj.218.2022.02.20.15.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 15:16:12 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Colin Ian King <colin.i.king@googlemail.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Tong Zhang <ztong0001@gmail.com>,
        =?UTF-8?q?Cl=C3=A1udio=20Maia?= <clrrm@isep.ipp.pt>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: cleanup proc fs entries upon exit
Date:   Sun, 20 Feb 2022 15:15:53 -0800
Message-Id: <20220220231554.2510567-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

proc fs entries need to be removed when module is removed, otherwise
when we try to insert the module again, kernel will complain

[  493.068012] proc_dir_entry 'net/ieee80211' already registered
[  493.271973]  proc_mkdir+0x18/0x20
[  493.272136]  ieee80211_debug_init+0x28/0xde8 [r8192u_usb]
[  493.272404]  rtl8192_usb_module_init+0x10/0x161 [r8192u_usb]

[   13.910616] proc_dir_entry 'net/rtl819xU' already registered
[   13.918931]  proc_mkdir+0x18/0x20
[   13.919098]  rtl8192_usb_module_init+0x142/0x16d [r8192u_usb]

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 364e1ca94f70..683afdc667bc 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -4825,6 +4825,11 @@ static int __init rtl8192_usb_module_init(void)
 static void __exit rtl8192_usb_module_exit(void)
 {
 	usb_deregister(&rtl8192_usb_driver);
+	remove_proc_entry(RTL819XU_MODULE_NAME, init_net.proc_net);
+
+#ifdef CONFIG_IEEE80211_DEBUG
+	ieee80211_debug_exit();
+#endif
 
 	RT_TRACE(COMP_DOWN, "Exiting");
 }
-- 
2.25.1

