Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB06B4F0A1C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 16:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358976AbiDCOLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 10:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347720AbiDCOLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 10:11:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EC7D220F9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 07:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648994991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Paew1cixTCbNDEAnJcjsrt4RDdzFbnZFs2J8I4RhtSg=;
        b=fGMXv+2fIILayWEL62qDUs4neJsKj2LHJ+aXBQXXjh7aXWyuCha3ES4D73Ge3k7F7lPDVV
        shpZ4gM7SepHf//IJRzGJ7TgQpESGeaghiGUr05QFl28i38Idr9bi224N6XmMEXZ51KOQT
        IFyl2KxiL81V4IRGcupEKCwdLIV0/tY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-1R03EGTcPJWhIXxG-F8pWQ-1; Sun, 03 Apr 2022 10:09:50 -0400
X-MC-Unique: 1R03EGTcPJWhIXxG-F8pWQ-1
Received: by mail-qv1-f71.google.com with SMTP id jv4-20020a05621429e400b00443ceb5a53bso2075938qvb.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 07:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Paew1cixTCbNDEAnJcjsrt4RDdzFbnZFs2J8I4RhtSg=;
        b=pzNoQ23GBuNf+0IWAl7Oj8Na35OpNCIu2IO1cxQMVYogyC0yNbM6RhvyAjzacicS9P
         +FskBMlFzaEbEx7hBLWc+0F8/icvbnpTQ+khLiT6+hCdhvLYcgvg0gu3vrDb/EEOghO+
         tsI0Oexn6jGhGkzEzNS9Q8kGoa/GV5+QNyDtXZDc70xbW6iQtruK2lyhUrF/sOVOSoRR
         RfOzFN4eWDa4hG8rsz3mqOxOPdcPlhF1I4V/oHupvp5E3MFrtf2z3h7TjBrFbmJHqNxy
         dtaLazHrGBArvHjYk/zUZ/dWkrrAziqoiM0cDwI/ae1BZ5EU9x3UNrgq1b5Q679jkJ0r
         uwWw==
X-Gm-Message-State: AOAM530dlTc6R2Ps8k6F5YTN7wl+RoCEynRZxM4bIkewGgq/PWnhjk5e
        M78GAcXs3btUxsreTpmuc7dBtectQ8D7Nr5dzkhj1Ha/uFQhygKANNdccpJ/MtdVBWpkFe3hRSd
        NMD6D0+5udoAa3rvBJ2q8CeM6
X-Received: by 2002:ac8:5f84:0:b0:2e0:6965:c999 with SMTP id j4-20020ac85f84000000b002e06965c999mr14326051qta.477.1648994989810;
        Sun, 03 Apr 2022 07:09:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwc0SCTbZqfX561PNjcDdM+9bvNOk7IjVyt8XoGCRzABltyeMkZOeruzXASPLtq+5otq/XfDg==
X-Received: by 2002:ac8:5f84:0:b0:2e0:6965:c999 with SMTP id j4-20020ac85f84000000b002e06965c999mr14325981qta.477.1648994988567;
        Sun, 03 Apr 2022 07:09:48 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h6-20020a379e06000000b0067b30874b90sm4605821qke.41.2022.04.03.07.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 07:09:48 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] fsi: cleanup extern usage in function definition
Date:   Sun,  3 Apr 2022 10:09:37 -0400
Message-Id: <20220403140937.3833578-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports these issues
fsi-core.c:395:12: warning: function 'fsi_slave_claim_range'
  with external linkage has definition
fsi-core.c:409:13: warning: function 'fsi_slave_release_range'
  with external linkage has definition

The storage-class-specifier extern is not needed in a
definition, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fsi/fsi-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 3a7b78e36701..0d11a17c53a0 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -392,8 +392,8 @@ int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
 }
 EXPORT_SYMBOL_GPL(fsi_slave_write);
 
-extern int fsi_slave_claim_range(struct fsi_slave *slave,
-		uint32_t addr, uint32_t size)
+int fsi_slave_claim_range(struct fsi_slave *slave,
+			  uint32_t addr, uint32_t size)
 {
 	if (addr + size < addr)
 		return -EINVAL;
@@ -406,8 +406,8 @@ extern int fsi_slave_claim_range(struct fsi_slave *slave,
 }
 EXPORT_SYMBOL_GPL(fsi_slave_claim_range);
 
-extern void fsi_slave_release_range(struct fsi_slave *slave,
-		uint32_t addr, uint32_t size)
+void fsi_slave_release_range(struct fsi_slave *slave,
+			     uint32_t addr, uint32_t size)
 {
 }
 EXPORT_SYMBOL_GPL(fsi_slave_release_range);
-- 
2.27.0

