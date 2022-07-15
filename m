Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF848575EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbiGOKEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiGOKEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:04:37 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE1929837;
        Fri, 15 Jul 2022 03:04:36 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id v7so4314977pfb.0;
        Fri, 15 Jul 2022 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=isy+lqfdGWbdDvwuazChaQNb0abTWcyitW2EDjnWOlI=;
        b=Q2M7MrRqF6mFSv571FjGLMdC73JlNSuFahX8KuP03e+1J2X+jJCFB78fZUVKId4AFZ
         LURcLafpCeRXfJBk9/uflAbz/sXgpClSrjaZXz5zZFpi2E/Mnhl4mtbbl+DIZGIuoWiG
         3dGrFc75ib2a9NPFjey/XYCwyyKUJNHZyCYyO3ovu4h+s3Av0LOkYF3X9psH2Oclox/i
         PRDPgZYCljVhW1eKvKJ3/sjFiGGTk0wBMbDymMEI4wrfnnFecrEPlws8vXtjNOlAPH2V
         EFB4sOHNTmwIPIgTnnoKtbX69y1AOxJmfjzhK/DVP0uEcpMXmXKI/vHaIzHY/lhuq+wY
         cfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=isy+lqfdGWbdDvwuazChaQNb0abTWcyitW2EDjnWOlI=;
        b=zdY3s2doChVY/SEZCQx+Rky12LntcN/psVqY5M5y8sj1bOBaKcNHsZAtdY7/t0h5vL
         pHyb3VsC3gI6orhcpF3DF/JWzKUWaxd85stvZP4VDGP1RdeksDsHEBOLIhw+L79U0clC
         Tft4zdUCLsjj7DaW3cZhxTPU5sv+sK72ankM4Oc6XijijsAv5pxnmAsPKlpPgXoFVuAX
         x0G3rNnpim1TddUKFzfthwYE+MGViZFhA1a5GooPhQkGaQqao9fx9MfwGvnvnN7px/Vb
         cQntNxFBe66z45ybzgVsNNiGfb/3W5qGjs4xgx5ATs1rWvxJ6GlmHth3fKHUhcZuphwF
         8sbA==
X-Gm-Message-State: AJIora9LA4rwXINbO6Xyc8Rw0dgA77o/i59sNEwVE+t05WUn8CkLotAG
        rGpwmMwMSqEitMkhn4kXL3s=
X-Google-Smtp-Source: AGRyM1tGkAL8CWV7X9Zma5mjqKMu840RrZuAzMkZdYdpVesc0xZ/Pbg/0AJEzPaGNYJzYp/9/ANAqg==
X-Received: by 2002:a05:6a00:8cf:b0:522:93a6:46e9 with SMTP id s15-20020a056a0008cf00b0052293a646e9mr13508450pfu.62.1657879476014;
        Fri, 15 Jul 2022 03:04:36 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:569:4518:3851:6d9:846d:fbd1])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709028d8c00b0016c1948ef7esm3033791plo.296.2022.07.15.03.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 03:04:35 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH 2/3] usb: typec: tcpci: Add get cc tcpci callback
Date:   Fri, 15 Jul 2022 18:04:17 +0800
Message-Id: <20220715100418.155011-3-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715100418.155011-1-gene.chen.richtek@gmail.com>
References: <20220715100418.155011-1-gene.chen.richtek@gmail.com>
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

From: Gene Chen <gene_chen@richtek.com>

Add set_vbus tcpci callback for vendor IC workaround.
According to different rp level detected, set corresponding
rx dead zone threshold in order to decode right pd message.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/usb/typec/tcpm/tcpci.c | 3 +++
 drivers/usb/typec/tcpm/tcpci.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index f33e08eb7670..fc2f6191b7d3 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -243,6 +243,9 @@ static int tcpci_get_cc(struct tcpc_dev *tcpc,
 	unsigned int reg, role_control;
 	int ret;
 
+	if (tcpci->data->get_cc)
+		return tcpci->data->get_cc(tcpci, tcpci->data, cc1, cc2);
+
 	ret = regmap_read(tcpci->regmap, TCPC_ROLE_CTRL, &role_control);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
index b2edd45f13c6..2cef19e131f8 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/drivers/usb/typec/tcpm/tcpci.h
@@ -190,6 +190,8 @@ struct tcpci_data {
 	unsigned char vbus_vsafe0v:1;
 
 	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
+	int (*get_cc)(struct tcpci *tcpci, struct tcpci_data *data,
+		      enum typec_cc_status *cc1, enum typec_cc_status *cc2);
 	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
 			 bool enable);
 	int (*start_drp_toggling)(struct tcpci *tcpci, struct tcpci_data *data,
-- 
2.25.1

