Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E4E583B26
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbiG1JWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiG1JWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:22:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821B86564A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:22:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 373DE20FE4;
        Thu, 28 Jul 2022 09:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659000140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KaNe8gfPDt7QKa5VYJW3wDvL8W+QWbWKq376KcUEzZY=;
        b=iclC+NarXfrqAALECZsO27bElHgeJdsCms/hrJHvEBkSkmzA/qXQ6v8PuZCunIHXDVPlNc
        cFqhoLd7krt4NogKAc3DC1OlWGUkpN/Y/NQHWqXAf2AtpNtc8sJg6tSZa9I7jMgLyMjQyF
        tXel9lVrJAnSRhXjWcpA1xv122NLLKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659000140;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KaNe8gfPDt7QKa5VYJW3wDvL8W+QWbWKq376KcUEzZY=;
        b=TBA2lHorOFAxGy+f8DPe3tvJL1GIVeEHMUj+A4a7hinopwHx8pN530VmqjBXuI10NHMQKf
        9pRc21bXEU05upAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0351513A7E;
        Thu, 28 Jul 2022 09:22:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M725OktV4mIuSwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Thu, 28 Jul 2022 09:22:19 +0000
Date:   Thu, 28 Jul 2022 11:22:16 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Chenglin Xu <chenglin.xu@mediatek.com>
Subject: [PATCH] soc: mediatek: Let PMIC Wrapper and SCPSYS depend on OF
Message-ID: <20220728112216.13b10689@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the following configuration options:
CONFIG_OF is not set
CONFIG_MTK_PMIC_WRAP=3Dy
CONFIG_MTK_SCPSYS=3Dy
we get the following build warnings:

  CC      drivers/soc/mediatek/mtk-pmic-wrap.o
drivers/soc/mediatek/mtk-pmic-wrap.c:2138:34: warning: =E2=80=98of_pwrap_ma=
tch_tbl=E2=80=99 defined but not used [-Wunused-const-variable=3D]
drivers/soc/mediatek/mtk-pmic-wrap.c:1953:34: warning: =E2=80=98of_slave_ma=
tch_tbl=E2=80=99 defined but not used [-Wunused-const-variable=3D]
  CC      drivers/soc/mediatek/mtk-scpsys.o
drivers/soc/mediatek/mtk-scpsys.c:1084:34: warning: =E2=80=98of_scpsys_matc=
h_tbl=E2=80=99 defined but not used [-Wunused-const-variable=3D]

Looking at the code, both drivers can only bind to OF-defined device
nodes, so these drivers are useless without OF and should therefore
depend on it.

Developers or QA teams who wish to test-build the code can still do
so by enabling CONFIG_OF, which is available on all architectures and
has no dependencies.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202207240252.ZY5hSCNB-lkp@intel.com/
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Chenglin Xu <chenglin.xu@mediatek.com>
---
 drivers/soc/mediatek/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- linux-5.18.orig/drivers/soc/mediatek/Kconfig	2022-05-22 21:52:31.000000=
000 +0200
+++ linux-5.18/drivers/soc/mediatek/Kconfig	2022-07-28 10:59:55.025131145 +=
0200
@@ -37,6 +37,7 @@ config MTK_INFRACFG
 config MTK_PMIC_WRAP
 	tristate "MediaTek PMIC Wrapper Support"
 	depends on RESET_CONTROLLER
+	depends on OF
 	select REGMAP
 	help
 	  Say yes here to add support for MediaTek PMIC Wrapper found
@@ -46,6 +47,7 @@ config MTK_PMIC_WRAP
 config MTK_SCPSYS
 	bool "MediaTek SCPSYS Support"
 	default ARCH_MEDIATEK
+	depends on OF
 	select REGMAP
 	select MTK_INFRACFG
 	select PM_GENERIC_DOMAINS if PM


--=20
Jean Delvare
SUSE L3 Support
