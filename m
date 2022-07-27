Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FFA582562
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiG0L0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiG0L0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:26:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A35042ACE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:26:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5454A37643;
        Wed, 27 Jul 2022 11:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658921199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1fQtbU2xCnCtNAD1uoQcCQ0vKe7X6uYstVN3t9WTs5Q=;
        b=W20gMLv5MgxHnYrjaIk4GhYWWerWWCJzbWlxbauNNrFh9+sinnpCWncbtnCB/UECrYC/FX
        FM0QMO7UWiGoSfi/Mp7qfqGU0jini/+MYyDpISz+IoG3CnBYzO6newaW9gN2ZadkHB+bi0
        +L+ReXGXAX9roAWPIvEnstD/qhED1RY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658921199;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1fQtbU2xCnCtNAD1uoQcCQ0vKe7X6uYstVN3t9WTs5Q=;
        b=laf3znNtppYHOQxA4xWxUVO1BH46vIUnZ9NZdTGuQXQ7+8ubLKrlLcAhF/0m0XVkHGHTCs
        AxaMvtH82UVWxBDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1106A13A8E;
        Wed, 27 Jul 2022 11:26:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yIyJAu8g4WLTfwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Wed, 27 Jul 2022 11:26:39 +0000
Date:   Wed, 27 Jul 2022 13:26:37 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chenglin Xu <chenglin.xu@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH RFC] regulator: mt6380: Fix unused array warning
Message-ID: <20220727132637.76d6073f@endymion.delvare>
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
CONFIG_REGULATOR_MT6380=3Dy
we get the following build warning:

  CC      drivers/regulator/mt6380-regulator.o
drivers/regulator/mt6380-regulator.c:322:34: warning: =E2=80=98mt6380_of_ma=
tch=E2=80=99 defined but not used [-Wunused-const-variable=3D]

Fix this by annotating that array with __maybe_unused, as done in
various regulator drivers.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202207240252.ZY5hSCNB-lkp@intel.com/
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Chenglin Xu <chenglin.xu@mediatek.com>
---
This assumes that the mt6380 driver can be used without OF support.
However, I can't find any in-tree piece of code instantiating the
"mt6380-regulator" platform device by name. So unless there's an
out-of-tree user, a better fix would be to remove mt6380_platform_ids
and make the driver depend on OF. Chenglin, would that be OK with
you?

 drivers/regulator/mt6380-regulator.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-5.18.orig/drivers/regulator/mt6380-regulator.c	2022-07-27 11:55:2=
1.672421481 +0200
+++ linux-5.18/drivers/regulator/mt6380-regulator.c	2022-07-27 12:01:53.151=
833378 +0200
@@ -319,7 +319,7 @@ static const struct platform_device_id m
 };
 MODULE_DEVICE_TABLE(platform, mt6380_platform_ids);
=20
-static const struct of_device_id mt6380_of_match[] =3D {
+static const struct of_device_id  __maybe_unused mt6380_of_match[] =3D {
 	{ .compatible =3D "mediatek,mt6380-regulator", },
 	{ /* sentinel */ },
 };


--=20
Jean Delvare
SUSE L3 Support
