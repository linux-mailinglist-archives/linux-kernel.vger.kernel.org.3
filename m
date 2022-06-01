Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7582E53A779
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354097AbiFAOB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354160AbiFAOAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:00:00 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8761E8B0B5;
        Wed,  1 Jun 2022 06:56:16 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C02EE22175;
        Wed,  1 Jun 2022 15:55:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1654091738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qveomebm5Cm9gpRTlOxUQGp85QoLnRj3uf6m3R58Nzc=;
        b=Ef/T/TwwXV0heKml7fRseyMbGK7LE2+swTLvvn7d8LSmdzqE8e6cbdZzZxk9HZJ2JlZIBM
        Nr1uZ2TAQwTaU9/W0rZWuOpoSO5SD3Xzxzqvwe7zasvq5a7hJD2KKgv+LFN3WAWZNz5Ak4
        4GXk6tTMylkqmrh3sTisRmzrsYwL4Mo=
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH] earlycon: prevent multiple register_console()
Date:   Wed,  1 Jun 2022 15:55:28 +0200
Message-Id: <20220601135528.3176471-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the earlycon parameter is given twice, the kernel will spit out a
WARN() in register_console() because it was already registered. The
non-dt variant setup_earlycon() already handles that gracefully. The dt
variant of_setup_earlycon() doesn't. Add the check there and propagate
it through early_init_dt_scan_chosen_stdout().

FWIW, this doesn't happen if CONFIG_ACPI_SPCR_TABLE is set. In that case
the registration is delayed until after earlycon parameter(s) are
parsed.

Signed-off-by: Michael Walle <michael@walle.cc>
---

I'm not sure if this should have a Fixes tag or not. If so I guess it
should be the very first commit which introduced the support (commit
fb11ffe74c79 ("of/fdt: add FDT serial scanning for earlycon")).

For the curious, here is the backtrace:

[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/printk/printk.c:3328 register_console+0x2b4/0x364
[    0.000000] console 'atmel_serial0' already registered
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.18.0-next-20220601+ #652
[    0.000000] Hardware name: Generic DT based system
[    0.000000] Backtrace: 
[    0.000000]  dump_backtrace from show_stack+0x18/0x1c
[    0.000000]  show_stack from dump_stack_lvl+0x48/0x54
[    0.000000]  dump_stack_lvl from dump_stack+0x18/0x1c
[    0.000000]  dump_stack from __warn+0xd0/0x148
[    0.000000]  __warn from warn_slowpath_fmt+0x9c/0xc4
[    0.000000]  warn_slowpath_fmt from register_console+0x2b4/0x364
[    0.000000]  register_console from of_setup_earlycon+0x29c/0x2ac
[    0.000000]  of_setup_earlycon from early_init_dt_scan_chosen_stdout+0x154/0x18c
[    0.000000]  early_init_dt_scan_chosen_stdout from param_setup_earlycon+0x40/0x48
[    0.000000]  param_setup_earlycon from do_early_param+0x88/0xc4
[    0.000000]  do_early_param from parse_args+0x1a4/0x404
[    0.000000]  parse_args from parse_early_options+0x40/0x48
[    0.000000]  parse_early_options from parse_early_param+0x38/0x48
[    0.000000]  parse_early_param from setup_arch+0x114/0x7a4
[    0.000000]  setup_arch from start_kernel+0x74/0x6dc
[    0.000000]  start_kernel from 0x0
[    0.000000] ---[ end trace 0000000000000000 ]---

 drivers/of/fdt.c              | 6 ++++--
 drivers/tty/serial/earlycon.c | 5 ++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index a8f5b6532165..7f3524213b43 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1025,6 +1025,7 @@ int __init early_init_dt_scan_chosen_stdout(void)
 	int l;
 	const struct earlycon_id *match;
 	const void *fdt = initial_boot_params;
+	int ret;
 
 	offset = fdt_path_offset(fdt, "/chosen");
 	if (offset < 0)
@@ -1057,8 +1058,9 @@ int __init early_init_dt_scan_chosen_stdout(void)
 		if (fdt_node_check_compatible(fdt, offset, match->compatible))
 			continue;
 
-		if (of_setup_earlycon(match, offset, options) == 0)
-			return 0;
+		ret = of_setup_earlycon(match, offset, options);
+		if (!ret || ret == -EALREADY)
+			return ret;
 	}
 	return -ENODEV;
 }
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 57c70851f22a..59fedf7be572 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -230,7 +230,10 @@ static int __init param_setup_earlycon(char *buf)
 			earlycon_acpi_spcr_enable = true;
 			return 0;
 		} else if (!buf) {
-			return early_init_dt_scan_chosen_stdout();
+			err = early_init_dt_scan_chosen_stdout();
+			if (err == -EALREADY)
+				return 0;
+			return err;
 		}
 	}
 
-- 
2.30.2

