Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D205624D3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbiF3VGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbiF3VG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:06:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68ADE2E69F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 14:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656623187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PgCRCs3Ju1LT1H7xrn3YHeQT3HJmnLyEcvVhogV2p8s=;
        b=ECuxXhbrqyFI5zdGzdeAdAmq/nJ4rf82GoY5/w57OlfMZ0IUcN/LbChWiq+HYTYJ3sRQ+J
        88Ler4yQzNzXYVFt60vEwOUyzliFtOW69iarSSmBBGtFNxA85MdNjGjXUjyjArrpCsoyYZ
        qY3cwWSQlI+/ymzCPw0dRqCI3Aqv/Zg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-dBXvMvptOJ2Igq7EWW0iWA-1; Thu, 30 Jun 2022 17:06:26 -0400
X-MC-Unique: dBXvMvptOJ2Igq7EWW0iWA-1
Received: by mail-qv1-f70.google.com with SMTP id ls8-20020a0562145f8800b0047078180732so709149qvb.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 14:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PgCRCs3Ju1LT1H7xrn3YHeQT3HJmnLyEcvVhogV2p8s=;
        b=ZBrriWyT6VjvEncKdcwpHsDZHIsBubZIqZf+brPEgMqlB/mpYzO5IB0H7do0HCj4L5
         ArSAmXIW1CAGDmq+c1AArKPjbGKXbn0lyjf3S6PMEWVVDjhx7ZWkaTqgqZ69Lv0EsOxp
         WS56duuhCGTtLSZDtFrc63sWK9vAaKoNABPir/kFTE6fhx8X3pjd/fEEYjs1x4GhQGF6
         4S7HiE7GYt7BUo+tS7dYBlzKkJ4s31BCaZYXJlshi0jfx+tySOdAZDFDQQ3fFPs8BpQL
         lejdj37crZm3K11sMm6CwMQ6ZEAE51xTarrenPFZl0AOz0CAow/3aEKZRfqSKMrnbBmf
         XV6Q==
X-Gm-Message-State: AJIora/gV65Tp2QL8YdFy7TPfB15PagYIbFT5mQAVNsbTir7bhA3maCz
        x5R8oH5Pf+Hw4xV9ImvMKESg1nEHfLj0h4ZtjGtYwMJ/gIEldgSM653wcPozHbxha7ieVdHGbc0
        fB2pdwGOGmBh1bxDPhu9Ib9MT
X-Received: by 2002:a05:620a:2903:b0:6af:41a4:3f71 with SMTP id m3-20020a05620a290300b006af41a43f71mr8265243qkp.350.1656623185646;
        Thu, 30 Jun 2022 14:06:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vWq9ez6tSed5y9DzhsOiLl8H6BjGzMp//FKEqb9RaQrfBysTvAYMxg4p2bdggmgxJctN+7+w==
X-Received: by 2002:a05:620a:2903:b0:6af:41a4:3f71 with SMTP id m3-20020a05620a290300b006af41a43f71mr8265219qkp.350.1656623185408;
        Thu, 30 Jun 2022 14:06:25 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v123-20020a379381000000b006a6c230f5e0sm7703164qkd.31.2022.06.30.14.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:06:25 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     kishon@ti.com, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, Frank.Li@nxp.com, jdmason@kudzu.us
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] PCI: endpoint: reduce several globals to statics
Date:   Thu, 30 Jun 2022 17:05:17 -0400
Message-Id: <20220630210517.1825677-1-trix@redhat.com>
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
v2 : Change commit prefix

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

