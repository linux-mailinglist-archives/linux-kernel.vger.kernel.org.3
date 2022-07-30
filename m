Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED9F585A7B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 14:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiG3Msj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 08:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiG3Msi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 08:48:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB601C10D
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 05:48:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB2205C2C6;
        Sat, 30 Jul 2022 12:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659185314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3i6QT0H5ug9EN2vXDhoq0YiBTjVOYiNk3wwwJBnOD6k=;
        b=Q71IlXQo6YbKuXUZ6pJrfonlulyHIJbXfPqUhB/22XrII3IYF/qfkICxFfQK6QoFtoa1xd
        Al++6qxt8HlkCIdHEmwwOOSFiRtYfV5jziHY2kwVb0xnVuyHLtrT5RirymcK3Sdf0b+4ei
        scND8zI0bFfEbwrwh1kFlDCt7kXPKnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659185314;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3i6QT0H5ug9EN2vXDhoq0YiBTjVOYiNk3wwwJBnOD6k=;
        b=nXQIu99qe+mH64pN2bwY1qN9dO1sLXYmnEGK+JRFVMl4ATnWnhhvvluzmtDA/yz956bhmv
        zGtwuy9MvNzgVZCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF44513A8E;
        Sat, 30 Jul 2022 12:48:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7VwwKaIo5WIkZAAAMHmgww
        (envelope-from <jdelvare@suse.de>); Sat, 30 Jul 2022 12:48:34 +0000
Date:   Sat, 30 Jul 2022 14:48:33 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Chenglin Xu <chenglin.xu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2] soc: mediatek: Let PMIC Wrapper and SCPSYS depend on OF
Message-ID: <20220730144833.0a0d9825@endymion.delvare>
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

Also drop of_match_ptr() from both drivers. We already know what it
will resolve to, so we might as well save cpp some work.

Developers or QA teams who wish to test-build the code can still do
so by enabling CONFIG_OF, which is available on all architectures and
has no dependencies.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202207240252.ZY5hSCNB-lkp@intel.com/
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Chenglin Xu <chenglin.xu@mediatek.com>
---
Changes since v1:
 * Drop of_match_ptr() (suggested by AngeloGioacchino Del Regno

 drivers/soc/mediatek/Kconfig         |    2 ++
 drivers/soc/mediatek/mtk-pmic-wrap.c |    2 +-
 drivers/soc/mediatek/mtk-scpsys.c    |    2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

--- linux-5.18.orig/drivers/soc/mediatek/Kconfig	2022-07-28 11:22:23.098393=
325 +0200
+++ linux-5.18/drivers/soc/mediatek/Kconfig	2022-07-28 11:23:58.635687065 +=
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
--- linux-5.18.orig/drivers/soc/mediatek/mtk-pmic-wrap.c	2022-07-30 11:20:2=
2.221919946 +0200
+++ linux-5.18/drivers/soc/mediatek/mtk-pmic-wrap.c	2022-07-30 11:41:14.073=
038643 +0200
@@ -2347,7 +2347,7 @@ static int pwrap_probe(struct platform_d
 static struct platform_driver pwrap_drv =3D {
 	.driver =3D {
 		.name =3D "mt-pmic-pwrap",
-		.of_match_table =3D of_match_ptr(of_pwrap_match_tbl),
+		.of_match_table =3D of_pwrap_match_tbl,
 	},
 	.probe =3D pwrap_probe,
 };
--- linux-5.18.orig/drivers/soc/mediatek/mtk-scpsys.c	2022-07-30 11:20:22.2=
21919946 +0200
+++ linux-5.18/drivers/soc/mediatek/mtk-scpsys.c	2022-07-30 11:41:22.466154=
796 +0200
@@ -1141,7 +1141,7 @@ static struct platform_driver scpsys_drv
 		.name =3D "mtk-scpsys",
 		.suppress_bind_attrs =3D true,
 		.owner =3D THIS_MODULE,
-		.of_match_table =3D of_match_ptr(of_scpsys_match_tbl),
+		.of_match_table =3D of_scpsys_match_tbl,
 	},
 };
 builtin_platform_driver(scpsys_drv);

--=20
Jean Delvare
SUSE L3 Support
