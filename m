Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0475562499
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 22:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbiF3UtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 16:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiF3UtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:49:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2192238182
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656622149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=di7J6Wa6nninmByx+gDsIMjmLcFBw0UA6kzPyPIpFZc=;
        b=f56HsuNHznGsRsAsRCbs3CiEF+7aekaQzZZwYoIYR96DX8wWGoidXktUCcCIuEqbhZ06yB
        JTWslixnVqryCaAkmpnecsxzJ0i1JLbkUzWI8WCcBMvPdb3shCzysaEetKd/GHlzIrsWzd
        JgboSBLoRuhoOjHo7MoixhuCv4pZNeA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-3SI_9F3RPa2Inb9RLX5UKA-1; Thu, 30 Jun 2022 16:49:08 -0400
X-MC-Unique: 3SI_9F3RPa2Inb9RLX5UKA-1
Received: by mail-qv1-f72.google.com with SMTP id mr11-20020a056214348b00b004705c0cb439so603738qvb.19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=di7J6Wa6nninmByx+gDsIMjmLcFBw0UA6kzPyPIpFZc=;
        b=gWkWTt+W5iimwA8vsoNLTm/oKP67nBYE/VvUZzLkyZBbUwnoucyvI51dH2YTnxYIuX
         l6yoSpi56A5oLw6n/w3Jj6qOlrfD5Q2WDnpCFIfxTafG5AY54cJ32IcaYxw0vXbPJNey
         E7K/bFAAIPPW87mq3EAORs/s8KkleZt4TYsWVdi0gsGUe9CXBhzQs9bmcmwTkirUi28T
         e5ZBMm7kIy/S1VmcDL+8nXzEvbeepPfh2FRrSAp5vsjyYjNtmz7hvqC8koBhIVY9zE3M
         KfREiTor7soatPOZsVNiSBKfHgbqWtsBlykknc7X8vVev8LC7W43rmE7N6xZ9lcMqVgZ
         J67w==
X-Gm-Message-State: AJIora8ksjYKEZuJXQ2YixNjBlGBQmOKs8Z+aXrWk+W6u8PtSTQ8lBtG
        uT5Y2zhM9+RfvJ4Sq2d96NEIZB47KRZfwWHNssVoNJHhQMhKBS5rVs4q/lkUjWE9fhamsKRUJCB
        2mXZbnS2M7Jr42dIbSufqF2s5
X-Received: by 2002:ac8:578f:0:b0:317:cce3:a989 with SMTP id v15-20020ac8578f000000b00317cce3a989mr9384275qta.322.1656622147566;
        Thu, 30 Jun 2022 13:49:07 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uKuchKxwg8yNSOQWvC4IJPX9LeJ5U64LQD3g9gvol6kA8jHVilKifjL3iwp+Ch0cTt3SLMog==
X-Received: by 2002:ac8:578f:0:b0:317:cce3:a989 with SMTP id v15-20020ac8578f000000b00317cce3a989mr9384252qta.322.1656622147190;
        Thu, 30 Jun 2022 13:49:07 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b20-20020ae9eb14000000b006aee8580a37sm15601071qkg.10.2022.06.30.13.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 13:49:06 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     kishon@ti.com, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, Frank.Li@nxp.com, jdmason@kudzu.us
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] NTB: EPF: reduce several globals to statics
Date:   Thu, 30 Jun 2022 16:48:59 -0400
Message-Id: <20220630204859.4134463-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse reports
drivers/pci/endpoint/functions/pci-epf-vntb.c:956:10: warning: symbol 'pci_space' was not declared. Should it be static?
drivers/pci/endpoint/functions/pci-epf-vntb.c:975:5: warning: symbol 'pci_read' was not declared. Should it be static?
drivers/pci/endpoint/functions/pci-epf-vntb.c:984:5: warning: symbol 'pci_write' was not declared. Should it be static?
drivers/pci/endpoint/functions/pci-epf-vntb.c:989:16: warning: symbol 'vpci_ops' was not declared. Should it be static?

These functions and variables are only used in pci-epf-vntb.c, so their storage
class specifiers should be static.

Fixes: ff32fac00d97 ("NTB: EPF: support NTB transfer between PCI RC and EP connection")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index ebf7e243eefa..6f0775b1fec3 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -953,7 +953,7 @@ static struct config_group *epf_ntb_add_cfs(struct pci_epf *epf,
 
 #define VPCI_BUS_NUM 0x10
 
-uint32_t pci_space[] = {
+static uint32_t pci_space[] = {
 	(VNTB_VID | (VNTB_PID << 16)),	//DeviceID, Vendor ID
 	0,		// status, Command
 	0xffffffff,	// Class code, subclass, prog if, revision id
@@ -972,7 +972,7 @@ uint32_t pci_space[] = {
 	0,		//Max Lat, Min Gnt, interrupt pin, interrupt line
 };
 
-int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
+static int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
 {
 	if (devfn == 0) {
 		memcpy(val, ((uint8_t *)pci_space) + where, size);
@@ -981,12 +981,12 @@ int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *
 	return -1;
 }
 
-int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
+static int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
 {
 	return 0;
 }
 
-struct pci_ops vpci_ops = {
+static struct pci_ops vpci_ops = {
 	.read = pci_read,
 	.write = pci_write,
 };
-- 
2.27.0

