Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AD153CB61
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 16:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244910AbiFCOMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 10:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237239AbiFCOMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 10:12:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FEB12754;
        Fri,  3 Jun 2022 07:12:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso12151922pjl.3;
        Fri, 03 Jun 2022 07:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AQ10zYcRBw5WaFdheuLXgUA9xdtkMVpnXoJErK9bTIg=;
        b=UMVzcVtb+3Z2wU0z6hHwpYX7UN2nVww6/sPmspOqL46hQ4vBX8lmCa1JcaFLdaZGIg
         CVAT+G22yBUe5HYrYZMCVTiMxnT1zBscvh7n8+IPenj3FjFhe6W+w9AdACJB21ufgge+
         K0cUW4vlQTYjRsG1RVoFzIn/VfhUZybGCxhvQQMD3NP3NZVkkZXh4IMzZy4NH9V4Q3DC
         BSfrKdbfkinvzbhA6n/0jqc7DlKf+WNhse7Sml80d+iQRQ1euHkM/l214UHW5HeFTrmB
         jPeX4O5ZBWs815r1875FgnbuoPYwLaSDWwqB1unFJwAHITiWYclc8bOKZv01juPxPWM9
         V5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AQ10zYcRBw5WaFdheuLXgUA9xdtkMVpnXoJErK9bTIg=;
        b=V7OmXEzAHA928+twBQDqCfuvx6zO8juOOcFVZxOAUzg7Ubgg19YZeb+qdfbnFhl6UF
         tSDOLzMiwPGNB8ncw9NRxFPF2cTep69acGchb3taOTSbg2AaFNHCcniwDzsZReySBAsJ
         g5sAGTImQHL5CwoZek0UZo44Vn8J4MvDnHAt57gre555oqF+BYXHOePUrRqE22+Mcz54
         VkKDlEK3JrjER790RRjlRodLUATOwkPseTCzbAePNPShJBUyrV7oQTFcCca0jQbaLr5H
         KFK6iqzOZfFjMR0Gd/gZrJ29yh3sFlhQp0+4dIl43rkjdUJg3WftvusSmT9soUI9wtNC
         0wjA==
X-Gm-Message-State: AOAM532wMauOli9eladTxAuQCqka6amEMnys3BnN1QDMWFlTKamyK1Ob
        eQRkQ6pXF2HR+RH59qvpJKU=
X-Google-Smtp-Source: ABdhPJywRw39nosBa2BdbHpD4jnRfnjqPoofU9FiYlyhxmebM9me3u2Bd0XzV0wheQS1+ffp9LkGMw==
X-Received: by 2002:a17:90b:314a:b0:1e6:826e:73b2 with SMTP id ip10-20020a17090b314a00b001e6826e73b2mr10318647pjb.239.1654265560240;
        Fri, 03 Jun 2022 07:12:40 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id 13-20020a170902c20d00b0015e8d4eb2adsm5403360pll.247.2022.06.03.07.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 07:12:39 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Vladimir Zapolskiy <vz@mleia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roland Stigge <stigge@antcom.de>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] usb: ohci-nxp: Fix refcount leak in ohci_hcd_nxp_probe
Date:   Fri,  3 Jun 2022 18:12:30 +0400
Message-Id: <20220603141231.979-1-linmq006@gmail.com>
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

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: 73108aa90cbf ("USB: ohci-nxp: Use isp1301 driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/usb/host/ohci-nxp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
index 85878e8ad331..106a6bcefb08 100644
--- a/drivers/usb/host/ohci-nxp.c
+++ b/drivers/usb/host/ohci-nxp.c
@@ -164,6 +164,7 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 	}
 
 	isp1301_i2c_client = isp1301_get_client(isp1301_node);
+	of_node_put(isp1301_node);
 	if (!isp1301_i2c_client)
 		return -EPROBE_DEFER;
 
-- 
2.25.1

