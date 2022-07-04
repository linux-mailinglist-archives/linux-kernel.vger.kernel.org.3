Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4CB56573A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbiGDNbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiGDNbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB42F13F2C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656941174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZFyoZ7D/fa5gmQoEd3Ma3fgXtCiYDuZqYWuaxk3SWTA=;
        b=TTnVjIZOhsuQHc8rEUkRJffmkwFkSmbecUYX40HZBu41wSOCoS/MVcJ27QbNjoj5nn/o/Y
        D6EblIp2aB5Je4girE7p5ZunEKwtuu+55T4mftAXehN+6pO3zzE99McCdKsmTxvHR/V1xI
        jcZlwBWaYSRk0wC/KAvqiBkGIZPzBqg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-TPqZkf3ENaCkLg5jIfRYrg-1; Mon, 04 Jul 2022 09:26:13 -0400
X-MC-Unique: TPqZkf3ENaCkLg5jIfRYrg-1
Received: by mail-qk1-f198.google.com with SMTP id 186-20020a3708c3000000b006af306eb272so8721574qki.18
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 06:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZFyoZ7D/fa5gmQoEd3Ma3fgXtCiYDuZqYWuaxk3SWTA=;
        b=3gkso+NGkq2CnfQMoVOlF7IRhb26J0Xk8zW6+KUcSy5J4YGQ6Z6XNFrr6CT6XPCOF3
         OO4XgWntKihd3ylSlmPUa3KgMUD1xvtu/q8idDI74NzSWQXlzhKD4AfhjmQW1E0XjCbT
         mje5I3e6wgCmSCEFng3cBxnKb9lnHWxVNMODigUIJHKsHt6InfNr98+VbkM5ZTEizkAO
         hGOVsrFianDY/t6fqOOVYWnfF+SpD3KjMfQmQcj4jfDgm6qKIyTgUxHZrTdKJdvyzkDG
         gCneqJZCdyWbcR4nem0kpGfPXBGB6XaCTi31kmE5H4Lo06uwbPWGxChr5QXqPVKc5zMf
         6wtQ==
X-Gm-Message-State: AJIora/6cX9E5BbzaVpus8ZZpIIAhwFmCsqIc18R5zP/bt5t7E4Goqvs
        /F8clKgvKEtKFBGjxdFPzyS7oal8l0y9LqoQDSi2lW0J/yCGHj1CK8xl+F6Z4bn7swWO/z5WWFp
        gfE7rEONfvyN2+PF86lTfv6Yj
X-Received: by 2002:a05:622a:2cb:b0:31d:3cc4:a451 with SMTP id a11-20020a05622a02cb00b0031d3cc4a451mr11543063qtx.286.1656941173373;
        Mon, 04 Jul 2022 06:26:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tkI+Nvz4sxYlPCW3hajzisXlWPUUDJaShU+UyRjZWMkD08tKFPIV8vYEypHMgCMF3Oc0EuPA==
X-Received: by 2002:a05:622a:2cb:b0:31d:3cc4:a451 with SMTP id a11-20020a05622a02cb00b0031d3cc4a451mr11543047qtx.286.1656941173151;
        Mon, 04 Jul 2022 06:26:13 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u16-20020a05620a431000b006a7284e5741sm25014528qko.54.2022.07.04.06.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 06:26:12 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     kishon@ti.com, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, jdmason@kudzu.us, Frank.Li@nxp.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v3] PCI: endpoint: pci-epf-vntb: reduce several globals to statics
Date:   Mon,  4 Jul 2022 09:25:59 -0400
Message-Id: <20220704132559.2859918-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
v2,3 : Change commit prefix

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

