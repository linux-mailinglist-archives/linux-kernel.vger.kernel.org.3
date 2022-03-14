Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C567C4D89CC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243177AbiCNQjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243281AbiCNQgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E148C3A733;
        Mon, 14 Mar 2022 09:35:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F699614D2;
        Mon, 14 Mar 2022 16:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55135C36AEF;
        Mon, 14 Mar 2022 16:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275711;
        bh=pXi/1CAvu03vLtMJHYxSFKkX7zHUkMFo6nPTIaAzLUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y5yCMiAQJy+yPG50Sv84iv2DnXg+wqPzmynhWQvKCDejPrd+DqXRtqkPBunBeH4X3
         ao+H7YyaF6+eI58JxQqx9DtKgN3a6RCqQfGu2x/nVNfZEVQV87h1oAMyOImdGMTkCb
         fel/zSQLvE1wHjQIK76HMSYpIyeoNyY2PwrfSPnTnZ8rVCSi8UJ5zjWrGZXBLHSC2S
         sB2ahQVk4g3pAGysVdzAbw/5Aidaj333r4twFG3RD82LcIQ6QLbNKRMPOVVXRxmsSg
         UGx70G5SSnthp3YeHQuON8nWqOjTUyOLHBLqnEmon3W5ztvas0su3AyWml87CoSKnB
         VLO4skq7Kf1tA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnf2-001x7a-1Q; Mon, 14 Mar 2022 17:35:08 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Christian Hemp <c.hemp@phytec.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jimmy Su <jimmy.su@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Martina Krasteva <martinax.krasteva@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sean Young <sean@mess.org>, Shawn Tu <shawnx.tu@intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 66/67] media: media/*/Kconfig: sort entries
Date:   Mon, 14 Mar 2022 17:35:01 +0100
Message-Id: <79bfd880f0f7debc6bda04f6f93ec0bd56e58bc7.1647274407.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647274406.git.mchehab@kernel.org>
References: <cover.1647274406.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the idems inside media Kconfig are out of order.
Sort them using the script below:

<script>
use strict;
use warnings;

my %config;
my @source;
my $out;

sub flush_config()
{
	if (scalar %config) {
		for my $c (sort keys %config) {
			$out .= $config{$c} . "\n";
		}
		%config = ();
	}

	return if (!scalar @source);

	$out .= "\n";
	for my $s (sort @source) {
		$out .= $s;
	}
	$out .= "\n";

	@source = ();
}

sub sort_kconfig($)
{
	my $fname = shift;
	my $cur_config = "";

	@source = ();
	$out = "";
	%config = ();

	open IN, $fname or die;
	while (<IN>) {
		if (m/^config\s+(.*)/) {
			$cur_config = $1;
			$config{$cur_config} .= $_;
		} elsif (m/^source\s+(.*)/) {
			push @source, $_;
		} elsif (m/^\s+/) {
			if ($cur_config eq "") {
				$out .= $_;
			} else {
				$config{$cur_config} .= $_;
			}
		} else {
			flush_config();
			$cur_config = "";
			$out .= $_;
		}
	}
	close IN or die;

	flush_config();

	$out =~ s/\n\n+/\n\n/g;
	$out =~ s/\n+$/\n/;

	open OUT, ">$fname";
	print OUT $out;
	close OUT;
}

for my $fname(@ARGV) {
	sort_kconfig $fname
}
</script>

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

 drivers/media/common/Kconfig             |  16 +-
 drivers/media/dvb-frontends/Kconfig      | 759 +++++++++++------------
 drivers/media/i2c/Kconfig                | 642 +++++++++----------
 drivers/media/mmc/Kconfig                |   1 +
 drivers/media/pci/Kconfig                |  29 +-
 drivers/media/radio/Kconfig              | 334 +++++-----
 drivers/media/rc/Kconfig                 | 382 ++++++------
 drivers/media/test-drivers/Kconfig       |   6 +-
 drivers/media/test-drivers/vidtv/Kconfig |   1 -
 drivers/media/tuners/Kconfig             | 407 ++++++------
 drivers/media/usb/Kconfig                |  33 +-
 drivers/media/usb/dvb-usb-v2/Kconfig     |  26 +-
 drivers/media/usb/dvb-usb/Kconfig        | 388 ++++++------
 drivers/media/usb/gspca/Kconfig          |  27 +-
 14 files changed, 1540 insertions(+), 1511 deletions(-)

diff --git a/drivers/media/common/Kconfig b/drivers/media/common/Kconfig
index 0f6bde0f793e..a2ae71270054 100644
--- a/drivers/media/common/Kconfig
+++ b/drivers/media/common/Kconfig
@@ -6,23 +6,23 @@ config MEDIA_COMMON_OPTIONS
 comment "common driver options"
 	depends on MEDIA_COMMON_OPTIONS
 
-config VIDEO_CX2341X
+config CYPRESS_FIRMWARE
 	tristate
-
-config VIDEO_TVEEPROM
-	tristate
-	depends on I2C
+	depends on USB
 
 config TTPCI_EEPROM
         tristate
         depends on I2C
 
-config CYPRESS_FIRMWARE
+config VIDEO_CX2341X
 	tristate
-	depends on USB
 
-source "drivers/media/common/videobuf2/Kconfig"
+config VIDEO_TVEEPROM
+	tristate
+	depends on I2C
+
 source "drivers/media/common/b2c2/Kconfig"
 source "drivers/media/common/saa7146/Kconfig"
 source "drivers/media/common/siano/Kconfig"
 source "drivers/media/common/v4l2-tpg/Kconfig"
+source "drivers/media/common/videobuf2/Kconfig"
diff --git a/drivers/media/dvb-frontends/Kconfig b/drivers/media/dvb-frontends/Kconfig
index 4101f9b1e731..2ef2ff2a38ff 100644
--- a/drivers/media/dvb-frontends/Kconfig
+++ b/drivers/media/dvb-frontends/Kconfig
@@ -11,6 +11,23 @@ menu "Customise DVB Frontends"
 comment "Multistandard (satellite) frontends"
 	depends on DVB_CORE
 
+config DVB_M88DS3103
+	tristate "Montage Technology M88DS3103"
+	depends on DVB_CORE && I2C && I2C_MUX
+	select REGMAP_I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Say Y when you want to support this frontend.
+
+config DVB_MXL5XX
+	tristate "MaxLinear MxL5xx based tuner-demodulators"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  MaxLinear MxL5xx family of DVB-S/S2 tuners/demodulators.
+
+	  Say Y when you want to support these frontends.
+
 config DVB_STB0899
 	tristate "STB0899 based"
 	depends on DVB_CORE && I2C
@@ -60,23 +77,6 @@ config DVB_STV6111
 
 	  Say Y when you want to support these frontends.
 
-config DVB_MXL5XX
-	tristate "MaxLinear MxL5xx based tuner-demodulators"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  MaxLinear MxL5xx family of DVB-S/S2 tuners/demodulators.
-
-	  Say Y when you want to support these frontends.
-
-config DVB_M88DS3103
-	tristate "Montage Technology M88DS3103"
-	depends on DVB_CORE && I2C && I2C_MUX
-	select REGMAP_I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Say Y when you want to support this frontend.
-
 comment "Multistandard (cable + terrestrial) frontends"
 	depends on DVB_CORE
 
@@ -89,25 +89,6 @@ config DVB_DRXK
 
 	  Say Y when you want to support this frontend.
 
-config DVB_TDA18271C2DD
-	tristate "NXP TDA18271C2 silicon tuner"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  NXP TDA18271 silicon tuner.
-
-	  Say Y when you want to support this tuner.
-
-config DVB_SI2165
-	tristate "Silicon Labs si2165 based"
-	depends on DVB_CORE && I2C
-	select REGMAP_I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A DVB-C/T demodulator.
-
-	  Say Y when you want to support this frontend.
-
 config DVB_MN88472
 	tristate "Panasonic MN88472"
 	depends on DVB_CORE && I2C
@@ -124,6 +105,25 @@ config DVB_MN88473
 	help
 	  Say Y when you want to support this frontend.
 
+config DVB_SI2165
+	tristate "Silicon Labs si2165 based"
+	depends on DVB_CORE && I2C
+	select REGMAP_I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A DVB-C/T demodulator.
+
+	  Say Y when you want to support this frontend.
+
+config DVB_TDA18271C2DD
+	tristate "NXP TDA18271C2 silicon tuner"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  NXP TDA18271 silicon tuner.
+
+	  Say Y when you want to support this tuner.
+
 comment "DVB-S (satellite) frontends"
 	depends on DVB_CORE
 
@@ -134,6 +134,27 @@ config DVB_CX24110
 	help
 	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
+config DVB_CX24116
+	tristate "Conexant CX24116 based"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A DVB-S/S2 tuner module. Say Y when you want to support this frontend.
+
+config DVB_CX24117
+	tristate "Conexant CX24117 based"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A Dual DVB-S/S2 tuner module. Say Y when you want to support this frontend.
+
+config DVB_CX24120
+	tristate "Conexant CX24120 based"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A DVB-S/S2 tuner module. Say Y when you want to support this frontend.
+
 config DVB_CX24123
 	tristate "Conexant CX24123 based"
 	depends on DVB_CORE && I2C
@@ -141,6 +162,21 @@ config DVB_CX24123
 	help
 	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
+config DVB_DS3000
+	tristate "Montage Tehnology DS3000 based"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A DVB-S/S2 tuner module. Say Y when you want to support this frontend.
+
+config DVB_MB86A16
+	tristate "Fujitsu MB86A16 based"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A DVB-S/DSS Direct Conversion reveiver.
+	  Say Y when you want to support this frontend.
+
 config DVB_MT312
 	tristate "Zarlink VP310/MT312/ZL10313 based"
 	depends on DVB_CORE && I2C
@@ -148,20 +184,6 @@ config DVB_MT312
 	help
 	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
-config DVB_ZL10036
-	tristate "Zarlink ZL10036 silicon tuner"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A DVB-S tuner module. Say Y when you want to support this frontend.
-
-config DVB_ZL10039
-	tristate "Zarlink ZL10039 silicon tuner"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A DVB-S tuner module. Say Y when you want to support this frontend.
-
 config DVB_S5H1420
 	tristate "Samsung S5H1420 based"
 	depends on DVB_CORE && I2C
@@ -169,8 +191,8 @@ config DVB_S5H1420
 	help
 	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
-config DVB_STV0288
-	tristate "ST STV0288 based"
+config DVB_SI21XX
+	tristate "Silicon Labs SI21XX based"
 	depends on DVB_CORE && I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
@@ -183,6 +205,13 @@ config DVB_STB6000
 	help
 	  A DVB-S silicon tuner module. Say Y when you want to support this tuner.
 
+config DVB_STV0288
+	tristate "ST STV0288 based"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A DVB-S tuner module. Say Y when you want to support this frontend.
+
 config DVB_STV0299
 	tristate "ST STV0299 based"
 	depends on DVB_CORE && I2C
@@ -190,13 +219,6 @@ config DVB_STV0299
 	help
 	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
-config DVB_STV6110
-	tristate "ST STV6110 silicon tuner"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A DVB-S silicon tuner module. Say Y when you want to support this tuner.
-
 config DVB_STV0900
 	tristate "ST STV0900 based"
 	depends on DVB_CORE && I2C
@@ -204,12 +226,20 @@ config DVB_STV0900
 	help
 	  A DVB-S/S2 demodulator. Say Y when you want to support this frontend.
 
-config DVB_TDA8083
-	tristate "Philips TDA8083 based"
+config DVB_STV6110
+	tristate "ST STV6110 silicon tuner"
 	depends on DVB_CORE && I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
-	  A DVB-S tuner module. Say Y when you want to support this frontend.
+	  A DVB-S silicon tuner module. Say Y when you want to support this tuner.
+
+config DVB_TDA10071
+	tristate "NXP TDA10071"
+	depends on DVB_CORE && I2C
+	select REGMAP_I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Say Y when you want to support this frontend.
 
 config DVB_TDA10086
 	tristate "Philips TDA10086 based"
@@ -218,6 +248,13 @@ config DVB_TDA10086
 	help
 	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
+config DVB_TDA8083
+	tristate "Philips TDA8083 based"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A DVB-S tuner module. Say Y when you want to support this frontend.
+
 config DVB_TDA8261
 	tristate "Philips TDA8261 based"
 	depends on DVB_CORE && I2C
@@ -225,28 +262,6 @@ config DVB_TDA8261
 	help
 	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
-config DVB_VES1X93
-	tristate "VLSI VES1893 or VES1993 based"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A DVB-S tuner module. Say Y when you want to support this frontend.
-
-config DVB_TUNER_ITD1000
-	tristate "Integrant ITD1000 Zero IF tuner for DVB-S/DSS"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A DVB-S tuner module. Say Y when you want to support this frontend.
-
-config DVB_TUNER_CX24113
-	tristate "Conexant CX24113/CX24128 tuner for DVB-S/DSS"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A DVB-S tuner module. Say Y when you want to support this frontend.
-
-
 config DVB_TDA826X
 	tristate "Philips TDA826X silicon tuner"
 	depends on DVB_CORE && I2C
@@ -254,41 +269,6 @@ config DVB_TDA826X
 	help
 	  A DVB-S silicon tuner module. Say Y when you want to support this tuner.
 
-config DVB_TUA6100
-	tristate "Infineon TUA6100 PLL"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A DVB-S PLL chip.
-
-config DVB_CX24116
-	tristate "Conexant CX24116 based"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A DVB-S/S2 tuner module. Say Y when you want to support this frontend.
-
-config DVB_CX24117
-	tristate "Conexant CX24117 based"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A Dual DVB-S/S2 tuner module. Say Y when you want to support this frontend.
-
-config DVB_CX24120
-	tristate "Conexant CX24120 based"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A DVB-S/S2 tuner module. Say Y when you want to support this frontend.
-
-config DVB_SI21XX
-	tristate "Silicon Labs SI21XX based"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A DVB-S tuner module. Say Y when you want to support this frontend.
-
 config DVB_TS2020
 	tristate "Montage Tehnology TS2020 based tuners"
 	depends on DVB_CORE && I2C
@@ -297,43 +277,63 @@ config DVB_TS2020
 	help
 	  A DVB-S/S2 silicon tuner. Say Y when you want to support this tuner.
 
-config DVB_DS3000
-	tristate "Montage Tehnology DS3000 based"
+config DVB_TUA6100
+	tristate "Infineon TUA6100 PLL"
 	depends on DVB_CORE && I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
-	  A DVB-S/S2 tuner module. Say Y when you want to support this frontend.
+	  A DVB-S PLL chip.
 
-config DVB_MB86A16
-	tristate "Fujitsu MB86A16 based"
+config DVB_TUNER_CX24113
+	tristate "Conexant CX24113/CX24128 tuner for DVB-S/DSS"
 	depends on DVB_CORE && I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
-	  A DVB-S/DSS Direct Conversion reveiver.
-	  Say Y when you want to support this frontend.
+	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
-config DVB_TDA10071
-	tristate "NXP TDA10071"
+config DVB_TUNER_ITD1000
+	tristate "Integrant ITD1000 Zero IF tuner for DVB-S/DSS"
 	depends on DVB_CORE && I2C
-	select REGMAP_I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
-	  Say Y when you want to support this frontend.
+	  A DVB-S tuner module. Say Y when you want to support this frontend.
+
+config DVB_VES1X93
+	tristate "VLSI VES1893 or VES1993 based"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A DVB-S tuner module. Say Y when you want to support this frontend.
+
+config DVB_ZL10036
+	tristate "Zarlink ZL10036 silicon tuner"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A DVB-S tuner module. Say Y when you want to support this frontend.
+
+config DVB_ZL10039
+	tristate "Zarlink ZL10039 silicon tuner"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
 comment "DVB-T (terrestrial) frontends"
 	depends on DVB_CORE
 
-config DVB_SP887X
-	tristate "Spase sp887x based"
-	depends on DVB_CORE && I2C
+config DVB_AF9013
+	tristate "Afatech AF9013 demodulator"
+	depends on DVB_CORE && I2C && I2C_MUX
+	select REGMAP
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
-	  A DVB-T tuner module. Say Y when you want to support this frontend.
+	  Say Y when you want to support this frontend.
 
-	  This driver needs external firmware. Please use the command
-	  "<kerneldir>/scripts/get_dvb_firmware sp887x" to
-	  download/extract it, and then copy it to /usr/lib/hotplug/firmware
-	  or /lib/firmware (depending on configuration of firmware hotplug).
+config DVB_AS102_FE
+	tristate
+	depends on DVB_CORE
+	default DVB_AS102
 
 config DVB_CX22700
 	tristate "Conexant CX22700 based"
@@ -349,64 +349,20 @@ config DVB_CX22702
 	help
 	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
-config DVB_S5H1432
-	tristate "Samsung s5h1432 demodulator (OFDM)"
+config DVB_CXD2820R
+	tristate "Sony CXD2820R"
 	depends on DVB_CORE && I2C
+	select REGMAP_I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
-	  A DVB-T tuner module. Say Y when you want to support this frontend.
+	  Say Y when you want to support this frontend.
 
-config DVB_DRXD
-	tristate "Micronas DRXD driver"
+config DVB_CXD2841ER
+	tristate "Sony CXD2841ER"
 	depends on DVB_CORE && I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
-	  A DVB-T tuner module. Say Y when you want to support this frontend.
-
-	  Note: this driver was based on vendor driver reference code (released
-	  under the GPL) as opposed to the existing drx397xd driver, which
-	  was written via reverse engineering.
-
-config DVB_L64781
-	tristate "LSI L64781"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A DVB-T tuner module. Say Y when you want to support this frontend.
-
-config DVB_TDA1004X
-	tristate "Philips TDA10045H/TDA10046H based"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A DVB-T tuner module. Say Y when you want to support this frontend.
-
-	  This driver needs external firmware. Please use the commands
-	  "<kerneldir>/scripts/get_dvb_firmware tda10045",
-	  "<kerneldir>/scripts/get_dvb_firmware tda10046" to
-	  download/extract them, and then copy them to /usr/lib/hotplug/firmware
-	  or /lib/firmware (depending on configuration of firmware hotplug).
-
-config DVB_NXT6000
-	tristate "NxtWave Communications NXT6000 based"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A DVB-T tuner module. Say Y when you want to support this frontend.
-
-config DVB_MT352
-	tristate "Zarlink MT352 based"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A DVB-T tuner module. Say Y when you want to support this frontend.
-
-config DVB_ZL10353
-	tristate "Zarlink ZL10353 based"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A DVB-T tuner module. Say Y when you want to support this frontend.
+	  Say Y when you want to support this frontend.
 
 config DVB_DIB3000MB
 	tristate "DiBcom 3000M-B"
@@ -448,20 +404,16 @@ config DVB_DIB9000
 	  A DVB-T tuner module. Designed for mobile usage. Say Y when you want
 	  to support this frontend.
 
-config DVB_TDA10048
-	tristate "Philips TDA10048HN based"
+config DVB_DRXD
+	tristate "Micronas DRXD driver"
 	depends on DVB_CORE && I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
 	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
-config DVB_AF9013
-	tristate "Afatech AF9013 demodulator"
-	depends on DVB_CORE && I2C && I2C_MUX
-	select REGMAP
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Say Y when you want to support this frontend.
+	  Note: this driver was based on vendor driver reference code (released
+	  under the GPL) as opposed to the existing drx397xd driver, which
+	  was written via reverse engineering.
 
 config DVB_EC100
 	tristate "E3C EC100"
@@ -470,27 +422,31 @@ config DVB_EC100
 	help
 	  Say Y when you want to support this frontend.
 
-config DVB_STV0367
-	tristate "ST STV0367 based"
+config DVB_GP8PSK_FE
+	tristate
+	depends on DVB_CORE
+	default DVB_USB_GP8PSK
+
+config DVB_L64781
+	tristate "LSI L64781"
 	depends on DVB_CORE && I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
-	  A DVB-T/C tuner module. Say Y when you want to support this frontend.
+	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
-config DVB_CXD2820R
-	tristate "Sony CXD2820R"
+config DVB_MT352
+	tristate "Zarlink MT352 based"
 	depends on DVB_CORE && I2C
-	select REGMAP_I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
-	  Say Y when you want to support this frontend.
+	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
-config DVB_CXD2841ER
-	tristate "Sony CXD2841ER"
+config DVB_NXT6000
+	tristate "NxtWave Communications NXT6000 based"
 	depends on DVB_CORE && I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
-	  Say Y when you want to support this frontend.
+	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
 config DVB_RTL2830
 	tristate "Realtek RTL2830 DVB-T"
@@ -517,6 +473,13 @@ config DVB_RTL2832_SDR
 	help
 	  Say Y when you want to support this SDR module.
 
+config DVB_S5H1432
+	tristate "Samsung s5h1432 demodulator (OFDM)"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A DVB-T tuner module. Say Y when you want to support this frontend.
+
 config DVB_SI2168
 	tristate "Silicon Labs Si2168"
 	depends on DVB_CORE && I2C && I2C_MUX
@@ -524,10 +487,44 @@ config DVB_SI2168
 	help
 	  Say Y when you want to support this frontend.
 
-config DVB_AS102_FE
-	tristate
-	depends on DVB_CORE
-	default DVB_AS102
+config DVB_SP887X
+	tristate "Spase sp887x based"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A DVB-T tuner module. Say Y when you want to support this frontend.
+
+	  This driver needs external firmware. Please use the command
+	  "<kerneldir>/scripts/get_dvb_firmware sp887x" to
+	  download/extract it, and then copy it to /usr/lib/hotplug/firmware
+	  or /lib/firmware (depending on configuration of firmware hotplug).
+
+config DVB_STV0367
+	tristate "ST STV0367 based"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A DVB-T/C tuner module. Say Y when you want to support this frontend.
+
+config DVB_TDA10048
+	tristate "Philips TDA10048HN based"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A DVB-T tuner module. Say Y when you want to support this frontend.
+
+config DVB_TDA1004X
+	tristate "Philips TDA10045H/TDA10046H based"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A DVB-T tuner module. Say Y when you want to support this frontend.
+
+	  This driver needs external firmware. Please use the commands
+	  "<kerneldir>/scripts/get_dvb_firmware tda10045",
+	  "<kerneldir>/scripts/get_dvb_firmware tda10046" to
+	  download/extract them, and then copy them to /usr/lib/hotplug/firmware
+	  or /lib/firmware (depending on configuration of firmware hotplug).
 
 config DVB_ZD1301_DEMOD
 	tristate "ZyDAS ZD1301"
@@ -536,18 +533,20 @@ config DVB_ZD1301_DEMOD
 	help
 	  Say Y when you want to support this frontend.
 
-config DVB_GP8PSK_FE
-	tristate
-	depends on DVB_CORE
-	default DVB_USB_GP8PSK
+config DVB_ZL10353
+	tristate "Zarlink ZL10353 based"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
 source "drivers/media/dvb-frontends/cxd2880/Kconfig"
 
 comment "DVB-C (cable) frontends"
 	depends on DVB_CORE
 
-config DVB_VES1820
-	tristate "VLSI VES1820 based"
+config DVB_STV0297
+	tristate "ST STV0297 based"
 	depends on DVB_CORE && I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
@@ -567,8 +566,8 @@ config DVB_TDA10023
 	help
 	  A DVB-C tuner module. Say Y when you want to support this frontend.
 
-config DVB_STV0297
-	tristate "ST STV0297 based"
+config DVB_VES1820
+	tristate "VLSI VES1820 based"
 	depends on DVB_CORE && I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
@@ -577,6 +576,77 @@ config DVB_STV0297
 comment "ATSC (North American/Korean Terrestrial/Cable DTV) frontends"
 	depends on DVB_CORE
 
+config DVB_AU8522
+	depends on DVB_CORE && I2C
+	tristate
+
+config DVB_AU8522_DTV
+	tristate "Auvitek AU8522 based DTV demod"
+	depends on DVB_CORE && I2C
+	select DVB_AU8522
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  An ATSC 8VSB, QAM64/256 & NTSC demodulator module. Say Y when
+	  you want to enable DTV demodulation support for this frontend.
+
+config DVB_AU8522_V4L
+	tristate "Auvitek AU8522 based ATV demod"
+	depends on VIDEO_DEV && DVB_CORE && I2C
+	select DVB_AU8522
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  An ATSC 8VSB, QAM64/256 & NTSC demodulator module. Say Y when
+	  you want to enable ATV demodulation support for this frontend.
+
+config DVB_BCM3510
+	tristate "Broadcom BCM3510"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  An ATSC 8VSB/16VSB and QAM64/256 tuner module. Say Y when you want to
+	  support this frontend.
+
+config DVB_LG2160
+	tristate "LG Electronics LG216x based"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  An ATSC/MH demodulator module. Say Y when you want
+	  to support this frontend.
+
+config DVB_LGDT3305
+	tristate "LG Electronics LGDT3304 and LGDT3305 based"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  An ATSC 8VSB and QAM64/256 tuner module. Say Y when you want
+	  to support this frontend.
+
+config DVB_LGDT3306A
+	tristate "LG Electronics LGDT3306A based"
+	depends on DVB_CORE && I2C && I2C_MUX
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  An ATSC 8VSB and QAM-B 64/256 demodulator module. Say Y when you want
+	  to support this frontend.
+
+config DVB_LGDT330X
+	tristate "LG Electronics LGDT3302/LGDT3303 based"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  An ATSC 8VSB and QAM64/256 tuner module. Say Y when you want
+	  to support this frontend.
+
+config DVB_MXL692
+	tristate "MaxLinear MXL692 based"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  MaxLinear MxL692 is a combo tuner-demodulator that
+	  supports ATSC 8VSB and QAM modes. Say Y when you want to
+	  support this frontend.
+
 config DVB_NXT200X
 	tristate "NxtWave Communications NXT2002/NXT2004 based"
 	depends on DVB_CORE && I2C
@@ -591,18 +661,6 @@ config DVB_NXT200X
 	  download/extract them, and then copy them to /usr/lib/hotplug/firmware
 	  or /lib/firmware (depending on configuration of firmware hotplug).
 
-config DVB_OR51211
-	tristate "Oren OR51211 based"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  An ATSC 8VSB tuner module. Say Y when you want to support this frontend.
-
-	  This driver needs external firmware. Please use the command
-	  "<kerneldir>/scripts/get_dvb_firmware or51211" to
-	  download it, and then copy it to /usr/lib/hotplug/firmware
-	  or /lib/firmware (depending on configuration of firmware hotplug).
-
 config DVB_OR51132
 	tristate "Oren OR51132 based"
 	depends on DVB_CORE && I2C
@@ -618,45 +676,17 @@ config DVB_OR51132
 	  /usr/lib/hotplug/firmware or /lib/firmware (depending on
 	  configuration of firmware hotplug).
 
-config DVB_BCM3510
-	tristate "Broadcom BCM3510"
+config DVB_OR51211
+	tristate "Oren OR51211 based"
 	depends on DVB_CORE && I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
-	  An ATSC 8VSB/16VSB and QAM64/256 tuner module. Say Y when you want to
-	  support this frontend.
+	  An ATSC 8VSB tuner module. Say Y when you want to support this frontend.
 
-config DVB_LGDT330X
-	tristate "LG Electronics LGDT3302/LGDT3303 based"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  An ATSC 8VSB and QAM64/256 tuner module. Say Y when you want
-	  to support this frontend.
-
-config DVB_LGDT3305
-	tristate "LG Electronics LGDT3304 and LGDT3305 based"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  An ATSC 8VSB and QAM64/256 tuner module. Say Y when you want
-	  to support this frontend.
-
-config DVB_LGDT3306A
-	tristate "LG Electronics LGDT3306A based"
-	depends on DVB_CORE && I2C && I2C_MUX
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  An ATSC 8VSB and QAM-B 64/256 demodulator module. Say Y when you want
-	  to support this frontend.
-
-config DVB_LG2160
-	tristate "LG Electronics LG216x based"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  An ATSC/MH demodulator module. Say Y when you want
-	  to support this frontend.
+	  This driver needs external firmware. Please use the command
+	  "<kerneldir>/scripts/get_dvb_firmware or51211" to
+	  download it, and then copy it to /usr/lib/hotplug/firmware
+	  or /lib/firmware (depending on configuration of firmware hotplug).
 
 config DVB_S5H1409
 	tristate "Samsung S5H1409 based"
@@ -666,28 +696,6 @@ config DVB_S5H1409
 	  An ATSC 8VSB and QAM64/256 tuner module. Say Y when you want
 	  to support this frontend.
 
-config DVB_AU8522
-	depends on DVB_CORE && I2C
-	tristate
-
-config DVB_AU8522_DTV
-	tristate "Auvitek AU8522 based DTV demod"
-	depends on DVB_CORE && I2C
-	select DVB_AU8522
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  An ATSC 8VSB, QAM64/256 & NTSC demodulator module. Say Y when
-	  you want to enable DTV demodulation support for this frontend.
-
-config DVB_AU8522_V4L
-	tristate "Auvitek AU8522 based ATV demod"
-	depends on VIDEO_DEV && DVB_CORE && I2C
-	select DVB_AU8522
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  An ATSC 8VSB, QAM64/256 & NTSC demodulator module. Say Y when
-	  you want to enable ATV demodulation support for this frontend.
-
 config DVB_S5H1411
 	tristate "Samsung S5H1411 based"
 	depends on DVB_CORE && I2C
@@ -696,26 +704,9 @@ config DVB_S5H1411
 	  An ATSC 8VSB and QAM64/256 tuner module. Say Y when you want
 	  to support this frontend.
 
-config DVB_MXL692
-	tristate "MaxLinear MXL692 based"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  MaxLinear MxL692 is a combo tuner-demodulator that
-	  supports ATSC 8VSB and QAM modes. Say Y when you want to
-	  support this frontend.
-
 comment "ISDB-T (terrestrial) frontends"
 	depends on DVB_CORE
 
-config DVB_S921
-	tristate "Sharp S921 frontend"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  AN ISDB-T DQPSK, QPSK, 16QAM and 64QAM 1seg tuner module.
-	  Say Y when you want to support this frontend.
-
 config DVB_DIB8000
 	tristate "DiBcom 8000MB/MC"
 	depends on DVB_CORE && I2C
@@ -732,17 +723,17 @@ config DVB_MB86A20S
 	  A driver for Fujitsu mb86a20s ISDB-T/ISDB-Tsb demodulator.
 	  Say Y when you want to support this frontend.
 
+config DVB_S921
+	tristate "Sharp S921 frontend"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  AN ISDB-T DQPSK, QPSK, 16QAM and 64QAM 1seg tuner module.
+	  Say Y when you want to support this frontend.
+
 comment "ISDB-S (satellite) & ISDB-T (terrestrial) frontends"
 	depends on DVB_CORE
 
-config DVB_TC90522
-	tristate "Toshiba TC90522"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Toshiba TC90522 2xISDB-S 8PSK + 2xISDB-T OFDM demodulator.
-	  Say Y when you want to support this frontend.
-
 config DVB_MN88443X
 	tristate "Socionext MN88443x"
 	depends on DVB_CORE && I2C
@@ -753,6 +744,14 @@ config DVB_MN88443X
 	  ISDB-S + ISDB-T demodulator.
 	  Say Y when you want to support this frontend.
 
+config DVB_TC90522
+	tristate "Toshiba TC90522"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Toshiba TC90522 2xISDB-S 8PSK + 2xISDB-T OFDM demodulator.
+	  Say Y when you want to support this frontend.
+
 comment "Digital terrestrial only tuners/PLL"
 	depends on DVB_CORE
 
@@ -785,42 +784,44 @@ config DVB_TUNER_DIB0090
 comment "SEC control devices for DVB-S"
 	depends on DVB_CORE
 
-source "drivers/media/dvb-frontends/drx39xyj/Kconfig"
+config DVB_A8293
+	tristate "Allegro A8293"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+
+config DVB_AF9033
+	tristate "Afatech AF9033 DVB-T demodulator"
+	depends on DVB_CORE && I2C
+	select REGMAP_I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
 
-config DVB_LNBH25
-	tristate "LNBH25 SEC controller"
+config DVB_ASCOT2E
+	tristate "Sony Ascot2E tuner"
 	depends on DVB_CORE && I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
-	  An SEC control chip.
-	  Say Y when you want to support this chip.
+	  Say Y when you want to support this frontend.
 
-config DVB_LNBH29
-	tristate "LNBH29 SEC controller"
+config DVB_ATBM8830
+	tristate "AltoBeam ATBM8830/8831 DMB-TH demodulator"
 	depends on DVB_CORE && I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
-	  LNB power supply and control voltage
-	  regulator chip with step-up converter
-	  and I2C interface for STMicroelectronics LNBH29.
-	  Say Y when you want to support this chip.
+	  A DMB-TH tuner module. Say Y when you want to support this frontend.
 
-config DVB_LNBP21
-	tristate "LNBP21/LNBH24 SEC controllers"
+config DVB_HELENE
+	tristate "Sony HELENE Sat/Ter tuner (CXD2858ER)"
 	depends on DVB_CORE && I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
-	  An SEC control chips.
+	  Say Y when you want to support this frontend.
 
-config DVB_LNBP22
-	tristate "LNBP22 SEC controllers"
+config DVB_HORUS3A
+	tristate "Sony Horus3A tuner"
 	depends on DVB_CORE && I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
-	  LNB power supply and control voltage
-	  regulator chip with step-up converter
-	  and I2C interface.
-	  Say Y when you want to support this chip.
+	  Say Y when you want to support this frontend.
 
 config DVB_ISL6405
 	tristate "ISL6405 SEC controller"
@@ -843,10 +844,12 @@ config DVB_ISL6423
 	help
 	  A SEC controller chip from Intersil
 
-config DVB_A8293
-	tristate "Allegro A8293"
+config DVB_IX2505V
+	tristate "Sharp IX2505V silicon tuner"
 	depends on DVB_CORE && I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
 config DVB_LGS8GL5
 	tristate "Silicon Legend LGS-8GL5 demodulator (OFDM)"
@@ -863,12 +866,48 @@ config DVB_LGS8GXX
 	help
 	  A DMB-TH tuner module. Say Y when you want to support this frontend.
 
-config DVB_ATBM8830
-	tristate "AltoBeam ATBM8830/8831 DMB-TH demodulator"
+config DVB_LNBH25
+	tristate "LNBH25 SEC controller"
 	depends on DVB_CORE && I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
-	  A DMB-TH tuner module. Say Y when you want to support this frontend.
+	  An SEC control chip.
+	  Say Y when you want to support this chip.
+
+config DVB_LNBH29
+	tristate "LNBH29 SEC controller"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  LNB power supply and control voltage
+	  regulator chip with step-up converter
+	  and I2C interface for STMicroelectronics LNBH29.
+	  Say Y when you want to support this chip.
+
+config DVB_LNBP21
+	tristate "LNBP21/LNBH24 SEC controllers"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  An SEC control chips.
+
+config DVB_LNBP22
+	tristate "LNBP22 SEC controllers"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  LNB power supply and control voltage
+	  regulator chip with step-up converter
+	  and I2C interface.
+	  Say Y when you want to support this chip.
+
+config DVB_M88RS2000
+	tristate "M88RS2000 DVB-S demodulator and tuner"
+	depends on DVB_CORE && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A DVB-S tuner module.
+	  Say Y when you want to support this frontend.
 
 config DVB_TDA665x
 	tristate "TDA665x tuner"
@@ -881,47 +920,7 @@ config DVB_TDA665x
 	  Currently supported tuners:
 	  * Panasonic ENV57H12D5 (ET-50DT)
 
-config DVB_IX2505V
-	tristate "Sharp IX2505V silicon tuner"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A DVB-S tuner module. Say Y when you want to support this frontend.
-
-config DVB_M88RS2000
-	tristate "M88RS2000 DVB-S demodulator and tuner"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A DVB-S tuner module.
-	  Say Y when you want to support this frontend.
-
-config DVB_AF9033
-	tristate "Afatech AF9033 DVB-T demodulator"
-	depends on DVB_CORE && I2C
-	select REGMAP_I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-
-config DVB_HORUS3A
-	tristate "Sony Horus3A tuner"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Say Y when you want to support this frontend.
-
-config DVB_ASCOT2E
-	tristate "Sony Ascot2E tuner"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Say Y when you want to support this frontend.
-
-config DVB_HELENE
-	tristate "Sony HELENE Sat/Ter tuner (CXD2858ER)"
-	depends on DVB_CORE && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Say Y when you want to support this frontend.
+source "drivers/media/dvb-frontends/drx39xyj/Kconfig"
 
 comment "Common Interface (EN50221) controller drivers"
 	depends on DVB_CORE
diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 5abc169f0a5c..14fe94f3c772 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -34,17 +34,68 @@ comment "audio, video and radio I2C drivers auto-selected by 'Autoselect ancilla
 menu "Audio decoders, processors and mixers"
 	visible if !MEDIA_HIDE_ANCILLARY_SUBDRV
 
-config VIDEO_TVAUDIO
-	tristate "Simple audio decoder chips"
+config VIDEO_CS3308
+	tristate "Cirrus Logic CS3308 audio ADC"
 	depends on VIDEO_DEV && I2C
 	help
-	  Support for several audio decoder chips found on some bt8xx boards:
-	  Philips: tda9840, tda9873h, tda9874h/a, tda9850, tda985x, tea6300,
-		   tea6320, tea6420, tda8425, ta8874z.
-	  Microchip: pic16c54 based design on ProVideo PV951 board.
+	  Support for the Cirrus Logic CS3308 High Performance 8-Channel
+	  Analog Volume Control
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called tvaudio.
+	  module will be called cs3308.
+
+config VIDEO_CS5345
+	tristate "Cirrus Logic CS5345 audio ADC"
+	depends on VIDEO_DEV && I2C
+	help
+	  Support for the Cirrus Logic CS5345 24-bit, 192 kHz
+	  stereo A/D converter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cs5345.
+
+config VIDEO_CS53L32A
+	tristate "Cirrus Logic CS53L32A audio ADC"
+	depends on VIDEO_DEV && I2C
+	help
+	  Support for the Cirrus Logic CS53L32A low voltage
+	  stereo A/D converter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cs53l32a.
+
+config VIDEO_MSP3400
+	tristate "Micronas MSP34xx audio decoders"
+	depends on VIDEO_DEV && I2C
+	help
+	  Support for the Micronas MSP34xx series of audio decoders.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called msp3400.
+
+config VIDEO_SONY_BTF_MPX
+	tristate "Sony BTF's internal MPX"
+	depends on VIDEO_DEV && I2C
+	help
+	  Support for the internal MPX of the Sony BTF-PG472Z tuner.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sony-btf-mpx.
+
+config VIDEO_TDA1997X
+	tristate "NXP TDA1997x HDMI receiver"
+	depends on VIDEO_DEV && I2C
+	depends on SND_SOC
+	select HDMI
+	select SND_PCM
+	select V4L2_FWNODE
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	  V4L2 subdevice driver for the NXP TDA1997x HDMI receivers.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called tda1997x.
 
 config VIDEO_TDA7432
 	tristate "Philips TDA7432 audio processor"
@@ -64,21 +115,6 @@ config VIDEO_TDA9840
 	  To compile this driver as a module, choose M here: the
 	  module will be called tda9840.
 
-config VIDEO_TDA1997X
-	tristate "NXP TDA1997x HDMI receiver"
-	depends on VIDEO_DEV && I2C
-	depends on SND_SOC
-	select HDMI
-	select SND_PCM
-	select V4L2_FWNODE
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	help
-	  V4L2 subdevice driver for the NXP TDA1997x HDMI receivers.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called tda1997x.
-
 config VIDEO_TEA6415C
 	tristate "Philips TEA6415C audio processor"
 	depends on I2C
@@ -97,45 +133,6 @@ config VIDEO_TEA6420
 	  To compile this driver as a module, choose M here: the
 	  module will be called tea6420.
 
-config VIDEO_MSP3400
-	tristate "Micronas MSP34xx audio decoders"
-	depends on VIDEO_DEV && I2C
-	help
-	  Support for the Micronas MSP34xx series of audio decoders.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called msp3400.
-
-config VIDEO_CS3308
-	tristate "Cirrus Logic CS3308 audio ADC"
-	depends on VIDEO_DEV && I2C
-	help
-	  Support for the Cirrus Logic CS3308 High Performance 8-Channel
-	  Analog Volume Control
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called cs3308.
-
-config VIDEO_CS5345
-	tristate "Cirrus Logic CS5345 audio ADC"
-	depends on VIDEO_DEV && I2C
-	help
-	  Support for the Cirrus Logic CS5345 24-bit, 192 kHz
-	  stereo A/D converter.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called cs5345.
-
-config VIDEO_CS53L32A
-	tristate "Cirrus Logic CS53L32A audio ADC"
-	depends on VIDEO_DEV && I2C
-	help
-	  Support for the Cirrus Logic CS53L32A low voltage
-	  stereo A/D converter.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called cs53l32a.
-
 config VIDEO_TLV320AIC23B
 	tristate "Texas Instruments TLV320AIC23B audio codec"
 	depends on VIDEO_DEV && I2C
@@ -145,6 +142,18 @@ config VIDEO_TLV320AIC23B
 	  To compile this driver as a module, choose M here: the
 	  module will be called tlv320aic23b.
 
+config VIDEO_TVAUDIO
+	tristate "Simple audio decoder chips"
+	depends on VIDEO_DEV && I2C
+	help
+	  Support for several audio decoder chips found on some bt8xx boards:
+	  Philips: tda9840, tda9873h, tda9874h/a, tda9850, tda985x, tea6300,
+		   tea6320, tea6420, tda8425, ta8874z.
+	  Microchip: pic16c54 based design on ProVideo PV951 board.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called tvaudio.
+
 config VIDEO_UDA1342
 	tristate "Philips UDA1342 audio codec"
 	depends on VIDEO_DEV && I2C
@@ -154,15 +163,14 @@ config VIDEO_UDA1342
 	  To compile this driver as a module, choose M here: the
 	  module will be called uda1342.
 
-config VIDEO_WM8775
-	tristate "Wolfson Microelectronics WM8775 audio ADC with input mixer"
+config VIDEO_VP27SMPX
+	tristate "Panasonic VP27's internal MPX"
 	depends on VIDEO_DEV && I2C
 	help
-	  Support for the Wolfson Microelectronics WM8775 high
-	  performance stereo A/D Converter with a 4 channel input mixer.
+	  Support for the internal MPX of the Panasonic VP27s tuner.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called wm8775.
+	  module will be called vp27smpx.
 
 config VIDEO_WM8739
 	tristate "Wolfson Microelectronics WM8739 stereo audio ADC"
@@ -174,23 +182,16 @@ config VIDEO_WM8739
 	  To compile this driver as a module, choose M here: the
 	  module will be called wm8739.
 
-config VIDEO_VP27SMPX
-	tristate "Panasonic VP27's internal MPX"
+config VIDEO_WM8775
+	tristate "Wolfson Microelectronics WM8775 audio ADC with input mixer"
 	depends on VIDEO_DEV && I2C
 	help
-	  Support for the internal MPX of the Panasonic VP27s tuner.
+	  Support for the Wolfson Microelectronics WM8775 high
+	  performance stereo A/D Converter with a 4 channel input mixer.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called vp27smpx.
+	  module will be called wm8775.
 
-config VIDEO_SONY_BTF_MPX
-	tristate "Sony BTF's internal MPX"
-	depends on VIDEO_DEV && I2C
-	help
-	  Support for the internal MPX of the Sony BTF-PG472Z tuner.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called sony-btf-mpx.
 endmenu
 
 menu "RDS decoders"
@@ -207,6 +208,7 @@ config VIDEO_SAA6588
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called saa6588.
+
 endmenu
 
 menu "Video decoders"
@@ -347,6 +349,20 @@ config VIDEO_KS0127
 	  To compile this driver as a module, choose M here: the
 	  module will be called ks0127.
 
+config VIDEO_MAX9286
+	tristate "Maxim MAX9286 GMSL deserializer support"
+	depends on I2C && I2C_MUX
+	depends on VIDEO_DEV
+	depends on OF_GPIO
+	select V4L2_FWNODE
+	select VIDEO_V4L2_SUBDEV_API
+	select MEDIA_CONTROLLER
+	help
+	  This driver supports the Maxim MAX9286 GMSL deserializer.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called max9286.
+
 config VIDEO_ML86V7667
 	tristate "OKI ML86V7667 video decoder"
 	depends on VIDEO_DEV && I2C
@@ -476,20 +492,6 @@ config VIDEO_VPX3220
 	  To compile this driver as a module, choose M here: the
 	  module will be called vpx3220.
 
-config VIDEO_MAX9286
-	tristate "Maxim MAX9286 GMSL deserializer support"
-	depends on I2C && I2C_MUX
-	depends on VIDEO_DEV
-	depends on OF_GPIO
-	select V4L2_FWNODE
-	select VIDEO_V4L2_SUBDEV_API
-	select MEDIA_CONTROLLER
-	help
-	  This driver supports the Maxim MAX9286 GMSL deserializer.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called max9286.
-
 comment "Video and audio decoders"
 
 config VIDEO_SAA717X
@@ -508,23 +510,19 @@ endmenu
 menu "Video encoders"
 	visible if !MEDIA_HIDE_ANCILLARY_SUBDRV
 
-config VIDEO_SAA7127
-	tristate "Philips SAA7127/9 digital video encoders"
+config VIDEO_AD9389B
+	tristate "Analog Devices AD9389B encoder"
 	depends on VIDEO_DEV && I2C
-	help
-	  Support for the Philips SAA7127/9 digital video encoders.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called saa7127.
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
 
-config VIDEO_SAA7185
-	tristate "Philips SAA7185 video encoder"
-	depends on VIDEO_DEV && I2C
 	help
-	  Support for the Philips SAA7185 video encoder.
+	  Support for the Analog Devices AD9389B video encoder.
+
+	  This is a Analog Devices HDMI transmitter.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called saa7185.
+	  module will be called ad9389b.
 
 config VIDEO_ADV7170
 	tristate "Analog Devices ADV7170 video encoder"
@@ -586,26 +584,30 @@ config VIDEO_ADV7511_CEC
 	  When selected the adv7511 will support the optional
 	  HDMI CEC feature.
 
-config VIDEO_AD9389B
-	tristate "Analog Devices AD9389B encoder"
-	depends on VIDEO_DEV && I2C
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-
-	help
-	  Support for the Analog Devices AD9389B video encoder.
-
-	  This is a Analog Devices HDMI transmitter.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad9389b.
-
 config VIDEO_AK881X
 	tristate "AK8813/AK8814 video encoders"
 	depends on I2C
 	help
 	  Video output driver for AKM AK8813 and AK8814 TV encoders
 
+config VIDEO_SAA7127
+	tristate "Philips SAA7127/9 digital video encoders"
+	depends on VIDEO_DEV && I2C
+	help
+	  Support for the Philips SAA7127/9 digital video encoders.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called saa7127.
+
+config VIDEO_SAA7185
+	tristate "Philips SAA7185 video encoder"
+	depends on VIDEO_DEV && I2C
+	help
+	  Support for the Philips SAA7185 video encoder.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called saa7185.
+
 config VIDEO_THS8200
 	tristate "Texas Instruments THS8200 video encoder"
 	depends on VIDEO_DEV && I2C
@@ -615,6 +617,7 @@ config VIDEO_THS8200
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ths8200.
+
 endmenu
 
 menu "Video improvement chips"
@@ -643,6 +646,7 @@ config VIDEO_UPD64083
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called upd64083.
+
 endmenu
 
 menu "Audio/Video compression chips"
@@ -676,31 +680,11 @@ config SDR_MAX2175
 	  To compile this driver as a module, choose M here; the
 	  module will be called max2175.
 
-
 endmenu
 
 menu "Miscellaneous helper chips"
 	visible if !MEDIA_HIDE_ANCILLARY_SUBDRV
 
-config VIDEO_THS7303
-	tristate "THS7303/53 Video Amplifier"
-	depends on VIDEO_DEV && I2C
-	select V4L2_ASYNC
-	help
-	  Support for TI THS7303/53 video amplifier
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ths7303.
-
-config VIDEO_M52790
-	tristate "Mitsubishi M52790 A/V switch"
-	depends on VIDEO_DEV && I2C
-	help
-	 Support for the Mitsubishi M52790 A/V switch.
-
-	 To compile this driver as a module, choose M here: the
-	 module will be called m52790.
-
 config VIDEO_I2C
 	tristate "I2C transport video support"
 	depends on VIDEO_DEV && I2C
@@ -715,6 +699,15 @@ config VIDEO_I2C
 	  To compile this driver as a module, choose M here: the
 	  module will be called video-i2c
 
+config VIDEO_M52790
+	tristate "Mitsubishi M52790 A/V switch"
+	depends on VIDEO_DEV && I2C
+	help
+	 Support for the Mitsubishi M52790 A/V switch.
+
+	 To compile this driver as a module, choose M here: the
+	 module will be called m52790.
+
 config VIDEO_ST_MIPID02
 	tristate "STMicroelectronics MIPID02 CSI-2 to PARALLEL bridge"
 	depends on I2C && VIDEO_DEV
@@ -728,6 +721,17 @@ config VIDEO_ST_MIPID02
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called st-mipid02.
+
+config VIDEO_THS7303
+	tristate "THS7303/53 Video Amplifier"
+	depends on VIDEO_DEV && I2C
+	select V4L2_ASYNC
+	help
+	  Support for TI THS7303/53 video amplifier
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ths7303.
+
 endmenu
 
 #
@@ -922,6 +926,103 @@ config VIDEO_IMX412
 	  To compile this driver as a module, choose M here: the
 	  module will be called imx412.
 
+config VIDEO_MAX9271_LIB
+	tristate
+
+config VIDEO_MT9M001
+	tristate "mt9m001 support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	  This driver supports MT9M001 cameras from Micron, monochrome
+	  and colour models.
+
+config VIDEO_MT9M032
+	tristate "MT9M032 camera sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select VIDEO_APTINA_PLL
+	help
+	  This driver supports MT9M032 camera sensors from Aptina, monochrome
+	  models only.
+
+config VIDEO_MT9M111
+	tristate "mt9m111, mt9m112 and mt9m131 support"
+	depends on I2C && VIDEO_DEV
+	select V4L2_FWNODE
+	help
+	  This driver supports MT9M111, MT9M112 and MT9M131 cameras from
+	  Micron/Aptina
+
+config VIDEO_MT9P031
+	tristate "Aptina MT9P031 support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select VIDEO_APTINA_PLL
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the Aptina
+	  (Micron) mt9p031 5 Mpixel camera.
+
+config VIDEO_MT9T001
+	tristate "Aptina MT9T001 support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	  This is a Video4Linux2 sensor driver for the Aptina
+	  (Micron) mt0t001 3 Mpixel camera.
+
+config VIDEO_MT9T112
+	tristate "Aptina MT9T111/MT9T112 support"
+	depends on I2C && VIDEO_DEV
+	help
+	  This is a Video4Linux2 sensor driver for the Aptina
+	  (Micron) MT9T111 and MT9T112 3 Mpixel camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mt9t112.
+
+config VIDEO_MT9V011
+	tristate "Micron mt9v011 sensor support"
+	depends on I2C && VIDEO_DEV
+	help
+	  This is a Video4Linux2 sensor driver for the Micron
+	  mt0v011 1.3 Mpixel camera.  It currently only works with the
+	  em28xx driver.
+
+config VIDEO_MT9V032
+	tristate "Micron MT9V032 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select REGMAP_I2C
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the Micron
+	  MT9V032 752x480 CMOS sensor.
+
+config VIDEO_MT9V111
+	tristate "Aptina MT9V111 sensor support"
+	depends on I2C && VIDEO_DEV
+	help
+	  This is a Video4Linux2 sensor driver for the Aptina/Micron
+	  MT9V111 sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mt9v111.
+
+config VIDEO_NOON010PC30
+	tristate "Siliconfile NOON010PC30 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	  This driver supports NOON010PC30 CIF camera from Siliconfile
+
 config VIDEO_OG01A1B
 	tristate "OmniVision OG01A1B sensor support"
 	depends on I2C && VIDEO_DEV
@@ -961,6 +1062,26 @@ config VIDEO_OV08D10
           To compile this driver as a module, choose M here: the
           module will be called ov08d10.
 
+config VIDEO_OV13858
+	tristate "OmniVision OV13858 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV13858 camera.
+
+config VIDEO_OV13B10
+	tristate "OmniVision OV13B10 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV13B10 camera.
+
 config VIDEO_OV2640
 	tristate "OmniVision OV2640 sensor support"
 	depends on VIDEO_DEV && I2C
@@ -1072,16 +1193,6 @@ config VIDEO_OV5648
 	  To compile this driver as a module, choose M here: the
 	  module will be called ov5648.
 
-config VIDEO_OV6650
-	tristate "OmniVision OV6650 sensor support"
-	depends on I2C && VIDEO_DEV
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV6650 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ov6650.
-
 config VIDEO_OV5670
 	tristate "OmniVision OV5670 sensor support"
 	depends on I2C && VIDEO_DEV
@@ -1130,6 +1241,16 @@ config VIDEO_OV5695
 	  To compile this driver as a module, choose M here: the
 	  module will be called ov5695.
 
+config VIDEO_OV6650
+	tristate "OmniVision OV6650 sensor support"
+	depends on I2C && VIDEO_DEV
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV6650 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov6650.
+
 config VIDEO_OV7251
 	tristate "OmniVision OV7251 sensor support"
 	depends on I2C && VIDEO_DEV
@@ -1143,18 +1264,6 @@ config VIDEO_OV7251
 	  To compile this driver as a module, choose M here: the
 	  module will be called ov7251.
 
-config VIDEO_OV772X
-	tristate "OmniVision OV772x sensor support"
-	depends on I2C && VIDEO_DEV
-	select REGMAP_SCCB
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV772x camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ov772x.
-
 config VIDEO_OV7640
 	tristate "OmniVision OV7640 sensor support"
 	depends on I2C && VIDEO_DEV
@@ -1174,6 +1283,18 @@ config VIDEO_OV7670
 	  OV7670 VGA camera.  It currently only works with the M88ALP01
 	  controller.
 
+config VIDEO_OV772X
+	tristate "OmniVision OV772x sensor support"
+	depends on I2C && VIDEO_DEV
+	select REGMAP_SCCB
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV772x camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov772x.
+
 config VIDEO_OV7740
 	tristate "OmniVision OV7740 sensor support"
 	depends on I2C && VIDEO_DEV
@@ -1253,141 +1374,6 @@ config VIDEO_OV9734
 	  To compile this driver as a module, choose M here: the
 	  module's name is ov9734.
 
-config VIDEO_OV13858
-	tristate "OmniVision OV13858 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV13858 camera.
-
-config VIDEO_OV13B10
-	tristate "OmniVision OV13B10 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV13B10 camera.
-
-config VIDEO_VS6624
-	tristate "ST VS6624 sensor support"
-	depends on VIDEO_DEV && I2C
-	help
-	  This is a Video4Linux2 sensor driver for the ST VS6624
-	  camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called vs6624.
-
-config VIDEO_MT9M001
-	tristate "mt9m001 support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	help
-	  This driver supports MT9M001 cameras from Micron, monochrome
-	  and colour models.
-
-config VIDEO_MT9M032
-	tristate "MT9M032 camera sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select VIDEO_APTINA_PLL
-	help
-	  This driver supports MT9M032 camera sensors from Aptina, monochrome
-	  models only.
-
-config VIDEO_MT9M111
-	tristate "mt9m111, mt9m112 and mt9m131 support"
-	depends on I2C && VIDEO_DEV
-	select V4L2_FWNODE
-	help
-	  This driver supports MT9M111, MT9M112 and MT9M131 cameras from
-	  Micron/Aptina
-
-config VIDEO_MT9P031
-	tristate "Aptina MT9P031 support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select VIDEO_APTINA_PLL
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the Aptina
-	  (Micron) mt9p031 5 Mpixel camera.
-
-config VIDEO_MT9T001
-	tristate "Aptina MT9T001 support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	help
-	  This is a Video4Linux2 sensor driver for the Aptina
-	  (Micron) mt0t001 3 Mpixel camera.
-
-config VIDEO_MT9T112
-	tristate "Aptina MT9T111/MT9T112 support"
-	depends on I2C && VIDEO_DEV
-	help
-	  This is a Video4Linux2 sensor driver for the Aptina
-	  (Micron) MT9T111 and MT9T112 3 Mpixel camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called mt9t112.
-
-config VIDEO_MT9V011
-	tristate "Micron mt9v011 sensor support"
-	depends on I2C && VIDEO_DEV
-	help
-	  This is a Video4Linux2 sensor driver for the Micron
-	  mt0v011 1.3 Mpixel camera.  It currently only works with the
-	  em28xx driver.
-
-config VIDEO_MT9V032
-	tristate "Micron MT9V032 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select REGMAP_I2C
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the Micron
-	  MT9V032 752x480 CMOS sensor.
-
-config VIDEO_MT9V111
-	tristate "Aptina MT9V111 sensor support"
-	depends on I2C && VIDEO_DEV
-	help
-	  This is a Video4Linux2 sensor driver for the Aptina/Micron
-	  MT9V111 sensor.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called mt9v111.
-
-config VIDEO_SR030PC30
-	tristate "Siliconfile SR030PC30 sensor support"
-	depends on I2C && VIDEO_DEV
-	help
-	  This driver supports SR030PC30 VGA camera from Siliconfile
-
-config VIDEO_NOON010PC30
-	tristate "Siliconfile NOON010PC30 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	help
-	  This driver supports NOON010PC30 CIF camera from Siliconfile
-
-source "drivers/media/i2c/m5mols/Kconfig"
-
-config VIDEO_MAX9271_LIB
-	tristate
-
 config VIDEO_RDACM20
 	tristate "IMI RDACM20 camera support"
 	depends on I2C
@@ -1426,23 +1412,15 @@ config VIDEO_RJ54N1
 	  To compile this driver as a module, choose M here: the
 	  module will be called rj54n1.
 
-config VIDEO_S5K6AA
-	tristate "Samsung S5K6AAFX sensor support"
-	depends on I2C && VIDEO_DEV
+config VIDEO_S5C73M3
+	tristate "Samsung S5C73M3 sensor support"
+	depends on I2C && SPI && VIDEO_DEV
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
 	help
-	  This is a V4L2 sensor driver for Samsung S5K6AA(FX) 1.3M
-	  camera sensor with an embedded SoC image signal processor.
-
-config VIDEO_S5K6A3
-	tristate "Samsung S5K6A3 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	help
-	  This is a V4L2 sensor driver for Samsung S5K6A3 raw
-	  camera sensor.
+	  This is a V4L2 sensor driver for Samsung S5C73M3
+	  8 Mpixel camera.
 
 config VIDEO_S5K4ECGX
 	tristate "Samsung S5K4ECGX sensor support"
@@ -1464,18 +1442,43 @@ config VIDEO_S5K5BAF
 	  This is a V4L2 sensor driver for Samsung S5K5BAF 2M
 	  camera sensor with an embedded SoC image signal processor.
 
+config VIDEO_S5K6A3
+	tristate "Samsung S5K6A3 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	  This is a V4L2 sensor driver for Samsung S5K6A3 raw
+	  camera sensor.
+
+config VIDEO_S5K6AA
+	tristate "Samsung S5K6AAFX sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	  This is a V4L2 sensor driver for Samsung S5K6AA(FX) 1.3M
+	  camera sensor with an embedded SoC image signal processor.
+
+config VIDEO_SR030PC30
+	tristate "Siliconfile SR030PC30 sensor support"
+	depends on I2C && VIDEO_DEV
+	help
+	  This driver supports SR030PC30 VGA camera from Siliconfile
+
+config VIDEO_VS6624
+	tristate "ST VS6624 sensor support"
+	depends on VIDEO_DEV && I2C
+	help
+	  This is a Video4Linux2 sensor driver for the ST VS6624
+	  camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called vs6624.
+
 source "drivers/media/i2c/ccs/Kconfig"
 source "drivers/media/i2c/et8ek8/Kconfig"
-
-config VIDEO_S5C73M3
-	tristate "Samsung S5C73M3 sensor support"
-	depends on I2C && SPI && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a V4L2 sensor driver for Samsung S5C73M3
-	  8 Mpixel camera.
+source "drivers/media/i2c/m5mols/Kconfig"
 
 endmenu
 
@@ -1572,6 +1575,7 @@ config VIDEO_LM3646
 	help
 	  This is a driver for the lm3646 dual flash controllers. It controls
 	  flash, torch LEDs.
+
 endmenu
 
 endif # VIDEO_DEV
diff --git a/drivers/media/mmc/Kconfig b/drivers/media/mmc/Kconfig
index 75aa6de08d53..2f9877bc61e4 100644
--- a/drivers/media/mmc/Kconfig
+++ b/drivers/media/mmc/Kconfig
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
 source "drivers/media/mmc/siano/Kconfig"
diff --git a/drivers/media/pci/Kconfig b/drivers/media/pci/Kconfig
index 92b156530d91..1224d908713a 100644
--- a/drivers/media/pci/Kconfig
+++ b/drivers/media/pci/Kconfig
@@ -12,50 +12,55 @@ if MEDIA_PCI_SUPPORT
 
 if MEDIA_CAMERA_SUPPORT
 	comment "Media capture support"
+
 source "drivers/media/pci/meye/Kconfig"
 source "drivers/media/pci/solo6x10/Kconfig"
 source "drivers/media/pci/sta2x11/Kconfig"
 source "drivers/media/pci/tw5864/Kconfig"
 source "drivers/media/pci/tw68/Kconfig"
 source "drivers/media/pci/tw686x/Kconfig"
+
 endif
 
 if MEDIA_ANALOG_TV_SUPPORT
 	comment "Media capture/analog TV support"
+
+source "drivers/media/pci/dt3155/Kconfig"
 source "drivers/media/pci/ivtv/Kconfig"
 source "drivers/media/pci/saa7146/Kconfig"
-source "drivers/media/pci/dt3155/Kconfig"
+
 endif
 
 if MEDIA_ANALOG_TV_SUPPORT || MEDIA_DIGITAL_TV_SUPPORT
 	comment "Media capture/analog/hybrid TV support"
+
+source "drivers/media/pci/bt8xx/Kconfig"
+source "drivers/media/pci/cobalt/Kconfig"
 source "drivers/media/pci/cx18/Kconfig"
 source "drivers/media/pci/cx23885/Kconfig"
 source "drivers/media/pci/cx25821/Kconfig"
 source "drivers/media/pci/cx88/Kconfig"
-source "drivers/media/pci/bt8xx/Kconfig"
 source "drivers/media/pci/saa7134/Kconfig"
 source "drivers/media/pci/saa7164/Kconfig"
-source "drivers/media/pci/cobalt/Kconfig"
 
 endif
 
 if MEDIA_DIGITAL_TV_SUPPORT
 	comment "Media digital TV PCI Adapters"
-source "drivers/media/pci/ttpci/Kconfig"
+
 source "drivers/media/pci/b2c2/Kconfig"
-source "drivers/media/pci/pluto2/Kconfig"
+source "drivers/media/pci/ddbridge/Kconfig"
 source "drivers/media/pci/dm1105/Kconfig"
-source "drivers/media/pci/pt1/Kconfig"
-source "drivers/media/pci/pt3/Kconfig"
 source "drivers/media/pci/mantis/Kconfig"
+source "drivers/media/pci/netup_unidvb/Kconfig"
 source "drivers/media/pci/ngene/Kconfig"
-source "drivers/media/pci/ddbridge/Kconfig"
+source "drivers/media/pci/pluto2/Kconfig"
+source "drivers/media/pci/pt1/Kconfig"
+source "drivers/media/pci/pt3/Kconfig"
 source "drivers/media/pci/smipcie/Kconfig"
-source "drivers/media/pci/netup_unidvb/Kconfig"
-endif
+source "drivers/media/pci/ttpci/Kconfig"
 
-source "drivers/media/pci/intel/ipu3/Kconfig"
+endif
 
 config VIDEO_PCI_SKELETON
 	tristate "Skeleton PCI V4L2 driver"
@@ -68,5 +73,7 @@ config VIDEO_PCI_SKELETON
 	  Enable build of the skeleton PCI driver, used as a reference
 	  when developing new drivers.
 
+source "drivers/media/pci/intel/ipu3/Kconfig"
+
 endif #MEDIA_PCI_SUPPORT
 endif #PCI
diff --git a/drivers/media/radio/Kconfig b/drivers/media/radio/Kconfig
index 58c10a2ed292..cca03bd2cc42 100644
--- a/drivers/media/radio/Kconfig
+++ b/drivers/media/radio/Kconfig
@@ -13,57 +13,6 @@ menuconfig RADIO_ADAPTERS
 
 if RADIO_ADAPTERS
 
-config RADIO_TEA575X
-	tristate
-
-source "drivers/media/radio/si470x/Kconfig"
-
-config RADIO_SI4713
-	tristate "Silicon Labs Si4713 FM Radio with RDS Transmitter support"
-
-source "drivers/media/radio/si4713/Kconfig"
-
-config RADIO_SI476X
-	tristate "Silicon Laboratories Si476x I2C FM Radio"
-	depends on I2C
-	depends on MFD_SI476X_CORE
-	depends on SND_SOC
-	select SND_SOC_SI476X
-	help
-	  Choose Y here if you have this FM radio chip.
-
-	  In order to control your radio card, you will need to use programs
-	  that are compatible with the Video For Linux 2 API.  Information on
-	  this API and pointers to "v4l2" programs may be found at
-	  <file:Documentation/userspace-api/media/index.rst>.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called radio-si476x.
-
-config USB_MR800
-	tristate "AverMedia MR 800 USB FM radio support"
-	depends on USB
-	help
-	  Say Y here if you want to connect this type of radio to your
-	  computer's USB port. Note that the audio is not digital, and
-	  you must connect the line out connector to a sound card or a
-	  set of speakers.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called radio-mr800.
-
-config USB_DSBR
-	tristate "D-Link/GemTek USB FM radio support"
-	depends on USB
-	help
-	  Say Y here if you want to connect this type of radio to your
-	  computer's USB port. Note that the audio is not digital, and
-	  you must connect the line out connector to a sound card or a
-	  set of speakers.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called dsbr100.
-
 config RADIO_MAXIRADIO
 	tristate "Guillemot MAXI Radio FM 2000 radio"
 	depends on PCI
@@ -80,6 +29,18 @@ config RADIO_MAXIRADIO
 	  To compile this driver as a module, choose M here: the
 	  module will be called radio-maxiradio.
 
+config RADIO_SAA7706H
+	tristate "SAA7706H Car Radio DSP"
+	depends on I2C
+	help
+	  Say Y here if you want to use the SAA7706H Car radio Digital
+	  Signal Processor, found for instance on the Russellville development
+	  board. On the russellville the device is connected to internal
+	  timberdale I2C bus.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called SAA7706H.
+
 config RADIO_SHARK
 	tristate "Griffin radioSHARK USB radio receiver"
 	depends on USB
@@ -115,41 +76,28 @@ config RADIO_SHARK2
 	  To compile this driver as a module, choose M here: the
 	  module will be called radio-shark2.
 
-config USB_KEENE
-	tristate "Keene FM Transmitter USB support"
-	depends on USB
-	help
-	  Say Y here if you want to connect this type of FM transmitter
-	  to your computer's USB port.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called radio-keene.
+config RADIO_SI4713
+	tristate "Silicon Labs Si4713 FM Radio with RDS Transmitter support"
 
-config USB_RAREMONO
-	tristate "Thanko's Raremono AM/FM/SW radio support"
-	depends on USB
+config RADIO_SI476X
+	tristate "Silicon Laboratories Si476x I2C FM Radio"
+	depends on I2C
+	depends on MFD_SI476X_CORE
+	depends on SND_SOC
+	select SND_SOC_SI476X
 	help
-	  The 'Thanko's Raremono' device contains the Si4734 chip from Silicon Labs Inc.
-	  It is one of the very few or perhaps the only consumer USB radio device
-	  to receive the AM/FM/SW bands.
+	  Choose Y here if you have this FM radio chip.
 
-	  Say Y here if you want to connect this type of AM/FM/SW receiver
-	  to your computer's USB port.
+	  In order to control your radio card, you will need to use programs
+	  that are compatible with the Video For Linux 2 API.  Information on
+	  this API and pointers to "v4l2" programs may be found at
+	  <file:Documentation/userspace-api/media/index.rst>.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called radio-raremono.
+	  module will be called radio-si476x.
 
-config USB_MA901
-	tristate "Masterkit MA901 USB FM radio support"
-	depends on USB
-	help
-	  Say Y here if you want to connect this type of radio to your
-	  computer's USB port. Note that the audio is not digital, and
-	  you must connect the line out connector to a sound card or a
-	  set of speakers or headphones.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called radio-ma901.
+config RADIO_TEA575X
+	tristate
 
 config RADIO_TEA5764
 	tristate "TEA5764 I2C FM radio support"
@@ -170,18 +118,6 @@ config RADIO_TEA5764_XTAL
 	  Say Y here if TEA5764 have a 32768 Hz crystal in circuit, say N
 	  here if TEA5764 reference frequency is connected in FREQIN.
 
-config RADIO_SAA7706H
-	tristate "SAA7706H Car Radio DSP"
-	depends on I2C
-	help
-	  Say Y here if you want to use the SAA7706H Car radio Digital
-	  Signal Processor, found for instance on the Russellville development
-	  board. On the russellville the device is connected to internal
-	  timberdale I2C bus.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called SAA7706H.
-
 config RADIO_TEF6862
 	tristate "TEF6862 Car Radio Enhanced Selectivity Tuner"
 	depends on I2C
@@ -222,7 +158,71 @@ config RADIO_WL1273
 	  To compile this driver as a module, choose M here: the
 	  module will be called radio-wl1273.
 
+config USB_DSBR
+	tristate "D-Link/GemTek USB FM radio support"
+	depends on USB
+	help
+	  Say Y here if you want to connect this type of radio to your
+	  computer's USB port. Note that the audio is not digital, and
+	  you must connect the line out connector to a sound card or a
+	  set of speakers.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called dsbr100.
+
+config USB_KEENE
+	tristate "Keene FM Transmitter USB support"
+	depends on USB
+	help
+	  Say Y here if you want to connect this type of FM transmitter
+	  to your computer's USB port.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called radio-keene.
+
+config USB_MA901
+	tristate "Masterkit MA901 USB FM radio support"
+	depends on USB
+	help
+	  Say Y here if you want to connect this type of radio to your
+	  computer's USB port. Note that the audio is not digital, and
+	  you must connect the line out connector to a sound card or a
+	  set of speakers or headphones.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called radio-ma901.
+
+config USB_MR800
+	tristate "AverMedia MR 800 USB FM radio support"
+	depends on USB
+	help
+	  Say Y here if you want to connect this type of radio to your
+	  computer's USB port. Note that the audio is not digital, and
+	  you must connect the line out connector to a sound card or a
+	  set of speakers.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called radio-mr800.
+
+config USB_RAREMONO
+	tristate "Thanko's Raremono AM/FM/SW radio support"
+	depends on USB
+	help
+	  The 'Thanko's Raremono' device contains the Si4734 chip from Silicon Labs Inc.
+	  It is one of the very few or perhaps the only consumer USB radio device
+	  to receive the AM/FM/SW bands.
+
+	  Say Y here if you want to connect this type of AM/FM/SW receiver
+	  to your computer's USB port.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called radio-raremono.
+
+source "drivers/media/radio/si470x/Kconfig"
+source "drivers/media/radio/si4713/Kconfig"
+
 # TI's ST based wl128x FM radio
+
 source "drivers/media/radio/wl128x/Kconfig"
 
 #
@@ -237,74 +237,6 @@ menuconfig V4L_RADIO_ISA_DRIVERS
 
 if V4L_RADIO_ISA_DRIVERS
 
-config RADIO_ISA
-	depends on ISA || COMPILE_TEST
-	tristate
-
-config RADIO_CADET
-	tristate "ADS Cadet AM/FM Tuner"
-	depends on ISA || COMPILE_TEST
-	help
-	  Choose Y here if you have one of these AM/FM radio cards, and then
-	  fill in the port address below.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called radio-cadet.
-
-config RADIO_RTRACK
-	tristate "AIMSlab RadioTrack (aka RadioReveal) support"
-	depends on ISA || COMPILE_TEST
-	select RADIO_ISA
-	help
-	  Choose Y here if you have one of these FM radio cards, and then fill
-	  in the port address below.
-
-	  Note that newer AIMSlab RadioTrack cards have a different chipset
-	  and are not supported by this driver.  For these cards, use the
-	  RadioTrack II driver below.
-
-	  If you have a GemTeks combined (PnP) sound- and radio card you must
-	  use this driver as a module and setup the card with isapnptools.
-	  You must also pass the module a suitable io parameter, 0x248 has
-	  been reported to be used by these cards.
-
-	  More information is contained in the file
-	  <file:Documentation/driver-api/media/drivers/radiotrack.rst>.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called radio-aimslab.
-
-config RADIO_RTRACK_PORT
-	hex "RadioTrack i/o port (0x20f or 0x30f)"
-	depends on RADIO_RTRACK=y
-	default "30f"
-	help
-	  Enter either 0x30f or 0x20f here.  The card default is 0x30f, if you
-	  haven't changed the jumper setting on the card.
-
-config RADIO_RTRACK2
-	tristate "AIMSlab RadioTrack II support"
-	depends on ISA || COMPILE_TEST
-	select RADIO_ISA
-	help
-	  Choose Y here if you have this FM radio card, and then fill in the
-	  port address below.
-
-	  Note: this driver hasn't been tested since a long time due to lack
-	  of hardware. If you have this hardware, then please contact the
-	  linux-media mailinglist.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called radio-rtrack2.
-
-config RADIO_RTRACK2_PORT
-	hex "RadioTrack II i/o port (0x20c or 0x30c)"
-	depends on RADIO_RTRACK2=y
-	default "30c"
-	help
-	  Enter either 0x30c or 0x20c here.  The card default is 0x30c, if you
-	  haven't changed the jumper setting on the card.
-
 config RADIO_AZTECH
 	tristate "Aztech/Packard Bell Radio"
 	depends on ISA || COMPILE_TEST
@@ -325,6 +257,16 @@ config RADIO_AZTECH_PORT
 	  haven't changed the setting of jumper JP3 on the card.  Removing the
 	  jumper sets the card to 0x358.
 
+config RADIO_CADET
+	tristate "ADS Cadet AM/FM Tuner"
+	depends on ISA || COMPILE_TEST
+	help
+	  Choose Y here if you have one of these AM/FM radio cards, and then
+	  fill in the port address below.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called radio-cadet.
+
 config RADIO_GEMTEK
 	tristate "GemTek Radio card (or compatible) support"
 	depends on ISA || COMPILE_TEST
@@ -365,6 +307,10 @@ config RADIO_GEMTEK_PROBE
 	  following ports will be probed: 0x20c, 0x30c, 0x24c, 0x34c, 0x248 and
 	  0x28c.
 
+config RADIO_ISA
+	depends on ISA || COMPILE_TEST
+	tristate
+
 config RADIO_MIROPCM20
 	tristate "miroSOUND PCM20 radio"
 	depends on ISA || COMPILE_TEST
@@ -380,6 +326,60 @@ config RADIO_MIROPCM20
 	  To compile this driver as a module, choose M here: the
 	  module will be called radio-miropcm20.
 
+config RADIO_RTRACK
+	tristate "AIMSlab RadioTrack (aka RadioReveal) support"
+	depends on ISA || COMPILE_TEST
+	select RADIO_ISA
+	help
+	  Choose Y here if you have one of these FM radio cards, and then fill
+	  in the port address below.
+
+	  Note that newer AIMSlab RadioTrack cards have a different chipset
+	  and are not supported by this driver.  For these cards, use the
+	  RadioTrack II driver below.
+
+	  If you have a GemTeks combined (PnP) sound- and radio card you must
+	  use this driver as a module and setup the card with isapnptools.
+	  You must also pass the module a suitable io parameter, 0x248 has
+	  been reported to be used by these cards.
+
+	  More information is contained in the file
+	  <file:Documentation/driver-api/media/drivers/radiotrack.rst>.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called radio-aimslab.
+
+config RADIO_RTRACK2
+	tristate "AIMSlab RadioTrack II support"
+	depends on ISA || COMPILE_TEST
+	select RADIO_ISA
+	help
+	  Choose Y here if you have this FM radio card, and then fill in the
+	  port address below.
+
+	  Note: this driver hasn't been tested since a long time due to lack
+	  of hardware. If you have this hardware, then please contact the
+	  linux-media mailinglist.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called radio-rtrack2.
+
+config RADIO_RTRACK2_PORT
+	hex "RadioTrack II i/o port (0x20c or 0x30c)"
+	depends on RADIO_RTRACK2=y
+	default "30c"
+	help
+	  Enter either 0x30c or 0x20c here.  The card default is 0x30c, if you
+	  haven't changed the jumper setting on the card.
+
+config RADIO_RTRACK_PORT
+	hex "RadioTrack i/o port (0x20f or 0x30f)"
+	depends on RADIO_RTRACK=y
+	default "30f"
+	help
+	  Enter either 0x30f or 0x20f here.  The card default is 0x30f, if you
+	  haven't changed the jumper setting on the card.
+
 config RADIO_SF16FMI
 	tristate "SF16-FMI/SF16-FMP/SF16-FMD Radio"
 	depends on ISA || COMPILE_TEST
@@ -451,13 +451,6 @@ config RADIO_TYPHOON
 	  To compile this driver as a module, choose M here: the
 	  module will be called radio-typhoon.
 
-config RADIO_TYPHOON_PORT
-	hex "Typhoon I/O port (0x316 or 0x336)"
-	depends on RADIO_TYPHOON=y
-	default "316"
-	help
-	  Enter the I/O port of your Typhoon or EcoRadio radio card.
-
 config RADIO_TYPHOON_MUTEFREQ
 	int "Typhoon frequency set when muting the device (kHz)"
 	depends on RADIO_TYPHOON=y
@@ -470,6 +463,13 @@ config RADIO_TYPHOON_MUTEFREQ
 	  the device is muted. There should be no local radio station at that
 	  frequency.
 
+config RADIO_TYPHOON_PORT
+	hex "Typhoon I/O port (0x316 or 0x336)"
+	depends on RADIO_TYPHOON=y
+	default "316"
+	help
+	  Enter the I/O port of your Typhoon or EcoRadio radio card.
+
 config RADIO_ZOLTRIX
 	tristate "Zoltrix Radio"
 	depends on ISA || COMPILE_TEST
diff --git a/drivers/media/rc/Kconfig b/drivers/media/rc/Kconfig
index c111af820ae4..f560fc38895f 100644
--- a/drivers/media/rc/Kconfig
+++ b/drivers/media/rc/Kconfig
@@ -15,15 +15,6 @@ menuconfig RC_CORE
 	  Say Y when you have a TV or an IR device.
 
 if RC_CORE
-source "drivers/media/rc/keymaps/Kconfig"
-
-config LIRC
-	bool "LIRC user interface"
-	help
-	   Enable this option to enable the Linux Infrared Remote
-	   Control user interface (e.g. /dev/lirc*). This interface
-	   passes raw IR to and from userspace, which is needed for
-	   IR transmitting (aka "blasting") and for the lirc daemon.
 
 config BPF_LIRC_MODE2
 	bool "Support for eBPF programs attached to lirc devices"
@@ -38,10 +29,45 @@ config BPF_LIRC_MODE2
 	   These eBPF programs can be used to decode IR into scancodes, for
 	   IR protocols not supported by the kernel decoders.
 
+config LIRC
+	bool "LIRC user interface"
+	help
+	   Enable this option to enable the Linux Infrared Remote
+	   Control user interface (e.g. /dev/lirc*). This interface
+	   passes raw IR to and from userspace, which is needed for
+	   IR transmitting (aka "blasting") and for the lirc daemon.
+
+source "drivers/media/rc/keymaps/Kconfig"
+
 menuconfig RC_DECODERS
 	bool "Remote controller decoders"
 
 if RC_DECODERS
+
+config IR_IMON_DECODER
+	tristate "Enable IR raw decoder for the iMON protocol"
+	help
+	   Enable this option if you have iMON PAD or Antec Veris infrared
+	   remote control and you would like to use it with a raw IR
+	   receiver, or if you wish to use an encoder to transmit this IR.
+
+config IR_JVC_DECODER
+	tristate "Enable IR raw decoder for the JVC protocol"
+	select BITREVERSE
+
+	help
+	   Enable this option if you have an infrared remote control which
+	   uses the JVC protocol, and you need software decoding support.
+
+config IR_MCE_KBD_DECODER
+	tristate "Enable IR raw decoder for the MCE keyboard/mouse protocol"
+	select BITREVERSE
+
+	help
+	   Enable this option if you have a Microsoft Remote Keyboard for
+	   Windows Media Center Edition, which you would like to use with
+	   a raw IR receiver in your system.
+
 config IR_NEC_DECODER
 	tristate "Enable IR raw decoder for the NEC protocol"
 	select BITREVERSE
@@ -66,21 +92,17 @@ config IR_RC6_DECODER
 	   Enable this option if you have an infrared remote control which
 	   uses the RC6 protocol, and you need software decoding support.
 
-config IR_JVC_DECODER
-	tristate "Enable IR raw decoder for the JVC protocol"
-	select BITREVERSE
-
+config IR_RCMM_DECODER
+	tristate "Enable IR raw decoder for the RC-MM protocol"
 	help
-	   Enable this option if you have an infrared remote control which
-	   uses the JVC protocol, and you need software decoding support.
-
-config IR_SONY_DECODER
-	tristate "Enable IR raw decoder for the Sony protocol"
-	select BITREVERSE
+	   Enable this option when you have IR with RC-MM protocol, and
+	   you need the software decoder. The driver supports 12,
+	   24 and 32 bits RC-MM variants. You can enable or disable the
+	   different modes using the following RC protocol keywords:
+	   'rc-mm-12', 'rc-mm-24' and 'rc-mm-32'.
 
-	help
-	   Enable this option if you have an infrared remote control which
-	   uses the Sony protocol, and you need software decoding support.
+	   To compile this driver as a module, choose M here: the module
+	   will be called ir-rcmm-decoder.
 
 config IR_SANYO_DECODER
 	tristate "Enable IR raw decoder for the Sanyo protocol"
@@ -100,14 +122,13 @@ config IR_SHARP_DECODER
 	   uses the Sharp protocol (Sharp, Denon), and you need software
 	   decoding support.
 
-config IR_MCE_KBD_DECODER
-	tristate "Enable IR raw decoder for the MCE keyboard/mouse protocol"
+config IR_SONY_DECODER
+	tristate "Enable IR raw decoder for the Sony protocol"
 	select BITREVERSE
 
 	help
-	   Enable this option if you have a Microsoft Remote Keyboard for
-	   Windows Media Center Edition, which you would like to use with
-	   a raw IR receiver in your system.
+	   Enable this option if you have an infrared remote control which
+	   uses the Sony protocol, and you need software decoding support.
 
 config IR_XMP_DECODER
 	tristate "Enable IR raw decoder for the XMP protocol"
@@ -117,25 +138,6 @@ config IR_XMP_DECODER
 	   Enable this option if you have IR with XMP protocol, and
 	   if the IR is decoded in software
 
-config IR_IMON_DECODER
-	tristate "Enable IR raw decoder for the iMON protocol"
-	help
-	   Enable this option if you have iMON PAD or Antec Veris infrared
-	   remote control and you would like to use it with a raw IR
-	   receiver, or if you wish to use an encoder to transmit this IR.
-
-config IR_RCMM_DECODER
-	tristate "Enable IR raw decoder for the RC-MM protocol"
-	help
-	   Enable this option when you have IR with RC-MM protocol, and
-	   you need the software decoder. The driver supports 12,
-	   24 and 32 bits RC-MM variants. You can enable or disable the
-	   different modes using the following RC protocol keywords:
-	   'rc-mm-12', 'rc-mm-24' and 'rc-mm-32'.
-
-	   To compile this driver as a module, choose M here: the module
-	   will be called ir-rcmm-decoder.
-
 endif #RC_DECODERS
 
 menuconfig RC_DEVICES
@@ -143,23 +145,6 @@ menuconfig RC_DEVICES
 
 if RC_DEVICES
 
-config RC_ATI_REMOTE
-	tristate "ATI / X10 based USB RF remote controls"
-	depends on USB
-	help
-	   Say Y here if you want to use an X10 based USB remote control.
-	   These are RF remotes with USB receivers.
-
-	   Such devices include the ATI remote that comes with many of ATI's
-	   All-In-Wonder video cards, the X10 "Lola" remote, NVIDIA RF remote,
-	   Medion RF remote, and SnapStream FireFly remote.
-
-	   This driver provides mouse pointer, left and right mouse buttons,
-	   and maps all the other remote buttons to keypress events.
-
-	   To compile this driver as a module, choose M here: the module will be
-	   called ati_remote.
-
 config IR_ENE
 	tristate "ENE eHome Receiver/Transceiver (pnp id: ENE0100/ENE02xxx)"
 	depends on PNP || COMPILE_TEST
@@ -173,6 +158,37 @@ config IR_ENE
 	   To compile this driver as a module, choose M here: the
 	   module will be called ene_ir.
 
+config IR_FINTEK
+	tristate "Fintek Consumer Infrared Transceiver"
+	depends on PNP || COMPILE_TEST
+	help
+	   Say Y here to enable support for integrated infrared receiver
+	   /transceiver made by Fintek. This chip is found on assorted
+	   Jetway motherboards (and of course, possibly others).
+
+	   To compile this driver as a module, choose M here: the
+	   module will be called fintek-cir.
+
+config IR_GPIO_CIR
+	tristate "GPIO IR remote control"
+	depends on (OF && GPIOLIB) || COMPILE_TEST
+	help
+	   Say Y if you want to use GPIO based IR Receiver.
+
+	   To compile this driver as a module, choose M here: the module will
+	   be called gpio-ir-recv.
+
+config IR_GPIO_TX
+	tristate "GPIO IR Bit Banging Transmitter"
+	depends on LIRC
+	depends on (OF && GPIOLIB) || COMPILE_TEST
+	help
+	   Say Y if you want to a GPIO based IR transmitter. This is a
+	   bit banging driver.
+
+	   To compile this driver as a module, choose M here: the module will
+	   be called gpio-ir-tx.
+
 config IR_HIX5HD2
 	tristate "Hisilicon hix5hd2 IR remote control"
 	depends on (OF && HAS_IOMEM) || COMPILE_TEST
@@ -183,6 +199,33 @@ config IR_HIX5HD2
 
 	   If you're not sure, select N here
 
+config IR_IGORPLUGUSB
+	tristate "IgorPlug-USB IR Receiver"
+	depends on USB
+	help
+	   Say Y here if you want to use the IgorPlug-USB IR Receiver by
+	   Igor Cesko. This device is included on the Fit-PC2.
+
+	   Note that this device can only record bursts of 36 IR pulses and
+	   spaces, which is not enough for the NEC, Sanyo and RC-6 protocol.
+
+	   To compile this driver as a module, choose M here: the module will
+	   be called igorplugusb.
+
+config IR_IGUANA
+	tristate "IguanaWorks USB IR Transceiver"
+	depends on USB
+	help
+	   Say Y here if you want to use the IguanaWorks USB IR Transceiver.
+	   Both infrared receive and send are supported. If you want to
+	   change the ID or the pin config, use the user space driver from
+	   IguanaWorks.
+
+	   Only firmware 0x0205 and later is supported.
+
+	   To compile this driver as a module, choose M here: the module will
+	   be called iguanair.
+
 config IR_IMON
 	tristate "SoundGraph iMON Receiver and Display"
 	depends on USB
@@ -203,16 +246,6 @@ config IR_IMON_RAW
 	   To compile this driver as a module, choose M here: the
 	   module will be called imon_raw.
 
-config IR_MCEUSB
-	tristate "Windows Media Center Ed. eHome Infrared Transceiver"
-	depends on USB
-	help
-	   Say Y here if you want to use a Windows Media Center Edition
-	   eHome Infrared Transceiver.
-
-	   To compile this driver as a module, choose M here: the
-	   module will be called mceusb.
-
 config IR_ITE_CIR
 	tristate "ITE Tech Inc. IT8712/IT8512 Consumer Infrared Transceiver"
 	depends on PNP || COMPILE_TEST
@@ -225,16 +258,15 @@ config IR_ITE_CIR
 	   To compile this driver as a module, choose M here: the
 	   module will be called ite-cir.
 
-config IR_FINTEK
-	tristate "Fintek Consumer Infrared Transceiver"
-	depends on PNP || COMPILE_TEST
+config IR_MCEUSB
+	tristate "Windows Media Center Ed. eHome Infrared Transceiver"
+	depends on USB
 	help
-	   Say Y here to enable support for integrated infrared receiver
-	   /transceiver made by Fintek. This chip is found on assorted
-	   Jetway motherboards (and of course, possibly others).
+	   Say Y here if you want to use a Windows Media Center Edition
+	   eHome Infrared Transceiver.
 
 	   To compile this driver as a module, choose M here: the
-	   module will be called fintek-cir.
+	   module will be called mceusb.
 
 config IR_MESON
 	tristate "Amlogic Meson IR remote receiver"
@@ -278,6 +310,18 @@ config IR_NUVOTON
 	   To compile this driver as a module, choose M here: the
 	   module will be called nuvoton-cir.
 
+config IR_PWM_TX
+	tristate "PWM IR transmitter"
+	depends on LIRC
+	depends on PWM
+	depends on OF || COMPILE_TEST
+	help
+	   Say Y if you want to use a PWM based IR transmitter. This is
+	   more power efficient than the bit banging gpio driver.
+
+	   To compile this driver as a module, choose M here: the module will
+	   be called pwm-ir-tx.
+
 config IR_REDRAT3
 	tristate "RedRat3 IR Transceiver"
 	depends on USB
@@ -289,6 +333,31 @@ config IR_REDRAT3
 	   To compile this driver as a module, choose M here: the
 	   module will be called redrat3.
 
+config IR_RX51
+	tristate "Nokia N900 IR transmitter diode"
+	depends on (OMAP_DM_TIMER && PWM_OMAP_DMTIMER && ARCH_OMAP2PLUS || COMPILE_TEST) && RC_CORE
+	help
+	   Say Y or M here if you want to enable support for the IR
+	   transmitter diode built in the Nokia N900 (RX51) device.
+
+	   The driver uses omap DM timers for generating the carrier
+	   wave and pulses.
+
+config IR_SERIAL
+	tristate "Homebrew Serial Port Receiver"
+	help
+	   Say Y if you want to use Homebrew Serial Port Receivers and
+	   Transceivers.
+
+	   To compile this driver as a module, choose M here: the module will
+	   be called serial-ir.
+
+config IR_SERIAL_TRANSMITTER
+	bool "Serial Port Transmitter"
+	depends on IR_SERIAL
+	help
+	   Serial Port Transmitter support
+
 config IR_SPI
 	tristate "SPI connected IR LED"
 	depends on SPI && LIRC
@@ -309,6 +378,37 @@ config IR_STREAMZAP
 	   To compile this driver as a module, choose M here: the
 	   module will be called streamzap.
 
+config IR_SUNXI
+	tristate "SUNXI IR remote control"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	help
+	   Say Y if you want to use sunXi internal IR Controller
+
+	   To compile this driver as a module, choose M here: the module will
+	   be called sunxi-ir.
+
+config IR_TOY
+	tristate "Infrared Toy and IR Droid"
+	depends on USB
+	help
+	   Say Y here if you want to use the Infrared Toy or IR Droid, USB
+	   versions.
+
+	   To compile this driver as a module, choose M here: the module will be
+	   called ir_toy.
+
+config IR_TTUSBIR
+	tristate "TechnoTrend USB IR Receiver"
+	depends on USB
+	select NEW_LEDS
+	select LEDS_CLASS
+	help
+	   Say Y here if you want to use the TechnoTrend USB IR Receiver. The
+	   driver can control the led.
+
+	   To compile this driver as a module, choose M here: the module will
+	   be called ttusbir.
+
 config IR_WINBOND_CIR
 	tristate "Winbond IR remote control"
 	depends on (X86 && PNP) || COMPILE_TEST
@@ -324,56 +424,22 @@ config IR_WINBOND_CIR
 	   To compile this driver as a module, choose M here: the module will
 	   be called winbond_cir.
 
-config IR_IGORPLUGUSB
-	tristate "IgorPlug-USB IR Receiver"
+config RC_ATI_REMOTE
+	tristate "ATI / X10 based USB RF remote controls"
 	depends on USB
 	help
-	   Say Y here if you want to use the IgorPlug-USB IR Receiver by
-	   Igor Cesko. This device is included on the Fit-PC2.
+	   Say Y here if you want to use an X10 based USB remote control.
+	   These are RF remotes with USB receivers.
 
-	   Note that this device can only record bursts of 36 IR pulses and
-	   spaces, which is not enough for the NEC, Sanyo and RC-6 protocol.
+	   Such devices include the ATI remote that comes with many of ATI's
+	   All-In-Wonder video cards, the X10 "Lola" remote, NVIDIA RF remote,
+	   Medion RF remote, and SnapStream FireFly remote.
 
-	   To compile this driver as a module, choose M here: the module will
-	   be called igorplugusb.
+	   This driver provides mouse pointer, left and right mouse buttons,
+	   and maps all the other remote buttons to keypress events.
 
-config IR_IGUANA
-	tristate "IguanaWorks USB IR Transceiver"
-	depends on USB
-	help
-	   Say Y here if you want to use the IguanaWorks USB IR Transceiver.
-	   Both infrared receive and send are supported. If you want to
-	   change the ID or the pin config, use the user space driver from
-	   IguanaWorks.
-
-	   Only firmware 0x0205 and later is supported.
-
-	   To compile this driver as a module, choose M here: the module will
-	   be called iguanair.
-
-config IR_TTUSBIR
-	tristate "TechnoTrend USB IR Receiver"
-	depends on USB
-	select NEW_LEDS
-	select LEDS_CLASS
-	help
-	   Say Y here if you want to use the TechnoTrend USB IR Receiver. The
-	   driver can control the led.
-
-	   To compile this driver as a module, choose M here: the module will
-	   be called ttusbir.
-
-config IR_RX51
-	tristate "Nokia N900 IR transmitter diode"
-	depends on (OMAP_DM_TIMER && PWM_OMAP_DMTIMER && ARCH_OMAP2PLUS || COMPILE_TEST) && RC_CORE
-	help
-	   Say Y or M here if you want to enable support for the IR
-	   transmitter diode built in the Nokia N900 (RX51) device.
-
-	   The driver uses omap DM timers for generating the carrier
-	   wave and pulses.
-
-source "drivers/media/rc/img-ir/Kconfig"
+	   To compile this driver as a module, choose M here: the module will be
+	   called ati_remote.
 
 config RC_LOOPBACK
 	tristate "Remote Control Loopback Driver"
@@ -387,38 +453,6 @@ config RC_LOOPBACK
 	   To compile this driver as a module, choose M here: the module will
 	   be called rc_loopback.
 
-config IR_GPIO_CIR
-	tristate "GPIO IR remote control"
-	depends on (OF && GPIOLIB) || COMPILE_TEST
-	help
-	   Say Y if you want to use GPIO based IR Receiver.
-
-	   To compile this driver as a module, choose M here: the module will
-	   be called gpio-ir-recv.
-
-config IR_GPIO_TX
-	tristate "GPIO IR Bit Banging Transmitter"
-	depends on LIRC
-	depends on (OF && GPIOLIB) || COMPILE_TEST
-	help
-	   Say Y if you want to a GPIO based IR transmitter. This is a
-	   bit banging driver.
-
-	   To compile this driver as a module, choose M here: the module will
-	   be called gpio-ir-tx.
-
-config IR_PWM_TX
-	tristate "PWM IR transmitter"
-	depends on LIRC
-	depends on PWM
-	depends on OF || COMPILE_TEST
-	help
-	   Say Y if you want to use a PWM based IR transmitter. This is
-	   more power efficient than the bit banging gpio driver.
-
-	   To compile this driver as a module, choose M here: the module will
-	   be called pwm-ir-tx.
-
 config RC_ST
 	tristate "ST remote control receiver"
 	depends on ARCH_STI || COMPILE_TEST
@@ -429,30 +463,6 @@ config RC_ST
 
 	   If you're not sure, select N here.
 
-config IR_SUNXI
-	tristate "SUNXI IR remote control"
-	depends on ARCH_SUNXI || COMPILE_TEST
-	help
-	   Say Y if you want to use sunXi internal IR Controller
-
-	   To compile this driver as a module, choose M here: the module will
-	   be called sunxi-ir.
-
-config IR_SERIAL
-	tristate "Homebrew Serial Port Receiver"
-	help
-	   Say Y if you want to use Homebrew Serial Port Receivers and
-	   Transceivers.
-
-	   To compile this driver as a module, choose M here: the module will
-	   be called serial-ir.
-
-config IR_SERIAL_TRANSMITTER
-	bool "Serial Port Transmitter"
-	depends on IR_SERIAL
-	help
-	   Serial Port Transmitter support
-
 config RC_XBOX_DVD
 	tristate "Xbox DVD Movie Playback Kit"
 	depends on USB
@@ -463,15 +473,7 @@ config RC_XBOX_DVD
 	   To compile this driver as a module, choose M here: the module will be
 	   called xbox_remote.
 
-config IR_TOY
-	tristate "Infrared Toy and IR Droid"
-	depends on USB
-	help
-	   Say Y here if you want to use the Infrared Toy or IR Droid, USB
-	   versions.
-
-	   To compile this driver as a module, choose M here: the module will be
-	   called ir_toy.
+source "drivers/media/rc/img-ir/Kconfig"
 
 endif #RC_DEVICES
 
diff --git a/drivers/media/test-drivers/Kconfig b/drivers/media/test-drivers/Kconfig
index d663d822ec75..51cf27834df0 100644
--- a/drivers/media/test-drivers/Kconfig
+++ b/drivers/media/test-drivers/Kconfig
@@ -6,10 +6,6 @@ menuconfig V4L_TEST_DRIVERS
 
 if V4L_TEST_DRIVERS
 
-source "drivers/media/test-drivers/vimc/Kconfig"
-
-source "drivers/media/test-drivers/vivid/Kconfig"
-
 config VIDEO_VIM2M
 	tristate "Virtual Memory-to-Memory Driver"
 	depends on VIDEO_DEV
@@ -22,6 +18,8 @@ config VIDEO_VIM2M
 	  framework.
 
 source "drivers/media/test-drivers/vicodec/Kconfig"
+source "drivers/media/test-drivers/vimc/Kconfig"
+source "drivers/media/test-drivers/vivid/Kconfig"
 
 endif #V4L_TEST_DRIVERS
 
diff --git a/drivers/media/test-drivers/vidtv/Kconfig b/drivers/media/test-drivers/vidtv/Kconfig
index 22c4fd39461f..e511e51c0b5b 100644
--- a/drivers/media/test-drivers/vidtv/Kconfig
+++ b/drivers/media/test-drivers/vidtv/Kconfig
@@ -7,5 +7,4 @@ config DVB_VIDTV
 	  validate the existing APIs in the media subsystem. It can also aid developers
 	  working on userspace applications.
 
-
 	  When in doubt, say N.
diff --git a/drivers/media/tuners/Kconfig b/drivers/media/tuners/Kconfig
index 81d1d56b9317..0c01b0298099 100644
--- a/drivers/media/tuners/Kconfig
+++ b/drivers/media/tuners/Kconfig
@@ -23,6 +23,172 @@ menu "Customize TV tuners"
 	visible if !MEDIA_HIDE_ANCILLARY_SUBDRV
 	depends on MEDIA_ANALOG_TV_SUPPORT || MEDIA_DIGITAL_TV_SUPPORT || MEDIA_RADIO_SUPPORT || MEDIA_SDR_SUPPORT
 
+config MEDIA_TUNER_E4000
+	tristate "Elonics E4000 silicon tuner"
+	depends on MEDIA_SUPPORT && I2C && VIDEO_DEV
+	select REGMAP_I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Elonics E4000 silicon tuner driver.
+
+config MEDIA_TUNER_FC0011
+	tristate "Fitipower FC0011 silicon tuner"
+	depends on MEDIA_SUPPORT && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Fitipower FC0011 silicon tuner driver.
+
+config MEDIA_TUNER_FC0012
+	tristate "Fitipower FC0012 silicon tuner"
+	depends on MEDIA_SUPPORT && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Fitipower FC0012 silicon tuner driver.
+
+config MEDIA_TUNER_FC0013
+	tristate "Fitipower FC0013 silicon tuner"
+	depends on MEDIA_SUPPORT && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Fitipower FC0013 silicon tuner driver.
+
+config MEDIA_TUNER_FC2580
+	tristate "FCI FC2580 silicon tuner"
+	depends on MEDIA_SUPPORT && I2C && VIDEO_DEV
+	select REGMAP_I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  FCI FC2580 silicon tuner driver.
+
+config MEDIA_TUNER_IT913X
+	tristate "ITE Tech IT913x silicon tuner"
+	depends on MEDIA_SUPPORT && I2C
+	select REGMAP_I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  ITE Tech IT913x silicon tuner driver.
+
+config MEDIA_TUNER_M88RS6000T
+	tristate "Montage M88RS6000 internal tuner"
+	depends on MEDIA_SUPPORT && I2C
+	select REGMAP_I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Montage M88RS6000 internal tuner.
+
+config MEDIA_TUNER_MAX2165
+	tristate "Maxim MAX2165 silicon tuner"
+	depends on MEDIA_SUPPORT && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A driver for the silicon tuner MAX2165 from Maxim.
+
+config MEDIA_TUNER_MC44S803
+	tristate "Freescale MC44S803 Low Power CMOS Broadband tuners"
+	depends on MEDIA_SUPPORT && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Say Y here to support the Freescale MC44S803 based tuners
+
+config MEDIA_TUNER_MSI001
+	tristate "Mirics MSi001"
+	depends on MEDIA_SUPPORT && SPI && VIDEO_DEV
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Mirics MSi001 silicon tuner driver.
+
+config MEDIA_TUNER_MT2060
+	tristate "Microtune MT2060 silicon IF tuner"
+	depends on MEDIA_SUPPORT && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A driver for the silicon IF tuner MT2060 from Microtune.
+
+config MEDIA_TUNER_MT2063
+	tristate "Microtune MT2063 silicon IF tuner"
+	depends on MEDIA_SUPPORT && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A driver for the silicon IF tuner MT2063 from Microtune.
+
+config MEDIA_TUNER_MT20XX
+	tristate "Microtune 2032 / 2050 tuners"
+	depends on MEDIA_SUPPORT && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Say Y here to include support for the MT2032 / MT2050 tuner.
+
+config MEDIA_TUNER_MT2131
+	tristate "Microtune MT2131 silicon tuner"
+	depends on MEDIA_SUPPORT && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A driver for the silicon baseband tuner MT2131 from Microtune.
+
+config MEDIA_TUNER_MT2266
+	tristate "Microtune MT2266 silicon tuner"
+	depends on MEDIA_SUPPORT && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A driver for the silicon baseband tuner MT2266 from Microtune.
+
+config MEDIA_TUNER_MXL301RF
+	tristate "MaxLinear MxL301RF tuner"
+	depends on MEDIA_SUPPORT && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  MaxLinear MxL301RF OFDM tuner driver.
+
+config MEDIA_TUNER_MXL5005S
+	tristate "MaxLinear MSL5005S silicon tuner"
+	depends on MEDIA_SUPPORT && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A driver for the silicon tuner MXL5005S from MaxLinear.
+
+config MEDIA_TUNER_MXL5007T
+	tristate "MaxLinear MxL5007T silicon tuner"
+	depends on MEDIA_SUPPORT && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A driver for the silicon tuner MxL5007T from MaxLinear.
+
+config MEDIA_TUNER_QM1D1B0004
+	tristate "Sharp QM1D1B0004 tuner"
+	depends on MEDIA_SUPPORT && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Sharp QM1D1B0004 ISDB-S tuner driver.
+
+config MEDIA_TUNER_QM1D1C0042
+	tristate "Sharp QM1D1C0042 tuner"
+	depends on MEDIA_SUPPORT && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Sharp QM1D1C0042 trellis coded 8PSK tuner driver.
+
+config MEDIA_TUNER_QT1010
+	tristate "Quantek QT1010 silicon tuner"
+	depends on MEDIA_SUPPORT && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A driver for the silicon tuner QT1010 from Quantek.
+
+config MEDIA_TUNER_R820T
+	tristate "Rafael Micro R820T silicon tuner"
+	depends on MEDIA_SUPPORT && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	select BITREVERSE
+	help
+	  Rafael Micro R820T silicon tuner driver.
+
+config MEDIA_TUNER_SI2157
+	tristate "Silicon Labs Si2157 silicon tuner"
+	depends on MEDIA_SUPPORT && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Silicon Labs Si2157 silicon tuner driver.
+
 config MEDIA_TUNER_SIMPLE
 	tristate "Simple tuner support"
 	depends on MEDIA_SUPPORT && I2C
@@ -31,6 +197,21 @@ config MEDIA_TUNER_SIMPLE
 	help
 	  Say Y here to include support for various simple tuners.
 
+config MEDIA_TUNER_TDA18212
+	tristate "NXP TDA18212 silicon tuner"
+	depends on MEDIA_SUPPORT && I2C
+	select REGMAP_I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  NXP TDA18212 silicon tuner driver.
+
+config MEDIA_TUNER_TDA18218
+	tristate "NXP TDA18218 silicon tuner"
+	depends on MEDIA_SUPPORT && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  NXP TDA18218 silicon tuner driver.
+
 config MEDIA_TUNER_TDA18250
 	tristate "NXP TDA18250 silicon tuner"
 	depends on MEDIA_SUPPORT && I2C
@@ -38,6 +219,20 @@ config MEDIA_TUNER_TDA18250
 	help
 	  Say Y here to include support for TDA18250 tuner.
 
+config MEDIA_TUNER_TDA18271
+	tristate "NXP TDA18271 silicon tuner"
+	depends on MEDIA_SUPPORT && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A silicon tuner module. Say Y when you want to support this tuner.
+
+config MEDIA_TUNER_TDA827X
+	tristate "Philips TDA827X silicon tuner"
+	depends on MEDIA_SUPPORT && I2C
+	default m if !MEDIA_SUBDRV_AUTOSELECT
+	help
+	  A DVB-T silicon tuner module. Say Y when you want to support this tuner.
+
 config MEDIA_TUNER_TDA8290
 	tristate "TDA 8290/8295 + 8275(a)/18271 tuner combo"
 	depends on MEDIA_SUPPORT && I2C
@@ -47,20 +242,6 @@ config MEDIA_TUNER_TDA8290
 	help
 	  Say Y here to include support for Philips TDA8290+8275(a) tuner.
 
-config MEDIA_TUNER_TDA827X
-	tristate "Philips TDA827X silicon tuner"
-	depends on MEDIA_SUPPORT && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A DVB-T silicon tuner module. Say Y when you want to support this tuner.
-
-config MEDIA_TUNER_TDA18271
-	tristate "NXP TDA18271 silicon tuner"
-	depends on MEDIA_SUPPORT && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A silicon tuner module. Say Y when you want to support this tuner.
-
 config MEDIA_TUNER_TDA9887
 	tristate "TDA 9885/6/7 analog IF demodulator"
 	depends on MEDIA_SUPPORT && I2C
@@ -83,54 +264,13 @@ config MEDIA_TUNER_TEA5767
 	help
 	  Say Y here to include support for the Philips TEA5767 radio tuner.
 
-config MEDIA_TUNER_MSI001
-	tristate "Mirics MSi001"
-	depends on MEDIA_SUPPORT && SPI && VIDEO_DEV
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Mirics MSi001 silicon tuner driver.
-
-config MEDIA_TUNER_MT20XX
-	tristate "Microtune 2032 / 2050 tuners"
-	depends on MEDIA_SUPPORT && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Say Y here to include support for the MT2032 / MT2050 tuner.
-
-config MEDIA_TUNER_MT2060
-	tristate "Microtune MT2060 silicon IF tuner"
-	depends on MEDIA_SUPPORT && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A driver for the silicon IF tuner MT2060 from Microtune.
-
-config MEDIA_TUNER_MT2063
-	tristate "Microtune MT2063 silicon IF tuner"
-	depends on MEDIA_SUPPORT && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A driver for the silicon IF tuner MT2063 from Microtune.
-
-config MEDIA_TUNER_MT2266
-	tristate "Microtune MT2266 silicon tuner"
-	depends on MEDIA_SUPPORT && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A driver for the silicon baseband tuner MT2266 from Microtune.
-
-config MEDIA_TUNER_MT2131
-	tristate "Microtune MT2131 silicon tuner"
-	depends on MEDIA_SUPPORT && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A driver for the silicon baseband tuner MT2131 from Microtune.
-
-config MEDIA_TUNER_QT1010
-	tristate "Quantek QT1010 silicon tuner"
+config MEDIA_TUNER_TUA9001
+	tristate "Infineon TUA9001 silicon tuner"
 	depends on MEDIA_SUPPORT && I2C
+	select REGMAP_I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
-	  A driver for the silicon tuner QT1010 from Quantek.
+	  Infineon TUA 9001 silicon tuner driver.
 
 config MEDIA_TUNER_XC2028
 	tristate "XCeive xc2028/xc3028 tuners"
@@ -139,15 +279,6 @@ config MEDIA_TUNER_XC2028
 	help
 	  Say Y here to include support for the xc2028/xc3028 tuners.
 
-config MEDIA_TUNER_XC5000
-	tristate "Xceive XC5000 silicon tuner"
-	depends on MEDIA_SUPPORT && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A driver for the silicon tuner XC5000 from Xceive.
-	  This device is only used inside a SiP called together with a
-	  demodulator for now.
-
 config MEDIA_TUNER_XC4000
 	tristate "Xceive XC4000 silicon tuner"
 	depends on MEDIA_SUPPORT && I2C
@@ -157,143 +288,13 @@ config MEDIA_TUNER_XC4000
 	  This device is only used inside a SiP called together with a
 	  demodulator for now.
 
-config MEDIA_TUNER_MXL5005S
-	tristate "MaxLinear MSL5005S silicon tuner"
+config MEDIA_TUNER_XC5000
+	tristate "Xceive XC5000 silicon tuner"
 	depends on MEDIA_SUPPORT && I2C
 	default m if !MEDIA_SUBDRV_AUTOSELECT
 	help
-	  A driver for the silicon tuner MXL5005S from MaxLinear.
+	  A driver for the silicon tuner XC5000 from Xceive.
+	  This device is only used inside a SiP called together with a
+	  demodulator for now.
 
-config MEDIA_TUNER_MXL5007T
-	tristate "MaxLinear MxL5007T silicon tuner"
-	depends on MEDIA_SUPPORT && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A driver for the silicon tuner MxL5007T from MaxLinear.
-
-config MEDIA_TUNER_MC44S803
-	tristate "Freescale MC44S803 Low Power CMOS Broadband tuners"
-	depends on MEDIA_SUPPORT && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Say Y here to support the Freescale MC44S803 based tuners
-
-config MEDIA_TUNER_MAX2165
-	tristate "Maxim MAX2165 silicon tuner"
-	depends on MEDIA_SUPPORT && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  A driver for the silicon tuner MAX2165 from Maxim.
-
-config MEDIA_TUNER_TDA18218
-	tristate "NXP TDA18218 silicon tuner"
-	depends on MEDIA_SUPPORT && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  NXP TDA18218 silicon tuner driver.
-
-config MEDIA_TUNER_FC0011
-	tristate "Fitipower FC0011 silicon tuner"
-	depends on MEDIA_SUPPORT && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Fitipower FC0011 silicon tuner driver.
-
-config MEDIA_TUNER_FC0012
-	tristate "Fitipower FC0012 silicon tuner"
-	depends on MEDIA_SUPPORT && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Fitipower FC0012 silicon tuner driver.
-
-config MEDIA_TUNER_FC0013
-	tristate "Fitipower FC0013 silicon tuner"
-	depends on MEDIA_SUPPORT && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Fitipower FC0013 silicon tuner driver.
-
-config MEDIA_TUNER_TDA18212
-	tristate "NXP TDA18212 silicon tuner"
-	depends on MEDIA_SUPPORT && I2C
-	select REGMAP_I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  NXP TDA18212 silicon tuner driver.
-
-config MEDIA_TUNER_E4000
-	tristate "Elonics E4000 silicon tuner"
-	depends on MEDIA_SUPPORT && I2C && VIDEO_DEV
-	select REGMAP_I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Elonics E4000 silicon tuner driver.
-
-config MEDIA_TUNER_FC2580
-	tristate "FCI FC2580 silicon tuner"
-	depends on MEDIA_SUPPORT && I2C && VIDEO_DEV
-	select REGMAP_I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  FCI FC2580 silicon tuner driver.
-
-config MEDIA_TUNER_M88RS6000T
-	tristate "Montage M88RS6000 internal tuner"
-	depends on MEDIA_SUPPORT && I2C
-	select REGMAP_I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Montage M88RS6000 internal tuner.
-
-config MEDIA_TUNER_TUA9001
-	tristate "Infineon TUA9001 silicon tuner"
-	depends on MEDIA_SUPPORT && I2C
-	select REGMAP_I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Infineon TUA 9001 silicon tuner driver.
-
-config MEDIA_TUNER_SI2157
-	tristate "Silicon Labs Si2157 silicon tuner"
-	depends on MEDIA_SUPPORT && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Silicon Labs Si2157 silicon tuner driver.
-
-config MEDIA_TUNER_IT913X
-	tristate "ITE Tech IT913x silicon tuner"
-	depends on MEDIA_SUPPORT && I2C
-	select REGMAP_I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  ITE Tech IT913x silicon tuner driver.
-
-config MEDIA_TUNER_R820T
-	tristate "Rafael Micro R820T silicon tuner"
-	depends on MEDIA_SUPPORT && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	select BITREVERSE
-	help
-	  Rafael Micro R820T silicon tuner driver.
-
-config MEDIA_TUNER_MXL301RF
-	tristate "MaxLinear MxL301RF tuner"
-	depends on MEDIA_SUPPORT && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  MaxLinear MxL301RF OFDM tuner driver.
-
-config MEDIA_TUNER_QM1D1C0042
-	tristate "Sharp QM1D1C0042 tuner"
-	depends on MEDIA_SUPPORT && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Sharp QM1D1C0042 trellis coded 8PSK tuner driver.
-
-config MEDIA_TUNER_QM1D1B0004
-	tristate "Sharp QM1D1B0004 tuner"
-	depends on MEDIA_SUPPORT && I2C
-	default m if !MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Sharp QM1D1B0004 ISDB-S tuner driver.
 endmenu
diff --git a/drivers/media/usb/Kconfig b/drivers/media/usb/Kconfig
index f97153df3c84..8de08704f8e4 100644
--- a/drivers/media/usb/Kconfig
+++ b/drivers/media/usb/Kconfig
@@ -12,53 +12,64 @@ if MEDIA_USB_SUPPORT
 
 if MEDIA_CAMERA_SUPPORT
 	comment "Webcam devices"
-source "drivers/media/usb/uvc/Kconfig"
+
+source "drivers/media/usb/cpia2/Kconfig"
 source "drivers/media/usb/gspca/Kconfig"
 source "drivers/media/usb/pwc/Kconfig"
-source "drivers/media/usb/cpia2/Kconfig"
-source "drivers/media/usb/zr364xx/Kconfig"
-source "drivers/media/usb/stkwebcam/Kconfig"
 source "drivers/media/usb/s2255/Kconfig"
+source "drivers/media/usb/stkwebcam/Kconfig"
 source "drivers/media/usb/usbtv/Kconfig"
+source "drivers/media/usb/uvc/Kconfig"
+source "drivers/media/usb/zr364xx/Kconfig"
+
 endif
 
 if MEDIA_ANALOG_TV_SUPPORT
 	comment "Analog TV USB devices"
-source "drivers/media/usb/pvrusb2/Kconfig"
+
+source "drivers/media/usb/go7007/Kconfig"
 source "drivers/media/usb/hdpvr/Kconfig"
+source "drivers/media/usb/pvrusb2/Kconfig"
 source "drivers/media/usb/stk1160/Kconfig"
-source "drivers/media/usb/go7007/Kconfig"
+
 endif
 
 if (MEDIA_ANALOG_TV_SUPPORT || MEDIA_DIGITAL_TV_SUPPORT)
 	comment "Analog/digital TV USB devices"
+
 source "drivers/media/usb/au0828/Kconfig"
 source "drivers/media/usb/cx231xx/Kconfig"
 source "drivers/media/usb/tm6000/Kconfig"
-endif
 
+endif
 
 if I2C && MEDIA_DIGITAL_TV_SUPPORT
 	comment "Digital TV USB devices"
-source "drivers/media/usb/dvb-usb/Kconfig"
+
+source "drivers/media/usb/as102/Kconfig"
+source "drivers/media/usb/b2c2/Kconfig"
 source "drivers/media/usb/dvb-usb-v2/Kconfig"
+source "drivers/media/usb/dvb-usb/Kconfig"
+source "drivers/media/usb/siano/Kconfig"
 source "drivers/media/usb/ttusb-budget/Kconfig"
 source "drivers/media/usb/ttusb-dec/Kconfig"
-source "drivers/media/usb/siano/Kconfig"
-source "drivers/media/usb/b2c2/Kconfig"
-source "drivers/media/usb/as102/Kconfig"
+
 endif
 
 if (MEDIA_CAMERA_SUPPORT || MEDIA_ANALOG_TV_SUPPORT || MEDIA_DIGITAL_TV_SUPPORT)
 	comment "Webcam, TV (analog/digital) USB devices"
+
 source "drivers/media/usb/em28xx/Kconfig"
+
 endif
 
 if MEDIA_SDR_SUPPORT
 	comment "Software defined radio USB devices"
+
 source "drivers/media/usb/airspy/Kconfig"
 source "drivers/media/usb/hackrf/Kconfig"
 source "drivers/media/usb/msi2500/Kconfig"
+
 endif
 
 endif #MEDIA_USB_SUPPORT
diff --git a/drivers/media/usb/dvb-usb-v2/Kconfig b/drivers/media/usb/dvb-usb-v2/Kconfig
index a4600a97d1fd..4eadc9539b4c 100644
--- a/drivers/media/usb/dvb-usb-v2/Kconfig
+++ b/drivers/media/usb/dvb-usb-v2/Kconfig
@@ -14,6 +14,8 @@ config DVB_USB_V2
 
 	  Say Y if you own a USB DVB device.
 
+if DVB_USB_V2
+
 config DVB_USB_AF9015
 	tristate "Afatech AF9015 DVB-T USB2.0 support"
 	depends on DVB_USB_V2 && I2C_MUX
@@ -87,6 +89,17 @@ config DVB_USB_CE6230
 	help
 	  Say Y here to support the Intel CE6230 DVB-T USB2.0 receiver
 
+config DVB_USB_DVBSKY
+	tristate "DVBSky USB support"
+	depends on DVB_USB_V2
+	select DVB_M88DS3103 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_SI2168 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_TS2020 if MEDIA_SUBDRV_AUTOSELECT
+	select MEDIA_TUNER_SI2157 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_SP2 if MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Say Y here to support the USB receivers from DVBSky.
+
 config DVB_USB_EC168
 	tristate "E3C EC168 DVB-T USB2.0 support"
 	depends on DVB_USB_V2
@@ -154,17 +167,6 @@ config DVB_USB_RTL28XXU
 	help
 	  Say Y here to support the Realtek RTL28xxU DVB USB receiver.
 
-config DVB_USB_DVBSKY
-	tristate "DVBSky USB support"
-	depends on DVB_USB_V2
-	select DVB_M88DS3103 if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_SI2168 if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_TS2020 if MEDIA_SUBDRV_AUTOSELECT
-	select MEDIA_TUNER_SI2157 if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_SP2 if MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Say Y here to support the USB receivers from DVBSky.
-
 config DVB_USB_ZD1301
 	tristate "ZyDAS ZD1301"
 	depends on DVB_USB_V2
@@ -172,3 +174,5 @@ config DVB_USB_ZD1301
 	select MEDIA_TUNER_MT2060 if MEDIA_SUBDRV_AUTOSELECT
 	help
 	  Say Y here to support the ZyDAS ZD1301 DVB USB receiver.
+
+endif
diff --git a/drivers/media/usb/dvb-usb/Kconfig b/drivers/media/usb/dvb-usb/Kconfig
index 6df96c2bf569..f10fe27e2a4d 100644
--- a/drivers/media/usb/dvb-usb/Kconfig
+++ b/drivers/media/usb/dvb-usb/Kconfig
@@ -22,15 +22,7 @@ config DVB_USB_DEBUG
 	  Say Y if you want to enable debugging. See modinfo dvb-usb (and the
 	  appropriate drivers) for debug levels.
 
-config DVB_USB_DIB3000MC
-	tristate
-	depends on DVB_USB
-	select DVB_DIB3000MC
-	help
-	  This is a module with helper functions for accessing the
-	  DIB3000MC from USB DVB devices. It must be a separate module
-	  in case DVB_USB is built-in and DVB_DIB3000MC is a module,
-	  and gets selected automatically when needed.
+if DVB_USB
 
 config DVB_USB_A800
 	tristate "AVerMedia AverTV DVB-T USB 2.0 (A800)"
@@ -41,84 +33,37 @@ config DVB_USB_A800
 	help
 	  Say Y here to support the AVerMedia AverTV DVB-T USB 2.0 (A800) receiver.
 
-config DVB_USB_DIBUSB_MB
-	tristate "DiBcom USB DVB-T devices (based on the DiB3000M-B) (see help for device list)"
+config DVB_USB_AF9005
+	tristate "Afatech AF9005 DVB-T USB1.1 support"
 	depends on DVB_USB
-	select DVB_PLL if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_DIB3000MB
-	depends on DVB_DIB3000MC || !DVB_DIB3000MC
 	select MEDIA_TUNER_MT2060 if MEDIA_SUBDRV_AUTOSELECT
+	select MEDIA_TUNER_QT1010 if MEDIA_SUBDRV_AUTOSELECT
 	help
-	  Support for USB 1.1 and 2.0 DVB-T receivers based on reference designs made by
-	  DiBcom (<http://www.dibcom.fr>) equipped with a DiB3000M-B demodulator.
+	  Say Y here to support the Afatech AF9005 based DVB-T USB1.1 receiver
+	  and the TerraTec Cinergy T USB XE (Rev.1)
 
-	  For an up-to-date list of devices supported by this driver, have a look
-	  on the Linux-DVB Wiki at www.linuxtv.org.
-
-	  Say Y if you own such a device and want to use it. You should build it as
-	  a module.
-
-config DVB_USB_DIBUSB_MB_FAULTY
-	bool "Support faulty USB IDs"
-	depends on DVB_USB_DIBUSB_MB
+config DVB_USB_AF9005_REMOTE
+	tristate "Afatech AF9005 default remote control support"
+	depends on DVB_USB_AF9005
 	help
-	  Support for faulty USB IDs due to an invalid EEPROM on some Artec devices.
+	  Say Y here to support the default remote control decoding for the
+	  Afatech AF9005 based receiver.
 
-config DVB_USB_DIBUSB_MC
-	tristate "DiBcom USB DVB-T devices (based on the DiB3000M-C/P) (see help for device list)"
+config DVB_USB_AZ6027
+	tristate "Azurewave DVB-S/S2 USB2.0 AZ6027 support"
 	depends on DVB_USB
-	select DVB_USB_DIB3000MC
-	select MEDIA_TUNER_MT2060 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_STB0899 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_STB6100 if MEDIA_SUBDRV_AUTOSELECT
 	help
-	  Support for USB2.0 DVB-T receivers based on reference designs made by
-	  DiBcom (<http://www.dibcom.fr>) equipped with a DiB3000M-C/P demodulator.
+	  Say Y here to support the AZ6027 device
 
-	  For an up-to-date list of devices supported by this driver, have a look
-	  on the Linux-DVB Wiki at www.linuxtv.org.
-
-	  Say Y if you own such a device and want to use it. You should build it as
-	  a module.
-
-config DVB_USB_DIB0700
-	tristate "DiBcom DiB0700 USB DVB devices (see help for supported devices)"
+config DVB_USB_CINERGY_T2
+	tristate "Terratec CinergyT2/qanu USB 2.0 DVB-T receiver"
 	depends on DVB_USB
-	select DVB_DIB7000P if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_DIB7000M if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_DIB8000 if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_USB_DIB3000MC if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_S5H1411 if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_LGDT3305 if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_MN88472 if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_TUNER_DIB0070 if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_TUNER_DIB0090 if MEDIA_SUBDRV_AUTOSELECT
-	select MEDIA_TUNER_MT2060 if MEDIA_SUBDRV_AUTOSELECT
-	select MEDIA_TUNER_MT2266 if MEDIA_SUBDRV_AUTOSELECT
-	select MEDIA_TUNER_XC2028 if MEDIA_SUBDRV_AUTOSELECT
-	select MEDIA_TUNER_XC5000 if MEDIA_SUBDRV_AUTOSELECT
-	select MEDIA_TUNER_XC4000 if MEDIA_SUBDRV_AUTOSELECT
-	select MEDIA_TUNER_MXL5007T if MEDIA_SUBDRV_AUTOSELECT
-	select MEDIA_TUNER_TDA18250 if MEDIA_SUBDRV_AUTOSELECT
 	help
-	  Support for USB2.0/1.1 DVB receivers based on the DiB0700 USB bridge. The
-	  USB bridge is also present in devices having the DiB7700 DVB-T-USB
-	  silicon. This chip can be found in devices offered by Hauppauge,
-	  Avermedia and other big and small companies.
+	  Support for "TerraTec CinergyT2" USB2.0 Highspeed DVB Receivers
 
-	  For an up-to-date list of devices supported by this driver, have a look
-	  on the LinuxTV Wiki at www.linuxtv.org.
-
-	  Say Y if you own such a device and want to use it. You should build it as
-	  a module.
-
-config DVB_USB_UMT_010
-	tristate "HanfTek UMT-010 DVB-T USB2.0 support"
-	depends on DVB_USB
-	select DVB_PLL if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_USB_DIB3000MC
-	select MEDIA_TUNER_MT2060 if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_MT352 if MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Say Y here to support the HanfTek UMT-010 USB2.0 stick-sized DVB-T receiver.
+	  Say Y if you own such a device and want to use it.
 
 config DVB_USB_CXUSB
 	tristate "Conexant USB2.0 hybrid reference design support"
@@ -159,19 +104,84 @@ config DVB_USB_CXUSB_ANALOG
 	  USB2.0 hybrid reference design.
 	  Currently this mode is supported only on a Medion MD95700 device.
 
-config DVB_USB_M920X
-	tristate "Uli m920x DVB-T USB2.0 support"
-	depends on DVB_USB
-	select DVB_MT352 if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_TDA1004X if MEDIA_SUBDRV_AUTOSELECT
-	select MEDIA_TUNER_QT1010 if MEDIA_SUBDRV_AUTOSELECT
-	select MEDIA_TUNER_TDA827X if MEDIA_SUBDRV_AUTOSELECT
-	select MEDIA_TUNER_SIMPLE if MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Say Y here to support the MSI Mega Sky 580 USB2.0 DVB-T receiver.
-	  Currently, only devices with a product id of
-	  "DTV USB MINI" (in cold state) are supported.
-	  Firmware required.
+config DVB_USB_DIB0700
+	tristate "DiBcom DiB0700 USB DVB devices (see help for supported devices)"
+	depends on DVB_USB
+	select DVB_DIB7000P if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_DIB7000M if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_DIB8000 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_USB_DIB3000MC if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_S5H1411 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_LGDT3305 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_MN88472 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_TUNER_DIB0070 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_TUNER_DIB0090 if MEDIA_SUBDRV_AUTOSELECT
+	select MEDIA_TUNER_MT2060 if MEDIA_SUBDRV_AUTOSELECT
+	select MEDIA_TUNER_MT2266 if MEDIA_SUBDRV_AUTOSELECT
+	select MEDIA_TUNER_XC2028 if MEDIA_SUBDRV_AUTOSELECT
+	select MEDIA_TUNER_XC5000 if MEDIA_SUBDRV_AUTOSELECT
+	select MEDIA_TUNER_XC4000 if MEDIA_SUBDRV_AUTOSELECT
+	select MEDIA_TUNER_MXL5007T if MEDIA_SUBDRV_AUTOSELECT
+	select MEDIA_TUNER_TDA18250 if MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Support for USB2.0/1.1 DVB receivers based on the DiB0700 USB bridge. The
+	  USB bridge is also present in devices having the DiB7700 DVB-T-USB
+	  silicon. This chip can be found in devices offered by Hauppauge,
+	  Avermedia and other big and small companies.
+
+	  For an up-to-date list of devices supported by this driver, have a look
+	  on the LinuxTV Wiki at www.linuxtv.org.
+
+	  Say Y if you own such a device and want to use it. You should build it as
+	  a module.
+
+config DVB_USB_DIB3000MC
+	tristate
+	depends on DVB_USB
+	select DVB_DIB3000MC
+	help
+	  This is a module with helper functions for accessing the
+	  DIB3000MC from USB DVB devices. It must be a separate module
+	  in case DVB_USB is built-in and DVB_DIB3000MC is a module,
+	  and gets selected automatically when needed.
+
+config DVB_USB_DIBUSB_MB
+	tristate "DiBcom USB DVB-T devices (based on the DiB3000M-B) (see help for device list)"
+	depends on DVB_USB
+	select DVB_PLL if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_DIB3000MB
+	depends on DVB_DIB3000MC || !DVB_DIB3000MC
+	select MEDIA_TUNER_MT2060 if MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Support for USB 1.1 and 2.0 DVB-T receivers based on reference designs made by
+	  DiBcom (<http://www.dibcom.fr>) equipped with a DiB3000M-B demodulator.
+
+	  For an up-to-date list of devices supported by this driver, have a look
+	  on the Linux-DVB Wiki at www.linuxtv.org.
+
+	  Say Y if you own such a device and want to use it. You should build it as
+	  a module.
+
+config DVB_USB_DIBUSB_MB_FAULTY
+	bool "Support faulty USB IDs"
+	depends on DVB_USB_DIBUSB_MB
+	help
+	  Support for faulty USB IDs due to an invalid EEPROM on some Artec devices.
+
+config DVB_USB_DIBUSB_MC
+	tristate "DiBcom USB DVB-T devices (based on the DiB3000M-C/P) (see help for device list)"
+	depends on DVB_USB
+	select DVB_USB_DIB3000MC
+	select MEDIA_TUNER_MT2060 if MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Support for USB2.0 DVB-T receivers based on reference designs made by
+	  DiBcom (<http://www.dibcom.fr>) equipped with a DiB3000M-C/P demodulator.
+
+	  For an up-to-date list of devices supported by this driver, have a look
+	  on the Linux-DVB Wiki at www.linuxtv.org.
+
+	  Say Y if you own such a device and want to use it. You should build it as
+	  a module.
 
 config DVB_USB_DIGITV
 	tristate "Nebula Electronics uDigiTV DVB-T USB2.0 support"
@@ -182,65 +192,6 @@ config DVB_USB_DIGITV
 	help
 	  Say Y here to support the Nebula Electronics uDigitV USB2.0 DVB-T receiver.
 
-config DVB_USB_VP7045
-	tristate "TwinhanDTV Alpha/MagicBoxII, DNTV tinyUSB2, Beetle USB2.0 support"
-	depends on DVB_USB
-	help
-	  Say Y here to support the
-
-	    TwinhanDTV Alpha (stick) (VP-7045),
-		TwinhanDTV MagicBox II (VP-7046),
-		DigitalNow TinyUSB 2 DVB-t,
-		DigitalRise USB 2.0 Ter (Beetle) and
-		TYPHOON DVB-T USB DRIVE
-
-	  DVB-T USB2.0 receivers.
-
-config DVB_USB_VP702X
-	tristate "TwinhanDTV StarBox and clones DVB-S USB2.0 support"
-	depends on DVB_USB
-	help
-	  Say Y here to support the
-
-	    TwinhanDTV StarBox,
-		DigitalRise USB Starbox and
-		TYPHOON DVB-S USB 2.0 BOX
-
-	  DVB-S USB2.0 receivers.
-
-config DVB_USB_GP8PSK
-	tristate "GENPIX 8PSK->USB module support"
-	depends on DVB_USB
-	help
-	  Say Y here to support the
-	    GENPIX 8psk module
-
-	  DVB-S USB2.0 receivers.
-
-config DVB_USB_NOVA_T_USB2
-	tristate "Hauppauge WinTV-NOVA-T usb2 DVB-T USB2.0 support"
-	depends on DVB_USB
-	select DVB_USB_DIB3000MC
-	select DVB_PLL if MEDIA_SUBDRV_AUTOSELECT
-	select MEDIA_TUNER_MT2060 if MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Say Y here to support the Hauppauge WinTV-NOVA-T usb2 DVB-T USB2.0 receiver.
-
-config DVB_USB_TTUSB2
-	tristate "Pinnacle 400e DVB-S USB2.0 support"
-	depends on DVB_USB
-	select DVB_TDA10086 if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_LNBP21 if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_TDA826X if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_TDA10023 if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_TDA10048 if MEDIA_SUBDRV_AUTOSELECT
-	select MEDIA_TUNER_TDA827X if MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Say Y here to support the Pinnacle 400e DVB-S USB2.0 receiver and
-	  the TechnoTrend CT-3650 CI DVB-C/T USB2.0 receiver. The
-	  firmware protocol used by this module is similar to the one used by the
-	  old ttusb-driver - that's why the module is called dvb-usb-ttusb2.
-
 config DVB_USB_DTT200U
 	tristate "WideView WT-200U and WT-220U (pen) DVB-T USB2.0 support (Yakumo/Hama/Typhoon/Yuan)"
 	depends on DVB_USB
@@ -251,43 +202,13 @@ config DVB_USB_DTT200U
 
 	  The WT-220U and its clones are pen-sized.
 
-config DVB_USB_OPERA1
-	tristate "Opera1 DVB-S USB2.0 receiver"
+config DVB_USB_DTV5100
+	tristate "AME DTV-5100 USB2.0 DVB-T support"
 	depends on DVB_USB
-	select DVB_STV0299 if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_PLL if MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Say Y here to support the Opera DVB-S USB2.0 receiver.
-
-config DVB_USB_AF9005
-	tristate "Afatech AF9005 DVB-T USB1.1 support"
-	depends on DVB_USB
-	select MEDIA_TUNER_MT2060 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_ZL10353 if MEDIA_SUBDRV_AUTOSELECT
 	select MEDIA_TUNER_QT1010 if MEDIA_SUBDRV_AUTOSELECT
 	help
-	  Say Y here to support the Afatech AF9005 based DVB-T USB1.1 receiver
-	  and the TerraTec Cinergy T USB XE (Rev.1)
-
-config DVB_USB_AF9005_REMOTE
-	tristate "Afatech AF9005 default remote control support"
-	depends on DVB_USB_AF9005
-	help
-	  Say Y here to support the default remote control decoding for the
-	  Afatech AF9005 based receiver.
-
-config DVB_USB_PCTV452E
-	tristate "Pinnacle PCTV HDTV Pro USB device/TT Connect S2-3600"
-	depends on DVB_USB
-	select TTPCI_EEPROM
-	select DVB_ISL6423 if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_LNBP22 if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_STB0899 if MEDIA_SUBDRV_AUTOSELECT
-	select DVB_STB6100 if MEDIA_SUBDRV_AUTOSELECT
-	help
-	  Support for external USB adapter designed by Pinnacle,
-	  shipped under the brand name 'PCTV HDTV Pro USB'.
-	  Also supports TT Connect S2-3600/3650 cards.
-	  Say Y if you own such a device and want to use it.
+	  Say Y here to support the AME DTV-5100 USB2.0 DVB-T receiver.
 
 config DVB_USB_DW2102
 	tristate "DvbWorld & TeVii DVB-S/S2 USB2.0 support"
@@ -312,29 +233,59 @@ config DVB_USB_DW2102
 	  Say Y here to support the DvbWorld, TeVii, Prof, TechnoTrend
 	  DVB-S/S2 USB2.0 receivers.
 
-config DVB_USB_CINERGY_T2
-	tristate "Terratec CinergyT2/qanu USB 2.0 DVB-T receiver"
+config DVB_USB_GP8PSK
+	tristate "GENPIX 8PSK->USB module support"
 	depends on DVB_USB
 	help
-	  Support for "TerraTec CinergyT2" USB2.0 Highspeed DVB Receivers
+	  Say Y here to support the
+	    GENPIX 8psk module
 
-	  Say Y if you own such a device and want to use it.
+	  DVB-S USB2.0 receivers.
 
-config DVB_USB_DTV5100
-	tristate "AME DTV-5100 USB2.0 DVB-T support"
+config DVB_USB_M920X
+	tristate "Uli m920x DVB-T USB2.0 support"
 	depends on DVB_USB
-	select DVB_ZL10353 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_MT352 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_TDA1004X if MEDIA_SUBDRV_AUTOSELECT
 	select MEDIA_TUNER_QT1010 if MEDIA_SUBDRV_AUTOSELECT
+	select MEDIA_TUNER_TDA827X if MEDIA_SUBDRV_AUTOSELECT
+	select MEDIA_TUNER_SIMPLE if MEDIA_SUBDRV_AUTOSELECT
 	help
-	  Say Y here to support the AME DTV-5100 USB2.0 DVB-T receiver.
+	  Say Y here to support the MSI Mega Sky 580 USB2.0 DVB-T receiver.
+	  Currently, only devices with a product id of
+	  "DTV USB MINI" (in cold state) are supported.
+	  Firmware required.
 
-config DVB_USB_AZ6027
-	tristate "Azurewave DVB-S/S2 USB2.0 AZ6027 support"
+config DVB_USB_NOVA_T_USB2
+	tristate "Hauppauge WinTV-NOVA-T usb2 DVB-T USB2.0 support"
 	depends on DVB_USB
+	select DVB_USB_DIB3000MC
+	select DVB_PLL if MEDIA_SUBDRV_AUTOSELECT
+	select MEDIA_TUNER_MT2060 if MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Say Y here to support the Hauppauge WinTV-NOVA-T usb2 DVB-T USB2.0 receiver.
+
+config DVB_USB_OPERA1
+	tristate "Opera1 DVB-S USB2.0 receiver"
+	depends on DVB_USB
+	select DVB_STV0299 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_PLL if MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Say Y here to support the Opera DVB-S USB2.0 receiver.
+
+config DVB_USB_PCTV452E
+	tristate "Pinnacle PCTV HDTV Pro USB device/TT Connect S2-3600"
+	depends on DVB_USB
+	select TTPCI_EEPROM
+	select DVB_ISL6423 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_LNBP22 if MEDIA_SUBDRV_AUTOSELECT
 	select DVB_STB0899 if MEDIA_SUBDRV_AUTOSELECT
 	select DVB_STB6100 if MEDIA_SUBDRV_AUTOSELECT
 	help
-	  Say Y here to support the AZ6027 device
+	  Support for external USB adapter designed by Pinnacle,
+	  shipped under the brand name 'PCTV HDTV Pro USB'.
+	  Also supports TT Connect S2-3600/3650 cards.
+	  Say Y if you own such a device and want to use it.
 
 config DVB_USB_TECHNISAT_USB2
 	tristate "Technisat DVB-S/S2 USB2.0 support"
@@ -343,3 +294,56 @@ config DVB_USB_TECHNISAT_USB2
 	select DVB_STV6110x if MEDIA_SUBDRV_AUTOSELECT
 	help
 	  Say Y here to support the Technisat USB2 DVB-S/S2 device
+
+config DVB_USB_TTUSB2
+	tristate "Pinnacle 400e DVB-S USB2.0 support"
+	depends on DVB_USB
+	select DVB_TDA10086 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_LNBP21 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_TDA826X if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_TDA10023 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_TDA10048 if MEDIA_SUBDRV_AUTOSELECT
+	select MEDIA_TUNER_TDA827X if MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Say Y here to support the Pinnacle 400e DVB-S USB2.0 receiver and
+	  the TechnoTrend CT-3650 CI DVB-C/T USB2.0 receiver. The
+	  firmware protocol used by this module is similar to the one used by the
+	  old ttusb-driver - that's why the module is called dvb-usb-ttusb2.
+
+config DVB_USB_UMT_010
+	tristate "HanfTek UMT-010 DVB-T USB2.0 support"
+	depends on DVB_USB
+	select DVB_PLL if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_USB_DIB3000MC
+	select MEDIA_TUNER_MT2060 if MEDIA_SUBDRV_AUTOSELECT
+	select DVB_MT352 if MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Say Y here to support the HanfTek UMT-010 USB2.0 stick-sized DVB-T receiver.
+
+config DVB_USB_VP702X
+	tristate "TwinhanDTV StarBox and clones DVB-S USB2.0 support"
+	depends on DVB_USB
+	help
+	  Say Y here to support the
+
+	    TwinhanDTV StarBox,
+		DigitalRise USB Starbox and
+		TYPHOON DVB-S USB 2.0 BOX
+
+	  DVB-S USB2.0 receivers.
+
+config DVB_USB_VP7045
+	tristate "TwinhanDTV Alpha/MagicBoxII, DNTV tinyUSB2, Beetle USB2.0 support"
+	depends on DVB_USB
+	help
+	  Say Y here to support the
+
+	    TwinhanDTV Alpha (stick) (VP-7045),
+		TwinhanDTV MagicBox II (VP-7046),
+		DigitalNow TinyUSB 2 DVB-t,
+		DigitalRise USB 2.0 Ter (Beetle) and
+		TYPHOON DVB-T USB DRIVE
+
+	  DVB-T USB2.0 receivers.
+
+endif
diff --git a/drivers/media/usb/gspca/Kconfig b/drivers/media/usb/gspca/Kconfig
index 2b106a7fcf4c..9c1939ce6be4 100644
--- a/drivers/media/usb/gspca/Kconfig
+++ b/drivers/media/usb/gspca/Kconfig
@@ -16,13 +16,8 @@ menuconfig USB_GSPCA
 	  To compile this driver as modules, choose M here: the
 	  module will be called gspca_main.
 
-
 if USB_GSPCA && VIDEO_DEV
 
-source "drivers/media/usb/gspca/m5602/Kconfig"
-source "drivers/media/usb/gspca/stv06xx/Kconfig"
-source "drivers/media/usb/gspca/gl860/Kconfig"
-
 config USB_GSPCA_BENQ
 	tristate "Benq USB Camera Driver"
 	depends on VIDEO_DEV && USB_GSPCA
@@ -251,6 +246,15 @@ config USB_GSPCA_SONIXJ
 	  To compile this driver as a module, choose M here: the
 	  module will be called gspca_sonixj
 
+config USB_GSPCA_SPCA1528
+	tristate "SPCA1528 USB Camera Driver"
+	depends on VIDEO_DEV && USB_GSPCA
+	help
+	  Say Y here if you want support for cameras based on the SPCA1528 chip.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called gspca_spca1528.
+
 config USB_GSPCA_SPCA500
 	tristate "SPCA500 USB Camera Driver"
 	depends on VIDEO_DEV && USB_GSPCA
@@ -305,15 +309,6 @@ config USB_GSPCA_SPCA561
 	  To compile this driver as a module, choose M here: the
 	  module will be called gspca_spca561.
 
-config USB_GSPCA_SPCA1528
-	tristate "SPCA1528 USB Camera Driver"
-	depends on VIDEO_DEV && USB_GSPCA
-	help
-	  Say Y here if you want support for cameras based on the SPCA1528 chip.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called gspca_spca1528.
-
 config USB_GSPCA_SQ905
 	tristate "SQ Technologies SQ905 based USB Camera Driver"
 	depends on VIDEO_DEV && USB_GSPCA
@@ -453,4 +448,8 @@ config USB_GSPCA_ZC3XX
 	  To compile this driver as a module, choose M here: the
 	  module will be called gspca_zc3xx.
 
+source "drivers/media/usb/gspca/gl860/Kconfig"
+source "drivers/media/usb/gspca/m5602/Kconfig"
+source "drivers/media/usb/gspca/stv06xx/Kconfig"
+
 endif
-- 
2.35.1

