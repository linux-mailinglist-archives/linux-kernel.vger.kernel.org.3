Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B5050D01E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 08:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238440AbiDXG5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 02:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbiDXG5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 02:57:14 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1D11384BC;
        Sat, 23 Apr 2022 23:54:14 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id a5so9479356qvx.1;
        Sat, 23 Apr 2022 23:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r09fsKtZLjwCj1HV5PJv3dMIB0dG9OUJQSIGrDje8nY=;
        b=D2egTLIFLgTdK0Mc24j9SCSI6wDrCg4nGiVux16xn8hlW2sdIOjQ3pf4I+Yqn1Y5lL
         Xhy3Ahc1eN0jkl0xr55gL7yzuKHEQzm64p7pXoFqJV6iTBmO+mzh7DymzxFR/3q9sRH0
         LsOn5JELpc+DR4KK+ymUrZgpiNoT0sysTPjwhyO0QH29cX/F/pocNB375knJDKZ07ALv
         Jl2s1Nin24pB06fFYExnvTdzfZm4TGYOoVNQ1dzHUF4/Doit2iIXrbYqHLtlrVnlunEx
         V7R0nn/eaSB5OOIbB/Altmt7O+nQV2u0cm2BsVAmzDLFV75LNGF+GsGjANkCXjv0zs2T
         P57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r09fsKtZLjwCj1HV5PJv3dMIB0dG9OUJQSIGrDje8nY=;
        b=NnTW+gB6kL3Z9a+ZLIQ8d8c52mV0Owbe5syl/uvwhPDA8mlI0ZZKTlYrC7NpAem4Gb
         +vPCe+ed57Frypp5VRVkCt3WTDnOQ3UaSt9ele6Nmtbd0JtDOTNoJccG1tRooH3iXktf
         cjB7/JtuIXEzlmK4WU6eHp8Pgxo3z11xBXR7fRMfZQtAcFvgx+6hcelhujbLfuZ69LZX
         tSQLh4TKdQtfCoLCH9MgzmYQ6ecjctwNHFekirCKEoTpG+PQFU/EUfP+ExkUG/UnLMpj
         GC7qjVSpzdr0dDROZVU9/DDs/xX0arbskpRErRKDpyhd8yd+p4oTZKkX77RSE3PIof3K
         dlXw==
X-Gm-Message-State: AOAM531V3REWHfaLS4CwtNMgADSC17ASOYs08L27SVfxYyu7yJO8JiRD
        BuDn2Pe/+ysSTW8K21pVQoo=
X-Google-Smtp-Source: ABdhPJwubd07iNkk3PuN+yBlilLbTVDrO8/SMttaNHqwcN892IygE4Smfa2WL/2CChIU3CEeqvQ8Ag==
X-Received: by 2002:a05:6214:2342:b0:42d:7c8b:9eac with SMTP id hu2-20020a056214234200b0042d7c8b9eacmr8693302qvb.5.1650783254063;
        Sat, 23 Apr 2022 23:54:14 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e23-20020a05620a12d700b0069ec181a0b2sm3142156qkl.69.2022.04.23.23.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 23:54:13 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     satishkh@cisco.com
Cc:     sebaddel@cisco.com, kartilak@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] scsi:fnic: remove unneeded flush_workqueue
Date:   Sun, 24 Apr 2022 06:54:06 +0000
Message-Id: <20220424065406.3228528-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ran jianping <ran.jianping@zte.com.cn>

All work currently pending will be done first by calling destroy_workqueue,
so there is no need to flush it explicitly.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
---
 drivers/scsi/fnic/fnic_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 9161bd2fd421..460e03a55096 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -1146,10 +1146,8 @@ static void __exit fnic_cleanup_module(void)
 {
 	pci_unregister_driver(&fnic_driver);
 	destroy_workqueue(fnic_event_queue);
-	if (fnic_fip_queue) {
-		flush_workqueue(fnic_fip_queue);
+	if (fnic_fip_queue)
 		destroy_workqueue(fnic_fip_queue);
-	}
 	kmem_cache_destroy(fnic_sgl_cache[FNIC_SGL_CACHE_MAX]);
 	kmem_cache_destroy(fnic_sgl_cache[FNIC_SGL_CACHE_DFLT]);
 	kmem_cache_destroy(fnic_io_req_cache);
-- 
2.25.1

