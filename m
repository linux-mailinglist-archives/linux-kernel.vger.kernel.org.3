Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1BB516AB7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 08:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383473AbiEBGKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 02:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383431AbiEBGKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 02:10:05 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698A14EF4B
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 23:06:37 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p12so11598379pfn.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 23:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FL4JimMUhmY1BeTMTK+TnPmU576KVxmETjweuyLuCOo=;
        b=OFXE66pE/ktWSt/5voVeEhMhzzjJ3ORO0W5OjxJds9qw+k7j2EG9ORxSHmD5i8yEm5
         nC9O4KPZiYx+rv4InxZiPdWLN2X4hDs0DhNp1k2iT/ZeAFpAmYyTDJIBCYb9udtNrq+G
         xPCzCRXZ2b+LgvRYHNkcR98uDFeQdjZNhZ9q7kZSRWU2Z0MDzV3ZeYTHPoWoNpv7+fQs
         cky8tLry5aLxOdICsNscsAYGlpDeRdlIcFXEG11VuGjhzJ9+YMFlhmiwe7E7yb13rf+H
         4HE25MLXBrJ52iZQPuL9A9rrp+85ZdIa9POCM2WQQBOBUr8zfcQh0BR8L4/uAdM8Mxz6
         4TuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FL4JimMUhmY1BeTMTK+TnPmU576KVxmETjweuyLuCOo=;
        b=k7+T8pUf5MWu4MODgKGKcWPSlAoAP9mE+jnw/OKFclXVLRHUzcwfXWNgUNRUbdXCCt
         V6+1cd5i/EIHhjc+u6R7r1nauH0pEXvFhbLVCcnn5BycBOxotBKvBe6j8N+3g1+z2+w3
         PfjWNZiXXVxHtl6xpuR3WwERAnRgWkh+Q+x0CDZCNq0UlYeH6AT3Rp6dcJSuxfeW5WuQ
         JhGHLrYMAZ9k8mUrNxQrIad2i+5KCHTXVMhPV+gujUlbj6M82JZpA+pg8YpzFGvvYpa3
         hOLfjghi2AUyU3/ALv1ZZhiXhWhYPNn7Gg7peKAjxeFbCeTVXNrHgetJVlO/L3Pe5WDL
         NdJQ==
X-Gm-Message-State: AOAM530ABmz1GuK/nAi2NRkqbn2q5ejJgvGbajbRyaFnbiWUMfs8dr/7
        /VGymxq4o+qF2MYUTo3UR9sv
X-Google-Smtp-Source: ABdhPJxb6iPxT001JHILmsfK5SvyQcjtft+sZmMyKCsyzDQDauyPZCbU2PiXuVxii4Sz+RFpxlBhLQ==
X-Received: by 2002:a62:e518:0:b0:4fa:9333:ddbd with SMTP id n24-20020a62e518000000b004fa9333ddbdmr10156182pff.11.1651471596890;
        Sun, 01 May 2022 23:06:36 -0700 (PDT)
Received: from localhost.localdomain ([27.111.75.99])
        by smtp.gmail.com with ESMTPSA id h3-20020a62b403000000b0050dc7628181sm3933826pfn.91.2022.05.01.23.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 23:06:36 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, kw@linux.com,
        bhelgaas@google.com, robh@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/8] PCI: endpoint: Add linkdown notifier support
Date:   Mon,  2 May 2022 11:36:07 +0530
Message-Id: <20220502060611.58987-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502060611.58987-1-manivannan.sadhasivam@linaro.org>
References: <20220502060611.58987-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to notify the EPF device about the linkdown event from the
EPC device.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 17 +++++++++++++++++
 include/linux/pci-epc.h             |  1 +
 include/linux/pci-epf.h             |  1 +
 3 files changed, 19 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 3bc9273d0a08..8401c2750c9e 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -697,6 +697,23 @@ void pci_epc_linkup(struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(pci_epc_linkup);
 
+/**
+ * pci_epc_linkdown() - Notify the EPF device that EPC device has dropped the
+ *			connection with the Root Complex.
+ * @epc: the EPC device which has dropped the link with the host
+ *
+ * Invoke to Notify the EPF device that the EPC device has dropped the
+ * connection with the Root Complex.
+ */
+void pci_epc_linkdown(struct pci_epc *epc)
+{
+	if (!epc || IS_ERR(epc))
+		return;
+
+	atomic_notifier_call_chain(&epc->notifier, LINK_DOWN, NULL);
+}
+EXPORT_SYMBOL_GPL(pci_epc_linkdown);
+
 /**
  * pci_epc_init_notify() - Notify the EPF device that EPC device's core
  *			   initialization is completed.
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index c414a08bfd67..d346ab9ae061 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -215,6 +215,7 @@ void pci_epc_destroy(struct pci_epc *epc);
 int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 		    enum pci_epc_interface_type type);
 void pci_epc_linkup(struct pci_epc *epc);
+void pci_epc_linkdown(struct pci_epc *epc);
 void pci_epc_init_notify(struct pci_epc *epc);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 			enum pci_epc_interface_type type);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 0c94cc1513bc..b1fcd88d0b1f 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -20,6 +20,7 @@ enum pci_epc_interface_type;
 enum pci_notify_event {
 	CORE_INIT,
 	LINK_UP,
+	LINK_DOWN,
 };
 
 enum pci_barno {
-- 
2.25.1

